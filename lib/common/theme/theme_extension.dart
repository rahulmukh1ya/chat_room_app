// Add this to the bottom of your chat_app_theme.dart file

import 'package:chat_app/common/theme/theme_class.dart';
import 'package:flutter/material.dart';

extension ThemeExtensions on BuildContext {
  // Check if dark mode
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  // Text styles
  TextStyle get headline1 => ChatAppTheme.headline1(isDark);
  TextStyle get headline2 => ChatAppTheme.headline2(isDark);
  TextStyle get headline3 => ChatAppTheme.headline3(isDark);
  TextStyle get bodyLarge => ChatAppTheme.bodyLarge(isDark);
  TextStyle get bodyMedium => ChatAppTheme.bodyMedium(isDark);
  TextStyle get bodySmall => ChatAppTheme.bodySmall(isDark);
  TextStyle get caption => ChatAppTheme.caption(isDark);
  TextStyle get button => ChatAppTheme.button(isDark);

  // Colors
  Color get textPrimary => ChatAppTheme.textPrimary(isDark);
  Color get textSecondary => ChatAppTheme.textSecondary(isDark);
  Color get textTertiary => ChatAppTheme.textTertiary(isDark);
  Color get successColor => ChatAppTheme.successColor(isDark);
  Color get warningColor => ChatAppTheme.warningColor(isDark);
  Color get infoColor => ChatAppTheme.infoColor(isDark);

  // Chat bubble colors
  Color get sentBubbleColor => ChatAppTheme.sentBubbleColor(isDark);
  Color get receivedBubbleColor => ChatAppTheme.receivedBubbleColor(isDark);
  Color get receivedBubbleBorder => ChatAppTheme.receivedBubbleBorder(isDark);

  // Chat decorations
  BoxDecoration get sentMessageDecoration =>
      ChatAppTheme.sentMessageDecoration(isDark);
  BoxDecoration get receivedMessageDecoration =>
      ChatAppTheme.receivedMessageDecoration(isDark);
}
