// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:smart_sight/model/filter_entity.dart';

import '../core/utils/history_notifier.dart';
import '../model/image_picker_provider.dart';

class CanvasViewModel {
  static final CanvasViewModel _instance = CanvasViewModel._internal();
  factory CanvasViewModel() => _instance;
  CanvasViewModel._internal();

  final openedImage = HistoryNotifier<Uint8List?>(null);

  Uint8List? originalImage;

  final selectedFilters = FilterList();

  final selectedFilter = ValueNotifier<FilterEntity?>(null);

  void openImage() async {
    final path = await ImagePickerProvider().pickImage();

    if (path == null) return;

    final image = await File(path).readAsBytes();

    openedImage.reset();
    originalImage = image;
    openedImage.value = image;
  }

  Future<void> applyFilters() async {
    if (openedImage.value == null) return;

    var image = originalImage!;

    for (final filter in selectedFilters.filters) {
      image = (await filter.onApplyFilter(image))!;
    }

    openedImage.value = image;
  }

  void addFilter(FilterEntity filter) {
    selectedFilters.addFilter(filter);
  }

  void removeFilter(int index) {
    selectedFilters.removeFilter(index);
  }

  void moveFilter(int oldIndex, int newIndex) {
    selectedFilters.moveFilter(oldIndex, newIndex);
  }

  void selectFilter(FilterEntity filter) {
    selectedFilter.value = filter;
  }
}

class FilterList extends ChangeNotifier {
  final List<FilterEntity> _filters = [];

  List<FilterEntity> get filters => _filters;

  void addFilter(FilterEntity filter) {
    _filters.add(filter);
    notifyListeners();
  }

  void removeFilter(int index) {
    _filters.removeAt(index);
    notifyListeners();
  }

  void moveFilter(int oldIndex, int newIndex) {
    final filter = _filters.removeAt(oldIndex);
    _filters.insert(newIndex, filter);
    notifyListeners();
  }
}
