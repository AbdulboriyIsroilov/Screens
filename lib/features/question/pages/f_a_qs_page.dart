import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:screens/core/utils/app_colors.dart';
import 'package:screens/core/utils/app_style.dart';
import 'package:screens/core/utils/enum_state.dart';
import 'package:screens/features/common/widgets/app_bar_common.dart';
import 'package:screens/features/common/widgets/loading_widget.dart';
import 'package:screens/features/home/widgets/search_text_field.dart';
import 'package:screens/features/question/managers/question_bloc.dart';
import 'package:screens/features/question/managers/question_state.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../common/widgets/bottom_navigation_bar_main.dart';

class FAQsPage extends StatefulWidget {
  const FAQsPage({super.key});

  @override
  State<FAQsPage> createState() => _FAQsPageState();
}

class _FAQsPageState extends State<FAQsPage> {
  final searchController = TextEditingController();
  int tanlanganIndex = 0;

  String qidiruv = '';

  @override
  Widget build(BuildContext context) {
    MyLocalizations local = MyLocalizations.of(context)!;
    final ThemeData theme = Theme.of(context);
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
        child: BlocBuilder<QuestionBloc, QuestionState>(
          builder: (context, state) => state.questionEnum == EnumState.loading
              ? LoadingWidget()
              : Column(
                  spacing: 16.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40.h,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.questionCategories.length,
                        separatorBuilder: (_, __) => SizedBox(width: 8.w),
                        itemBuilder: (context, index) {
                          final bool aktiv = tanlanganIndex == index;
                          return GestureDetector(
                            onTap: () => setState(() => tanlanganIndex = index),
                            child: Container(
                              height: 36.h,
                              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
                              decoration: BoxDecoration(
                                color: aktiv ? theme.colorScheme.onInverseSurface : Colors.transparent,
                                borderRadius: BorderRadius.circular(10.r),
                                border: BoxBorder.all(color: theme.colorScheme.inversePrimary, width: 1.5),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                state.questionCategories[index].title,
                                style: AppStyles.w500s16.copyWith(
                                  color: aktiv ? AppColors.white : theme.colorScheme.onPrimaryFixed,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SearchTextField(controller: searchController, maxWidth: 341, search: local.search_for_questions),
                    Expanded(
                      child: ListView.separated(
                        itemCount: state.question.length,
                        separatorBuilder: (_, __) => SizedBox(height: 8.h),
                        itemBuilder: (context, index) {
                          final faq = state.question[index];
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: theme.colorScheme.inversePrimary,width: 1.5),
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
                              title: Text(faq.title, style: theme.textTheme.bodyLarge),
                              childrenPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                              children: [
                                Text(faq.answer, style: theme.textTheme.bodySmall),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarMain(isActive: 4),
    );
  }
}
