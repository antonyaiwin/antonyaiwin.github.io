import 'package:flutter/material.dart';
import 'package:flutter_personal_portfolio/controller/contact_section_controller.dart';
import 'package:flutter_personal_portfolio/core/constants/color_constants.dart';
import 'package:provider/provider.dart';

import '../../../../global_widgets/elevated_container.dart';
import '../../../../global_widgets/subtitle.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    var contactFormProvider = context.read<ContactSectionController>();
    return ConstrainedBox(
      constraints: BoxConstraints.loose(const Size.fromWidth(700)),
      child: Form(
        key: contactFormProvider.formKey,
        child: Column(
          children: [
            const Subtitle(text: 'Get In Touch'),
            const SizedBox(height: 10),
            ElevatedContainer(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ContactSubtitle(
                    text: 'Name',
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: contactFormProvider.nameController,
                    decoration:
                        const InputDecoration(hintText: 'Enter Your Name'),
                    validator: contactFormProvider.nameValidator,
                  ),
                  const SizedBox(height: 20),
                  const ContactSubtitle(
                    text: 'Email',
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: contactFormProvider.emailController,
                    decoration:
                        const InputDecoration(hintText: 'Enter Your Email'),
                    validator: contactFormProvider.emailValidator,
                  ),
                  const SizedBox(height: 20),
                  const ContactSubtitle(text: 'Message'),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: contactFormProvider.messageController,
                    decoration:
                        const InputDecoration(hintText: 'Enter Your Message'),
                    maxLines: 5,
                    validator: contactFormProvider.messageValidator,
                  ),
                  const SizedBox(height: 15),
                  Consumer<ContactSectionController>(
                    builder: (BuildContext context,
                            ContactSectionController value, Widget? child) =>
                        OutlinedButton(
                      onPressed: value.submittingData
                          ? null
                          : () {
                              contactFormProvider.submitForm(context);
                            },
                      child: Center(
                        child: Text(
                            value.submittingData ? 'Submitting...' : 'Submit'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
