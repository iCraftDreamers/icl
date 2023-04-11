import 'package:flutter/material.dart';
import 'package:get/get.dart';

class _FadeTransitionController extends GetxController
    with GetSingleTickerProviderStateMixin {
  _FadeTransitionController({this.duration, this.delay});

  late AnimationController _controller;
  late Animation<double> _animation;
  final int? delay;
  final Duration? duration;

  @override
  void onInit() {
    super.onInit();
    _controller = AnimationController(
      duration: duration ?? const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    Future.delayed(Duration(milliseconds: delay ?? 0))
        .then((_) => _controller.forward());
  }

  @override
  void onClose() {
    _controller.dispose();
    super.onClose();
  }
}

class FadeTransitionBuilder extends StatelessWidget {
  const FadeTransitionBuilder({
    super.key,
    required this.child,
    this.delay,
    this.duration,
  });

  final Widget child;
  final int? delay;
  final Duration? duration;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<_FadeTransitionController>(
      init: _FadeTransitionController(duration: duration, delay: delay),
      builder: (controller) => AnimatedBuilder(
        animation: controller._animation,
        builder: (context, child) {
          return FadeTransition(
            opacity: controller._animation,
            child: child,
          );
        },
        child: child,
      ),
    );
  }
}
