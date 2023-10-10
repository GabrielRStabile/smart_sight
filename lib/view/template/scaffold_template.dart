import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:smart_sight/view/organisms/filters_configuration_sidebar_organism.dart';
import 'package:smart_sight/view/organisms/filters_list_sidebar_organism.dart';
import 'package:smart_sight/view/organisms/toolbar_organism.dart';

import '../../view_model/canvas_view_model.dart';

class ScaffoldTemplate extends StatelessWidget {
  final Widget child;

  const ScaffoldTemplate({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return PlatformMenuBar(
      menus: [
        const PlatformMenu(
          label: 'SmartSight',
          menus: [
            PlatformProvidedMenuItem(
              type: PlatformProvidedMenuItemType.about,
            ),
            PlatformProvidedMenuItem(
              type: PlatformProvidedMenuItemType.quit,
            ),
          ],
        ),
        PlatformMenu(
          label: 'Arquivo',
          menus: [
            PlatformMenuItem(
              label: 'Abrir imagem...',
              onSelected: () => CanvasViewModel().openImage(),
            ),
          ],
        ),
      ],
      child: MacosWindow(
        endSidebar: Sidebar(
          shownByDefault: false,
          minWidth: 250,
          topOffset: 12,
          builder: (_, __) => const FiltersConfigurationSidebarOrganism(),
        ),
        sidebar: Sidebar(
          minWidth: 250,
          builder: (_, __) => const FiltersListSidebarOrganism(),
        ),
        child: Builder(
          builder: (context) {
            return MacosScaffold(
              toolBar: ToolbarOrganism(context: context),
              children: [
                ContentArea(
                  builder: (_, __) {
                    return child;
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
