import 'package:flutter/material.dart';
import 'package:flutter_personal_portfolio/global_widgets/link_mouse_region.dart';

extension WidgetExtension on Widget {
  Widget get hoverElastic => LinkMouseRegion.elastic(child: this);
  Widget get hover => LinkMouseRegion(child: this);
}
