import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Premium Chat Application Theme
/// Inspired by: Telegram, Discord, Slack, and modern design systems
class ChatAppTheme {
  // ============================================================================
  // COLOR PALETTE - Light Mode
  // Inspired by: Soft, warm tones with high contrast for readability
  // ============================================================================
  static const _lightPrimary = Color(
    0xFF6366F1,
  ); // Indigo - vibrant but sophisticated
  static const _lightSecondary = Color(0xFF8B5CF6); // Purple accent

  static const _lightBackground = Color(0xFFF8FAFC); // Soft blue-gray
  static const _lightSurface = Color(0xFFFFFFFF);
  static const _lightSurfaceVariant = Color(0xFFF1F5F9);

  static const _lightError = Color(0xFFEF4444);
  static const _lightSuccess = Color(0xFF10B981);
  static const _lightWarning = Color(0xFFF59E0B);
  static const _lightInfo = Color(0xFF3B82F6);

  // Text colors
  static const _lightTextPrimary = Color(0xFF0F172A);
  static const _lightTextSecondary = Color(0xFF475569);
  static const _lightTextTertiary = Color(0xFF94A3B8);

  // Chat-specific colors
  static const _lightSentBubble = Color(0xFF6366F1);
  static const _lightReceivedBubble = Color(0xFFFFFFFF);
  static const _lightReceivedBubbleBorder = Color(0xFFE2E8F0);

  // ============================================================================
  // COLOR PALETTE - Dark Mode
  // Inspired by: Deep, rich colors with OLED-friendly blacks
  // ============================================================================
  static const _darkPrimary = Color(0xFF818CF8); // Lighter indigo for dark mode
  static const _darkSecondary = Color(0xFFA78BFA); // Light purple

  static const _darkBackground = Color(0xFF0F172A); // Deep navy
  static const _darkSurface = Color(0xFF1E293B);
  static const _darkSurfaceVariant = Color(0xFF334155);

  static const _darkError = Color(0xFFF87171);
  static const _darkSuccess = Color(0xFF34D399);
  static const _darkWarning = Color(0xFFFBBF24);
  static const _darkInfo = Color(0xFF60A5FA);

  // Text colors
  static const _darkTextPrimary = Color(0xFFF1F5F9);
  static const _darkTextSecondary = Color(0xFFCBD5E1);
  static const _darkTextTertiary = Color(0xFF64748B);

  // Chat-specific colors
  static const _darkSentBubble = Color(0xFF6366F1);
  static const _darkReceivedBubble = Color(0xFF1E293B);
  static const _darkReceivedBubbleBorder = Color(0xFF334155);

  // ============================================================================
  // LIGHT THEME
  // ============================================================================
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: 'SFPro',

    // Color Scheme
    colorScheme: const ColorScheme.light(
      primary: _lightPrimary,
      primaryContainer: Color(0xFFEEF2FF),
      secondary: _lightSecondary,
      secondaryContainer: Color(0xFFF5F3FF),
      tertiary: Color(0xFFEC4899),
      surface: _lightSurface,
      surfaceContainerHighest: _lightSurfaceVariant,
      error: _lightError,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: _lightTextPrimary,
      onSurfaceVariant: _lightTextSecondary,
      outline: Color(0xFFCBD5E1),
    ),

    // Scaffold
    scaffoldBackgroundColor: _lightBackground,

