import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task/bloc/login_bloc/login_cubit.dart';
import 'package:task/bloc/login_bloc/login_states.dart';
import 'package:task/modules/password/change_password_screen.dart';
import 'package:task/shared/Theme/colors.dart';
import 'package:task/shared/Theme/text_style.dart';
import 'package:task/shared/components/components.dart';
import 'package:task/shared/components/shared_method.dart';
import 'package:task/shared/responsive/responsive.dart';

// ignore: must_be_immutable
class ConfirmCodePassword extends StatelessWidget {
  ConfirmCodePassword({Key? key}) : super(key: key);

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {},
      builder: (context, state) {
        LoginCubit cubit = LoginCubit.get(context);
        return ScreenWithImage(
          image:
              'assets/images/62429906-golden-key-and-pisolated-on-white-removebg-preview.png',
          alignment: const Alignment(-0.7, 1.01),
          widget: Scaffold(
            backgroundColor: Colors.transparent,
            body: DuplicateScreen(
              text1: 'مرحبا أحمد',
              text2: 'نسيت كلمة المرور',
              descripeText: 'كود التجقيق',
              isChangePassword: true,
              widget: Form(
                key: cubit.confirmPassformKey,
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: PinCodeTextField(
                    length: 4,
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    animationType: AnimationType.fade,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Must Enter code';
                      }
                      return null;
                    },
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: rhight(context) / 12,
                      fieldWidth: rwidth(context) / 6,
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                    ),
                    autoFocus: false,
                    scrollPadding: EdgeInsets.zero,
                    animationDuration: const Duration(milliseconds: 300),
                    cursorColor: Colors.black,
                    controller: controller,
                    onCompleted: (v) {
                      print("Completed $v ");
                      cubit.code = int.parse(v);
                    },
                    onChanged: (value) {
                      print(value);
                    },
                    appContext: context,
                  ),
                ),
              ),
              button: MyButton(
                  widget: Text(
                    'تأكيد',
                    style: AppTextStyle.head2
                        .copyWith(color: Colors.white, fontSize: 18),
                  ),
                  onPressed: () {
                    if (cubit.confirmPassformKey.currentState!.validate()) {
                      navigateTo(context, ChangePasswordScreen());
                    }
                  },
                  width: rwidth(context) / 2.3),
              myTextButton: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.refresh_sharp,
                    color: AppColors.text2,
                    size: 25,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'إعاد المحاوله',
                    style: AppTextStyle.smallText.copyWith(
                        decoration: TextDecoration.underline,
                        color: AppColors.text2),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
