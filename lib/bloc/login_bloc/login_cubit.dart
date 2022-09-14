import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/bloc/login_bloc/login_states.dart';
import 'package:task/models/activate_model.dart';
import 'package:task/models/error_model.dart';
import 'package:task/models/login_mode.dart';
import 'package:task/network/remote/remote.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitLoginState());

  static LoginCubit get(context) => BlocProvider.of(context);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController sendEmailcontroller = TextEditingController();

  int? code;

  var loginformKey = GlobalKey<FormState>();

  var sendEmailForgetPass = GlobalKey<FormState>();

  var confirmPassformKey = GlobalKey<FormState>();

  LoginModel? loginModel;
  void login({
    required String email,
    required String password,
  }) {
    emit(LoginLoading());
    DioHelper.postData(path: '/login', data: {
      'email': email,
      'password': password,
      'token_firebase': 'rrrrrrrrrrrrrrrrrrrrrrrrrrr',
      'device_id': 44645645645,
    }).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(LoginSuccess(loginModel: loginModel!));
    }).catchError((error) {
      if (error is DioError) {
        if (error.response!.statusCode == 422) {
          emit(LoginError(errormessage: error.response!.data['message']));
        }
        if (error.response!.statusCode == 404) {
          emit(LoginError(
              errormessage: error.response!.data['message'], activate: true));
        }
      }
      print(error.toString());
    });
  }

  ActivateModel? activateModel;
  void sendEmailCode({required String email}) {
    emit(SendEmailCodeLoading());
    DioHelper.postData(
        path: '/active-phone-or-email',
        data: {'email': email, 'type': 'email'}).then((value) {
      activateModel = ActivateModel.fromJson(value.data);
      emit(SendEmailCodeSuccess(activateModel: activateModel!));
    }).catchError((error) {
      if (error is DioError) {
        if (error.response!.statusCode == 422) {
          emit(SendEmailCodeError(
              errorModel: ErrorModel.fromJson(error.response!.data)));
        }
      }
      print(error.toString());
    });
  }
}
