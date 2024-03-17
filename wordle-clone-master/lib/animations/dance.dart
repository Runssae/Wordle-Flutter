import 'package:flutter/material.dart';

class Dance extends StatefulWidget {
  const Dance(
      {required this.child,
      required this.animate,
      required this.delay,
      Key? key})
      : super(key: key);

  final Widget child;
  final bool animate;
  final int delay;

  @override
  State<Dance> createState() => _DanceState();
}

class _DanceState extends State<Dance> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    // Initialize animation controller and animation
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);

    _animation = TweenSequence<Offset>([
      TweenSequenceItem(
          tween: Tween(begin: const Offset(0, 0), end: const Offset(0, -0.80)),
          weight: 15),
      TweenSequenceItem(
          tween: Tween(begin: const Offset(0, -0.80), end: const Offset(0, 0)),
          weight: 10),
      TweenSequenceItem(
          tween: Tween(begin: const Offset(0, 0), end: const Offset(0, -0.30)),
          weight: 12),
      TweenSequenceItem(
          tween: Tween(begin: const Offset(0, -0.30), end: const Offset(0, 0)),
          weight: 8),
    ]).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine));

    super.initState();
  }

  @override
  void dispose() {
    // Dispose animation controller
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant Dance oldWidget) {
    // Trigger animation when widget is updated
    if (widget.animate) {
      Future.delayed(Duration(milliseconds: widget.delay), () {
        if (mounted) {
          _controller.forward();
        }
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    // Apply slide animation to the child widget
    return SlideTransition(
      position: _animation,
      child: widget.child,
    );
  }
}
