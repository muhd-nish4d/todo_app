import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/screens/authentication/otp_verification.dart';
import 'package:todoapp/screens/home/todos.dart';

class LoginProvider extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoading = false;
  String? verficationIdforOtp;

  void submittedPhoneNumber(String phoneNumber, BuildContext ctx) async {
    isLoading = true;
    notifyListeners();
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        isLoading = false;
        notifyListeners();
        verficationIdforOtp = verificationId;
        Navigator.push(ctx,
            MaterialPageRoute(builder: (context) => const ScreenOtpEnter()));
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void otpVerification(String otp, BuildContext ctx) {
    isLoading = true;
    notifyListeners();
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verficationIdforOtp!, smsCode: otp);
    auth.signInWithCredential(credential).then((value) {
      isLoading = false;
      notifyListeners();
      Navigator.pushAndRemoveUntil(
          ctx,
          MaterialPageRoute(
            builder: (context) => ScreenTodos(),
          ),
          (route) => false);
    });
  }
}
