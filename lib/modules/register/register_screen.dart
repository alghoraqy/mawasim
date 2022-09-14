import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/bloc/register_bloc/register_cubit.dart';
import 'package:task/bloc/register_bloc/register_states.dart';
import 'package:task/modules/confirm/methods/choose_methods.dart';
import 'package:task/modules/login/login_screen.dart';
import 'package:task/shared/Theme/colors.dart';
import 'package:task/shared/Theme/text_style.dart';
import 'package:task/shared/components/components.dart';
import 'package:task/shared/components/shared_method.dart';
import 'package:task/shared/responsive/responsive.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, states) {
        if (states is RegisterSuccess) {
          flutterToast(text: states.registerModel.message, color: Colors.green);
          navigateTo(context, const ChooseMethodScreen());
        } else {
          if (states is RegisterError) {
            flutterToast(text: states.errorModel.message, color: Colors.red);
          }
        }
      },
      builder: (context, states) {
        RegisterCubit cubit = RegisterCubit.get(context);
        return Scaffold(
          body: Layout(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'مرحبا بـك !',
                    style: AppTextStyle.head1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'إنشاء حساب لبدأ التطبيق',
                    style: AppTextStyle.head2.copyWith(fontSize: 23),
                  ),
                  SizedBox(
                    height: rhight(context) / 20,
                  ),
                  const DashedRow(text: ' تسجيل جديد'),
                   SizedBox(
                    height: rhight(context)/40,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: rwidth(context) / 15),
                    child: Form(
                      key: cubit.formKey,
                      child: Column(
                        children: [
                          MyFormField(
                            hint: 'إسم المستخدم',
                            iconRoute: 'assets/icons/user (50).png',
                            inputType: TextInputType.name,
                            controller: cubit.nameController,
                            errorText: 'لابد من ادخال الإسم',
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          MyFormField(
                            hint: 'رقم الجوال',
                            iconRoute: 'assets/icons/mobile.png',
                            inputType: TextInputType.phone,
                            controller: cubit.phoneController,
                            errorText: 'لابد من ادخال رقم الجوال',
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          MyFormField(
                            hint: 'البريد الإلكتروني',
                            iconRoute: 'assets/icons/mail (11).png',
                            inputType: TextInputType.emailAddress,
                            controller: cubit.emailController,
                            errorText: 'لابد من ادخال البريد الالكتروني',
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          MyFormField(
                            hint: 'كلمة المرور',
                            iconRoute: 'assets/icons/padlock (1).png',
                            inputType: TextInputType.visiblePassword,
                            isSecure: true,
                            controller: cubit.passwordController,
                            errorText: 'لابد من ادخال كلمة المرور',
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: rwidth(context) / 30),
                            width: rwidth(context) / 1.05,
                            child: TextFormField(
                              keyboardType: TextInputType.visiblePassword,
                              controller: cubit.confirmPasswordController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'لابد من ادخال تأكيد كلمة المرور';
                                }
                                if (value != cubit.passwordController.text) {
                                  return 'كلمة المرور غير متشابهة';
                                }
                                return null;
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.all(10),
                                prefixIconConstraints: const BoxConstraints(
                                    minWidth: 18, minHeight: 18),
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Image(
                                    image: AssetImage(
                                        'assets/icons/padlock (1).png'),
                                    fit: BoxFit.cover,
                                    color: Colors.grey,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: AppColors.text1)),
                                hintText: 'تأكيد كلمة المرور',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          MyButton(
                              widget: states is RegisterLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : Text(
                                      'تسجيل',
                                      style: AppTextStyle.head2.copyWith(
                                          color: Colors.white, fontSize: 18),
                                    ),
                              onPressed: () {
                                if (cubit.formKey.currentState!.validate()) {
                                  cubit.register(
                                    name: cubit.nameController.text,
                                    phone: cubit.phoneController.text,
                                    email: cubit.emailController.text,
                                    password: cubit.passwordController.text,
                                    confirmPassword:
                                        cubit.confirmPasswordController.text,
                                  );
                                }
                              },
                              width: rwidth(context) / 2.3),
                          const SizedBox(
                            height: 15,
                          ),
                          MyTextButton(
                              text: 'لدي حساب بالفعل',
                              clickableText: 'تسجيل دخول',
                              onPressed: () {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const LoginScreen();
                                }));
                              }),
                        ],
                      ),
                    ),
                  ),
                  const UnderImage(
                      forGroungImage: 'assets/images/pngegg (18).png'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
