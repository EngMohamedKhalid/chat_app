// ignore_for_file: avoid_print
import 'package:chat_app/shared/cubit/states.dart';
import 'package:chat_app/shared/network/local/cash_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SharedCubit extends Cubit <SharedStates>{
  SharedCubit ():super(InitialState());
  static SharedCubit getObject(context) =>BlocProvider.of(context);
  bool light =false;
  void changeLight ({bool? fromShared}){
    if(fromShared!=null){
      light =fromShared;
      emit(ChangeLightState());
    }else{
      light =!light;
      CashHelper.setPool(key: "isDark", value: light).then((value){
        emit(ChangeLightState());
      });
    }
  }

}