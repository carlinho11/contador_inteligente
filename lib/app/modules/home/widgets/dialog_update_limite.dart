import 'package:contador_presenca/app/modules/home/home_store.dart';
import 'package:contador_presenca/app/shared/ui/widgets/app_button.dart';
import 'package:contador_presenca/app/shared/ui/widgets/app_button_Outlined.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

showDialogUpdateLimite(BuildContext context) {
  final HomeStore store = Modular.get();

  var size = MediaQuery.of(context).size;

  TextEditingController limiteController = TextEditingController();

  limiteController.text = store.limite.toString();

  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        contentPadding:
            const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 20),
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const Text(
                "Limite de Pessoas",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF234d70),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF234d70),
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                  signed: false,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                maxLength: 10,
                controller: limiteController,
                decoration: null,
              ),
              const SizedBox(
                height: 15,
              ),
              AppButton(
                label: 'Alterar',
                height: 45,
                width: size.width,
                onPressed: () => store.updateLimite(
                    limite: limiteController.text, context: context),
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
