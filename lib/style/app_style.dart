


import 'package:flutter/material.dart';

import 'app_size.dart';

lightTextStyle({required fontSize,required color,height}) {
  return TextStyle(fontSize: fontSize, color: color,fontWeight: FontWeight.w400, fontFamily: "Satoshi");
}

regularTextStyle({required fontSize,required color,height}) {
  return TextStyle(fontSize: fontSize, color: color,fontWeight: FontWeight.w500,height: height, fontFamily: "Satoshi");
}

mediumTextStyle({required fontSize,required color,height}) {
  return TextStyle(fontSize: fontSize, color: color,fontWeight: FontWeight.w600, fontFamily: "Satoshi");
}

boldTextStyle({required fontSize,required color,height}) {
  return TextStyle(fontSize: fontSize, color: color,fontWeight: FontWeight.w700, fontFamily: "Satoshi");
}

appBarTextStyle({fontSize,required color}) {
  return TextStyle(fontSize: fontSize??dimen20, color: color,fontWeight: FontWeight.w700, fontFamily: "Satoshi");
}

