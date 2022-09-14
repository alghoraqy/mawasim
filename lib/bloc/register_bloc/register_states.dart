import 'package:task/models/activate_acount_model.dart';
import 'package:task/models/activate_model.dart';
import 'package:task/models/error_model.dart';
import 'package:task/models/register_model.dart';

abstract class RegisterStates {}

class InitRegisterState extends RegisterStates {}

class RegisterLoading extends RegisterStates {}

class RegisterSuccess extends RegisterStates {
  final RegisterModel registerModel;
  RegisterSuccess({required this.registerModel});
}

class RegisterError extends RegisterStates {
  final ErrorModel errorModel;
  RegisterError({required this.errorModel});
}

class ActivateEmailOrPhoneLoading extends RegisterStates {}

class ActivateEmailOrPhoneSuccess extends RegisterStates {
  final ActivateModel activateModel;
  ActivateEmailOrPhoneSuccess({required this.activateModel});
}

class ActivateEmailOrPhoneError extends RegisterStates {
  final ErrorModel errorModel;
  ActivateEmailOrPhoneError({required this.errorModel});
}

class ActivateAccountLoading extends RegisterStates {}

class ActivateAccountSuccess extends RegisterStates {
  final ActivateAccountModel activateAccountModel;
  ActivateAccountSuccess({required this.activateAccountModel});
}

class ActivateAccountError extends RegisterStates {
  final String message;
  ActivateAccountError({required this.message});
}
