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

