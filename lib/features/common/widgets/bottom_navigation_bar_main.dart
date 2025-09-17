import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routers.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_svg.dart';

class BottomNavigationBarMain extends StatefulWidget {
  const BottomNavigationBarMain({super.key});

  @override
  State<BottomNavigationBarMain> createState() =>
      _BottomNavigationBarMainState();
}

class _BottomNavigationBarMainState extends State<BottomNavigationBarMain> {
  int _currentIndex = 0;

  final List<String> _routes = [
    Routers.home,
    Routers.home,
    Routers.home,
    Routers.home,
    Routers.home,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(
            color: AppColors.grey,
            width: 1,
          ),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
          context.go(_routes[index]);
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.black,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppSvgs.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppSvgs.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppSvgs.heart),
            label: "Saved",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppSvgs.cart),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppSvgs.user),
            label: "Account",
          ),
        ],
      ),
    );
  }
}
