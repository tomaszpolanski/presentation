import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AndroidKeys {
  static const pageUpKey = 266;
  static const pageDownKey = 267;
  static const leftKey = 263;
  static const rightKey = 262;
  static const downKey = 264;
  static const upKey = 265;
}

class MacOSKeys {
  static const escapeKey = 53;
  static const spaceKey = 49;
  static const pageUpKey = 116;
  static const pageDownKey = 121;
  static const leftKey = 123;
  static const rightKey = 124;
  static const downKey = 125;
  static const upKey = 126;
}

class WindowsKeys {
  static const leftKey = 37;
  static const rightKey = 39;
  static const pageUpKey = 38;
  static const pageDownKey = 40;
}

class PresentationController {
  PresentationController({@required this.controller})
      : assert(controller != null) {
    _keyboard.addListener(_handleKey);
  }

  final PageController controller;
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
      _handleRawKeys(_returnKeyCode(value));
    }
  }

  int _returnKeyCode(RawKeyEvent value) {
    final data = value.data;
    if (data is RawKeyEventDataLinux) {
      return data.keyCode;
    } else if (data is RawKeyEventDataMacOs) {
      return data.keyCode;
    } else if (data is RawKeyEventDataAndroid) {
      return data.keyCode;
    } else {
      return -1;
    }
  }

  void _handleRawKeys(int keyCode) {
    switch (keyCode) {
      case 20:
      case 21:
      case AndroidKeys.leftKey:
      case AndroidKeys.pageUpKey:
      case AndroidKeys.upKey:
      case WindowsKeys.leftKey:
      case WindowsKeys.pageUpKey:
      case MacOSKeys.leftKey:
      case MacOSKeys.pageUpKey:
      case MacOSKeys.upKey:
        _sendAction(PageAction.previous);
        break;
      case 19:
      case 22:
      case AndroidKeys.rightKey:
      case AndroidKeys.pageDownKey:
      case AndroidKeys.downKey:
      case WindowsKeys.rightKey:
      case WindowsKeys.pageDownKey:
      case MacOSKeys.rightKey:
      case MacOSKeys.pageDownKey:
      case MacOSKeys.downKey:
        _sendAction(PageAction.next);
        break;
      default:
        break;
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
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void nextSlide() {
    controller.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}

enum PageAction {
  next,
  previous,
}
