import 'package:contador_presenca/app/shared/ui/app_ui.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? label;
  final double? width;
  final double? height;
  final Icon? icone;
  final Color? colorPress;
  final Color? color;
  const AppButton({
    Key? key,
    this.label,
    this.onPressed,
    this.width,
    this.height,
    this.icone,
    this.colorPress,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
      color: color ?? AppUi.corSecundaria,
      child: InkWell(
        highlightColor: colorPress,
        hoverColor: colorPress,
        focusColor: colorPress,
        splashColor: colorPress,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),

        onTap: onPressed, // Handle your onTap
        child: Ink(
          height: height,
          width: width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icone != null) icone!,
              Visibility(
                visible: icone != null,
                child: const SizedBox(
                  width: 8,
                ),
              ),
              if (label != null)
                Text(
                  label!,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
