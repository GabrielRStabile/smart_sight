import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';

import '../../view_model/canvas_view_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: ValueListenableBuilder(
            valueListenable: CanvasViewModel().openedImage,
            builder: (context, value, child) {
              return value == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const MacosIcon(
                          CupertinoIcons.photo_fill_on_rectangle_fill,
                          size: 32,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Nenhuma imagem aberta',
                          style: MacosTheme.of(context)
                              .typography
                              .title1
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Clique no ícone de fotos na barra de ferramentas acima e depois em Abrir Imagem.',
                          style: MacosTheme.of(context)
                              .typography
                              .callout
                              .copyWith(
                                fontWeight: FontWeight.w600,
                                color: MacosDynamicColor.resolve(
                                  MacosColors.secondaryLabelColor,
                                  context,
                                ),
                              ),
                        ),
                      ],
                    )
                  : Image.memory(value);
            },
          ),
        ),
      ],
    );
  }
}
