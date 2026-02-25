import 'package:flutter/material.dart';

@immutable
class AppVisuals extends ThemeExtension<AppVisuals> {
  final Color chartPrimary;
  final Color chartSecondary;
  final Color incomeColor;
  final Color expenseColor;
  final Color glow;

  const AppVisuals({
    required this.chartPrimary,
    required this.chartSecondary,
    required this.incomeColor,
    required this.expenseColor,
    required this.glow,
  });

  @override
  ThemeExtension<AppVisuals> copyWith({
    Color? chartPrimary,
    Color? chartSecondary,
    Color? incomeColor,
    Color? expenseColor,
    Color? glow,
  }) {
    return AppVisuals(
      chartPrimary: chartPrimary ?? this.chartPrimary,
      chartSecondary: chartSecondary ?? this.chartSecondary,
      incomeColor: incomeColor ?? this.incomeColor,
      expenseColor: expenseColor ?? this.expenseColor,
      glow: glow ?? this.glow,
    );
  }

  @override
  ThemeExtension<AppVisuals> lerp(
    covariant ThemeExtension<AppVisuals>? other,
    double t,
  ) => this;

  static const lightVisuals = AppVisuals(
    chartPrimary: Color(0xFF362670),
    chartSecondary: Color(0xFF7268BA),
    incomeColor: Color(0xFF4CAF50),
    expenseColor: Color(0xFFD32F2F),
    glow: Color(0x33362670),
  );
}
