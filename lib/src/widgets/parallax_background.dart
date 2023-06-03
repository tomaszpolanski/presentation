import 'package:flutter/material.dart';
import 'package:presentation/src/widgets/animation_mode.dart';

export 'package:presentation/presentation.dart';

class AnimatedParallaxImage extends StatefulWidget {
  const AnimatedParallaxImage({
    super.key,
    required this.asset,
    this.package,
    this.opacity = 1,
  });

  final String asset;
  final String? package;
  final double opacity;

  @override
  _AnimatedParallaxImageState createState() => _AnimatedParallaxImageState();
}

class _AnimatedParallaxImageState extends State<AnimatedParallaxImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 160),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (AnimationMode.of(context)) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Image.asset(
          widget.asset,
          package: widget.package,
          color: Colors.white.withOpacity(widget.opacity),
          colorBlendMode: BlendMode.modulate,
          fit: BoxFit.fitHeight,
          alignment: FractionalOffset(_controller.value, 0),
        );
      },
    );
  }
}
