import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:smart_sight/view_model/canvas_view_model.dart';

class AddedFiltersListOrganism extends StatefulWidget {
  const AddedFiltersListOrganism({super.key});

  @override
  State<AddedFiltersListOrganism> createState() =>
      _AddedFiltersListOrganismState();
}

class _AddedFiltersListOrganismState extends State<AddedFiltersListOrganism> {
  int selectedFilterIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: MacosDynamicColor.resolve(
        MacosColors.underPageBackgroundColor,
        context,
      ),
      child: AnimatedBuilder(
        animation: CanvasViewModel().selectedFilters,
        builder: (_, child) {
          final filters = CanvasViewModel().selectedFilters.filters;

          return ReorderableListView.builder(
            shrinkWrap: true,
            itemCount: filters.length,
            buildDefaultDragHandles: false,
            itemBuilder: (context, index) {
              final filter = filters[index];

              bool isSelected = selectedFilterIndex == index;

              return ListTile(
                key: Key(index.toString()),
                onTap: () {
                  setState(() => selectedFilterIndex = index);
                  CanvasViewModel().selectFilter(filter);
                },
                title: Text(
                  'Filtro ${filter.name}',
                  style: MacosTheme.of(context).typography.body.copyWith(
                        color: MacosDynamicColor.resolve(
                          MacosColors.labelColor,
                          context,
                        ),
                      ),
                ),
                leading: MacosIconButton(
                  icon: const MacosIcon(CupertinoIcons.trash),
                  backgroundColor: MacosDynamicColor.resolve(
                    MacosColors.controlBackgroundColor,
                    context,
                  ),
                  onPressed: () {
                    setState(() {
                      CanvasViewModel().removeFilter(index);
                    });
                  },
                ),
                trailing: ReorderableDragStartListener(
                  index: index,
                  child: const MacosIcon(
                    CupertinoIcons.move,
                  ),
                ),
                selected: isSelected,
                tileColor: MacosDynamicColor.resolve(
                  MacosColors.underPageBackgroundColor,
                  context,
                ),
                selectedTileColor: MacosDynamicColor.resolve(
                  MacosColors.selectedControlBackgroundColor,
                  context,
                ),
              );
            },
            onReorder: (oldIndex, newIndex) {
              setState(() {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }

                CanvasViewModel().moveFilter(oldIndex, newIndex);
              });
            },
          );
        },
      ),
    );
  }
}
