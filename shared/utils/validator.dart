import 'constants.dart';

class EmailValidator {
  static String? validateEmail(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return emptyEmailField;
      }
      // Regex for email validation
      RegExp regExp = new RegExp(emailRegex);
      if (regExp.hasMatch(value)) {
        return null;
      }
      return invalidEmailField;
    } else
      return null;
  }
}

class PhoneNumberValidator {
  static String? validatePhoneNumber(String? value) {
    // print(value);
    if (value != null) {
      if (value.isEmpty) {
        return emptyTextField;
      }
      if (value.length != 11) {
        return phoneNumberLengthError;
      }
      // Regex for phone number validation
      RegExp regExp = new RegExp(phoneNumberRegex);
      // print(regExp.hasMatch(value));
      if (regExp.hasMatch(value)) {
        return null;
      }
      return invalidPhoneNumberField;
    } else
      return null;
  }
}

class NumberValidator {
  static String? validateNumber(String value) {
    // print(value);
    if (value != null) {
      if (value.isEmpty) {
        return emptyTextField;
      }
      if (value.length != 10) {
        return numberLengthError;
      }
      // Regex for phone number validation
      RegExp regExp = new RegExp(numberRegex);
      // print(regExp.hasMatch(value));
      if (regExp.hasMatch(value)) {
        return null;
      }
      return invalidNumberField;
    } else
      return null;
  }
}

class PasswordValidator {
  static bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  static String? validatePassword(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return emptyPasswordField;
      }

      if (value.length < 6) {
        return passwordLengthError;
      }

      if (!validateStructure(value)) {
        return "Please enter valid password. (Min. 1 upper case \nMin. 1 lowercase \nMin. 1 Numeric Number \nMinimum 1 Special Character( ! @ # \$ & * ~ )";
      }
    } else
      return null;
    return null;
  }

  static String? validateLoginPassword(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return emptyPasswordField;
      }

      if (value.length < 8) {
        return passwordLengthError;
      }
    } else
      return null;
    return null;
  }
}

class UsernameValidator {
  static String? validateUsername(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return emptyUsernameField;
      }

      if (value.length < 6) {
        return usernameLengthError;
      }
    } else
      return null;

    return null;
  }
}

class FieldValidator {
  static String? validate(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return emptyTextField;
      }
    } else
      return null;

    return null;
  }
}
