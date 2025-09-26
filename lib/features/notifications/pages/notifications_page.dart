import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:screens/features/common/widgets/loading_widget.dart';
import 'package:screens/features/notifications/managers/notifications_bloc.dart';
import 'package:screens/features/notifications/managers/notifications_state.dart';
import 'package:screens/features/notifications/widgets/notifications_day_widgets.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/utils/app_svg.dart';
import '../../common/widgets/app_bar_common.dart';
import '../../common/widgets/bottom_navigation_bar_main.dart';
import '../../common/widgets/empty_widget.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    MyLocalizations local = MyLocalizations.of(context)!;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      appBar: AppBarCommon(
        title: local.notifications,
        action: false,
        onPressed: () {
          context.pop();
        },
        activ: 5,
      ),
      body: BlocProvider(
        create: (context) => NotificationsBloc(notificationsRepo: context.read()),
        child: BlocBuilder<NotificationsBloc, NotificationsState>(
          builder: (context, state) => state.loading
              ? LoadingWidget()
              : (state.notificationsBugun.isEmpty &&
                    state.notificationsKecha.isEmpty &&
                    state.notificationsEski.isEmpty)
              ? EmptyWidget(
                  title1: local.notifications_null_title1,
                  title2: local.notifications_null_title2,
                  svg: AppSvgs.bellDuotone,
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(24.w, 20.h, 25.w, 100.h),
                    child: Column(
                      children: [
                        NotificationsDayWidgets(
                          state: state.notificationsBugun,
                          title: local.today,
                          day: 1,
                        ),
                        NotificationsDayWidgets(
                          state: state.notificationsKecha,
                          title: local.yesterday,
                          day: 2,
                        ),
                        NotificationsDayWidgets(
                          state: state.notificationsEski,
                          title: local.the_old_days,
                          day: 3,
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
