import 'package:task/models/activate_model.dart';
import 'package:task/models/error_model.dart';
import 'package:task/models/login_mode.dart';

abstract class LoginStates {}

class InitLoginState extends LoginStates {}

class LoginLoading extends LoginStates {}

class LoginSuccess extends LoginStates {
  final LoginModel loginModel;
  LoginSuccess({required this.loginModel});
}

class LoginError extends LoginStates {
  final String errormessage;
  bool? activate = false;
  LoginError({required this.errormessage, this.activate});
}

class SendEmailCodeLoading extends LoginStates {}

class SendEmailCodeSuccess extends LoginStates {
  final ActivateModel activateModel;
  SendEmailCodeSuccess({required this.activateModel});
}

class SendEmailCodeError extends LoginStates {
  final ErrorModel errorModel;
  SendEmailCodeError({required this.errorModel});
}
