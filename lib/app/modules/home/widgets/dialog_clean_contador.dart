import 'package:contador_presenca/app/modules/home/home_store.dart';
import 'package:contador_presenca/app/shared/ui/app_ui.dart';
import 'package:contador_presenca/app/shared/ui/widgets/app_button.dart';
import 'package:contador_presenca/app/shared/ui/widgets/app_button_outlined.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

showDialogCleanContador(BuildContext context) {
  final HomeStore store = Modular.get();

  var size = MediaQuery.of(context).size;

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        contentPadding:
            const EdgeInsets.only(top: 30, right: 20, left: 20, bottom: 20),
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const Text(
                "Você realmente deseja zerar o contador?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppUi.corPrincipal,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              AppButton(
                label: 'Confirmar',
                height: 45,
                width: size.width,
                onPressed: () => store.cleanContador(context),
              ),
              const SizedBox(
                height: 10,
              ),
              AppButtonOutlined(
                label: 'Cancelar',
                height: 45,
                width: size.width,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      );
    },
  );
}
