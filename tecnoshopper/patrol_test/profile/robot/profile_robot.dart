import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

class ProfileRobot {
  final PatrolIntegrationTester $;

  ProfileRobot(this.$);

  Future<void> abrirCuenta() async {
    await $(find.byIcon(Icons.account_circle_outlined)).tap();
  }

  Future<void> completarNombre(String value) async {
    await $(const ValueKey('account_name_field')).enterText(value);
  }

  Future<void> completarApellido(String value) async {
    await $(const ValueKey('account_lastname_field')).enterText(value);
  }

  Future<void> completarTelefono(String value) async {
    await $(const ValueKey('account_phone_field')).enterText(value);
  }

  Future<void> completarFechaNacimiento(String value) async {
    await $(const ValueKey('account_birthdate_field')).enterText(value);
  }

  Future<void> completarDireccion(String value) async {
    await $(const ValueKey('account_address_field')).enterText(value);
  }

  Future<void> completarPais(String value) async {
    await $(const ValueKey('account_country_field')).enterText(value);
  }

  Future<void> guardarPerfil() async {
    await $(const ValueKey('account_save_button')).tap();
  }

  Future<void> verificarPerfilGuardado() async {
    await $(find.text('Perfil actualizado correctamente')).waitUntilVisible();
  }

  Future<void> verificarCamposObligatorios() async {
    await $(find.text('Completa los campos obligatorios')).waitUntilVisible();
  }
}