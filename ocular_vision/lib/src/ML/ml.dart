import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future<String> getModelPath(String asset) async {
  final path = '${(await getApplicationSupportDirectory()).path}/$asset';
  await Directory(dirname(path)).create(recursive: true);
  final file = File(path);
  if (!await file.exists()) {
    final byteData = await rootBundle.load(asset);
    await file.writeAsBytes(byteData.buffer
        .asInt8List(byteData.offsetInBytes, byteData.lengthInBytes));
  }
  return file.path;
}

class ObjectDetectorView extends StatefulWidget {
  const ObjectDetectorView({super.key});

  @override
  State<ObjectDetectorView> createState() => _ObjectDetectorViewState();
}

class _ObjectDetectorViewState extends State<ObjectDetectorView> {
  ObjectDetector? _objectDetector;
  final DetectionMode _mode = DetectionMode.single;
  bool _canProcess = false;
  bool _isBusy = false;
  String? _text;
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void _initializeDetector() async {
    _objectDetector?.close();
    _objectDetector = null;
    print('Set detector in mode: $_mode');
    final modelPath = await getModelPath('assets/ml/model.tflite');
    print('use custom mode path: $modelPath');
    final options = LocalObjectDetectorOptions(
        mode: _mode,
        modelPath: modelPath,
        classifyObjects: true,
        multipleObjects: true);
    _objectDetector = ObjectDetector(options: options);
    _canProcess = true;
  }

  Future<String> _processImage(InputImage inputImage) async {
    _initializeDetector();
    if (_objectDetector == null) return "";
    if (!_canProcess) return "";
    if (_isBusy) return "";
    setState(() {
      _text = '';
    });
    final objects = await _objectDetector!.processImage(inputImage);
    String text = 'Objects found: ${objects.length}';
    for (final object in objects) {
      text +=
          'Object: trackingID: ${object.trackingId} - ${object.labels.map((e) => e.text)}\n\n';
    }
    _text = text;
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
    return _text!;
  }

  Future<String> processImageCall(InputImage inputImage) async {
    return await _processImage(inputImage);
  }
}
