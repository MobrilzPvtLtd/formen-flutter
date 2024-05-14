import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'app_localization_delegate.dart';

class AppLocalizations{
  final Locale locale;
  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context){
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = AppLocalizationDelegate();

  Map<String,String>? _localizedString;

  Future<void> load() async{
    String jsonString = await rootBundle.loadString("lang/${locale.languageCode}.json");
    Map<String,dynamic> jsonMap = json.decode(jsonString);
    _localizedString = jsonMap.map<String,String>((key, value) {
      return MapEntry(key, value.toString());
    });
  }

  String? translate(String key) => _localizedString![key];
}