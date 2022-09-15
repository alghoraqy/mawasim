import 'package:flutter/material.dart';
import 'package:task/shared/Theme/text_style.dart';
import 'package:task/shared/components/components.dart';
import 'package:task/shared/responsive/responsive.dart';

// ignore: must_be_immutable
class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);

  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmPasswordcontroller = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ScreenWithImage(
        image: 'assets/images/Crypto-Lock-3D-Illustration-2.png',
        alignment: const Alignment(-0.6, .98),
        widget: Scaffold(
          backgroundColor: Colors.transparent,
          body: DuplicateScreen(
            text1: 'مرحبا أحمد !',
            text2: 'تغيير كلمة المرور',
            descripeText: 'تغيير كلمة المرور',
            isChangePassword: true,
            widget: Form(
              key: formKey,
              child: Column(
                children: [
                  MyFormField(
                    hint: 'كلمة المرور الجديدة',
                    iconRoute: 'assets/icons/padlock (1).png',
                    inputType: TextInputType.visiblePassword,
                    isSecure: true,
                    controller: passwordcontroller,
                    errorText: 'برجاء إدخال كلمة المرور الجديدة',
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  MyFormField(
                    hint: 'تأكيد كلمة المرور الجديدة',
                    iconRoute: 'assets/icons/padlock (1).png',
                    inputType: TextInputType.visiblePassword,
                    isSecure: true,
                    controller: confirmPasswordcontroller,
                    errorText: 'برجاء إدخال تأكيد كلمة المرور الجديدة',
                  )
                ],
              ),
            ),
            button: MyButton(
                widget: Text(
                  'حفظ',
                  style: AppTextStyle.head2
                      .copyWith(color: Colors.white, fontSize: 18),
                ),
                onPressed: () {
                  formKey.currentState!.validate();
                },
                width: rwidth(context) / 2.3),
          ),
        ));
  }
}
