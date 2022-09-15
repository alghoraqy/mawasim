import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/bloc/login_bloc/login_cubit.dart';
import 'package:task/bloc/login_bloc/login_states.dart';
import 'package:task/modules/confirm/code/confirm_code_pass_screen.dart';
import 'package:task/shared/Theme/text_style.dart';
import 'package:task/shared/components/components.dart';
import 'package:task/shared/components/shared_method.dart';
import 'package:task/shared/responsive/responsive.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is SendEmailCodeSuccess) {
          flutterToast(text: state.activateModel.message, color: Colors.green);
          navigateTo(context, ConfirmCodePassword());
        } else {
          if (state is LoginError) {
            flutterToast(text: state.errormessage, color: Colors.red);
          }
        }
      },
      builder: (context, state) {
        LoginCubit cubit = LoginCubit.get(context);
        return ScreenWithImage(
            image:
                'assets/images/toppng.com-dudas-y-preguntas-png-question-mark-716x876.png',
            alignment: const Alignment(-0.7, 1.03),
            widget: Scaffold(
              backgroundColor: Colors.transparent,
              body: DuplicateScreen(
                text1: 'مرحبا أحمد !',
                text2: 'نسيت كلمة المرور',
                descripeText:
                    'برجاء إدخال البريد الإلكتروني لإرسال كود التحقيق',
                widget: Form(
                  key: cubit.sendEmailForgetPass,
                  child: Column(
                    children: [
                      MyFormField(
                        hint: 'البريد الإلكتروني',
                        iconRoute: 'assets/icons/mail (11).png',
                        inputType: TextInputType.emailAddress,
                        controller: cubit.sendEmailcontroller,
                        errorText: 'برجاء إدخال البريد الإلكتروني',
                      ),
                    ],
                  ),
                ),
                button: MyButton(
                    widget: state is SendEmailCodeLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            'إرسال',
                            style: AppTextStyle.head2
                                .copyWith(color: Colors.white, fontSize: 18),
                          ),
                    onPressed: () {
                      if (cubit.sendEmailForgetPass.currentState!.validate()) {
                        cubit.sendEmailCode(
                            email: cubit.sendEmailcontroller.text);
                      }
                    },
                    width: rwidth(context) / 2.3),
                myTextButton: MyTextButton(
                    text: 'لم يتم إرسال الرسالة',
                    clickableText: 'إعادة المحاوله',
                    onPressed: () {}),
              ),
            ));
      },
    );
  }
}
