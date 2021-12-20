import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'colors.dart';
import 'font_constants.dart';
import 'size_constant.dart';

extension TextStyleExtension on TextTheme {
  TextStyle text10Black() {
    return subtitle2!.copyWith(
      fontFamily: fontFamilyRegular,
      fontSize: k10Font,
    );
  }

  TextStyle text10Orange() {
    return subtitle2!.copyWith(
      fontFamily: fontFamilyRegular,
      fontSize: k10Font,
      color: AppColors.textColorOrange,
    );
  }

  TextStyle text12Black() {
    return subtitle2!.copyWith(
      fontSize: k12Font,
      fontFamily: fontFamilyBold,
    );
  }

  TextStyle text12BlackLight() {
    return subtitle2!.copyWith(
        fontSize: k12Font,
        fontFamily: fontFamilyBold,
        fontWeight: FontWeight.w300);
  }

  TextStyle text14Black() {
    return subtitle2!.copyWith(
      fontSize: k14Font,
      fontFamily: fontFamilyRegular,
    );
  }

  TextStyle text14BlackLight() {
    return subtitle2!.copyWith(
      fontSize: k14Font,
      fontFamily: fontFamilyRegular,
      fontWeight: FontWeight.w300,
    );
  }

  TextStyle text13Black() {
    return subtitle2!.copyWith(
      fontFamily: fontFamilyRegular,
      fontSize: k13Font,
    );
  }

  TextStyle text13Blue() {
    return subtitle2!.copyWith(
        fontFamily: fontFamilyRegular,
        fontSize: k13Font,
        color: AppColors.textColorBlue);
  }

  TextStyle text13Grey() {
    return subtitle2!.copyWith(
        fontSize: k13Font,
        fontFamily: fontFamilyRegular,
        color: AppColors.textColorGrey);
  }

  TextStyle text15MediumDark() {
    return subtitle2!.copyWith(
      fontSize: k15Font,
      fontFamily: fontFamilyMedium,
    );
  }

  TextStyle text15Grey() {
    return subtitle2!.copyWith(
        fontSize: k15Font,
        fontFamily: fontFamilyRegular,
        color: AppColors.textColorGrey);
  }

  TextStyle text15MediumGrey() {
    return text15Grey().copyWith(fontFamily: fontFamilyMedium);
  }

  TextStyle text16Grey() {
    return subtitle2!.copyWith(
        fontSize: k16Font,
        fontFamily: fontFamilyRegular,
        color: AppColors.textColorGrey);
  }

  TextStyle text16BoldGrey() {
    return subtitle2!.copyWith(
      fontSize: k16Font,
      color: AppColors.textColorGrey,
    );
  }

  TextStyle text15Black() {
    return subtitle2!.copyWith(
      fontFamily: fontFamilyRegular,
      fontSize: k15Font,
    );
  }

  TextStyle text15BlackLight() {
    return subtitle2!.copyWith(
      fontFamily: fontFamilyRegular,
      fontSize: k15Font,
      fontWeight: FontWeight.w300
    );
  }

  TextStyle text16Black() {
    return subtitle2!.copyWith(
      fontFamily: fontFamilyRegular,
      fontSize: k16Font,
    );
  }

  TextStyle text16BlackLight() {
    return subtitle2!.copyWith(
      fontFamily: fontFamilyRegular,
      fontSize: k16Font,
      fontWeight: FontWeight.w300,
    );
  }

  TextStyle text16MediumBlack() {
    return subtitle2!.copyWith(
      fontFamily: fontFamilyMedium,
      fontSize: k16Font,
    );
  }

  TextStyle text16MediumGrey() {
    return subtitle2!.copyWith(
      fontFamily: fontFamilyMedium,
      fontSize: k16Font,
      color: AppColors.textColorGrey,
    );
  }

  TextStyle text15BoldBlack() {
    return subtitle2!.copyWith(
      fontFamily: fontFamilyBold,
      fontSize: k15Font,
    );
  }

  TextStyle text16BoldBlack() {
    return subtitle2!.copyWith(
      fontFamily: fontFamilyBold,
      fontSize: k16Font,
    );
  }

  TextStyle text13Medium() {
    return subtitle2!.copyWith(
      fontFamily: fontFamilyMedium,
      fontSize: k13Font,
    );
  }

  TextStyle text13MediumWhite() {
    return subtitle2!.copyWith(
        fontFamily: fontFamilyMedium,
        fontSize: k13Font,
        color: AppColors.textColorWhite);
  }

  TextStyle text18Bold() {
    return subtitle2!.copyWith(
      fontFamily: fontFamilyBold,
      fontSize: k18Font,
    );
  }

  TextStyle text18Medium() {
    return subtitle2!.copyWith(
      fontFamily: fontFamilyMedium,
      fontSize: k18Font,
    );
  }

  TextStyle text18BlackLight() {
    return subtitle2!.copyWith(
      fontFamily: fontFamilyMedium,
      fontSize: k18Font,
      fontWeight: FontWeight.w300
    );
  }

  TextStyle text18MediumGrey() {
    return subtitle2!.copyWith(
      fontFamily: fontFamilyMedium,
      fontSize: k18Font,
      color: AppColors.textColorGrey,
    );
  }

  TextStyle text20Bold() {
    return subtitle2!.copyWith(
      fontFamily: fontFamilyBold,
      fontSize: k20Font,
    );
  }

  TextStyle text16White() {
    return subtitle2!.copyWith(
      fontFamily: fontFamilyRegular,
      fontSize: k16Font,
      color: AppColors.textColorWhite,
    );
  }

  TextStyle buttonText16White() {
    return button!.copyWith(
      fontSize: k16Font,
    );
  }

  TextStyle text17Medium() {
    return subtitle2!.copyWith(
      fontFamily: fontFamilyMedium,
      fontSize: k17Font,
    );
  }

  TextStyle text17Bold() {
    return subtitle2!.copyWith(
      fontFamily: fontFamilyBold,
      fontSize: k17Font,
    );
  }

  TextStyle text17Grey() {
    return subtitle2!.copyWith(
      color: AppColors.textColorGrey,
      fontFamily: fontFamilyRegular,
      fontSize: k17Font,
    );
  }

  TextStyle text17Black() {
    return subtitle2!.copyWith(
      fontFamily: fontFamilyRegular,
      fontSize: k17Font,
    );
  }

  TextStyle text34Black() {
    return headline4!.copyWith(
      fontSize: k32Font,
      fontFamily: fontFamilyRegular,
    );
  }

  TextStyle text34BoldBlack() {
    return headline4!.copyWith(
      fontSize: k34Font,
    );
  }

  TextStyle text24BoldWhite() {
    return headline6!.copyWith(
      fontSize: k24Font,
      color: AppColors.textColorWhite,
    );
  }

  TextStyle text24Black() {
    return headline6!.copyWith(
      fontSize: k24Font,
      fontFamily: fontFamilyRegular,
    );
  }

  TextStyle text24BoldBlack() {
    return headline6!.copyWith(
      fontSize: k24Font,
      fontFamily: fontFamilyBold,
    );
  }
}
