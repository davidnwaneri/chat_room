import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// {@template space_widget}
/// A widget that adds a space in the main axis.
///
/// If used in a `Column`, whose main axis is vertical, the spacing will
/// be applied on the vertical axis.
///
/// If used in a `Row`, whose main axis is horizontal, the spacing will
/// be applied on the horizontal axis.
///
/// A wrapper around `Gap`
/// {@endtemplate}
class Space extends StatelessWidget {
  /// {@macro space_widget}
  const Space(
    this.value, {
    super.key,
  });

  final double value;

  @override
  Widget build(BuildContext context) {
    return Gap(value);
  }
}
