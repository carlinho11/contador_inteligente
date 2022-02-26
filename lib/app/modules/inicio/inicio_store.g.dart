// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inicio_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$InicioStore on _InicioStoreBase, Store {
  final _$exibirLeituraAtom = Atom(name: '_InicioStoreBase.exibirLeitura');

  @override
  bool get exibirLeitura {
    _$exibirLeituraAtom.reportRead();
    return super.exibirLeitura;
  }

  @override
  set exibirLeitura(bool value) {
    _$exibirLeituraAtom.reportWrite(value, super.exibirLeitura, () {
      super.exibirLeitura = value;
    });
  }

  final _$statusAtom = Atom(name: '_InicioStoreBase.status');

  @override
  bool get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(bool value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  @override
  String toString() {
    return '''
exibirLeitura: ${exibirLeitura},
status: ${status}
    ''';
  }
}
