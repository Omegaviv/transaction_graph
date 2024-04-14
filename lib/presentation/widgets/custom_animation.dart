import 'package:card_transactions/presentation/widgets/credit_card.dart';
import 'package:flutter/material.dart';
import 'dart:math' show pi;

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

class CreditCardPreviewAnimation extends StatefulWidget {
  const CreditCardPreviewAnimation({super.key});

  @override
  State<CreditCardPreviewAnimation> createState() =>
      _CreditCardPreviewAnimationState();
}

class _CreditCardPreviewAnimationState extends State<CreditCardPreviewAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _xController;
  late AnimationController _yController;
  late AnimationController _zController;
  late Tween<double> _animation;
  late Tween<double> _yanimation;
  late Tween<double> _zanimation;

  @override
  void initState() {
    super.initState();

    _xController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _yController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 7),
    );

    _zController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );

    _animation = Tween<double>(
      begin: 0,
      end: -pi / 7,
    );

    _yanimation = Tween<double>(
      begin: 0,
      end: pi / 8,
    );

    _zanimation = Tween<double>(
      begin: 0,
      end: pi / 15,
    );
    _xController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _xController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _xController.forward();
      }
    });

    _yController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _yController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _yController.forward();
      }
    });

    _zController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _zController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _zController.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _xController.dispose();
    _yController.dispose();
    _zController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _xController.forward();

    _yController.forward();

    _zController.forward();
    return AnimatedBuilder(
      animation: Listenable.merge([
        _xController,
        _yController,
        _zController,
      ]),
      builder: (context, child) {
        return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..rotateX(_animation.evaluate(_xController))
              ..rotateY(_yanimation.evaluate(_yController))
              ..rotateZ(_zanimation.evaluate(_zController)),
            child: child);
      },
      child: const CreditCard(
          color: Color(0xFF090943),
          cardExpiration: "08/2027",
          cardHolder: "VIVEK VERMA",
          cardNumber: "3546 7532 XXXX 9742"),
    );
  }
}
