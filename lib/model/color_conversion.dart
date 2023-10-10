import 'dart:typed_data';

import 'package:color/color.dart';
import 'package:image/image.dart';
import 'package:smart_sight/model/filter_entity.dart';

abstract class ColorConversionEntity extends FilterEntity {
  ColorConversionEntity({required super.name});

  @override
  Future<Uint8List?> onApplyFilter(Uint8List image);
}

class BGRToBW extends ColorConversionEntity {
  BGRToBW() : super(name: 'BGR para BW');

  @override
  List<FilterParams> params = [];

  @override
  Future<Uint8List?> onApplyFilter(Uint8List image) async {
    final img = decodeImage(Uint8List.fromList(image));
    final grayImg = copyResize(img!, width: img.width, height: img.height);

    grayscale(grayImg);

    return Uint8List.fromList(encodePng(grayImg));
  }
}

class BGRToHSL extends ColorConversionEntity {
  BGRToHSL() : super(name: 'BGR para HSL');

  @override
  List<FilterParams> params = [];

  @override
  Future<Uint8List?> onApplyFilter(Uint8List image) async {
    final hslImage = Uint8List.fromList(image);

    for (int i = 0; i < image.length; i += 3) {
      final r = image[i] / 255.0;
      final g = image[i + 1] / 255.0;
      final b = image[i + 2] / 255.0;

      final hslColor = RgbColor(r, g, b).toHslColor();

      final h = (hslColor.h * 255).round();
      final s = (hslColor.s * 255).round();
      final l = (hslColor.l * 255).round();

      hslImage[i] = h.clamp(0, 255);
      hslImage[i + 1] = s.clamp(0, 255);
      hslImage[i + 2] = l.clamp(0, 255);
    }

    return hslImage;
  }
}
