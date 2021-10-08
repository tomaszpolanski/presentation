import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PresentationController {
  PresentationController({
    required this.controller,
    this.animationDuration = const Duration(milliseconds: 300),
  }) {
    _keyboard.addListener(_handleKey);
  }

  final PageController controller;
  final Duration animationDuration;
  final RawKeyboard _keyboard = RawKeyboard.instance;
  final List<ValueChanged<PageAction>> _listeners =
      <ValueChanged<PageAction>>[];

  void addListener(ValueChanged<PageAction> listener) {
    _listeners.add(listener);
  }

  void removeListener(ValueChanged<PageAction> listener) {
    _listeners.remove(listener);
  }

  void dispose() {
    _keyboard.removeListener(_handleKey);
  }

  void _handleKey(RawKeyEvent value) {
    if (value is RawKeyUpEvent) {
      if (value.logicalKey == LogicalKeyboardKey.arrowLeft ||
          value.logicalKey == LogicalKeyboardKey.arrowUp ||
          value.logicalKey == LogicalKeyboardKey.pageUp) {
        _sendAction(PageAction.previous);
      } else if (value.logicalKey == LogicalKeyboardKey.arrowRight ||
          value.logicalKey == LogicalKeyboardKey.arrowDown ||
          value.logicalKey == LogicalKeyboardKey.pageDown) {
        _sendAction(PageAction.next);
      }
    }
  }

  void _sendAction(PageAction action) {
    if (_listeners.isEmpty) {
      switch (action) {
        case PageAction.next:
          nextSlide();
          break;
        case PageAction.previous:
          previousSlide();
          break;
      }
    } else {
      for (final ValueChanged<PageAction> listener in _listeners) {
        listener(action);
      }
    }
  }

  void nextStep() => _sendAction(PageAction.next);

  void previousStep() => _sendAction(PageAction.previous);

  void previousSlide() {
    controller.previousPage(
      duration: animationDuration,
      curve: Curves.easeOut,
    );
  }

  void nextSlide() {
    controller.nextPage(
      duration: animationDuration,
      curve: Curves.easeOut,
    );
  }
}

enum PageAction {
  next,
  previous,
}
