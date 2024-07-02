import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

final poppinsRegular = GoogleFonts.poppins(
  fontWeight: FontWeight.w400,
);

final poppinsMedium = GoogleFonts.poppins(
  fontWeight: FontWeight.w500,
);

final poppinsBold = GoogleFonts.poppins(
  fontWeight: FontWeight.w700,
);

final poppinsBlack = GoogleFonts.poppins(
  fontWeight: FontWeight.w900,
);

//card boxShadow
List<BoxShadow>? cardShadow = Get.isDarkMode
    ? null
    : [
        BoxShadow(
          offset: const Offset(0, 1),
          blurRadius: 2,
          color: Colors.black.withOpacity(0.15),
        )
      ];
