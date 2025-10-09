import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:screens/core/utils/app_style.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/routers.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_svg.dart';

class BottomNavigationBarMain extends StatefulWidget {
  const BottomNavigationBarMain({
    super.key,
    required this.isActive,
  });

  final int isActive;

  @override
  State<BottomNavigationBarMain> createState() => _BottomNavigationBarMainState();
}

class _BottomNavigationBarMainState extends State<BottomNavigationBarMain> {
  late int _currentIndex;

  final List<String> _routes = [
    Routers.home,
    Routers.search,
    Routers.saved,
    Routers.cart,
    Routers.account,
  ];

  @override
  void initState() {
    _currentIndex = widget.isActive;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MyLocalizations local = MyLocalizations.of(context)!;
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
        unselectedItemColor: AppColors.greyDark,
        selectedLabelStyle: AppStyles.w500s12,
        unselectedLabelStyle: AppStyles.w500s12,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppSvgs.home,
              colorFilter: ColorFilter.mode(
                _currentIndex == 0 ? AppColors.black : AppColors.grey,
                BlendMode.modulate,
              ),
            ),
            label: local.home,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppSvgs.search,
              colorFilter: ColorFilter.mode(
                _currentIndex == 1 ? AppColors.black : AppColors.grey,
                BlendMode.modulate,
              ),
            ),
            label: local.search,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppSvgs.heart,
              colorFilter: ColorFilter.mode(
                _currentIndex == 2 ? AppColors.black : AppColors.grey,
                BlendMode.modulate,
              ),
            ),
            label: local.saved,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppSvgs.cart,
              colorFilter: ColorFilter.mode(
                _currentIndex == 3 ? AppColors.black : AppColors.grey,
                BlendMode.modulate,
              ),
            ),
            label: local.cart,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppSvgs.user,
              colorFilter: ColorFilter.mode(
                _currentIndex == 4 ? AppColors.black : AppColors.grey,
                BlendMode.modulate,
              ),
            ),
            label: local.account,
          ),
        ],
      ),
    );
  }
}
