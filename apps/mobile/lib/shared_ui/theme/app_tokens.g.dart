// GENERATED from design/tokens.json. Run pnpm tokens:generate; do not edit.
import 'package:flutter/material.dart';

abstract final class AppTokens {
  static const fontFamily = 'DM Sans';
  static const double space4 = 4;
  static const double space8 = 8;
  static const double space12 = 12;
  static const double space16 = 16;
  static const double space20 = 20;
  static const double space24 = 24;
  static const double space28 = 28;
  static const double space32 = 32;
  static const double space36 = 36;
  static const double space40 = 40;
  static const double space48 = 48;
  static const double radiusBadge = 12;
  static const double radiusControl = 14;
  static const double radiusCompactCard = 24;
  static const double radiusCard = 36;
  static const double minimumTarget = 48;
  static const double formMax = 640;
  static const double readingMax = 720;
  static const double workspaceMax = 1200;
  static const double borderWidth = 1;
  static const double selectedWidth = 2;
  static const double focusWidth = 3;
  static const double focusOffset = 2;
  static const double motionFastMs = 120;
  static const double motionStandardMs = 180;

  static const textTheme = TextTheme(
    displayLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: 64,
      height: 72 / 64,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      fontVariations: [FontVariation('wght', 600), FontVariation('opsz', 40)],
    ),
    displayMedium: TextStyle(
      fontFamily: fontFamily,
      fontSize: 56,
      height: 72 / 56,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      fontVariations: [FontVariation('wght', 600), FontVariation('opsz', 40)],
    ),
    displaySmall: TextStyle(
      fontFamily: fontFamily,
      fontSize: 40,
      height: 52 / 40,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      fontVariations: [FontVariation('wght', 600), FontVariation('opsz', 40)],
    ),
    headlineLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: 40,
      height: 52 / 40,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      fontVariations: [FontVariation('wght', 600), FontVariation('opsz', 40)],
    ),
    headlineMedium: TextStyle(
      fontFamily: fontFamily,
      fontSize: 32,
      height: 40 / 32,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      fontVariations: [FontVariation('wght', 600), FontVariation('opsz', 32)],
    ),
    headlineSmall: TextStyle(
      fontFamily: fontFamily,
      fontSize: 24,
      height: 32 / 24,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      fontVariations: [FontVariation('wght', 600), FontVariation('opsz', 24)],
    ),
    titleLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: 24,
      height: 32 / 24,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      fontVariations: [FontVariation('wght', 600), FontVariation('opsz', 24)],
    ),
    titleMedium: TextStyle(
      fontFamily: fontFamily,
      fontSize: 20,
      height: 30 / 20,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      fontVariations: [FontVariation('wght', 600), FontVariation('opsz', 20)],
    ),
    titleSmall: TextStyle(
      fontFamily: fontFamily,
      fontSize: 18,
      height: 26 / 18,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      fontVariations: [FontVariation('wght', 600), FontVariation('opsz', 18)],
    ),
    bodyLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: 16,
      height: 24 / 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      fontVariations: [FontVariation('wght', 400), FontVariation('opsz', 16)],
    ),
    bodyMedium: TextStyle(
      fontFamily: fontFamily,
      fontSize: 16,
      height: 24 / 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      fontVariations: [FontVariation('wght', 400), FontVariation('opsz', 16)],
    ),
    bodySmall: TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
      height: 20 / 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      fontVariations: [FontVariation('wght', 400), FontVariation('opsz', 14)],
    ),
    labelLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: 16,
      height: 24 / 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 0,
      fontVariations: [FontVariation('wght', 500), FontVariation('opsz', 16)],
    ),
    labelMedium: TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
      height: 20 / 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0,
      fontVariations: [FontVariation('wght', 500), FontVariation('opsz', 14)],
    ),
    labelSmall: TextStyle(
      fontFamily: fontFamily,
      fontSize: 12,
      height: 20 / 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      fontVariations: [FontVariation('wght', 400), FontVariation('opsz', 12)],
    ),
  );
}

