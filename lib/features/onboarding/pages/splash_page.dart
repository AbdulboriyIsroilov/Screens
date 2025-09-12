import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:screens/core/router/routers.dart';
import 'package:screens/core/utils/app_colors.dart';
import 'package:screens/core/utils/app_svg.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({
    super.key,
  });

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  final tween = Tween<double>(begin: 0, end: 134);
  final alignmentTween = AlignmentTween(begin: Alignment.topRight,end: Alignment.center);
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
    Future.delayed(Duration(seconds: 4),(){
      context.go(Routers.onboarding);
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              "assets/image/splash_image.png",
              width: double.infinity,
              height: 627.h,
              fit: BoxFit.cover,
            ),
          ),
          AnimatedRotation(
            duration: Duration(seconds: 0),
            turns: controller.value * 1,
            child: Align(
              alignment: alignmentTween.evaluate(controller),
              child: SvgPicture.asset(
                AppSvgs.splash,
                width: tween.evaluate(controller).w,
                height: tween.evaluate(controller).h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
