import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/bloc/register_bloc/register_cubit.dart';
import 'package:task/bloc/register_bloc/register_states.dart';
import 'package:task/modules/confirm/code/confirm_code_screen.dart';
import 'package:task/shared/Theme/text_style.dart';
import 'package:task/shared/components/components.dart';
import 'package:task/shared/components/shared_method.dart';
import 'package:task/shared/responsive/responsive.dart';

class SendPhoneScreen extends StatelessWidget {
  const SendPhoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        if (state is ActivateEmailOrPhoneSuccess) {
          flutterToast(text: state.activateModel.message, color: Colors.green);
          navigateTo(
              context,
              ConfirmCodeScreen(
                input: RegisterCubit.get(context).sendPhoneController.text,
              ));
        } else {
          if (state is ActivateEmailOrPhoneError) {
            flutterToast(text: state.errorModel.message, color: Colors.red);
          }
        }
      },
      builder: (context, state) {
        RegisterCubit cubit = RegisterCubit.get(context);
        return Scaffold(
          body: DuplicateScreen(
            text1: 'مرحبا أحمد !',
            text2: 'تأكيد التسجيل بالتطبيق',
            descripeText: 'برجاء إادخال رقم الجوال لإرسال كود التحقيق',
            widget: Form(
              key: cubit.sendPhoneformKey,
              child: Column(
                children: [
                  MyFormField(
                    hint: 'رقم الجوال',
                    iconRoute: 'assets/icons/mobile.png',
                    inputType: TextInputType.phone,
                    controller: cubit.sendPhoneController,
                    errorText: 'برجاء إادخال رقم الجوال',
                  ),
                ],
              ),
            ),
            button: MyButton(
                widget: state is ActivateEmailOrPhoneLoading
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                    : Text(
                        'إرسال',
                        style: AppTextStyle.head2
                            .copyWith(color: Colors.white, fontSize: 18),
                      ),
                onPressed: () {
                  if (cubit.sendPhoneformKey.currentState!.validate()) {
                    cubit.activatePhoneOrEmail(
                        method: 'phone', input: cubit.sendPhoneController.text);
                  }
                },
                width: rwidth(context) / 2.3),
            myTextButton: MyTextButton(
                text: 'لم يتم إرسال الرسالة',
                clickableText: 'إعادة المحاوله',
                onPressed: () {}),
            underWidget: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Stack(
                  children: [
                    Image(
                      image: const AssetImage('assets/images/Mask Group 3.png'),
                      height: rhight(context) / 4.5,
                      //fit: BoxFit.cover,
                    ),
                    PositionedDirectional(
                      start: 20,
                      bottom: 0,
                      end: 20,
                      child: Image(
                        image: const AssetImage('assets/images/vector.png'),
                        height: rhight(context) / 5,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
