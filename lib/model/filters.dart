import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:image/image.dart' as img;
import 'package:image/image.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:smart_sight/model/filter_entity.dart';

class GaussianBlur extends FilterEntity {
  GaussianBlur() : super(name: 'Blur Gaussiano');

  int sigma = 0;

  @override
  List<FilterParams> get params => [
        FilterParams<int>(
          name: 'Sigma',
          value: sigma,
          widget: StatefulBuilder(
            builder: (context, setState) {
              return CupertinoSlider(
                value: sigma.toDouble(),
                min: 0,
                max: 100,
                divisions: 10,
                onChanged: (value) {
                  sigma = value.toInt();
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

    final blurredImage = img.gaussianBlur(decodedImage!, radius: sigma);

    final resultBytes = Uint8List.fromList(img.encodePng(blurredImage));

    return resultBytes;
  }
}

class Noise extends FilterEntity {
  Noise() : super(name: 'Ruído');

  @override
  List<FilterParams> get params => [
        FilterParams<int>(
          name: 'Sigma',
          value: sigma,
          widget: StatefulBuilder(
            builder: (context, setState) {
              return CupertinoSlider(
                value: sigma.toDouble(),
                min: 0,
                max: 100,
                divisions: 10,
                onChanged: (value) {
                  sigma = value.toInt();
                  setState(() {});
                },
              );
            },
          ),
        ),
        FilterParams<NoiseType>(
          name: 'Tipo',
          value: type,
          widget: StatefulBuilder(
            builder: (context, setState) {
              return CupertinoSlidingSegmentedControl<NoiseType>(
                groupValue: type,
                thumbColor: MacosColors.controlAccentColor,
                children: const {
                  NoiseType.gaussian: Text('Gaussiano'),
                  NoiseType.poisson: Text('Poisson'),
                  NoiseType.rice: Text('Arroz'),
                  NoiseType.saltAndPepper: Text('Sal e Pimenta'),
                  NoiseType.uniform: Text('Uniforme'),
                },
                onValueChanged: (value) {
                  type = value!;
                  setState(() {});
                },
              );
            },
          ),
        ),
      ];

  int sigma = 0;
  NoiseType type = NoiseType.gaussian;

  @override
  Future<Uint8List?> onApplyFilter(Uint8List image) async {
    final decodedImage = img.decodeImage(Uint8List.fromList(image));

    final blurredImage = img.noise(decodedImage!, sigma, type: type);

    final resultBytes = Uint8List.fromList(img.encodePng(blurredImage));

    return resultBytes;
  }
}
