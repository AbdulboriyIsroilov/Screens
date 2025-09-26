import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:screens/core/utils/app_colors.dart';
import 'package:screens/core/utils/app_style.dart';
import 'package:screens/features/common/widgets/app_bar_common.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../common/widgets/bottom_navigation_bar_main.dart';

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() => _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  bool generalNotifications = true;
  bool sound = true;
  bool vibrate = false;

  @override
  Widget build(BuildContext context) {
    MyLocalizations local = MyLocalizations.of(context)!;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarCommon(
        title: local.notifications,
        activ: 4,
        onPressed: () {
          context.pop();
        },
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text(local.general_notifications, style: AppStyles.w500s16),
            value: generalNotifications,
            onChanged: (val) {
              setState(() {
                generalNotifications = val;
              });
            },
          ),
          Divider(color: AppColors.grey),
          SwitchListTile(
            title: Text(local.sound, style: AppStyles.w500s16),
            value: sound,
            onChanged: (val) {
              setState(() {
                sound = val;
              });
            },
          ),
          Divider(color: AppColors.grey),
          SwitchListTile(
            title: Text(local.vibrate, style: AppStyles.w500s16),
            value: vibrate,
            onChanged: (val) {
              setState(() {
                vibrate = val;
              });
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarMain(isActive: 4),
    );
  }
}
