import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:screens/core/utils/app_colors.dart';
import 'package:screens/core/utils/app_svg.dart';
import 'package:screens/features/account/widgets/help_center_button.dart';
import 'package:screens/features/common/widgets/app_bar_common.dart';

import '../../../core/l10n/app_localizations.dart';

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    MyLocalizations local = MyLocalizations.of(context)!;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarCommon(
        title: local.help_center,
        activ: 4,
        onPressed: () {
          context.pop();
        },
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 15.h, 25.w, 100.h),
        child: Column(
          spacing: 14.h,
          children: [
            HelpCenterButton(svg: AppSvgs.headphones, title: "Customer Service"),
            HelpCenterButton(svg: AppSvgs.whatsapp, title: "Whatsapp"),
            HelpCenterButton(svg: AppSvgs.web, title: "Website"),
            HelpCenterButton(svg: AppSvgs.facebook, title: "Facebook"),
            HelpCenterButton(svg: AppSvgs.twitter, title: "Twitter"),
            HelpCenterButton(svg: AppSvgs.instagram, title: "Instagram"),
          ],
        ),
      ),
    );
  }
}