    // AppBar Theme
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: false,
      backgroundColor: _lightSurface,
      foregroundColor: _lightTextPrimary,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: _lightTextPrimary,
        letterSpacing: -0.5,
      ),
    ),

    // Card Theme
    cardTheme: CardThemeData(
      elevation: 0,
      color: _lightSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFE2E8F0), width: 1),
      ),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _lightSurface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _lightPrimary, width: 2),
      ),
      hintStyle: const TextStyle(color: _lightTextTertiary, fontSize: 15),
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
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
        ),
      ),
    ),

    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _lightPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
    ),

    // Icon Theme
    iconTheme: const IconThemeData(color: _lightTextSecondary, size: 24),

    // Divider Theme
    dividerTheme: const DividerThemeData(
      color: Color(0xFFE2E8F0),
      thickness: 1,
      space: 1,
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: _lightSurface,
      selectedItemColor: _lightPrimary,
      unselectedItemColor: _lightTextTertiary,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
      unselectedLabelStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
    ),

    // Floating Action Button Theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _lightPrimary,
      foregroundColor: Colors.white,
      elevation: 4,
      highlightElevation: 8,
    ),

    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: _lightSurfaceVariant,
      selectedColor: _lightPrimary,
      labelStyle: const TextStyle(color: _lightTextPrimary),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );

  // ============================================================================
  // DARK THEME
  // ============================================================================
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    // Color Scheme
    colorScheme: const ColorScheme.dark(
      primary: _darkPrimary,
      primaryContainer: Color(0xFF312E81),
      secondary: _darkSecondary,
      secondaryContainer: Color(0xFF4C1D95),
      tertiary: Color(0xFFF472B6),
      surface: _darkSurface,
      surfaceContainerHighest: _darkSurfaceVariant,
      error: _darkError,
      onPrimary: _darkBackground,
      onSecondary: _darkBackground,
      onSurface: _darkTextPrimary,
      onSurfaceVariant: _darkTextSecondary,
      outline: Color(0xFF475569),
    ),

    // Scaffold
    scaffoldBackgroundColor: _darkBackground,

    // AppBar Theme
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: false,
      backgroundColor: _darkSurface,
      foregroundColor: _darkTextPrimary,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: _darkTextPrimary,
        letterSpacing: -0.5,
      ),
    ),

    // Card Theme
    cardTheme: CardThemeData(
      elevation: 0,
      color: _darkSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFF334155), width: 1),
      ),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _darkSurface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF334155)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF334155)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _darkPrimary, width: 2),
      ),
      hintStyle: const TextStyle(color: _darkTextTertiary, fontSize: 15),
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
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
        ),
      ),
    ),

    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _darkPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
    ),

    // Icon Theme
    iconTheme: const IconThemeData(color: _darkTextSecondary, size: 24),

    // Divider Theme
    dividerTheme: const DividerThemeData(
      color: Color(0xFF334155),
      thickness: 1,
      space: 1,
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: _darkSurface,
      selectedItemColor: _darkPrimary,
      unselectedItemColor: _darkTextTertiary,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
      unselectedLabelStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
    ),

    // Floating Action Button Theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _darkPrimary,
      foregroundColor: _darkBackground,
      elevation: 4,
      highlightElevation: 8,
    ),

    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: _darkSurfaceVariant,
      selectedColor: _darkPrimary,
      labelStyle: const TextStyle(color: _darkTextPrimary),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );

  // ============================================================================
  // CUSTOM CHAT COLORS - Legacy methods (prefer extension methods below)
  // ============================================================================

  static Color sentBubbleColor(bool isDark) =>
      isDark ? _darkSentBubble : _lightSentBubble;

  static Color receivedBubbleColor(bool isDark) =>
      isDark ? _darkReceivedBubble : _lightReceivedBubble;

  static Color receivedBubbleBorder(bool isDark) =>
      isDark ? _darkReceivedBubbleBorder : _lightReceivedBubbleBorder;

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
  // CUSTOM TEXT STYLES
  // ============================================================================

  static TextStyle headline1(bool isDark) => TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: isDark ? _darkTextPrimary : _lightTextPrimary,
    letterSpacing: -1,
  );

  static TextStyle headline2(bool isDark) => TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: isDark ? _darkTextPrimary : _lightTextPrimary,
    letterSpacing: -0.5,
  );

  static TextStyle headline3(bool isDark) => TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: isDark ? _darkTextPrimary : _lightTextPrimary,
    letterSpacing: -0.3,
  );

  static TextStyle bodyLarge(bool isDark) => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: isDark ? _darkTextPrimary : _lightTextPrimary,
    height: 1.5,
  );

  static TextStyle bodyMedium(bool isDark) => TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: isDark ? _darkTextSecondary : _lightTextSecondary,
    height: 1.5,
  );

  static TextStyle bodySmall(bool isDark) => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: isDark ? _darkTextTertiary : _lightTextTertiary,
    height: 1.4,
  );

  static TextStyle caption(bool isDark) => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: isDark ? _darkTextTertiary : _lightTextTertiary,
    letterSpacing: 0.2,
  );

  static TextStyle button(bool isDark) => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: isDark ? _darkTextPrimary : _lightTextPrimary,
    letterSpacing: 0,
  );

  // ============================================================================
  // SPACING CONSTANTS
  // ============================================================================

  static const double spacing2xs = 4.0;
  static const double spacingXs = 8.0;
  static const double spacingSm = 12.0;
  static const double spacingMd = 16.0;
  static const double spacingLg = 24.0;
  static const double spacingXl = 32.0;
  static const double spacing2xl = 48.0;

  // ============================================================================
  // BORDER RADIUS CONSTANTS
  // ============================================================================

  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0;
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
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.08),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ],
  );

  static BoxDecoration receivedMessageDecoration(bool isDark) => BoxDecoration(
    color: receivedBubbleColor(isDark),
    border: Border.all(color: receivedBubbleBorder(isDark), width: 1),
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(18),
      topRight: Radius.circular(18),
      bottomLeft: Radius.circular(4),
      bottomRight: Radius.circular(18),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: isDark ? 0.1 : 0.04),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ],
  );
}
