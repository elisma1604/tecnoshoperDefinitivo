import 'package:flutter_ces/main.dart';
import 'package:patrol/patrol.dart';

import '../../login/robot/login_robot.dart';
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
}
