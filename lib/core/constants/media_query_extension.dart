import 'package:flutter/widgets.dart';

extension MediaQuerySize on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
}
