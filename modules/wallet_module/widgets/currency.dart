
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

 currency(context) {
  Locale locale = Localizations.localeOf(context);

  var format = NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'NGN');
 return format;
}