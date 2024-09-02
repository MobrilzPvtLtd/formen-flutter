
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'lite_dark_state.dart';

enum ThemeEvent { toggleDark, toggleLight}

class ThemeBloc extends Cubit<ThemeState> {



  ThemeBloc() : super(ThemeState.lightTheme) {
    getTheme().then((value) {
      if(value == "dark"){
        emit(ThemeState.darkTheme);
      }else{
        emit(ThemeState.lightTheme);
      }
    });
  }
 addTheme(event){
   switch (event) {
     case ThemeEvent.toggleDark:
       emit(ThemeState.darkTheme);
       break;
     case ThemeEvent.toggleLight:
       emit(ThemeState.lightTheme);
       break;
   }
 }
}

Future<String?> getTheme() async {
  SharedPreferences preferences =  await SharedPreferences.getInstance();

  return preferences.getString("ThemeData");
}