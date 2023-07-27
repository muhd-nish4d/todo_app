import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/constants/form_feild/pinput_form.dart';
import 'package:todoapp/provider/login_provider.dart';

class ScreenOtpEnter extends StatelessWidget {
  const ScreenOtpEnter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Pinput(
            defaultPinTheme: defaultPinTheme,
            focusedPinTheme: focusedPinTheme,
            submittedPinTheme: submittedPinTheme,
            length: 6,
            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
            showCursor: true,
            onCompleted: (pin) {
              Provider.of<LoginProvider>(context, listen: false)
                  .otpVerification(pin, context);
            },
          ),
        ],
      ),
    );
  }
}
