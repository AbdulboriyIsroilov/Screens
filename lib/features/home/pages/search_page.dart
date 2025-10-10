import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:screens/core/utils/app_colors.dart';
import 'package:screens/core/utils/app_style.dart';
import 'package:screens/core/utils/app_svg.dart';
import 'package:screens/features/common/widgets/app_bar_common.dart';
import 'package:screens/features/common/widgets/empty_widget.dart';
import 'package:screens/features/common/widgets/loading_widget.dart';
import 'package:screens/features/home/widgets/search_text_field.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/routers.dart';
import '../../common/widgets/bottom_navigation_bar_main.dart';
import '../managers/home_bloc.dart';
import '../managers/home_state.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MyLocalizations local = MyLocalizations.of(context)!;
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) => Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        appBar: AppBarCommon(
          title: local.search,
          activ: 1,
          onPressed: (){context.go(Routers.home);},
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(55.h),
            child: SearchTextField(
              controller: controller,
              search: local.search_for_clothes,
              maxWidth: 341,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(24.w, 5.h, 25.w, 0.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (state.loading) ...[
                const LoadingWidget(),
              ] else if (state.product.isEmpty) ...[
                EmptyWidget(
                  title1: "No Results Found!",
                  title2: "Try a similar word or something more general.",
                  svg: AppSvgs.searchDuotone,
                ),
              ] else ...[
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.only(top: 20.h, bottom: 100.h),
                    itemCount: state.product.length,
                    separatorBuilder: (context, index) => SizedBox(height: 20.h),
                    itemBuilder: (context, index) {
                      final mahsulot = state.product[index];
                      return Column(
                        spacing: 12.h,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                spacing: 12.w,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(6.r),
                                    child: Image.network(
                                      mahsulot.image,
                                      width: 56.w,
                                      height: 53.3.h,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        mahsulot.title,
                                        style: AppStyles.w600s16,
                                      ),
                                      Text(
                                        "\$ ${mahsulot.price}",
                                        style: AppStyles.w500s12,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  context.push(
                                      Routers.productDetailsById(id: state.product[index].id)
                                  );
                                },
                                child: SvgPicture.asset(AppSvgs.arrowTop),
                              ),
                            ],
                          ),
                          index == state.product.length - 1 ? SizedBox() : Divider(color: AppColors.grey),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBarMain(isActive: 1),
      ),
    );
  }
}
