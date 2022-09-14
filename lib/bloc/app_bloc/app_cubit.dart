import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/bloc/app_bloc/app_states.dart';
import 'package:task/models/services_model.dart';
import 'package:task/network/remote/remote.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitAppSates());

  static AppCubit get(context) => BlocProvider.of(context);

  ServicesModel? servicesModel;
  void getServices() {
    DioHelper.getData(path: '/get-services').then((value) {
      servicesModel = ServicesModel.fromJson(value.data);
      print(servicesModel!.data[0].title);
      emit(GetServicesSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetServicesError());
    });
  }
}
