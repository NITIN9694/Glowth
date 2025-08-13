

import 'package:flutter/material.dart';
import 'package:glowth/style/app_size.dart';
import 'package:glowth/style/app_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ArrowButtonAnimation extends StatefulWidget {

  const ArrowButtonAnimation({super.key});

  @override
  State<ArrowButtonAnimation> createState() => _ArrowButtonAnimationState();
}

class _ArrowButtonAnimationState extends State<ArrowButtonAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFF7A3CFF), // main purple color
          border: Border.all(
            color: const Color(0xFFB084FF), // border purple shade
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF7A3CFF).withOpacity(0.4),
              blurRadius: 20,
              spreadRadius: 5,
            )
          ],
        ),
        child:  Center(
          child: Icon(
            Icons.arrow_forward_rounded,
            color: Colors.white,
            size: 28,
          ),
        ),
      ),
    );
  }
}



class SubmitButtonAnimation extends StatefulWidget {
  const SubmitButtonAnimation({super.key});

  @override
  State<SubmitButtonAnimation> createState() => _SubmitButtonAnimationState();
}

class _SubmitButtonAnimationState extends  State<SubmitButtonAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Center(
        child: Container(
          height: 50.h,
          width: 170.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: const Color(0xFF7A3CFF), // main purple color
            border: Border.all(
              color: const Color(0xFFB084FF), // border purple shade
              width: 3,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF7A3CFF).withOpacity(0.4),
                blurRadius: 20,
                spreadRadius: 5,
              )
            ],
          ),
          child:  Center(
            child:Text("Submit",
            style: mediumTextStyle(fontSize: dimen16, color: Colors.white),
            )
          ),
        ),
      ),
    );
  }
}
