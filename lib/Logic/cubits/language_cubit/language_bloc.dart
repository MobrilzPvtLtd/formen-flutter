import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState>{
  LanguageCubit() : super(const SelectedLanguage(Locale('en')));

  void toArabic() =>  emit(const SelectedLanguage(Locale('ar')));

  void toEnglish() =>  emit(const SelectedLanguage(Locale('en')));

  void toSpanish() =>  emit(const SelectedLanguage(Locale('sp')));

  void toHindi() =>  emit(const SelectedLanguage(Locale('hi')));

  void toGujarati() =>  emit(const SelectedLanguage(Locale('gu')));

  void toAfrikaans() =>  emit(const SelectedLanguage(Locale('af')));

  void toBengali() =>  emit(const SelectedLanguage(Locale('be')));

  void toIndonesian() =>  emit(const SelectedLanguage(Locale('in')));
}
