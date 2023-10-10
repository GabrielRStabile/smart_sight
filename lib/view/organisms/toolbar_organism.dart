import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';

import '../../view_model/canvas_view_model.dart';

class ToolbarOrganism extends ToolBar {
  final BuildContext context;

  const ToolbarOrganism({
    super.key,
    required this.context,
  });

  @override
  bool get allowWallpaperTintingOverrides => true;

  @override
  bool get enableBlur => true;

  @override
  Widget? get title => const Text('Smart Sight');

  @override
  List<ToolbarItem>? get actions => [
        ToolBarPullDownButton(
          label: 'Opções de arquivos',
          icon: CupertinoIcons.photo_on_rectangle,
          items: [
            MacosPulldownMenuItem(
              title: const Text('Abrir imagem'),
              onTap: () => CanvasViewModel().openImage(),
            ),
            const MacosPulldownMenuItem(
              title: Text('Salvar imagem...'),
            ),
          ],
        ),
        const ToolBarSpacer(),
        ToolBarIconButton(
          label: 'Rodar filtros',
          tooltipMessage: 'Rodar filtros',
          showLabel: false,
          icon: const MacosIcon(CupertinoIcons.play_arrow_solid),
          onPressed: () => CanvasViewModel().applyFilters(),
        ),
        const ToolBarSpacer(),
        ToolBarIconButton(
          label: 'Mostrar processos',
          tooltipMessage: 'Mostrar processos',
          showLabel: false,
          icon: const MacosIcon(CupertinoIcons.sidebar_right),
          onPressed: () =>
              MacosWindowScope.maybeOf(context)?.toggleEndSidebar(),
        ),
      ];
}
