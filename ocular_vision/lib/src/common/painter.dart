import 'dart:io';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';
import 'package:ocular_vision/src/common/color_constants.dart';

import 'coordinates_translator.dart';

class ObjectDetectorPainter extends CustomPainter {
  ObjectDetectorPainter(
    this._objects,
    this.imageSize,
    this.rotation,
    this.cameraLensDirection,
  );

  final List<DetectedObject> _objects;
  final Size imageSize;
  final InputImageRotation rotation;
  final CameraLensDirection cameraLensDirection;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = primaryColor.withOpacity(0.6);

    final Paint background = Paint()..color = primaryColor.withOpacity(0.8);

    for (final DetectedObject detectedObject in _objects) {
      final ParagraphBuilder builder = ParagraphBuilder(
        ParagraphStyle(
            textAlign: TextAlign.left,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: "Poppins",
            textDirection: TextDirection.ltr),
      );
      builder.pushStyle(
          ui.TextStyle(color: Colors.grey[200], background: background));
      if (detectedObject.labels.isNotEmpty) {
        final label = detectedObject.labels
            .reduce((a, b) => a.confidence > b.confidence ? a : b);
        builder
            .addText('${label.text}, ${label.confidence.toStringAsFixed(2)}\n');
      }
      builder.pop();

      final left = translateX(
        detectedObject.boundingBox.left,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );
      final top = translateY(
        detectedObject.boundingBox.top,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );
      final right = translateX(
        detectedObject.boundingBox.right,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );
      final bottom = translateY(
        detectedObject.boundingBox.bottom,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );
      const double padding = 10.0; // Adjust padding as needed
      final Rect labelRect = Rect.fromLTRB(
        left - padding,
        top - padding,
        right + padding,
        top + 20 + padding, // Adjust the height as needed
      );
      final RRect roundedRect = RRect.fromRectAndRadius(
        labelRect,
        const Radius.circular(15.0), // Adjust border radius as needed
      );
      canvas.drawRRect(roundedRect, background);

      final RRect roundedRectv2 = RRect.fromRectAndRadius(
          Rect.fromLTRB(left, top, right, bottom), Radius.circular(15));
      canvas.drawRRect(
        roundedRectv2,
        paint,
      );

      canvas.drawParagraph(
        builder.build()
          ..layout(ParagraphConstraints(
            width: (right - left - 2 * padding).abs(),
          )),
        Offset(
            Platform.isAndroid &&
                    cameraLensDirection == CameraLensDirection.front
                ? right
                : left,
            top),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
