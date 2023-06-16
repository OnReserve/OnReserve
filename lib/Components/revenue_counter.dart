import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RevenueCountUpAnimation extends StatefulWidget {
  final double endValue;
  final Duration duration;

  const RevenueCountUpAnimation({
    Key? key,
    required this.endValue,
    required this.duration,
  }) : super(key: key);

  @override
  _RevenueCountUpAnimationState createState() =>
      _RevenueCountUpAnimationState();
}

class _RevenueCountUpAnimationState extends State<RevenueCountUpAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    final endValue = widget.endValue;
    final startValue = 0.0;
    _animation = Tween<double>(
      begin: startValue,
      end: endValue,
    ).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        return Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '${_animation.value.toStringAsFixed(2).split('.')[0]} ',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // TextSpan(
              //   text: 'ETB',
              //   style: TextStyle(
              //     fontSize: 12.0,
              //     fontWeight: FontWeight.normal,
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }
}
