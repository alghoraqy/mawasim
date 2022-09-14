import 'package:flutter/material.dart';
import 'package:task/modules/confirm/send/send_email_screen.dart';
import 'package:task/modules/confirm/send/send_phone_screen.dart';
import 'package:task/shared/Theme/colors.dart';
import 'package:task/shared/Theme/text_style.dart';
import 'package:task/shared/components/components.dart';
import 'package:task/shared/components/shared_method.dart';
import 'package:task/shared/responsive/responsive.dart';

class ChooseMethodScreen extends StatelessWidget {
  const ChooseMethodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Layout(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'مرحبا أحمد',
              style: AppTextStyle.head1,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'تأكيد التسجيل بالتطبيق',
              style: AppTextStyle.head2,
            ),
            SizedBox(
              height: rhight(context) / 8,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text(
                'برجاء تحديد واحد من الخيارات التالية لإرسال كود التحقيق',
                style: AppTextStyle.head2
                    .copyWith(color: AppColors.text1, fontSize: 15),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            ChooseMethodComponent(
              text1: 'رقم الجوال',
              text2: 'ادخل رقم الجوال لإرسال كود التحقق الخاص بك',
              image: 'assets/images/mobile-app (1).png',
              onPressed: () {
                navigateTo(context, const SendPhoneScreen());
              },
            ),
            const SizedBox(
              height: 15,
            ),
            ChooseMethodComponent(
              text1: 'ألبريد الإلكتروني',
              text2: 'ادخل البريد الإلكتروني لإرسال كود التحقق الخاص بك',
              image: 'assets/images/email (10).png',
              onPressed: () {
                navigateTo(context, const SendEmailScreen());
              },
            ),
            SizedBox(
              height: rhight(context) / 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Stack(
                  children: [
                    Image(
                      image: const AssetImage('assets/images/Mask Group 3.png'),
                      height: rhight(context) / 4.72,
                      //fit: BoxFit.cover,
                    ),
                    PositionedDirectional(
                      start: 20,
                      bottom: 0,
                      end: 20,
                      child: Image(
                        image: const AssetImage(
                            'assets/images/pad-lock-free-download-login-lock-combination-lock-security-transparent-png-151078.png'),
                        height: rhight(context) / 5,
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      )),
    );
  }
}
