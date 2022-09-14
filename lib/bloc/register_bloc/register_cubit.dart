import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/bloc/register_bloc/register_states.dart';
import 'package:task/models/activate_acount_model.dart';
import 'package:task/models/activate_model.dart';
import 'package:task/models/error_model.dart';
import 'package:task/models/register_model.dart';
import 'package:task/network/remote/remote.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(InitRegisterState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  var formKey = GlobalKey<FormState>();

  var sendEmailformKey = GlobalKey<FormState>();
  var sendPhoneformKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  TextEditingController sendEmailController = TextEditingController();
  TextEditingController sendPhoneController = TextEditingController();

  RegisterModel? registerModel;
  void register({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String confirmPassword,
  }) {
    emit(RegisterLoading());
    DioHelper.postData(path: '/register', data: {
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
      'confirm_password': confirmPassword,
      'token_firebase': 'rrrrrrrrrrrrrrrrrrrrr',
      'device_id': 446456456456
    }).then((value) {
      registerModel = RegisterModel.fromJson(value.data);
      emit(RegisterSuccess(registerModel: registerModel!));
    }).catchError((error) {
      if (error is DioError) {
        if (error.response!.statusCode == 422) {
          emit(RegisterError(
              errorModel: ErrorModel.fromJson(error.response!.data)));
        }
      }
    });
  }

  ActivateModel? activateModel;
  void activatePhoneOrEmail({
    required String method,
    required dynamic input,
  }) {
    emit(ActivateEmailOrPhoneLoading());
    DioHelper.postData(
        path: '/active-phone-or-email',
        data: {method: input, 'type': method}).then((value) {
      activateModel = ActivateModel.fromJson(value.data);
      emit(ActivateEmailOrPhoneSuccess(activateModel: activateModel!));
    }).catchError((error) {
      if (error is DioError) {
        if (error.response!.statusCode == 422) {
          emit(ActivateEmailOrPhoneError(
              errorModel: ErrorModel.fromJson(error.response!.data)));
        }
      }
      print(error.toString());
    });
  }

  int? code;
  ActivateAccountModel? activateAccountModel;
  void activateAccount(
      {required dynamic input, required int code, required String type}) {
    emit(ActivateAccountLoading());
    DioHelper.postData(
            path: '/active-code',
            data: {'phone_or_email': input, 'code': code, 'type': type})
        .then((value) {
      activateAccountModel = ActivateAccountModel.fromJson(value.data);
      emit(ActivateAccountSuccess(activateAccountModel: activateAccountModel!));
    }).catchError((error) {
      if (error is DioError) {
        if (error.response!.statusCode == 404) {
          emit(ActivateAccountError(message: error.response!.data['message']));
        }
      }
      print(error.toString());
    });
  }
}
