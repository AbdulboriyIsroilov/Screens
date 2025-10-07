import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

MaskTextInputFormatter expiryDateFormatter = MaskTextInputFormatter(
  mask: '##/##',
  filter: {"#": RegExp(r'\d')},
  type: MaskAutoCompletionType.eager,
);

MaskTextInputFormatter cardNumberFormatter = MaskTextInputFormatter(
  mask: '#### #### #### ####',
  filter: {"#": RegExp(r'\d')},
  type: MaskAutoCompletionType.eager,
);

MaskTextInputFormatter phoneNumberFormatter = MaskTextInputFormatter(
  mask: '+ 998 ## ### ## ##',
  filter: {"#": RegExp(r'\d')},
  type: MaskAutoCompletionType.lazy,
);

String maskCardNumber(String cardNumber) {
  // Faqat raqamlarni qoldiramiz
  final raqamlar = cardNumber.replaceAll(RegExp(r'\D'), '');
  if (raqamlar.isEmpty) return '';

  // Oxirgi 4 ta raqamni olish
  final oxirgiTort = raqamlar.substring(raqamlar.length - 4);

  // Yashirin qismini * bilan to‘ldiramiz
  final maskLength = raqamlar.length - 4;
  final mask = List.generate(maskLength, (index) => '*').join();

  // Har 4 belgidan keyin bo‘sh joy qo‘shamiz
  final formatlangan = (mask + oxirgiTort)
      .replaceAllMapped(RegExp(r'.{4}'), (match) => '${match.group(0)} ')
      .trim();

  return formatlangan;
}


