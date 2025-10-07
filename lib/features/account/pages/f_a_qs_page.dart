import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:screens/core/utils/app_colors.dart';
import 'package:screens/core/utils/app_list.dart';
import 'package:screens/core/utils/app_style.dart';
import 'package:screens/features/common/widgets/app_bar_common.dart';
import 'package:screens/features/home/widgets/search_text_field.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../common/widgets/bottom_navigation_bar_main.dart';

class FAQsPage extends StatefulWidget {
  const FAQsPage({super.key});

  @override
  State<FAQsPage> createState() => _FAQsPageState();
}

class _FAQsPageState extends State<FAQsPage> {
  final searchController = TextEditingController();
  final List<String> filterlar = ['General', 'Account', 'Service', 'Payment'];
  int tanlanganIndex = 0;


  String qidiruv = '';

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> filterFaq = AppList.faqList
        .where((faq) => faq['savol']!.toLowerCase().contains(qidiruv.toLowerCase()))
        .toList();
    MyLocalizations local = MyLocalizations.of(context)!;
    return Scaffold(
      extendBody: true,
      appBar: AppBarCommon(
        title: local.f_a_qs,
        activ: 4,
        onPressed: () {
          context.pop();
        },
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 24.h, 25.w, 56.h),
        child: Column(
          spacing: 16.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: filterlar.length,
                separatorBuilder: (_, __) => SizedBox(width: 8.w),
                itemBuilder: (context, index) {
                  final bool aktiv = tanlanganIndex == index;
                  return GestureDetector(
                    onTap: () => setState(() => tanlanganIndex = index),
                    child: Container(
                      height: 36.h,
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
                      decoration: BoxDecoration(
                        color: aktiv ? AppColors.black : AppColors.white,
                        borderRadius: BorderRadius.circular(10.r),
                        border: BoxBorder.all(color: AppColors.grey),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        filterlar[index],
                        style: AppStyles.w500s16.copyWith(color: aktiv ? Colors.white : Colors.black),
                      ),
                    ),
                  );
                },
              ),
            ),
            SearchTextField(controller: searchController, maxWidth: 341, search: local.search_for_questions),
            Expanded(
              child: ListView.separated(
                itemCount: filterFaq.length,
                separatorBuilder: (_, __) => SizedBox(height: 8.h),
                itemBuilder: (context, index) {
                  final faq = filterFaq[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: ExpansionTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      title: Text(faq['savol']!, style: AppStyles.w500s16),
                      childrenPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                      children: [
                        Text(faq['javob']!, style: AppStyles.w400s12),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarMain(isActive: 4),
    );
  }
}
