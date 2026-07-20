import 'package:flutter_ces/main.dart';
import 'package:patrol/patrol.dart';

import '../robot/login_robot.dart';
import '../robot/signup_robot.dart';

void main() {
  patrolTest(
    'registrarse en el sistema con datos válidos',
    ($) async {
      await $.pumpWidgetAndSettle(const MyApp());

      final loginRobot = LoginRobot($);
      final signupRobot = SignupRobot($);

      await loginRobot.abrirRegistro();
      await signupRobot.ingresarEmail('registro_${DateTime.now().microsecondsSinceEpoch}@tecnoshopper.com');
      await signupRobot.ingresarPassword('pass123');
      await signupRobot.registrar();
      await signupRobot.verificarRegistroExitoso();
    },
  );

  patrolTest(
    'registrarse en el sistema con datos inválidos',
    ($) async {
      await $.pumpWidgetAndSettle(const MyApp());

      final loginRobot = LoginRobot($);
      final signupRobot = SignupRobot($);

      await loginRobot.abrirRegistro();
      await signupRobot.ingresarEmail('test@tecnoshopper.com');
      await signupRobot.ingresarPassword('pass123');
      await signupRobot.registrar();
      await signupRobot.verificarEmailDuplicado();
    },
  );

  patrolTest(
    'iniciar sesión con datos válidos',
    ($) async {
      await $.pumpWidgetAndSettle(const MyApp());

      final loginRobot = LoginRobot($);
      await loginRobot.ingresarEmail('test@tecnoshopper.com');
      await loginRobot.ingresarPassword('password123');
      await loginRobot.presionarBotonLogin();
      await loginRobot.verificarInicioDeSesionExitoso();
    },
  );

  patrolTest(
    'iniciar sesión con datos inválidos',
    ($) async {
      await $.pumpWidgetAndSettle(const MyApp());

      final loginRobot = LoginRobot($);
      await loginRobot.ingresarEmail('incorrecto@test.com');
      await loginRobot.ingresarPassword('claveincorrecta');
      await loginRobot.presionarBotonLogin();
      await loginRobot.verificarMensajeDeError('Error de inicio de sesión');
    },
  );
}