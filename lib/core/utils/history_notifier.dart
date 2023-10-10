import 'package:flutter/foundation.dart';

class HistoryNotifier<T> extends ValueNotifier<T> {
  HistoryNotifier(super.value);

  List<T> _history = [];

  int _undoIndex = 0;

  bool get canUndo => _undoIndex + 1 < _history.length;

  bool get canRedo => _undoIndex > 0;

  @override
  set value(T newValue) {
    if (super.value == newValue) return;

    _clearRedoHistory();
    _history.insert(0, value);

    super.value = newValue;
  }

  void undo() {
    if (canUndo) {
      super.value = _history[++_undoIndex];
    }
  }

  void redo() {
    if (canRedo) {
      super.value = _history[--_undoIndex];
    }
  }

  void reset() {
    if (_history.isNotEmpty) {
      final initialState = _history.last;
      _history.clear();
      super.value = initialState;
      _history.insert(0, initialState);
      _undoIndex = 0;
    }
  }

  void _clearRedoHistory() {
    _history = _history.sublist(_undoIndex, _history.length);
    _undoIndex = 0;
  }
}
