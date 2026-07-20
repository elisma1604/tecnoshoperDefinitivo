import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

class SignupRobot {
  final PatrolIntegrationTester $;

  SignupRobot(this.$);

  Future<void> abrirRegistro() async {
    await $(find.text('¿Necesitás registrarte?')).tap();
  }

  Future<void> ingresarEmail(String email) async {
    await $(const ValueKey('signup_email_field')).enterText(email);
  }

  Future<void> ingresarPassword(String password) async {
    await $(const ValueKey('signup_password_field')).enterText(password);
  }

  Future<void> registrar() async {
    await $(const ValueKey('signup_submit_button')).tap();
  }

  Future<void> verificarRegistroExitoso() async {
    await $(find.text('Registro exitoso')).waitUntilVisible();
    await $(find.text('OK')).tap();
  }

  Future<void> verificarEmailDuplicado() async {
    await $(find.text('Error de registro')).waitUntilVisible();
    await $(find.text('OK')).tap();
  }

  Future<void> verificarEmailInvalido() async {
    await $(find.text('Ingresa un email válido')).waitUntilVisible();
  }
}
