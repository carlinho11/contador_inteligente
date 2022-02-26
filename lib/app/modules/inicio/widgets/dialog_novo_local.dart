import 'package:contador_presenca/app/modules/inicio/inicio_store.dart';
import 'package:contador_presenca/app/shared/ui/app_ui.dart';
import 'package:contador_presenca/app/shared/ui/widgets/app_button.dart';
import 'package:contador_presenca/app/shared/ui/widgets/app_button_Outlined.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

showDialogNovoLocal(BuildContext context) {
  final InicioStore store = Modular.get();

  var size = MediaQuery.of(context).size;

  TextEditingController descricaoController = TextEditingController();
  TextEditingController limiteController = TextEditingController();

  limiteController.text = '50';

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
                "Novo Local",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppUi.corPrincipal,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 2,
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  border: Border.all(width: 1, color: const Color(0xffeeeeee)),
                ),
                child: TextField(
                  controller: descricaoController,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppUi.corPrincipal,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Descrição',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: AppUi.corPrincipal.withOpacity(0.5),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    contentPadding: const EdgeInsets.only(
                        left: 10, top: 0, bottom: 0, right: 0),
                  ),
                  textAlignVertical: TextAlignVertical.center,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 2,
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  border: Border.all(width: 1, color: const Color(0xffeeeeee)),
                ),
                child: TextField(
                  controller: limiteController,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppUi.corPrincipal,
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: false,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  decoration: InputDecoration(
                    hintText: 'Limite',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: AppUi.corPrincipal.withOpacity(0.5),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    contentPadding: const EdgeInsets.only(
                        left: 10, top: 0, bottom: 0, right: 0),
                  ),
                  textAlignVertical: TextAlignVertical.center,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              AppButton(
                label: 'Salvar',
                width: size.width,
                height: 50,
                onPressed: () async {
                  store.novoLocal(
                      descricaoController.text, limiteController.text, context);
                },
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
