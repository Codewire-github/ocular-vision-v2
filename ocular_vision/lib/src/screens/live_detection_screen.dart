import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';
import 'package:ocular_vision/src/ML/ml.dart';
import 'package:ocular_vision/src/common/detector_view.dart';
import 'package:ocular_vision/src/common/painter.dart';

class LiveDetectionScreen extends StatefulWidget {
  const LiveDetectionScreen({super.key});

  @override
  State<LiveDetectionScreen> createState() => _LiveDetectionScreen();
}

class _LiveDetectionScreen extends State<LiveDetectionScreen> {
  ObjectDetector? _objectDetector;
  DetectionMode _mode = DetectionMode.stream;
  bool _canProcess = false;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  var _cameraLensDirection = CameraLensDirection.back;
  int _option = 0;
  List<String> options = [
    'Default',
    'Plants',
    'Animals',
    'Foods',
    'Technology',
    'Furniture',
    'Insects',
    'Birds',
    "All"
  ];
  final _modeloptions = {
    'Default': 'object_labeler.tflite',
    'Plants': 'lite-model_aiy_vision_classifier_plants_V1_3.tflite',
    'Animals': 'animals.tflite',
    'Foods': 'lite-model_aiy_vision_classifier_food_V1_1.tflite',
    'Technology': 'technology.tflite',
    'Furniture': 'furniture.tflite',
    'Insects': 'insects.tflite',
    'Birds': 'lite-model_aiy_vision_classifier_birds_V1_3.tflite',
    "All": 'mobilenet.tflite',
  };

  void handleOptionPressed(int val) {
    setState(() {
      _option = val;
    });
    _initializeDetector();
  }

  @override
  void dispose() {
    _canProcess = false;
    _objectDetector?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        DetectorView(
          title: 'Object Detector',
          customPaint: _customPaint,
          text: _text,
          onImage: _processImage,
          initialCameraLensDirection: _cameraLensDirection,
          onCameraLensDirectionChanged: (value) => _cameraLensDirection = value,
          onCameraFeedReady: _initializeDetector,
          initialDetectionMode: DetectorViewMode.values[_mode.index],
          onDetectorViewModeChanged: _onScreenModeChanged,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              height: 80,
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: Colors.black,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 38,
                    alignment: Alignment.center,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: options.length,
                        itemBuilder: (BuildContext context, int index) {
                          bool isSelected = _option == index;

                          return Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 15,
                            ),
                            margin: const EdgeInsets.symmetric(
                              horizontal: 2.5,
                            ),
                            decoration: BoxDecoration(
                                color: isSelected ? Colors.white : null,
                                borderRadius: BorderRadius.circular(25)),
                            child: TextButton(
                              onPressed: () {
                                handleOptionPressed(index);
                              },
                              child: Text(options[index],
                                  style: TextStyle(
                                      color: isSelected
                                          ? Colors.black
                                          : Colors.grey[200],
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Poppins",
                                      fontSize: 16)),
                            ),
                          );
                        }),
                  )
                ],
              )),
        ),
      ]),
    );
  }

  void _onScreenModeChanged(DetectorViewMode mode) {
    switch (mode) {
      case DetectorViewMode.gallery:
        _mode = DetectionMode.single;
        _initializeDetector();
        return;

      case DetectorViewMode.liveFeed:
        _mode = DetectionMode.stream;
        _initializeDetector();
        return;
    }
  }

  void _initializeDetector() async {
    _objectDetector?.close();
    _objectDetector = null;
    print('Set detector in mode: $_mode');

    // use a custom model
    // make sure to add tflite model to assets/ml
    final option = _modeloptions[_modeloptions.keys.toList()[_option]] ?? '';
    final modelPath = await getModelPath('assets/ml/$option');
    print('use custom model path: $modelPath');
    final options = LocalObjectDetectorOptions(
      mode: _mode,
      modelPath: modelPath,
      classifyObjects: true,
      multipleObjects: true,
    );
    _objectDetector = ObjectDetector(options: options);

    _canProcess = true;
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (_objectDetector == null) return;
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    final objects = await _objectDetector!.processImage(inputImage);
    // print('Objects found: ${objects.length}\n\n');
    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
      final painter = ObjectDetectorPainter(
        objects,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        _cameraLensDirection,
      );
      _customPaint = CustomPaint(painter: painter);
    } else {
      String text = 'Objects found: ${objects.length}\n\n';
      for (final object in objects) {
        text +=
            'Object:  trackingId: ${object.trackingId} - ${object.labels.map((e) => e.text)}\n\n';
      }
      _text = text;

      _customPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
