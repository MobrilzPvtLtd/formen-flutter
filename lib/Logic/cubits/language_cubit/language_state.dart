
part of 'language_bloc.dart';

@immutable
abstract class LanguageState{
  final Locale locale;
  const LanguageState(this.locale);
}

class SelectedLanguage extends LanguageState {
  const SelectedLanguage(Locale locale) : super(locale);
}

