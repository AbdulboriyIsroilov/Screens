import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screens/core/utils/app_colors.dart';
import 'package:screens/core/utils/app_style.dart';
import 'package:screens/data/models/notifications_models/notifications_model.dart';

class NotificationsDayWidgets extends StatelessWidget {
  const NotificationsDayWidgets({
    super.key,
    required this.state,
    required this.title,
  });

  final List<NotificationsModel> state;
  final String title;

  @override
  Widget build(BuildContext context) {
    return state.isEmpty ? SizedBox() : Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 15.h,
      children: [
        Divider(color: AppColors.grey),
        Text(
          title,
          style: AppStyles.w600s16,
        ),
        ...List.generate(state.length, (index) {
          return Row(
            spacing: 13.w,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.network(
                state[index].icon,
                width: 20.w,
                height: 20.h,
              ),
              Column(
                spacing: 2,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state[index].title,
                    style: AppStyles.w600s15,
                    maxLines: 1,
                  ),
                  Text(
                    state[index].content,
                    style: AppStyles.w400s12,
                    maxLines: 1,
                  ),
                  SizedBox(height: 10.h),
                  index == state.length-1 ? SizedBox() : Container(
                    width: 304.w,
                    height: 1,
                    color: AppColors.grey,
                  ),
                ],
              ),
            ],
          );
        }),
      ],
    );
  }
}
