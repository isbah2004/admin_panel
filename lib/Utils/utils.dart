import 'package:admin_panel/theme/theme_data.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static Future urlLauncher(url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
  static showMessage(
      {required BuildContext context,
      required String title,
      required String message}) {
    Flushbar(backgroundColor: AppTheme.hintColor,titleColor: AppTheme.primaryTextColor,messageColor: AppTheme.primaryColor,
      title: title,
      message: message,
      duration: const Duration(seconds: 3),
    ).show(context);
  }
}
