import 'package:dating/language/localization/app_localization.dart';
import 'package:flutter/material.dart' show Locale, LocalizationsDelegate;

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations>{
 const AppLocalizationDelegate();
  @override
  bool isSupported(Locale locale){
  return ['en','ar','af','be','gu','hi','in','sp'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async{
    AppLocalizations appLocalizations = AppLocalizations(locale);
    await appLocalizations.load();
    return appLocalizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) => false;

}