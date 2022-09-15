import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task/bloc/register_bloc/register_cubit.dart';
import 'package:task/bloc/register_bloc/register_states.dart';
import 'package:task/modules/confirm/methods/choose_methods.dart';
import 'package:task/modules/home/home_screen.dart';
import 'package:task/network/local/local.dart';
import 'package:task/shared/Theme/colors.dart';
import 'package:task/shared/Theme/text_style.dart';
import 'package:task/shared/components/components.dart';
import 'package:task/shared/components/shared_method.dart';
import 'package:task/shared/constances.dart/constances.dart';
import 'package:task/shared/responsive/responsive.dart';

// ignore: must_be_immutable
class ConfirmCodeScreen extends StatelessWidget {
  final dynamic input;

  ConfirmCodeScreen({Key? key, required this.input}) : super(key: key);

  TextEditingController controller = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        if (state is ActivateAccountSuccess) {
          flutterToast(
              text: state.activateAccountModel.message, color: Colors.green);
          CachHelper.saveData(
                  key: 'token',
                  value: state.activateAccountModel.activateAccountData.token)
              .then((value) {
            AppConstances.token =
                state.activateAccountModel.activateAccountData.token;

            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return const HomeScreen();
            }));
          });
        } else {
          if (state is ActivateAccountError) {
            flutterToast(text: state.message, color: Colors.red);
          }
        }
      },
      builder: (context, state) {
        RegisterCubit cubit = RegisterCubit.get(context);
        return ScreenWithImage(
          image:
              'assets/images/62429906-golden-key-and-pisolated-on-white-removebg-preview.png',
          alignment: const Alignment(-0.7, 1.01),
          widget: Scaffold(
            backgroundColor: Colors.transparent,
            body: DuplicateScreen(
              text1: 'مرحبا أحمد',
              text2: 'تأكيد التسجيل بالتطبيق',
              descripeText: 'كود التحقيق',
              isChangePassword: true,
              widget: Form(
                key: formKey,
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
                    animationDuration: const Duration(milliseconds: 300),
                    cursorColor: Colors.black,
                    controller: controller,
                    autoFocus: true,
                    onCompleted: (value) {
                      cubit.code = int.parse(value);
                    },
                    onChanged: (value) {},
                    appContext: context,
                  ),
                ),
              ),
              button: MyButton(
                  widget: state is ActivateAccountLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          'تأكيد',
                          style: AppTextStyle.head2
                              .copyWith(color: Colors.white, fontSize: 18),
                        ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      cubit.activateAccount(
                          input: input,
                          code: cubit.code!,
                          type: input is String ? 'email' : 'phone');
                    }
                  },
                  width: rwidth(context) / 2.3),
              myTextButton: InkWell(
                onTap: () {
                  navigateTo(context, const ChooseMethodScreen());
                },
                child: Row(
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
          ),
        );
      },
    );
  }
}
