import 'package:flutter/material.dart';
import 'package:sunglasses/core/utils/app_constants.dart';
import 'package:sunglasses/models/language_model.dart';

class LanguageRepo {
  List<LanguageModel?> getAllLanguages({BuildContext? context}) {
    return AppConstants.languages;
  }
}
