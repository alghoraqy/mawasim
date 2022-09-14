import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task/shared/Theme/colors.dart';
import 'package:task/shared/Theme/text_style.dart';
import 'package:task/shared/responsive/responsive.dart';

class Layout extends StatelessWidget {
  final Widget child;
  const Layout({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          top: rhight(context) / 50,
          right: rwidth(context) / 15,
        ),
        child: SizedBox(
          width: rwidth(context),
          child: child,
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class MyFormField extends StatelessWidget {
  final String hint;
  final String iconRoute;
  final TextInputType inputType;
  final TextEditingController controller;
  final String errorText;
  bool? isSecure;
  MyFormField(
      {Key? key,
      required this.hint,
      required this.iconRoute,
      required this.inputType,
      this.isSecure,
      required this.controller,
      required this.errorText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: rwidth(context) / 30),
      width: rwidth(context) / 1.05,
      child: TextFormField(
        keyboardType: inputType,
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return errorText;
          }
          return null;
        },
        obscureText: isSecure ?? false,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(10),
          prefixIconConstraints:
              const BoxConstraints(minWidth: 18, minHeight: 18),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Image(
              image: AssetImage(iconRoute),
              fit: BoxFit.cover,
              color: Colors.grey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.text1)),
          hintText: hint,
        ),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  final Widget widget;
  final VoidCallback onPressed;
  final double width;

  const MyButton({
    Key? key,
    required this.widget,
    required this.onPressed,
    required this.width,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: MaterialButton(
          color: AppColors.buttonColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
          height: rhight(context) / 14.5,
          onPressed: onPressed,
          child: widget),
    );
  }
}

class DashedRow extends StatelessWidget {
  final String text;
  const DashedRow({Key? key, required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 2,
          width: rwidth(context) / 15,
          color: AppColors.text1,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          text,
          style: AppTextStyle.head1.copyWith(fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}

class MyTextButton extends StatelessWidget {
  final String text;
  final String clickableText;
  final VoidCallback onPressed;
  const MyTextButton(
      {Key? key,
      required this.text,
      required this.clickableText,
      required this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$text .',
          style: AppTextStyle.smallText,
        ),
        TextButton(
            onPressed: onPressed,
            child: Text(
              clickableText,
              style: AppTextStyle.smallText.copyWith(
                  color: AppColors.text2, decoration: TextDecoration.underline),
            ))
      ],
    );
  }
}

class UnderImage extends StatelessWidget {
  final String forGroungImage;
  const UnderImage({
    Key? key,
    required this.forGroungImage,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Stack(
          children: [
            Image(
              image: const AssetImage('assets/images/Mask Group 3.png'),
              height: rhight(context) / 4.6,
            ),
            PositionedDirectional(
              start: 0,
              bottom: 0,
              end: 15,
              child: Image(
                image: AssetImage(forGroungImage),
                height: rhight(context) / 4.5,
                fit: BoxFit.cover,
              ),
            )
          ],
        )
      ],
    );
  }
}

// ignore: must_be_immutable
class DuplicateScreen extends StatelessWidget {
  final String text1;
  final String text2;
  final String descripeText;
  final Widget widget;
  final MyButton button;
  Widget? myTextButton;
  final Widget underWidget;
  bool? isChangePassword;

  DuplicateScreen(
      {super.key,
      required this.text1,
      required this.text2,
      required this.descripeText,
      required this.widget,
      required this.button,
      this.myTextButton,
      required this.underWidget,
      this.isChangePassword});

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text1,
              style: AppTextStyle.head1,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              text2,
              style: AppTextStyle.head2,
            ),
            SizedBox(
              height: rhight(context) / 5,
            ),
            if (isChangePassword == null)
              Padding(
                padding: EdgeInsets.only(right: rwidth(context) / 12),
                child: Text(
                  descripeText,
                  style: AppTextStyle.head2
                      .copyWith(fontSize: 16, color: AppColors.text1),
                ),
              )
            else
              Center(
                child: Text(
                  descripeText,
                  style: AppTextStyle.head2
                      .copyWith(fontSize: 16, color: AppColors.text1),
                ),
              ),
            SizedBox(
              height: rhight(context) / 15,
            ),
            Padding(
                padding: EdgeInsets.only(left: rwidth(context) / 12),
                child: widget),
            SizedBox(
              height: rhight(context) / 13,
            ),
            Padding(
              padding: EdgeInsets.only(left: rwidth(context) / 12),
              child: Column(
                children: [
                  Center(child: button),
                  SizedBox(
                    height: rhight(context) / 20,
                  ),
                  myTextButton ?? const SizedBox(),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            underWidget,
          ],
        ),
      ),
    );
  }
}

class ServiceComponent extends StatelessWidget {
  final String image;
  final String text;
  final VoidCallback onPressed;

  const ServiceComponent(
      {Key? key,
      required this.image,
      required this.text,
      required this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: rwidth(context) / 2.3,
      child: MaterialButton(
        padding: EdgeInsets.zero,
        height: rhight(context) / 4.5,
        onPressed: onPressed,
        color: AppColors.services,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Image(
              image: AssetImage(image),
              height: rhight(context) / 16,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              text,
              style: AppTextStyle.head2.copyWith(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}

class ArrowButton extends StatelessWidget {
  final VoidCallback onPressed;
  const ArrowButton({Key? key, required this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: rwidth(context) / 7,
      child: MaterialButton(
        padding: EdgeInsets.zero,
        height: rhight(context) / 15,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Colors.white),
        ),
        child: const Icon(
          Icons.keyboard_arrow_right,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }
}

class ChooseMethodComponent extends StatelessWidget {
  final String text1;
  final String text2;
  final String image;
  final VoidCallback onPressed;

  const ChooseMethodComponent({
    Key? key,
    required this.text1,
    required this.text2,
    required this.image,
    required this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: rwidth(context) / 1.2,
      child: DottedBorder(
        color: AppColors.text2,
        dashPattern: const [8, 4],
        radius: const Radius.circular(10),
        borderType: BorderType.RRect,
        child: MaterialButton(
          onPressed: onPressed,
          height: rhight(context) / 5.8,
          padding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: rwidth(context) / 18),
            child: Row(
              children: [
                Image(
                  image: AssetImage(image),
                  height: rhight(context) / 12,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text1,
                        style: AppTextStyle.smallText
                            .copyWith(color: AppColors.text2),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        text2,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.smallText
                            .copyWith(color: AppColors.text1, fontSize: 13),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<bool?> flutterToast({required String text, required Color color}) {
  return Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
}
