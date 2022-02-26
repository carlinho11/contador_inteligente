import 'package:contador_presenca/app/models/local_model.dart';

abstract class LocalRepository {
  Future<String> addLocal(LocalModel local);
  Future<String> updateContador({required String id, required int valor});
  Future<String> delete(String id);
  Future<String> updateLimite({required int limite, required String id});
  Future<String> cleanContador(String id);
  Stream getLocal(String id);
  Future<bool> initializeDefault();
}
