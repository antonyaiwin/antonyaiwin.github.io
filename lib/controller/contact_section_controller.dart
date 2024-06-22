import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_personal_portfolio/core/constants/color_constants.dart';
import 'package:flutter_personal_portfolio/core/constants/string_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSectionController extends ChangeNotifier {
  bool submittingData = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  Future<void> submitForm(BuildContext context) async {
    if (formKey.currentState?.validate() ?? false) {
      submittingData = true;
      notifyListeners();
      try {
        Uri uri = Uri.parse(contactFormLink);

        uri = Uri(
          scheme: uri.scheme,
          host: uri.host,
          path: uri.path,
          query: uri.query,
          queryParameters: {
            contactFormNameElementId: nameController.text,
            contactFormEmailElementId: emailController.text,
            contactFormMessageElementId: messageController.text,
          },
        );
        launchUrl(uri);
        clearTextField();
        // log(uri.toString());
        // var response = await http.post(
        //   uri,
        //   body: {
        //     contactFormNameElementId: nameController.text,
        //     contactFormEmailElementId: emailController.text,
        //     contactFormMessageElementId: messageController.text,
        //   },
        // ).timeout(const Duration(seconds: 10));
        // log(response.toString());
        // if (response.statusCode == 200) {
        //   clearTextField();

        //   if (context.mounted) {
        //     showSuccessDialog(context);
        //   }
        // } else {
        //   if (context.mounted) {
        //     showErrorSnackbar(context);
        //   }
        // }
        // } on http.ClientException catch (e) {
        //   log(e.message.toString());
        // log(e.uri.toString());
        // if (context.mounted) {
        //   showErrorSnackbar(context);
        // }
      } on Exception catch (e) {
        log(e.toString());
        // log(e.runtimeType.toString());
        // if (context.mounted) {
        //   showErrorSnackbar(context);
        // }
      }
      submittingData = false;
      notifyListeners();
    }
  }

  void clearTextField() {
    nameController.clear();
    emailController.clear();
    messageController.clear();
  }

  void showSuccessDialog(BuildContext context) {
    showAdaptiveDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Your contact details have been submitted successfully. You will be contacted shortly.',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: ColorConstants.primaryWhite),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void showErrorSnackbar(context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Something went wrong. Details not submitted!'),
      ),
    );
  }

  String? nameValidator(String? value) {
    if (value != null && value.length >= 3) {
      return null;
    } else {
      return 'Enter valid name!';
    }
  }

  String? emailValidator(String? value) {
    if (EmailValidator.validate(value ?? '')) {
      return null;
    } else {
      return 'Enter valid email address!';
    }
  }

  String? messageValidator(String? value) {
    if (value != null && value.isNotEmpty) {
      return null;
    } else {
      return 'Enter valid message!';
    }
  }
}
