import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:screens/core/utils/app_style.dart';
import 'package:screens/core/utils/app_svg.dart';
import 'package:screens/data/models/reviews_models/reviews_model.dart';

class ReviewsWidget extends StatelessWidget {
  const ReviewsWidget({
    super.key,
    required this.review,
  });

  final ReviewsModel review;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      spacing: 6.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 6.w,
          children: List.generate(5, (i) {
            return i < review.rating
                ? SizedBox(
                    width: 17.w,
                    height: 15.5.h,
                    child: SvgPicture.asset(AppSvgs.star),
                  )
                : SizedBox(
                    width: 17.w,
                    height: 15.5.h,
                    child: SvgPicture.asset(AppSvgs.starBloon),
                  );
          }),
        ),
        Text(
          review.comment,
          style: AppStyles.w400s14,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Row(
          spacing: 8.w,
          children: [
            Text(
              review.userFullName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "• ${DateFormat('d MMM, HH:mm').format(DateTime.parse(review.created))}",
              style: AppStyles.w400s14,
            ),
          ],
        ),
        Divider(
          color: theme.colorScheme.inversePrimary,
        ),
      ],
    );
  }
}
