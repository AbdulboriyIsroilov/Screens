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
    final ThemeData theme = Theme.of(context);
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
            title: Text(local.general_notifications, style: theme.textTheme.bodyLarge),
            value: generalNotifications,
            onChanged: (val) {
              setState(() {
                generalNotifications = val;
              });
            },
          ),
          Divider(color: theme.colorScheme.inversePrimary),
          SwitchListTile(
            title: Text(local.sound, style: theme.textTheme.bodyLarge),
            value: sound,
            onChanged: (val) {
              setState(() {
                sound = val;
              });
            },
          ),
          Divider(color: theme.colorScheme.inversePrimary),
          SwitchListTile(
            title: Text(local.vibrate, style: theme.textTheme.bodyLarge),
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
