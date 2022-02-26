import 'package:flutter/material.dart';

class AppUi {
  AppUi._();

  static const Color corPrincipal = Color(0xFF234d70);
  static const Color corSecundaria = Color(0xffeba834);
  static const Color corFundo = Color(0xFFF2F2F2);
  static const Color corPreto = Color(0xFFF2F2F2);

  static const BoxShadow sombraPrincipal = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.1),
    blurRadius: 20,
    offset: Offset(0, 4),
  );
}
