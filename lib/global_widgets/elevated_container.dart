import 'package:flutter/material.dart';

import '../core/constants/color_constants.dart';

class ElevatedContainer extends StatelessWidget {
  const ElevatedContainer({
    super.key,
    required this.child,
    this.padding,
  });
  final Widget child;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: ColorConstants.lightNavy,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
