import 'package:admin_panel/Utils/utils.dart';
import 'package:admin_panel/authscreen/verify_code.dart';
import 'package:admin_panel/homescreen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/widgets.dart';

const String adminsPhone = '+923072118499';
final FirebaseAuth auth = FirebaseAuth.instance;

class PhoneProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void login(
      {
      required BuildContext context}) {
    setLoading(true);
    auth.verifyPhoneNumber(
        phoneNumber: adminsPhone,
        verificationCompleted: (_) {
          setLoading(false);
        },
        verificationFailed: (e) {
          setLoading(false);
          Utils.showMessage(
              context: context, title: 'Error', message: e.toString());
        },
        codeSent: (String verificationId, int? token) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VerifyCodeScreen(
                        verificationId: verificationId,
                      )));
          setLoading(false);
        },
        codeAutoRetrievalTimeout: (e) {
          Utils.showMessage(
              context: context, title: 'Timeout', message: e.toString());
          setLoading(false);
        });
  }

  Future<void> verifyPhone(
      {
      required TextEditingController verificationCodeController,
      required String verificationId,
      required BuildContext context}) async {
    setLoading(true);
    final crendital = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: verificationCodeController.text.toString());

    try {
      await auth.signInWithCredential(crendital);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } catch (e) {
      setLoading(false);
      Utils.showMessage(
          context: context, title: 'Error', message: e.toString());
    }
  }
}
