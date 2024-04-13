import 'package:flutter/material.dart';

class SingleDayTransactionAnimation extends StatefulWidget {
  const SingleDayTransactionAnimation(
      {super.key,
      required this.dayDifferenceFromStart,
      required this.child,
      required this.animationUpToSize});

  final int dayDifferenceFromStart;
  final Widget child;
  final double animationUpToSize;

  @override
  State<SingleDayTransactionAnimation> createState() =>
      _SingleDayTransactionAnimationState();
}

class _SingleDayTransactionAnimationState
    extends State<SingleDayTransactionAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController animate;
  late Animation<double> _sizeAnimation;
  @override
  void initState() {
    super.initState();
    animate = AnimationController(
        vsync: this,
        duration:
            Duration(milliseconds: 1100 + widget.dayDifferenceFromStart * 5));
    _sizeAnimation = Tween(begin: 0.0, end: widget.animationUpToSize).animate(
      CurvedAnimation(
        parent: animate,
        curve: const Interval(
          0,
          1,
          curve: Curves.bounceInOut,
        ),
      ),
    );
    animate.forward();
  }

  @override
  void dispose() {
    animate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animate,
      child: widget.child,
      builder: (BuildContext context, Widget? animationChild) {
        return SizedBox(
          height: _sizeAnimation.value,
          width: _sizeAnimation.value,
          child: animationChild,
        );
      },
    );
  }
}
