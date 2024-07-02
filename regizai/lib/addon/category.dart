import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:path/path.dart';

Category(String result) {

  var convert = double.parse(result);

  if (convert.round() > 40) {
    return AwesomeSnackbarContent(
      title: 'This Result!!',
      message:'based on the results of your weight calculation Obesity Class III',

      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
      contentType: ContentType.failure,
      // to configure for material banner
      inMaterialBanner: true,
    );
  } else if (convert.round() > 35 && convert.round() < 39) {
    return AwesomeSnackbarContent(
      title: 'This Result!!',
      message:'based on the results of your weight calculation Obesity Class II',

      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
      contentType: ContentType.failure,
      // to configure for material banner
      inMaterialBanner: true,
    );
  } else if (convert.round() > 30 && convert.round() < 35) {
    return AwesomeSnackbarContent(
      title: 'This Result!!',
      message:'based on the results of your weight calculation Obesity Class I',

      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
      contentType: ContentType.failure,
      // to configure for material banner
      inMaterialBanner: true,
    );
  } else if (convert.round() >= 25 && convert.round() < 30) {
    return AwesomeSnackbarContent(
      title: 'This Result!!',
      message:'based on the results of your weight calculation Overweight',

      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
      contentType: ContentType.warning,
      // to configure for material banner
      inMaterialBanner: true,
    );
  } else if (convert.round() > 18 && convert.round() < 25) {
    return AwesomeSnackbarContent(
      title: 'This Result!!',
      message:'based on the results of your weight calculation Normalweight',

      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
      contentType: ContentType.success,
      // to configure for material banner
      inMaterialBanner: true,
    );
  } else {
    return AwesomeSnackbarContent(
      title: 'This Result!!',
      message:'based on the results of your weight calculation Underweight',

      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
      contentType: ContentType.failure,
      // to configure for material banner
      inMaterialBanner: true,
    );
  }

}