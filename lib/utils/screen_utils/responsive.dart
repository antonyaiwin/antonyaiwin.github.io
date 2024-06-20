import 'package:flutter/material.dart';

// class Responsive {
bool isMobile(BuildContext context) {
  return MediaQuery.sizeOf(context).width < 600;
}

bool isbelow750(BuildContext context) {
  return MediaQuery.sizeOf(context).width < 750;
}

// bool isWeb(BuildContext context) {
//   return MediaQuery.sizeOf(context).width >=
//       500; /*  &&
//       MediaQuery.sizeOf(context).width < 1000; */
// }
// }
