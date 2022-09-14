import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/bloc/app_bloc/app_cubit.dart';
import 'package:task/bloc/app_bloc/app_states.dart';
import 'package:task/modules/login/login_screen.dart';
import 'package:task/network/local/local.dart';
import 'package:task/shared/Theme/colors.dart';
import 'package:task/shared/Theme/text_style.dart';
import 'package:task/shared/components/components.dart';
import 'package:task/shared/responsive/responsive.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return AppCubit()..getServices();
      },
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, states) {},
        builder: (context, states) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            body: SafeArea(
              top: false,
              child: Container(
                height: rhight(context),
                width: rwidth(context),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/Rectangle 1234.png'),
                      fit: BoxFit.cover),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: rhight(context) / 15,
                      right: rwidth(context) / 20,
                      left: rwidth(context) / 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ArrowButton(onPressed: () {
                            CachHelper.removeData(key: 'token').then((value) {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return const LoginScreen();
                              }));
                            });
                          }),
                          const SizedBox(
                            width: 15,
                          ),
                          Text('الخدمات الرئيسية',
                              style: AppTextStyle.head1
                                  .copyWith(color: Colors.white, fontSize: 25))
                        ],
                      ),
                      SizedBox(
                        height: rhight(context) / 12,
                      ),
                      cubit.servicesModel != null
                          ? Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ServiceComponent(
                                        image: 'assets/services/Group 179.png',
                                        text: 'نظافة مباني',
                                        onPressed: () {}),
                                    ServiceComponent(
                                        image: 'assets/services/Group 180.png',
                                        text: 'نظافة السيارات',
                                        onPressed: () {}),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ServiceComponent(
                                        image: 'assets/services/Group 175.png',
                                        text: 'تأجير حاويات',
                                        onPressed: () {}),
                                    ServiceComponent(
                                        image: 'assets/services/Group 181.png',
                                        text: 'إيجار وايتات',
                                        onPressed: () {}),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ServiceComponent(
                                        image: 'assets/services/Group 2182.png',
                                        text: 'خدمات صيانة',
                                        onPressed: () {}),
                                    ServiceComponent(
                                        image: 'assets/services/Group 2183.png',
                                        text: 'خدمات حاويات',
                                        onPressed: () {}),
                                  ],
                                ),
                              ],
                            )
                          : Expanded(
                              child: Center(
                                child: CircularProgressIndicator(
                                    color: AppColors.services),
                              ),
                            )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
