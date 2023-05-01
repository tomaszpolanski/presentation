import 'package:flutter/foundation.dart';
import 'package:presentation/src/presentation_controller.dart';

class PageStepper<T> extends Listenable {
  PageStepper({
    required this.controller,
    required this.steps,
  }) : _currentStep = steps.first;

  final List<T> steps;
  final PresentationController controller;
  T _currentStep;
  final List<_StepTransition<T>> _transitions = [];
  VoidCallback? _listenable;

  void addStep(
    T currentStep,
    T nextStep,
    VoidCallback transition,
  ) {
    _transitions.add(
      _StepTransition<T>(
        currentStep: currentStep,
        nextStep: nextStep,
        transition: transition,
      ),
    );
  }

  void add({
    required T fromStep,
    required T toStep,
    required VoidCallback forward,
    VoidCallback? reverse,
  }) {
    _transitions.add(
      _StepTransition<T>(
        currentStep: fromStep,
        nextStep: toStep,
        transition: forward,
      ),
    );
    if (reverse != null) {
      _transitions.add(
        _StepTransition<T>(
          currentStep: toStep,
          nextStep: fromStep,
          transition: reverse,
        ),
      );
    }
  }

  void next() {
    final nextStep = _getNextStep(_currentStep);
    if (nextStep != null) {
      _currentStep = _tryTransition(current: _currentStep, next: nextStep);
    } else {
      controller.nextSlide();
    }
  }

  void previous() {
    final nextStep = _getPreviousStep(_currentStep);
    if (nextStep != null) {
      _currentStep = _tryTransition(current: _currentStep, next: nextStep);
    } else {
      controller.previousSlide();
    }
  }

  T _tryTransition({required T current, required T next}) {
    final t = _transitions.firstWhereOrNull(
      (transition) =>
          transition.currentStep == _currentStep && transition.nextStep == next,
    );

    if (t != null) {
      t.transition();
      final l = _listenable;
      if (l != null) {
        l();
      }
      return next;
    } else {
      return _currentStep;
    }
  }

  void build() {
    controller.addListener(_handlePageAction);
  }

  void dispose() {
    controller.removeListener(_handlePageAction);
    _transitions.clear();
  }

  void _handlePageAction(PageAction action) {
    if (action == PageAction.next) {
      next();
    } else {
      previous();
    }
  }

  T? _getNextStep(T current) {
    final currentIndex = steps.indexOf(_currentStep);
    return currentIndex + 1 < steps.length ? steps[currentIndex + 1] : null;
  }

  T? _getPreviousStep(T current) {
    final currentIndex = steps.indexOf(_currentStep);
    return currentIndex - 1 >= 0 ? steps[currentIndex - 1] : null;
  }

  @override
  void addListener(VoidCallback listener) {
    _listenable = listener;
  }

  @override
  void removeListener(VoidCallback listener) {
    if (_listenable == listener) {
      _listenable = null;
    }
  }
}

class _StepTransition<T> {
  const _StepTransition({
    required this.currentStep,
    required this.nextStep,
    required this.transition,
  });

  final T currentStep;
  final T nextStep;
  final VoidCallback transition;
}

extension ListEx<E> on List<E> {
  E? firstWhereOrNull(bool Function(E element) test) {
    for (final element in this) {
      if (test(element)) {
        return element;
      }
    }
    return null;
  }
}
