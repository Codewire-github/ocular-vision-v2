import 'dart:io';
import 'dart:math';

import 'package:ocular_vision/src/ML/ml.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ocular_vision/src/widgets/information_container.dart';
import 'package:intl/intl.dart';

Color generateRandomLightColor() {
  Random random = Random();

  // Generate random values for red, green, and blue
  int red = random.nextInt(96) + 160;
  int green = random.nextInt(96) + 160;
  int blue = random.nextInt(96) + 160;

  return Color.fromARGB(160, red, green, blue);
}

class InfoScreen extends StatefulWidget {
  final int option;
  final String category;
  final File photo;
  final String email; // Add email parameter

  const InfoScreen({
    Key? key,
    required this.option,
    required this.category,
    required this.photo,
    required this.email,
  }) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  // ObjectDetector? _objectDetector;
  late ImageLabeler _imageLabeler;
  // final DetectionMode _mode = DetectionMode.single;
  bool _canProcess = false;
  bool _isBusy = false;
  String _result = '';
  String description = "";
  Map<String, dynamic> animalExtraInfo = {};
  List<String> imageUrls = [];
  File? image;
  bool isBottomSheetShown = false;
  int noOfObjectsFound = 0;
  bool isBookmarked = false;
  String? _downloadUrl;

  final _options = [
    'lite-model_aiy_vision_classifier_plants_V1_3.tflite',
    'animals.tflite',
    'lite-model_aiy_vision_classifier_food_V1_1.tflite',
    'technology.tflite',
    'furniture.tflite',
    'insects.tflite',
    'lite-model_aiy_vision_classifier_birds_V1_3.tflite',
    'mobilenet.tflite',
  ];

  void isBookmarkCallBack(bool val) async {
    setState(() {
      isBookmarked = val;
    });
    if (_result.isNotEmpty && imageUrls.isNotEmpty) {
      await sendPostRequest(_result, imageUrls.first, isBookmarked);
    }
  }

  @override
  void initState() {
    super.initState();
    firsThingsToDo();
  }

  @override
  void dispose() {
    _canProcess = false;
    _imageLabeler.close();
    super.dispose();
  }

  Future<void> firsThingsToDo() async {
    await _initializeLabeler();
    await _processImagev2(widget.photo);
    await fetchDescription();
    await fetchImage();
    if ((_result.isNotEmpty || noOfObjectsFound != 0) && widget.option != 7) {
      await _uploadImage();
    }
  }

