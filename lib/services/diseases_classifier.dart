import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

class PredictionResult {
  final String label;
  final double confidence;

  PredictionResult({
    required this.label,
    required this.confidence,
  });
}

class DiseaseClassifier {
  late Interpreter _interpreter;
  late List<String> _labels;

  Future<void> loadModel() async {
    _interpreter = await Interpreter.fromAsset(
      'assets/models/crop_disease_model.tflite',
    );

    final labelsJson = await rootBundle.loadString(
      'assets/class_names.json',
    );

    final decoded = jsonDecode(labelsJson);

    if (decoded is List) {
      _labels = decoded.map((e) => e.toString()).toList();
    } else if (decoded is Map) {
      final sortedKeys = decoded.keys.toList()
        ..sort(
              (a, b) => int.parse(a.toString()).compareTo(
            int.parse(b.toString()),
          ),
        );

      _labels = sortedKeys
          .map((key) => decoded[key].toString())
          .toList();
    }

    print("TFLite model loaded");
    print("Input: ${_interpreter.getInputTensor(0).shape}");
    print("Output: ${_interpreter.getOutputTensor(0).shape}");
  }

  PredictionResult predict(Uint8List imageBytes) {
    final decodedImage = img.decodeImage(imageBytes);

    if (decodedImage == null) {
      throw Exception("Unable to decode image");
    }

    final resized = img.copyResize(
      decodedImage,
      width: 224,
      height: 224,
    );

    final input = List.generate(
      1,
          (_) => List.generate(
        224,
            (y) => List.generate(
          224,
              (x) {
            final pixel = resized.getPixel(x, y);

            return [
              pixel.r.toDouble(),
              pixel.g.toDouble(),
              pixel.b.toDouble(),
            ];
          },
        ),
      ),
    );

    final output = List.generate(
      1,
          (_) => List.filled(_labels.length, 0.0),
    );

    _interpreter.run(input, output);

    final probabilities = output[0];

    int bestIndex = 0;

    for (int i = 1; i < probabilities.length; i++) {
      if (probabilities[i] > probabilities[bestIndex]) {
        bestIndex = i;
      }
    }

    return PredictionResult(
      label: _labels[bestIndex],
      confidence: probabilities[bestIndex],
    );
  }

  void dispose() {
    _interpreter.close();
  }
}