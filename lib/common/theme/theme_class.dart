import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Apple-Inspired Minimalist Theme
/// Pure black and white design with subtle grays
class ChatAppTheme {
  // ============================================================================
  // COLOR PALETTE - Light Mode (Apple iOS/macOS inspired)
  // ============================================================================
  static const _lightPrimary = Color(0xFF000000); // Pure black
  static const _lightSecondary = Color(0xFF1C1C1E); // Dark gray

  static const _lightBackground = Color(0xFFFFFFFF); // Pure white
  static const _lightSurface = Color(0xFFFAFAFA); // Off-white
  static const _lightSurfaceVariant = Color(0xFFF2F2F7); // Light gray

  static const _lightError = Color(0xFF000000);
  static const _lightSuccess = Color(0xFF1C1C1E);
  static const _lightWarning = Color(0xFF3A3A3C);
  static const _lightInfo = Color(0xFF000000);

  // Text colors
  static const _lightTextPrimary = Color(0xFF000000);
  static const _lightTextSecondary = Color(0xFF3A3A3C);
  static const _lightTextTertiary = Color(0xFF8E8E93);

  // Borders and dividers
  static const _lightBorder = Color(0xFFE5E5EA);
  static const _lightDivider = Color(0xFFD1D1D6);

  // Chat-specific colors
  static const _lightSentBubble = Color(0xFF000000);
  static const _lightReceivedBubble = Color(0xFFF2F2F7);

  // ============================================================================
  // COLOR PALETTE - Dark Mode (Apple iOS/macOS inspired)
  // ============================================================================
  static const _darkPrimary = Color(0xFFFFFFFF); // Pure white
  static const _darkSecondary = Color(0xFFE5E5EA); // Light gray

  static const _darkBackground = Color(0xFF000000); // Pure black
  static const _darkSurface = Color(0xFF1C1C1E); // Dark gray
  static const _darkSurfaceVariant = Color(0xFF2C2C2E); // Darker gray

  static const _darkError = Color(0xFFFFFFFF);
  static const _darkSuccess = Color(0xFFE5E5EA);
  static const _darkWarning = Color(0xFFC7C7CC);
  static const _darkInfo = Color(0xFFFFFFFF);

  // Text colors
  static const _darkTextPrimary = Color(0xFFFFFFFF);
  static const _darkTextSecondary = Color(0xFFAEAEB2);
  static const _darkTextTertiary = Color(0xFF636366);

  // Borders and dividers
  static const _darkBorder = Color(0xFF38383A);
  static const _darkDivider = Color(0xFF48484A);

  // Chat-specific colors
  static const _darkSentBubble = Color(0xFFFFFFFF);
  static const _darkReceivedBubble = Color(0xFF1C1C1E);

  // ============================================================================
  // LIGHT THEME
  // ============================================================================
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: 'SFProDisplay',

    // Color Scheme
    colorScheme: const ColorScheme.light(
      primary: _lightPrimary,
      primaryContainer: _lightSurfaceVariant,
      secondary: _lightSecondary,
      secondaryContainer: _lightSurfaceVariant,
      tertiary: _lightTextSecondary,
      surface: _lightSurface,
      surfaceContainerHighest: _lightSurfaceVariant,
      error: _lightError,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: _lightTextPrimary,
      onSurfaceVariant: _lightTextSecondary,
      outline: _lightBorder,
    ),

    // Scaffold
    scaffoldBackgroundColor: _lightBackground,

