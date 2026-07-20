import 'package:flutter_ces/main.dart';
import 'package:patrol/patrol.dart';

import '../../login/robot/login_robot.dart';
import '../robot/profile_robot.dart';

void main() {
  patrolTest(
    'configurar y guardar información personal',
    ($) async {
      await $.pumpWidgetAndSettle(const MyApp());

      final loginRobot = LoginRobot($);
      final profileRobot = ProfileRobot($);

      await loginRobot.loginConCredencialesValidas();

      await profileRobot.abrirCuenta();
      await profileRobot.completarNombre('Ana');
      await profileRobot.completarApellido('García');
      await profileRobot.completarTelefono('099123456');
      await profileRobot.completarFechaNacimiento('01/01/1995');
      await profileRobot.completarDireccion('Calle Falsa 123');
      await profileRobot.completarPais('Uruguay');
      await profileRobot.guardarPerfil();
      await profileRobot.verificarPerfilGuardado();
    },
  );

  patrolTest(
    'configurar información personal y validar campos vacíos',
    ($) async {
      await $.pumpWidgetAndSettle(const MyApp());

      final loginRobot = LoginRobot($);
      final profileRobot = ProfileRobot($);

      await loginRobot.loginConCredencialesValidas();
      await profileRobot.abrirCuenta();
      await profileRobot.completarNombre('');
      await profileRobot.completarApellido('');
      await profileRobot.completarDireccion('');
      await profileRobot.completarPais('');
      await profileRobot.guardarPerfil();
      await profileRobot.verificarCamposObligatorios();
    },
  );
}