@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.canvas,
    required this.surface,
    required this.raised,
    required this.mutedSurface,
    required this.textHeading,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.icon,
    required this.border,
    required this.controlBorder,
    required this.link,
    required this.focus,
    required this.selection,
    required this.onSelection,
    required this.disabled,
    required this.onDisabled,
    required this.badge,
    required this.onBadge,
    required this.primary,
    required this.onPrimary,
    required this.primaryHover,
    required this.primaryPressed,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryHover,
    required this.secondaryPressed,
    required this.info,
    required this.infoSurface,
    required this.success,
    required this.successSurface,
    required this.warning,
    required this.warningSurface,
    required this.error,
    required this.errorSurface,
  });

  final Color canvas;
  final Color surface;
  final Color raised;
  final Color mutedSurface;
  final Color textHeading;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color icon;
  final Color border;
  final Color controlBorder;
  final Color link;
  final Color focus;
  final Color selection;
  final Color onSelection;
  final Color disabled;
  final Color onDisabled;
  final Color badge;
  final Color onBadge;
  final Color primary;
  final Color onPrimary;
  final Color primaryHover;
  final Color primaryPressed;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryHover;
  final Color secondaryPressed;
  final Color info;
  final Color infoSurface;
  final Color success;
  final Color successSurface;
  final Color warning;
  final Color warningSurface;
  final Color error;
  final Color errorSurface;

  static const light = AppColors(
    canvas: Color(0xFFF4F4F5),
    surface: Color(0xFFFFFFFF),
    raised: Color(0xFFFFFFFF),
    mutedSurface: Color(0xFFFAFAFA),
    textHeading: Color(0xFF09090B),
    textPrimary: Color(0xFF18181B),
    textSecondary: Color(0xFF52525B),
    textMuted: Color(0xFF52525B),
    icon: Color(0xFF52525B),
    border: Color(0xFFECECEE),
    controlBorder: Color(0xFF71717A),
    link: Color(0xFF18181B),
    focus: Color(0xFF09090B),
    selection: Color(0xFFECECEE),
    onSelection: Color(0xFF18181B),
    disabled: Color(0xFFF4F4F5),
    onDisabled: Color(0xFF52525B),
    badge: Color(0xFFFF5A00),
    onBadge: Color(0xFF09090B),
    primary: Color(0xFF09090B),
    onPrimary: Color(0xFFFFFFFF),
    primaryHover: Color(0xFF27272A),
    primaryPressed: Color(0xFF3F3F46),
    secondary: Color(0xFFFFFFFF),
    onSecondary: Color(0xFF18181B),
    secondaryHover: Color(0xFFF4F4F5),
    secondaryPressed: Color(0xFFECECEE),
    info: Color(0xFF18181B),
    infoSurface: Color(0xFFF4F4F5),
    success: Color(0xFF18181B),
    successSurface: Color(0xFFF4F4F5),
    warning: Color(0xFF18181B),
    warningSurface: Color(0xFFF4F4F5),
    error: Color(0xFF18181B),
    errorSurface: Color(0xFFF4F4F5),
  );

  static const dark = AppColors(
    canvas: Color(0xFF09090B),
    surface: Color(0xFF18181B),
    raised: Color(0xFF27272A),
    mutedSurface: Color(0xFF27272A),
    textHeading: Color(0xFFFAFAFA),
    textPrimary: Color(0xFFFAFAFA),
    textSecondary: Color(0xFFD4D4D8),
    textMuted: Color(0xFFA1A1AA),
    icon: Color(0xFFD4D4D8),
    border: Color(0xFF3F3F46),
    controlBorder: Color(0xFFA1A1AA),
    link: Color(0xFFFAFAFA),
    focus: Color(0xFFFAFAFA),
    selection: Color(0xFF3F3F46),
    onSelection: Color(0xFFFAFAFA),
    disabled: Color(0xFF27272A),
    onDisabled: Color(0xFFA1A1AA),
    badge: Color(0xFFFF5A00),
    onBadge: Color(0xFF09090B),
    primary: Color(0xFFFAFAFA),
    onPrimary: Color(0xFF09090B),
    primaryHover: Color(0xFFECECEE),
    primaryPressed: Color(0xFFD4D4D8),
    secondary: Color(0xFF18181B),
    onSecondary: Color(0xFFFAFAFA),
    secondaryHover: Color(0xFF27272A),
    secondaryPressed: Color(0xFF3F3F46),
    info: Color(0xFFFAFAFA),
    infoSurface: Color(0xFF27272A),
    success: Color(0xFFFAFAFA),
    successSurface: Color(0xFF27272A),
    warning: Color(0xFFFAFAFA),
    warningSurface: Color(0xFF27272A),
    error: Color(0xFFFAFAFA),
    errorSurface: Color(0xFF27272A),
  );

  static AppColors of(BuildContext context) =>
      Theme.of(context).extension<AppColors>()!;

  @override
  AppColors copyWith({
    Color? canvas,
    Color? surface,
    Color? raised,
    Color? mutedSurface,
    Color? textHeading,
    Color? textPrimary,
    Color? textSecondary,
    Color? textMuted,
    Color? icon,
    Color? border,
    Color? controlBorder,
    Color? link,
    Color? focus,
    Color? selection,
    Color? onSelection,
    Color? disabled,
    Color? onDisabled,
    Color? badge,
    Color? onBadge,
    Color? primary,
    Color? onPrimary,
    Color? primaryHover,
    Color? primaryPressed,
    Color? secondary,
    Color? onSecondary,
    Color? secondaryHover,
    Color? secondaryPressed,
    Color? info,
    Color? infoSurface,
    Color? success,
    Color? successSurface,
    Color? warning,
    Color? warningSurface,
    Color? error,
    Color? errorSurface,
  }) => AppColors(
    canvas: canvas ?? this.canvas,
    surface: surface ?? this.surface,
    raised: raised ?? this.raised,
    mutedSurface: mutedSurface ?? this.mutedSurface,
    textHeading: textHeading ?? this.textHeading,
    textPrimary: textPrimary ?? this.textPrimary,
    textSecondary: textSecondary ?? this.textSecondary,
    textMuted: textMuted ?? this.textMuted,
    icon: icon ?? this.icon,
    border: border ?? this.border,
    controlBorder: controlBorder ?? this.controlBorder,
    link: link ?? this.link,
    focus: focus ?? this.focus,
    selection: selection ?? this.selection,
    onSelection: onSelection ?? this.onSelection,
    disabled: disabled ?? this.disabled,
    onDisabled: onDisabled ?? this.onDisabled,
    badge: badge ?? this.badge,
    onBadge: onBadge ?? this.onBadge,
    primary: primary ?? this.primary,
    onPrimary: onPrimary ?? this.onPrimary,
    primaryHover: primaryHover ?? this.primaryHover,
    primaryPressed: primaryPressed ?? this.primaryPressed,
    secondary: secondary ?? this.secondary,
    onSecondary: onSecondary ?? this.onSecondary,
    secondaryHover: secondaryHover ?? this.secondaryHover,
    secondaryPressed: secondaryPressed ?? this.secondaryPressed,
    info: info ?? this.info,
    infoSurface: infoSurface ?? this.infoSurface,
    success: success ?? this.success,
    successSurface: successSurface ?? this.successSurface,
    warning: warning ?? this.warning,
    warningSurface: warningSurface ?? this.warningSurface,
    error: error ?? this.error,
    errorSurface: errorSurface ?? this.errorSurface,
  );

  @override
  AppColors lerp(covariant AppColors? other, double t) {
    if (other == null) return this;
    return AppColors(
      canvas: Color.lerp(canvas, other.canvas, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      raised: Color.lerp(raised, other.raised, t)!,
      mutedSurface: Color.lerp(mutedSurface, other.mutedSurface, t)!,
      textHeading: Color.lerp(textHeading, other.textHeading, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      icon: Color.lerp(icon, other.icon, t)!,
      border: Color.lerp(border, other.border, t)!,
      controlBorder: Color.lerp(controlBorder, other.controlBorder, t)!,
      link: Color.lerp(link, other.link, t)!,
      focus: Color.lerp(focus, other.focus, t)!,
      selection: Color.lerp(selection, other.selection, t)!,
      onSelection: Color.lerp(onSelection, other.onSelection, t)!,
      disabled: Color.lerp(disabled, other.disabled, t)!,
      onDisabled: Color.lerp(onDisabled, other.onDisabled, t)!,
      badge: Color.lerp(badge, other.badge, t)!,
      onBadge: Color.lerp(onBadge, other.onBadge, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      primaryHover: Color.lerp(primaryHover, other.primaryHover, t)!,
      primaryPressed: Color.lerp(primaryPressed, other.primaryPressed, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      onSecondary: Color.lerp(onSecondary, other.onSecondary, t)!,
      secondaryHover: Color.lerp(secondaryHover, other.secondaryHover, t)!,
      secondaryPressed: Color.lerp(
        secondaryPressed,
        other.secondaryPressed,
        t,
      )!,
      info: Color.lerp(info, other.info, t)!,
      infoSurface: Color.lerp(infoSurface, other.infoSurface, t)!,
      success: Color.lerp(success, other.success, t)!,
      successSurface: Color.lerp(successSurface, other.successSurface, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      warningSurface: Color.lerp(warningSurface, other.warningSurface, t)!,
      error: Color.lerp(error, other.error, t)!,
      errorSurface: Color.lerp(errorSurface, other.errorSurface, t)!,
    );
  }
}
