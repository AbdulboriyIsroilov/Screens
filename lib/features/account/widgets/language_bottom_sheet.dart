import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screens/core/utils/app_svg.dart';

import '../../common/managers/localizatoin_cubit.dart';

class LanguageBottomSheet extends StatefulWidget {
  final dynamic local; // sizning localization obyekt
  const LanguageBottomSheet({super.key, required this.local});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  late String tanlanganTil;

  @override
  void initState() {
    super.initState();
    final locale = context.read<LocalizationCubit>().locals;
    if (locale == "uz") {
      tanlanganTil = "O‘zbekcha";
    } else if (locale == "ru") {
      tanlanganTil = "Русский";
    } else {
      tanlanganTil = "English";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390.w,
      height: 350.h,
      padding: EdgeInsets.fromLTRB(24.5.w, 30.h, 24.5.w, 31.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 15.h,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.local.switch_language,
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: SvgPicture.asset(AppSvgs.cancel),
              ),
            ],
          ),
          SizedBox(height: 5.h),

          // 🇺🇿 O'zbekcha
          _buildLanguageRow(
            flag: AppSvgs.uz,
            title: "O‘zbekcha",
            localeCode: "uz",
          ),

          // 🇬🇧 English
          _buildLanguageRow(
            flag: AppSvgs.en,
            title: "English",
            localeCode: "en",
          ),

          // 🇷🇺 Русский
          _buildLanguageRow(
            flag: AppSvgs.ru,
            title: "Русский",
            localeCode: "ru",
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageRow({
    required String flag,
    required String title,
    required String localeCode,
  }) {
    final ThemeData theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          spacing: 10.w,
          children: [
            SvgPicture.asset(flag),
            Text(title, style: theme.textTheme.bodyMedium),
          ],
        ),
        Radio<String>(
          value: title,
          groupValue: tanlanganTil,
          onChanged: (value) {
            context.read<LocalizationCubit>().changeLocale(locale: localeCode);
            setState(() => tanlanganTil = value!);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
