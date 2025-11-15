// Add this to your theme extension file

import 'package:chat_app/common/theme/theme_class.dart';
import 'package:flutter/material.dart';

extension ThemeExtensions on BuildContext {
  // Check if dark mode
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  // Text styles - mapped to existing ChatAppTheme styles
  TextStyle get largeTitle => ChatAppTheme.largeTitle(isDark);
  TextStyle get title1 => ChatAppTheme.title1(isDark);
  TextStyle get title2 => ChatAppTheme.title2(isDark);
  TextStyle get title3 => ChatAppTheme.title3(isDark);
  TextStyle get headline => ChatAppTheme.headline(isDark);
  TextStyle get body => ChatAppTheme.body(isDark);
  TextStyle get callout => ChatAppTheme.callout(isDark);
  TextStyle get subheadline => ChatAppTheme.subheadline(isDark);
  TextStyle get footnote => ChatAppTheme.footnote(isDark);
  TextStyle get caption1 => ChatAppTheme.caption1(isDark);
  TextStyle get caption2 => ChatAppTheme.caption2(isDark);

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

  // Message text colors
  Color get sentMessageTextColor => ChatAppTheme.sentMessageTextColor(isDark);
  Color get receivedMessageTextColor => ChatAppTheme.receivedMessageTextColor(isDark);

  // Chat decorations
  BoxDecoration get sentMessageDecoration =>
      ChatAppTheme.sentMessageDecoration(isDark);
  BoxDecoration get receivedMessageDecoration =>
      ChatAppTheme.receivedMessageDecoration(isDark);

  // Spacing constants
  double get spacing2xs => ChatAppTheme.spacing2xs;
  double get spacingXs => ChatAppTheme.spacingXs;
  double get spacingSm => ChatAppTheme.spacingSm;
  double get spacingMd => ChatAppTheme.spacingMd;
  double get spacingLg => ChatAppTheme.spacingLg;
  double get spacingXl => ChatAppTheme.spacingXl;
  double get spacing2xl => ChatAppTheme.spacing2xl;

  // Border radius constants
  double get radiusSm => ChatAppTheme.radiusSm;
  double get radiusMd => ChatAppTheme.radiusMd;
  double get radiusLg => ChatAppTheme.radiusLg;
  double get radiusXl => ChatAppTheme.radiusXl;
  double get radiusFull => ChatAppTheme.radiusFull;
}