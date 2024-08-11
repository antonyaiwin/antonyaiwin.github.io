import 'package:flutter/material.dart';
import 'package:flutter_personal_portfolio/extensions/widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/string_constants.dart';

class ResumeButton extends StatelessWidget {
  const ResumeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        launchUrl(Uri.parse(resumeLink));
      },
      child: const Text('My Resume'),
    ).hover;
  }
}
