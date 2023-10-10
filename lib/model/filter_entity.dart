// ignore_for_file: unused_local_variable

import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:image/image.dart' as img;
import 'package:meta/meta.dart';

class FilterParams<T> {
  final String name;
  final T value;
  final Widget widget;

  FilterParams({required this.name, required this.value, required this.widget});
}

abstract class FilterEntity {
  final String name;

  @visibleForOverriding
  List<FilterParams> get params => const [];

  FilterEntity({
    required this.name,
  });

  Future<Uint8List?> onApplyFilter(Uint8List image);
}

class Erode extends FilterEntity {
  Erode() : super(name: 'Erosão');

  List<List<int>> kernel = [
    [0, 1, 0],
    [1, 1, 1],
    [0, 1, 0],
  ];

  @override
  List<FilterParams> get params => [];

  @override
  Future<Uint8List?> onApplyFilter(Uint8List image) async {
    final decodedImage = img.decodeImage(Uint8List.fromList(image));
    int width = decodedImage!.width;
    int height = decodedImage.height;
    return null;

    // for (int y = 0; y < height; y++) {
    //   for (int x = 0; x < width; x++) {
    //     bool isEroded = true;
    //     for (int i = 0; i < kernel.length; i++) {
    //       for (int j = 0; j < kernel[i].length; j++) {
    //         int kernelValue = kernel[i][j];
    //         int imageValue = decodedImage
    //             .getPixel(
    //               x + i - kernel.length / 2,
    //               y + j - kernel.length / 2,
    //             )
    //             .r
    //             .toInt();
    //         if (kernelValue != 255 && imageValue != kernelValue) {
    //           isEroded = false;
    //           break;
    //         }
    //       }
    //       if (!isEroded) {
    //         break;
    //       }
    //     }

    //     final pixel = decodedImage.getPixel(x, y);

    //     final rgbColor = img.ColorRgb8(
    //       pixel.r.toInt(),
    //       pixel.g.toInt(),
    //       pixel.b.toInt(),
    //     );

    //     // Define o valor do pixel erodado.
    //     decodedImage.setPixel(
    //         x, y, isEroded ? img.ColorRgb8(0, 0, 0) : rgbColor);
    //   }
    // }

    // return output;
  }
}

class ThresholdBinarize extends FilterEntity {
  ThresholdBinarize() : super(name: 'Threshold');

  int threshold = 0;

  @override
  List<FilterParams> get params => [
        FilterParams<int>(
          name: 'Threshold',
          value: threshold,
          widget: CupertinoSlider(
            value: threshold.toDouble(),
            min: 0,
            max: 255,
            divisions: 1,
            onChanged: (value) {
              threshold = value.toInt();
            },
          ),
        ),
      ];

  @override
  Future<Uint8List?> onApplyFilter(Uint8List image) async {
    final decodedImage = img.decodeImage(Uint8List.fromList(image));

    int width = image.length ~/ image.elementSizeInBytes;
    int height = image.length ~/ width * image.elementSizeInBytes;

    var binaryImage = img.Image.fromBytes(
      width: width,
      height: height,
      bytes: image.buffer,
    );

    for (int i = 0; i < image.length; i += 4) {
      int pixel = image[i];
      if (pixel > threshold) {
        image[i] = 255;
      } else {
        image[i] = 0;
      }
    }

    return image;
  }
}
