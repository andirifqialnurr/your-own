import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_tokens.g.dart';

abstract final class AppTheme {
  static ThemeData build(Brightness brightness) {
    final c = brightness == Brightness.light ? AppColors.light : AppColors.dark;
    final inverse = brightness == Brightness.light
        ? AppColors.dark
        : AppColors.light;
    final scheme = ColorScheme(
      brightness: brightness,
      primary: c.primary,
      onPrimary: c.onPrimary,
      primaryContainer: c.selection,
      onPrimaryContainer: c.onSelection,
      primaryFixed: AppColors.light.selection,
      primaryFixedDim: AppColors.light.border,
      onPrimaryFixed: AppColors.light.textPrimary,
      onPrimaryFixedVariant: AppColors.light.textSecondary,
      secondary: c.onSecondary,
      onSecondary: c.secondary,
      secondaryContainer: c.selection,
      onSecondaryContainer: c.onSelection,
      secondaryFixed: AppColors.light.selection,
      secondaryFixedDim: AppColors.light.border,
      onSecondaryFixed: AppColors.light.textPrimary,
      onSecondaryFixedVariant: AppColors.light.textSecondary,
      tertiary: c.textPrimary,
      onTertiary: c.surface,
      tertiaryContainer: c.selection,
      onTertiaryContainer: c.onSelection,
      tertiaryFixed: AppColors.light.selection,
      tertiaryFixedDim: AppColors.light.border,
      onTertiaryFixed: AppColors.light.textPrimary,
      onTertiaryFixedVariant: AppColors.light.textSecondary,
      error: c.error,
      onError: c.surface,
      errorContainer: c.errorSurface,
      onErrorContainer: c.error,
      surface: c.surface,
      onSurface: c.textPrimary,
      onSurfaceVariant: c.textSecondary,
      surfaceDim: c.canvas,
      surfaceBright: c.raised,
      surfaceContainerLowest: c.canvas,
      surfaceContainerLow: c.mutedSurface,
      surfaceContainer: c.surface,
      surfaceContainerHigh: c.raised,
      surfaceContainerHighest: c.raised,
      outline: c.controlBorder,
      outlineVariant: c.border,
      shadow: Colors.transparent,
      scrim: AppColors.light.primary.withValues(
        alpha: brightness == Brightness.light ? 0.40 : 0.64,
      ),
      inverseSurface: inverse.surface,
      onInverseSurface: inverse.textPrimary,
      inversePrimary: inverse.primary,
      surfaceTint: Colors.transparent,
    );
    final text = AppTokens.textTheme.apply(
      bodyColor: c.textPrimary,
      displayColor: c.textHeading,
    );
    final control = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppTokens.radiusControl),
    );
    final fieldBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppTokens.radiusControl),
      borderSide: BorderSide(color: c.controlBorder),
    );
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: c.canvas,
      canvasColor: c.canvas,
      fontFamily: AppTokens.fontFamily,
      textTheme: text,
      extensions: [c],
      iconTheme: IconThemeData(color: c.icon),
      dividerColor: c.border,
      disabledColor: c.onDisabled,
      splashFactory: NoSplash.splashFactory,
      filledButtonTheme: FilledButtonThemeData(style: _button(c, filled: true)),
      outlinedButtonTheme: OutlinedButtonThemeData(style: outlined(c)),
      textButtonTheme: TextButtonThemeData(
        style: _button(c, filled: false).copyWith(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) return c.disabled;
            if (states.contains(WidgetState.pressed)) return c.secondaryPressed;
            if (states.contains(WidgetState.hovered)) return c.secondaryHover;
            return Colors.transparent;
          }),
          side: const WidgetStatePropertyAll(BorderSide.none),
        ),
      ),
      cardTheme: CardThemeData(
        color: c.surface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusCard),
          side: BorderSide(color: c.border),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: c.raised,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: text.titleLarge,
        contentTextStyle: text.bodyLarge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusCard),
          side: BorderSide(color: c.controlBorder),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: c.raised,
        modalBackgroundColor: c.raised,
        elevation: 0,
        modalElevation: 0,
        surfaceTintColor: Colors.transparent,
        shape: control,
      ),
      inputDecorationTheme: InputDecorationThemeData(
        filled: true,
        fillColor: c.surface,
        labelStyle: text.bodyLarge,
        hintStyle: text.bodyLarge?.copyWith(color: c.textMuted),
        helperStyle: text.bodySmall?.copyWith(color: c.textSecondary),
        errorStyle: text.bodySmall?.copyWith(color: c.error),
        border: fieldBorder,
        enabledBorder: fieldBorder,
        disabledBorder: fieldBorder,
        focusedBorder: fieldBorder.copyWith(
          borderSide: BorderSide(color: c.focus, width: AppTokens.focusWidth),
        ),
        errorBorder: fieldBorder.copyWith(
          borderSide: BorderSide(
            color: c.error,
            width: AppTokens.selectedWidth,
          ),
        ),
        focusedErrorBorder: fieldBorder.copyWith(
          borderSide: BorderSide(color: c.error, width: AppTokens.focusWidth),
        ),
        contentPadding: const EdgeInsets.all(AppTokens.space16),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: c.textPrimary,
        selectionColor: c.selection,
        selectionHandleColor: c.textPrimary,
      ),
      appBarTheme: AppBarThemeData(
        backgroundColor: c.canvas,
        foregroundColor: c.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: systemBars(brightness),
      ),
      tooltipTheme: TooltipThemeData(
        textStyle: text.bodySmall,
        decoration: BoxDecoration(
          color: c.raised,
          border: Border.all(color: c.controlBorder),
          borderRadius: BorderRadius.circular(AppTokens.radiusBadge),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: c.textPrimary),
    );
  }

  static ButtonStyle outlined(AppColors c, {bool selected = false}) =>
      _button(c, filled: false, selected: selected);

  static ButtonStyle _button(
    AppColors c, {
    required bool filled,
    bool selected = false,
  }) => ButtonStyle(
    minimumSize: const WidgetStatePropertyAll(
      Size(AppTokens.minimumTarget, AppTokens.minimumTarget),
    ),
    padding: const WidgetStatePropertyAll(
      EdgeInsets.symmetric(
        horizontal: AppTokens.space16,
        vertical: AppTokens.space12,
      ),
    ),
    textStyle: WidgetStatePropertyAll(AppTokens.textTheme.labelLarge),
    foregroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) return c.onDisabled;
      return filled ? c.onPrimary : (selected ? c.onSelection : c.onSecondary);
    }),
    backgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) return c.disabled;
      if (states.contains(WidgetState.pressed)) {
        return filled ? c.primaryPressed : c.secondaryPressed;
      }
      if (states.contains(WidgetState.hovered)) {
        return filled ? c.primaryHover : c.secondaryHover;
      }
      return filled ? c.primary : (selected ? c.selection : c.secondary);
    }),
    overlayColor: const WidgetStatePropertyAll(Colors.transparent),
    elevation: const WidgetStatePropertyAll(0),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTokens.radiusControl),
      ),
    ),
    side: WidgetStatePropertyAll(
      BorderSide(
        color: selected ? c.textPrimary : c.controlBorder,
        width: selected ? AppTokens.selectedWidth : AppTokens.borderWidth,
      ),
    ),
    animationDuration: Duration.zero,
  );

  static SystemUiOverlayStyle systemBars(Brightness brightness) {
    final icons = brightness == Brightness.dark
        ? Brightness.light
        : Brightness.dark;
    return SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: brightness,
      statusBarIconBrightness: icons,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: icons,
      systemNavigationBarContrastEnforced: true,
      systemStatusBarContrastEnforced: true,
    );
  }
}
