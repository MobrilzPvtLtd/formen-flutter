// ignore_for_file: file_names, constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';


class Strings {
  static const String appName = 'Payment Card Demo';
  static const String fieldReq = 'This field is required';
  static const String numberIsInvalid = 'Card is invalid';
  static const String pay = 'Validate';
}

class PaymentCardCreated {
  CardTypee? type;
  String? number;
  String? name;
  String? amount;
  String? email;
  int? month;
  int? year;
  int? cvv;

  PaymentCardCreated(
      {this.type,
        this.number,
        this.name,
        this.amount,
        this.month,
        this.year,
        this.cvv,
        this.email});

  @override
  String toString() {
    return '[Type: $type, Number: $number, Name: $name, Month: $month, Year: $year, CVV: $cvv, Email: $email, Amount: $amount]';
  }
}

enum CardTypee {
  Master,
  Visa,
  Verve,
  Discover,
  AmericanExpress,
  DinersClub,
  Jcb,
  Others,
  Invalid
}

class CardUtils {
  static String? validateCVV(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.fieldReq;
    }

    if (value.length < 3 || value.length > 4) {
      return "CVV is invalid";
    }
    return null;
  }

  static String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.fieldReq;
    }

    int year;
    int month;
    // The value contains a forward slash if the month and year has been
    // entered.
    if (value.contains(RegExp(r'(/)'))) {
      var split = value.split(RegExp(r'(/)'));
      // The value before the slash is the month while the value to right of
      // it is the year.
      month = int.parse(split[0]);
      year = int.parse(split[1]);
    } else {
      // Only the month was entered
      month = int.parse(value.substring(0, (value.length)));
      year = -1; // Lets use an invalid year intentionally
    }

    if ((month < 1) || (month > 12)) {
      // A valid month is between 1 (January) and 12 (December)
      return 'Expiry month is invalid';
    }

    var fourDigitsYear = convertYearTo4Digits(year);
    if ((fourDigitsYear < 1) || (fourDigitsYear > 2099)) {
      // We are assuming a valid should be between 1 and 2099.
      // Note that, it's valid doesn't mean that it has not expired.
      return 'Expiry year is invalid';
    }

    if (!hasDateExpired(month, year)) {
      return "Card has expired";
    }
    return null;
  }

  /// Convert the two-digit year to four-digit year if necessary
  static int convertYearTo4Digits(int year) {
    if (year < 100 && year >= 0) {
      var now = DateTime.now();
      String currentYear = now.year.toString();
      String prefix = currentYear.substring(0, currentYear.length - 2);
      year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
    }
    return year;
  }

  static bool hasDateExpired(int month, int year) {
    return isNotExpired(year, month);
  }

  static bool isNotExpired(int year, int month) {
    // It has not expired if both the year and date has not passed
    return !hasYearPassed(year) && !hasMonthPassed(year, month);
  }

  static List<int> getExpiryDate(String value) {
    var split = value.split(RegExp(r'(/)'));
    return [int.parse(split[0]), int.parse(split[1])];
  }

  static bool hasMonthPassed(int year, int month) {
    var now = DateTime.now();
    // The month has passed if:
    // 1. The year is in the past. In that case, we just assume that the month
    // has passed
    // 2. Card's month (plus another month) is more than current month.
    return hasYearPassed(year) ||
        convertYearTo4Digits(year) == now.year && (month < now.month + 1);
  }

  static bool hasYearPassed(int year) {
    int fourDigitsYear = convertYearTo4Digits(year);
    var now = DateTime.now();
    // The year has passed if the year we are currently is more than card's
    // year
    return fourDigitsYear < now.year;
  }

  static String getCleanedNumber(String text) {
    RegExp regExp = RegExp(r"[^0-9]");
    return text.replaceAll(regExp, '');
  }

  static Widget? getCardIcon(CardTypee? cardType) {
    String img = "";
    Icon? icon;
    switch (cardType) {
      case CardTypee.Master:
        img = 'mastercard.png';
        break;
      case CardTypee.Visa:
        img = 'visa.png';
        break;
      case CardTypee.Verve:
        img = 'verve.png';
        break;
      case CardTypee.AmericanExpress:
        img = 'american_express.png';
        break;
      case CardTypee.Discover:
        img = 'discover.png';
        break;
      case CardTypee.DinersClub:
        img = 'dinners_club.png';
        break;
      case CardTypee.Jcb:
        img = 'jcb.png';
        break;
      case CardTypee.Others:
        icon = Icon(
          Icons.warning,
          size: 20.0,
          color: Color(0xff7D2AFF),
        );
        break;
      default:
        icon = Icon(
          Icons.warning,
          size: 20.0,
          color: Color(0xff7D2AFF),
        );
        break;
    }
    Widget? widget;
    if (img.isNotEmpty) {
      widget = Icon(
        Icons.warning,
        size: 20.0,
        color: Color(0xff7D2AFF),
      );
    } else {
      widget = icon;
    }
    return widget;
  }

  /// With the card number with Luhn Algorithm
  /// https://en.wikipedia.org/wiki/Luhn_algorithm
  static String? validateCardNum(String? input) {
    if (input == null || input.isEmpty) {
      return Strings.fieldReq;
    }

    input = getCleanedNumber(input);

    if (input.length < 8) {
      return Strings.numberIsInvalid;
    }

    int sum = 0;
    int length = input.length;
    for (var i = 0; i < length; i++) {
      // get digits in reverse order
      int digit = int.parse(input[length - i - 1]);

      // every 2nd number multiply with 2
      if (i % 2 == 1) {
        digit *= 2;
      }
      sum += digit > 9 ? (digit - 9) : digit;
    }

    if (sum % 10 == 0) {
      return null;
    }

    return Strings.numberIsInvalid;
  }

  static CardTypee getCardTypeFrmNumber(String input) {
    CardTypee cardType;
    if (input.startsWith(RegExp(
        r'((5[1-5])|(222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720))'))) {
      cardType = CardTypee.Master;
    } else if (input.startsWith(RegExp(r'4'))) {
      cardType = CardTypee.Visa;
    } else if (input.startsWith(RegExp(r'((506([01]))|(507([89]))|(6500))'))) {
      cardType = CardTypee.Verve;
    } else if (input.startsWith(RegExp(r'((34)|(37))'))) {
      cardType = CardTypee.AmericanExpress;
    } else if (input.startsWith(RegExp(r'((6[45])|(6011))'))) {
      cardType = CardTypee.Discover;
    } else if (input.startsWith(RegExp(r'((30[0-5])|(3[89])|(36)|(3095))'))) {
      cardType = CardTypee.DinersClub;
    } else if (input.startsWith(RegExp(r'(352[89]|35[3-8][0-9])'))) {
      cardType = CardTypee.Jcb;
    } else if (input.length <= 8) {
      cardType = CardTypee.Others;
    } else {
      cardType = CardTypee.Invalid;
    }
    return cardType;
  }
}
