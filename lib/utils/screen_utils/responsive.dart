import 'package:flutter/material.dart';

// class Responsive {
bool isMobile(BuildContext context) {
  return MediaQuery.sizeOf(context).width < 600;
}

// bool isWeb(BuildContext context) {
//   return MediaQuery.sizeOf(context).width >=
//       500; /*  &&
//       MediaQuery.sizeOf(context).width < 1000; */
// }
// }
