import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screens/core/utils/app_svg.dart';

import '../../../core/utils/app_colors.dart';
import '../managers/home_bloc.dart';
import '../managers/home_event.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({
    super.key,
    required this.controller,
    this.maxWidth = 281,
    required this.search,
  });

  final TextEditingController controller;
  final double maxWidth;
  final String search;

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = widget.controller.text.trim();
    context.read<HomeBloc>().add(
      FetchProductsEvent(title: query.isEmpty ? null : query),
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onSearchChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return TextField(
      controller: widget.controller,
      style: theme.textTheme.bodyLarge,
      cursorColor: AppColors.black,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        constraints: BoxConstraints(
          minWidth: 280.w,
          maxWidth: widget.maxWidth.w,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: theme.colorScheme.inversePrimary, width: 1.5),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: theme.colorScheme.inversePrimary,width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: theme.colorScheme.inversePrimary,width: 1.5),
        ),
        hintText: widget.search,
        hintStyle: theme.textTheme.bodySmall,
        prefixIcon: IconButton(
          onPressed: () {}, // ixtiyoriy
          icon: SvgPicture.asset(AppSvgs.search),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            widget.controller.clear();
            context.read<HomeBloc>().add(const FetchProductsEvent(title: ""));
          },
          icon: SvgPicture.asset(AppSvgs.mic),
        ),
      ),
    );
  }
}
