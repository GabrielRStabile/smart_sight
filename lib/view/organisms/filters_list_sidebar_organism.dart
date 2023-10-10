import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:smart_sight/model/color_conversion.dart';
import 'package:smart_sight/model/edge_detection.dart';
import 'package:smart_sight/model/filter_entity.dart';
import 'package:smart_sight/model/filters.dart';
import 'package:smart_sight/view_model/canvas_view_model.dart';

class FiltersListSidebarOrganism extends StatefulWidget {
  const FiltersListSidebarOrganism({super.key});

  @override
  State<FiltersListSidebarOrganism> createState() =>
      _FiltersListSidebarOrganismState();
}

class _FiltersListSidebarOrganismState
    extends State<FiltersListSidebarOrganism> {
  final List<FilterEntity> filterList = [
    BGRToBW(),
    BGRToHSL(),
    GaussianBlur(),
    SobelEdgeDetector(),
    Noise(),
  ];

  @override
  Widget build(BuildContext context) {
    final secondaryColor = MacosDynamicColor.resolve(
      MacosColors.secondaryLabelColor,
      context,
    );

    final plusIcon = MacosIcon(
      CupertinoIcons.plus_app,
      size: 16,
      color: secondaryColor,
    );

    return SidebarItems(
      currentIndex: 0,
      itemSize: SidebarItemSize.large,
      onChanged: (index) {
        CanvasViewModel().addFilter(filterList[index - 1]);
      },
      items: [
        const SidebarItem(
          leading: MacosIcon(CupertinoIcons.home),
          label: Text('Dashboard'),
        ),
        SidebarItem(
          label: const Text('Conversão de cores'),
          disclosureItems: [
            SidebarItem(
              trailing: plusIcon,
              label: const Text('BGR para BW'),
            ),
            SidebarItem(
              trailing: plusIcon,
              label: const Text('BGR para HSL'),
            ),
          ],
        ),
        SidebarItem(
          label: const Text('Filtros'),
          disclosureItems: [
            SidebarItem(
              trailing: plusIcon,
              label: const Text('Gaussian Blur'),
            ),
          ],
        ),
        SidebarItem(
          label: const Text('Detecção de bordas'),
          disclosureItems: [
            SidebarItem(
              trailing: plusIcon,
              label: const Text('Sobel'),
            ),
          ],
        ),
        SidebarItem(
          label: const Text('Ruído'),
          disclosureItems: [
            SidebarItem(
              trailing: plusIcon,
              label: const Text('Ruído'),
            ),
          ],
        ),
        SidebarItem(
          label: const Text('Morfologia Matemática'),
          disclosureItems: [
            SidebarItem(
              trailing: plusIcon,
              label: const Text('Erosão'),
            ),
            SidebarItem(
              trailing: plusIcon,
              label: const Text('Dilatação'),
            ),
          ],
        ),
      ],
    );
  }
}