    // AppBar Theme
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: false,
      backgroundColor: _lightBackground,
      foregroundColor: _lightTextPrimary,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: _lightTextPrimary,
        letterSpacing: -0.8,
        fontFamily: 'SFProDisplay',
      ),
    ),

    // Card Theme
    cardTheme: CardThemeData(
      elevation: 0,
      color: _lightSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: _lightBorder, width: 0.5),
      ),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _lightSurfaceVariant,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      hintStyle: const TextStyle(
        color: _lightTextTertiary,
        fontSize: 17,
        fontWeight: FontWeight.w400,
      ),
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: _lightPrimary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.4,
          fontFamily: 'SFProDisplay',
        ),
      ),
    ),

    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _lightPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w400,
          fontFamily: 'SFProDisplay',
        ),
      ),
    ),

    // Icon Theme
    iconTheme: const IconThemeData(color: _lightTextPrimary, size: 22),

    // Divider Theme
    dividerTheme: const DividerThemeData(
      color: _lightDivider,
      thickness: 0.5,
      space: 0.5,
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: _lightBackground,
      selectedItemColor: _lightPrimary,
      unselectedItemColor: _lightTextTertiary,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      selectedLabelStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 11,
        fontFamily: 'SFProDisplay',
      ),
      unselectedLabelStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 11,
        fontFamily: 'SFProDisplay',
      ),
    ),

    // Floating Action Button Theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _lightPrimary,
      foregroundColor: Colors.white,
      elevation: 0,
      highlightElevation: 0,
      shape: CircleBorder(),
    ),

    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: _lightSurfaceVariant,
      selectedColor: _lightPrimary,
      labelStyle: const TextStyle(
        color: _lightTextPrimary,
        fontFamily: 'SFProDisplay',
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );

  // ============================================================================
  // DARK THEME
  // ============================================================================
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: 'SFProDisplay',

    // Color Scheme
    colorScheme: const ColorScheme.dark(
      primary: _darkPrimary,
      primaryContainer: _darkSurfaceVariant,
      secondary: _darkSecondary,
      secondaryContainer: _darkSurfaceVariant,
      tertiary: _darkTextSecondary,
      surface: _darkSurface,
      surfaceContainerHighest: _darkSurfaceVariant,
      error: _darkError,
      onPrimary: _darkBackground,
      onSecondary: _darkBackground,
      onSurface: _darkTextPrimary,
      onSurfaceVariant: _darkTextSecondary,
      outline: _darkBorder,
    ),

    // Scaffold
    scaffoldBackgroundColor: _darkBackground,

    // AppBar Theme
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: false,
      backgroundColor: _darkBackground,
      foregroundColor: _darkTextPrimary,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: _darkTextPrimary,
        letterSpacing: -0.8,
        fontFamily: 'SFProDisplay',
      ),
    ),

    // Card Theme
    cardTheme: CardThemeData(
      elevation: 0,
      color: _darkSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: _darkBorder, width: 0.5),
      ),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _darkSurfaceVariant,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      hintStyle: const TextStyle(
        color: _darkTextTertiary,
        fontSize: 17,
        fontWeight: FontWeight.w400,
      ),
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: _darkPrimary,
        foregroundColor: _darkBackground,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.4,
          fontFamily: 'SFProDisplay',
        ),
      ),
    ),

    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _darkPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w400,
          fontFamily: 'SFProDisplay',
        ),
      ),
    ),

    // Icon Theme
    iconTheme: const IconThemeData(color: _darkTextPrimary, size: 22),

    // Divider Theme
    dividerTheme: const DividerThemeData(
      color: _darkDivider,
      thickness: 0.5,
      space: 0.5,
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: _darkBackground,
      selectedItemColor: _darkPrimary,
      unselectedItemColor: _darkTextTertiary,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      selectedLabelStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 11,
        fontFamily: 'SFProDisplay',
      ),
      unselectedLabelStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 11,
        fontFamily: 'SFProDisplay',
      ),
    ),

    // Floating Action Button Theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _darkPrimary,
      foregroundColor: _darkBackground,
      elevation: 0,
      highlightElevation: 0,
      shape: CircleBorder(),
    ),

    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: _darkSurfaceVariant,
      selectedColor: _darkPrimary,
      labelStyle: const TextStyle(
        color: _darkTextPrimary,
        fontFamily: 'SFProDisplay',
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );

  // ============================================================================
  // CUSTOM CHAT COLORS
  // ============================================================================

  static Color sentBubbleColor(bool isDark) =>
      isDark ? _darkSentBubble : _lightSentBubble;

  static Color receivedBubbleColor(bool isDark) =>
      isDark ? _darkReceivedBubble : _lightReceivedBubble;

  static Color receivedBubbleBorder(bool isDark) =>
      isDark ? _darkBorder : _lightBorder;

  static Color successColor(bool isDark) =>
      isDark ? _darkSuccess : _lightSuccess;

  static Color warningColor(bool isDark) =>
      isDark ? _darkWarning : _lightWarning;

  static Color infoColor(bool isDark) => isDark ? _darkInfo : _lightInfo;

  static Color textPrimary(bool isDark) =>
      isDark ? _darkTextPrimary : _lightTextPrimary;

  static Color textSecondary(bool isDark) =>
      isDark ? _darkTextSecondary : _lightTextSecondary;

  static Color textTertiary(bool isDark) =>
      isDark ? _darkTextTertiary : _lightTextTertiary;

  // ============================================================================
  // CUSTOM TEXT STYLES (Apple Typography)
  // ============================================================================

  static TextStyle largeTitle(bool isDark) => TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.w700,
    color: isDark ? _darkTextPrimary : _lightTextPrimary,
    letterSpacing: -0.8,
  );

  static TextStyle title1(bool isDark) => TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: isDark ? _darkTextPrimary : _lightTextPrimary,
    letterSpacing: -0.6,
  );

  static TextStyle title2(bool isDark) => TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: isDark ? _darkTextPrimary : _lightTextPrimary,
    letterSpacing: -0.4,
  );

  static TextStyle title3(bool isDark) => TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: isDark ? _darkTextPrimary : _lightTextPrimary,
    letterSpacing: -0.3,
  );

  static TextStyle headline(bool isDark) => TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: isDark ? _darkTextPrimary : _lightTextPrimary,
    letterSpacing: -0.4,
  );

  static TextStyle body(bool isDark) => TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    color: isDark ? _darkTextPrimary : _lightTextPrimary,
    letterSpacing: -0.4,
    height: 1.3,
  );

  static TextStyle callout(bool isDark) => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: isDark ? _darkTextSecondary : _lightTextSecondary,
    letterSpacing: -0.3,
  );

  static TextStyle subheadline(bool isDark) => TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: isDark ? _darkTextSecondary : _lightTextSecondary,
    letterSpacing: -0.2,
  );

  static TextStyle footnote(bool isDark) => TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: isDark ? _darkTextTertiary : _lightTextTertiary,
    letterSpacing: -0.1,
  );

  static TextStyle caption1(bool isDark) => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: isDark ? _darkTextTertiary : _lightTextTertiary,
    letterSpacing: 0,
  );

  static TextStyle caption2(bool isDark) => TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: isDark ? _darkTextTertiary : _lightTextTertiary,
    letterSpacing: 0.1,
  );

  // ============================================================================
  // SPACING CONSTANTS (Apple HIG)
  // ============================================================================

  static const double spacing2xs = 2.0;
  static const double spacingXs = 4.0;
  static const double spacingSm = 8.0;
  static const double spacingMd = 16.0;
  static const double spacingLg = 20.0;
  static const double spacingXl = 32.0;
  static const double spacing2xl = 44.0;

  // ============================================================================
  // BORDER RADIUS CONSTANTS (Apple Style)
  // ============================================================================

  static const double radiusSm = 8.0;
  static const double radiusMd = 10.0;
  static const double radiusLg = 12.0;
  static const double radiusXl = 20.0;
  static const double radiusFull = 999.0;

  // ============================================================================
  // CHAT-SPECIFIC DECORATIONS
  // ============================================================================

  static BoxDecoration sentMessageDecoration(bool isDark) => BoxDecoration(
    color: sentBubbleColor(isDark),
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(18),
      topRight: Radius.circular(18),
      bottomLeft: Radius.circular(18),
      bottomRight: Radius.circular(4),
    ),
    boxShadow: isDark
        ? []
        : [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
  );

  static BoxDecoration receivedMessageDecoration(bool isDark) => BoxDecoration(
    color: receivedBubbleColor(isDark),
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(18),
      topRight: Radius.circular(18),
      bottomLeft: Radius.circular(4),
      bottomRight: Radius.circular(18),
    ),
    boxShadow: isDark
        ? []
        : [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
  );

  // Message text color (for contrast)
  static Color sentMessageTextColor(bool isDark) =>
      isDark ? _darkBackground : Colors.white;

  static Color receivedMessageTextColor(bool isDark) =>
      isDark ? _darkTextPrimary : _lightTextPrimary;
}
