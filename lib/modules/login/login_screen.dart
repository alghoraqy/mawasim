import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/bloc/login_bloc/login_cubit.dart';
import 'package:task/bloc/login_bloc/login_states.dart';
import 'package:task/modules/confirm/methods/choose_methods.dart';
import 'package:task/modules/home/home_screen.dart';
import 'package:task/modules/password/forget_password_screen.dart';
import 'package:task/modules/register/register_screen.dart';
import 'package:task/network/local/local.dart';
import 'package:task/shared/Theme/text_style.dart';
import 'package:task/shared/components/components.dart';
import 'package:task/shared/components/shared_method.dart';
import 'package:task/shared/constances.dart/constances.dart';
import 'package:task/shared/responsive/responsive.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            flutterToast(text: state.loginModel.message, color: Colors.green);
            CachHelper.saveData(
                    key: 'token',
                    value: state.loginModel.activateAccountData.token)
                .then((value) {
              AppConstances.token = state.loginModel.activateAccountData.token;
              navigateTo(context, const HomeScreen());
            });
          } else {
            if (state is LoginError) {
              flutterToast(text: state.errormessage, color: Colors.red);
              if (state.errormessage == "الحساب غير مفعل") {
                navigateTo(context, const ChooseMethodScreen());
              }
            }
          }
        },
        builder: (context, state) {
          LoginCubit cubit = LoginCubit.get(context);
          return Scaffold(
            body: Layout(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '! مرحبا بعودتك',
                      textDirection: TextDirection.ltr,
                      style: AppTextStyle.head1,
                    ),
                    SizedBox(
                      height: rhight(context) / 45,
                    ),
                    Text(
                      'تسجيل الدخول للمتابعة',
                      style: AppTextStyle.head2,
                    ),
                    SizedBox(
                      height: rhight(context) / 9,
                    ),
                    const DashedRow(text: 'تسجيل الدخول'),
                    SizedBox(
                      height: rhight(context) / 60,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: rwidth(context) / 15),
                      child: Form(
                        key: cubit.loginformKey,
                        child: Column(
                          children: [
                            MyFormField(
                              hint: 'البريد الإلكتروني',
                              iconRoute: 'assets/icons/mail (11).png',
                              inputType: TextInputType.emailAddress,
                              controller: cubit.emailController,
                              errorText: 'برجاء إدخال البريد الإلكتروني',
                            ),
                            SizedBox(
                              height: rhight(context) / 60,
                            ),
                            MyFormField(
                              hint: 'كلمة المرور',
                              iconRoute: 'assets/icons/padlock (1).png',
                              inputType: TextInputType.visiblePassword,
                              isSecure: true,
                              controller: cubit.passwordController,
                              errorText: 'برجاءإدخال  كلمة المرور',
                            ),
                            SizedBox(
                              height: rhight(context) / 70,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      navigateTo(context,
                                          const ForgetPasswordScreen());
                                    },
                                    child: Text(
                                      'نسيت كلمة المرور ؟',
                                      style: AppTextStyle.smallText,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: rhight(context) / 70,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: rwidth(context) / 16),
                      child: Center(
                        child: MyButton(
                            widget: state is LoginLoading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    'دخول',
                                    style: AppTextStyle.head2.copyWith(
                                        color: Colors.white, fontSize: 18),
                                  ),
                            onPressed: () {
                              if (cubit.loginformKey.currentState!.validate()) {
                                cubit.login(
                                    email: cubit.emailController.text,
                                    password: cubit.passwordController.text);
                              }
                            },
                            width: rwidth(context) / 2.3),
                      ),
                    ),
                    SizedBox(
                      height: rhight(context) / 80,
                    ),
                    MyTextButton(
                        text: 'ليس لدي حساب',
                        clickableText: 'تسجيل جديد',
                        onPressed: () {
                          navigateTo(context, const RegisterScreen());
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image(
                          image:
                              const AssetImage('assets/images/Group 3125.png'),
                          height: rhight(context) / 3.3,
                          fit: BoxFit.cover,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
