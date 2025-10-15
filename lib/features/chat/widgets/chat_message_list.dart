import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_style.dart';

class ChatMessageList extends StatelessWidget {
  final List messages;
  final ScrollController scrollController;

  const ChatMessageList({
    super.key,
    required this.messages,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView.separated(
      controller: scrollController,
      padding: EdgeInsets.fromLTRB(25.w, 16.h, 25.w, 35.h),
      itemCount: messages.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final msg = messages[index];
        final isTo = msg["direction"] == "to";
        final message = msg["message"];
        final date = msg["date"];

        return Column(
          crossAxisAlignment: isTo ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              constraints: BoxConstraints(maxWidth: 255.w),
              decoration: BoxDecoration(
                color: isTo ? AppColors.grey : theme.colorScheme.onInverseSurface,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.r),
                  topRight: Radius.circular(10.r),
                  bottomLeft: Radius.circular(isTo ? 0 : 10.r),
                  bottomRight: Radius.circular(isTo ? 10.r : 0),
                ),
              ),
              child: Text(
                message,
                style: isTo ? AppStyles.w500s16 : AppStyles.w500s16w,
              ),
            ),
            Text(
              DateFormat("hh:mm a").format(DateTime.parse(date)),
              style: theme.textTheme.bodyLarge,
            ),
          ],
        );
      },
    );
  }
}
