import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/bloc/register_bloc/register_cubit.dart';
import 'package:task/bloc/register_bloc/register_states.dart';
import 'package:task/modules/confirm/code/confirm_code_screen.dart';
import 'package:task/shared/Theme/text_style.dart';
import 'package:task/shared/components/components.dart';
import 'package:task/shared/components/shared_method.dart';
import 'package:task/shared/responsive/responsive.dart';

class SendEmailScreen extends StatelessWidget {
  const SendEmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        if (state is ActivateEmailOrPhoneSuccess) {
          flutterToast(text: state.activateModel.message, color: Colors.green);
          navigateTo(
              context,
              ConfirmCodeScreen(
                input: RegisterCubit.get(context).sendEmailController.text,
              ));
        } else {
          if (state is ActivateEmailOrPhoneError) {
            flutterToast(text: state.errorModel.message, color: Colors.red);
          }
        }
      },
      builder: (context, state) {
        RegisterCubit cubit = RegisterCubit.get(context);
        return ScreenWithImage(
            image:
                'assets/images/116-1167951_dhanvradhi-nidhi-limited-green-email-icon-png-removebg-preview.png',
            alignment: const Alignment(-0.55, 1.01),
            widget: Scaffold(
              backgroundColor: Colors.transparent,
              body: DuplicateScreen(
                text1: 'مرحبا أحمد !',
                text2: 'تأكيد التسجيل بالتطبيق',
                descripeText:
                    'برجاء إدخال البريد الإلكتروني لإرسال كود التحقيق',
                widget: Form(
                  key: cubit.sendEmailformKey,
                  child: Column(
                    children: [
                      MyFormField(
                        hint: 'البريد الإلكتروني',
                        iconRoute: 'assets/icons/mail (11).png',
                        inputType: TextInputType.emailAddress,
                        controller: cubit.sendEmailController,
                        errorText: 'برجاء إدخال البريد الإلكتروني',
                      ),
                    ],
                  ),
                ),
                button: MyButton(
                    widget: state is ActivateEmailOrPhoneLoading
                        ? const Center(
                            child:
                                CircularProgressIndicator(color: Colors.white),
                          )
                        : Text(
                            'إرسال',
                            style: AppTextStyle.head2
                                .copyWith(color: Colors.white, fontSize: 18),
                          ),
                    onPressed: () {
                      if (cubit.sendEmailformKey.currentState!.validate()) {
                        cubit.activatePhoneOrEmail(
                            method: 'email',
                            input: cubit.sendEmailController.text);
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
