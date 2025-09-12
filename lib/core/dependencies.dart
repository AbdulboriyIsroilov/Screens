import 'package:provider/provider.dart';

import '../features/common/managers/app_theme_view_model.dart';

final dependencies = [
  ChangeNotifierProvider(create: (context) => AppThemeViewModel()),
];
