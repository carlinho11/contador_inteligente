import 'package:flutter/material.dart';
import 'dart:math';

class Circulo extends CustomPainter {
  final double largura;
  final List<double> valoresPorcentagem;
  final List<Color> cores;

  Circulo({
    required this.largura,
    required this.valoresPorcentagem,
    required this.cores,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2) - largura;
    double anguloInicial = -pi / 2;
    double angulo;

    for (int i = 0; i < valoresPorcentagem.length; i++) {
      Paint circulo = Paint()
        ..strokeWidth = largura
        ..color = cores[i]
        ..style = PaintingStyle.stroke;

      angulo = (pi * 2) * valoresPorcentagem[i];

      canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
          anguloInicial, angulo, false, circulo);
      anguloInicial += angulo;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
