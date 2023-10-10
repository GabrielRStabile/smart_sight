import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:image/image.dart' as img;
import 'package:smart_sight/model/filter_entity.dart';

class SobelEdgeDetector extends FilterEntity {
  SobelEdgeDetector() : super(name: 'Detecção de bordas Sobel');

  int amount = 0;

  @override
  List<FilterParams> get params => [
        FilterParams<int>(
          name: 'Quantidade',
          value: amount,
          widget: StatefulBuilder(
            builder: (context, setState) {
              return CupertinoSlider(
                value: amount.toDouble(),
                min: 0,
                max: 100,
                divisions: 10,
                onChanged: (value) {
                  amount = value.toInt();
                  setState(() {});
                },
              );
            },
          ),
        ),
      ];

  @override
  Future<Uint8List?> onApplyFilter(Uint8List image) async {
    final decodedImage = img.decodeImage(Uint8List.fromList(image));

    final detectedImage = img.sobel(decodedImage!, amount: amount);

    final resultBytes = Uint8List.fromList(img.encodePng(detectedImage));

    return resultBytes;
  }
}