  @override
  Widget build(BuildContext context) {
    File selectedImage = widget.photo;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height * 0.4,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
            ),
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(40)),
              child: Image.file(
                selectedImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 50),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 25,
                        color: Colors.white,
                      )),
                ),
              )),
          if (_result.isNotEmpty) ...{
            if (widget.option == 1 || widget.option == 7) ...{
              Align(
                alignment: Alignment.bottomCenter,
                child: AnimalInformationContainer(
                  result: _result,
                  description: description,
                  noOfObjectsFound: noOfObjectsFound,
                  isBookmarked: isBookmarked,
                  isBookmarkedCallback: isBookmarkCallBack,
                  imageUrls: imageUrls,
                ),
              ),
            } else if (widget.option == 2) ...{
              Align(
                alignment: Alignment.bottomCenter,
                child: FoodInformationContainer(
                  result: _result,
                  description: description,
                  noOfObjectsFound: noOfObjectsFound,
                  isBookmarked: isBookmarked,
                  isBookmarkedCallback: isBookmarkCallBack,
                  imageUrls: imageUrls,
                  primaryColor: generateRandomLightColor(),
                ),
              ),
            } else ...{
              Align(
                alignment: Alignment.bottomCenter,
                child: InformationContainer(
                  result: _result,
                  description: description,
                  noOfObjectsFound: noOfObjectsFound,
                  isBookmarked: isBookmarked,
                  isBookmarkedCallback: isBookmarkCallBack,
                  imageUrls: imageUrls,
                  primaryColor: generateRandomLightColor(),
                ),
              ),
            }
          } else ...{
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      'assets/img/error.png',
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Try scanning another object.",
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          }
        ],
      ),
    );
  }

  Future<void> _initializeLabeler() async {
    final path = 'assets/ml/${_options[widget.option]}';
    print("Model path: $path");
    final modelPath = await getModelPath(path);
    final options = LocalLabelerOptions(modelPath: modelPath);
    _imageLabeler = ImageLabeler(options: options);
    _canProcess = true;
  }

  Future<void> _processImagev2(File imageSelected) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _result = '';
    });
    final selectedImage = InputImage.fromFile(imageSelected);
    final labels = await _imageLabeler.processImage(selectedImage);
    setState(() {
      noOfObjectsFound = labels.length;
    });

    String text = '';
    for (final label in labels) {
      text += '${label.label}';
    }
    print("I am running ===============================");
    print(text);
    setState(() {
      if (widget.option == 7) {
        _result = text[0].toUpperCase() + text.substring(1);
      } else {
        _result = text;
      }
    });

    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> fetchDescription() async {
    final response = await http.get(
      Uri.parse('https://en.wikipedia.org/api/rest_v1/page/summary/$_result'),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        if (data['extract'] != null) {
          description = data['extract'];
        } else {
          description = 'No description available';
        }
      });
    } else {
      setState(() {
        description = 'Failed to fetch data.';
      });
    }
  }

  Future<void> fetchImage() async {
    try {
      const String apiKey =
          'VcbYu53HEsdckdbTQRQRrWR5AXt3DVpKP5cMJAkkdBW63iUkpfIT7gQE';
      final responseI = await http.get(
        Uri.parse('https://api.pexels.com/v1/search?query=$_result&per_page=5'),
        headers: {'Authorization': apiKey},
      );
      if (responseI.statusCode == 200) {
        Map<String, dynamic> data = json.decode(responseI.body);
        List<dynamic> photos = data['photos'];

        for (var photo in photos) {
          String imageUrl = photo['src']['medium'];
          setState(() {
            imageUrls.add(imageUrl);
          });
        }
      } else {
        print('Failed to fetch images');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _uploadImage() async {
    try {
      final startTime = DateTime.now();
      final uri = Uri.parse('https://api.cloudinary.com/v1_1/dcmn0ytla/upload');
      final request = http.MultipartRequest('POST', uri)
        ..fields['upload_preset'] = 'fytrk3vx'
        ..files
            .add(await http.MultipartFile.fromPath('file', widget.photo.path));

      final response = await request.send();
      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        final data = jsonDecode(responseString);
        setState(() {
          _downloadUrl = data['secure_url'];
          print(_downloadUrl);
        });
        final endTime = DateTime.now();
        print('Duration: ${endTime.difference(startTime)}');

        // After uploading, send the POST request
        await sendPostRequest(_result, _downloadUrl!, isBookmarked);
      } else {
        print('Failed to upload image. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading image: $e');
      // Handle error
    }
  }

  Future<void> sendPostRequest(
      String detectedObject, String imageUrls, bool isBookmarked) async {
    final url = Uri.parse('http://35.172.212.23:8080/api/ocular');

    // Get the current date and time
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd MMM, yyyy').format(now);

    final requestData = {
      'userName': widget.email,
      'imageData': [
        {
          'imageName': detectedObject,
          'image': imageUrls,
          'category': widget.category,
          'date': formattedDate,
          'saved': isBookmarked,
        }
      ]
    };

    final body = jsonEncode(requestData);

    final headers = {
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.post(
        url,
        body: body,
        headers: headers,
      );

      if (response.statusCode == 200) {
        print('Post request successful');
        print(response.body);
      } else {
        print('Post request failed with status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error sending POST request: $error');
    }
  }
}
