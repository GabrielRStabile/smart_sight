// ignore_for_file: invalid_use_of_visible_for_overriding_member

import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:smart_sight/view/organisms/added_filters_list_organism.dart';
import 'package:smart_sight/view_model/canvas_view_model.dart';

class FiltersConfigurationSidebarOrganism extends StatefulWidget {
  const FiltersConfigurationSidebarOrganism({super.key});

  @override
  State<FiltersConfigurationSidebarOrganism> createState() =>
      _FiltersConfigurationSidebarOrganismState();
}

class _FiltersConfigurationSidebarOrganismState
    extends State<FiltersConfigurationSidebarOrganism> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CupertinoSlidingSegmentedControl(
          children: const {
            0: Text('        􀤐        '),
            1: Text('        􀥏        '),
          },
          thumbColor: MacosColors.controlAccentColor,
          groupValue: currentIndex,
          onValueChanged: (index) {
            setState(() {
              currentIndex = index as int;
            });
          },
        ),
        const SizedBox(height: 24),
        IndexedStack(
          alignment: Alignment.topCenter,
          index: currentIndex,
          children: const [
            AddedFiltersListOrganism(),
            ConfigurationFilterOrganism(),
          ],
        ),
      ],
    );
  }
}

class ConfigurationFilterOrganism extends StatelessWidget {
  const ConfigurationFilterOrganism({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CanvasViewModel().selectedFilter,
      builder: (_, filter, child) {
        return Column(
          children: [
            const SizedBox(height: 24),
            Text(
              'Configurações',
              style: MacosTheme.of(context).typography.title2,
            ),
            const SizedBox(height: 24),
            if (filter != null)
              ...filter.params.map((param) {
                return Container(
                  width: 400,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        param.name,
                        style: MacosTheme.of(context).typography.body,
                      ),
                      const SizedBox(height: 8),
                      Builder(
                        builder: (context) {
                          return param.widget;
                        },
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                );
              }).toList(),
          ],
        );
      },
    );
  }
}
