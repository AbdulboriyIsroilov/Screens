import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:screens/features/notifications/managers/notifications_cubit.dart';
import 'package:screens/features/notifications/managers/notifications_state.dart';
import 'package:screens/features/notifications/widgets/notifications_day_widgets.dart';

import '../../../core/utils/app_svg.dart';
import '../../common/widgets/app_bar_common.dart';
import '../../common/widgets/bottom_navigation_bar_main.dart';
import '../../common/widgets/empty_widget.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBarCommon(
        title: "Notifications",
        action: false,
        onPressed: () {
          context.pop();
        },
        activ: 5,
      ),
      body: BlocProvider(
        create: (context) => NotificationsCubit(notificationsRepo: context.read()),
        child: BlocBuilder<NotificationsCubit, NotificationsState>(
          builder: (context, state) =>
              (state.notificationsBugun.isEmpty && state.notificationsKecha.isEmpty && state.notificationsEski.isEmpty)
              ? EmptyWidget(
                  title1: "You haven’t gotten any notifications yet!",
                  title2: "We’ll alert you when something cool happens.",
                  svg: AppSvgs.bellDuotone,
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(24.w, 0, 25.w, 100.h),
                    child: Column(
                      children: [
                        NotificationsDayWidgets(
                          state: state.notificationsBugun,
                          title: 'Today',
                        ),
                        NotificationsDayWidgets(
                          state: state.notificationsKecha,
                          title: 'Yesterday',
                        ),
                        NotificationsDayWidgets(
                          state: state.notificationsEski,
                          title: 'The Old Days',
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarMain(isActive: index),
    );
  }
}
