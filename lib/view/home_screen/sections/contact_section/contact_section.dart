import 'package:flutter/material.dart';
import 'package:flutter_personal_portfolio/core/constants/color_constants.dart';

import '../../../../global_widgets/subtitle.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.loose(const Size.fromWidth(700)),
      child: Column(
        children: [
          const Subtitle(text: 'Get In Touch'),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: ColorConstants.lightNavy,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ContactSubtitle(
                  text: 'Name',
                ),
                const SizedBox(height: 5),
                TextFormField(
                  decoration:
                      const InputDecoration(hintText: 'Enter Your Name'),
                ),
                const SizedBox(height: 20),
                const ContactSubtitle(
                  text: 'Email',
                ),
                const SizedBox(height: 5),
                TextFormField(
                  decoration:
                      const InputDecoration(hintText: 'Enter Your Email'),
                ),
                const SizedBox(height: 20),
                const ContactSubtitle(text: 'Message'),
                const SizedBox(height: 5),
                TextFormField(
                  decoration:
                      const InputDecoration(hintText: 'Enter Your Message'),
                  maxLines: 5,
                ),
                const SizedBox(height: 15),
                OutlinedButton(
                  onPressed: () {},
                  child: const Center(
                    child: Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ContactSubtitle extends StatelessWidget {
  const ContactSubtitle({
    super.key,
    required this.text,
  });

  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: ColorConstants.primaryWhite,
          ),
    );
  }
}
