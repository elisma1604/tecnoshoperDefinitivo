import 'package:flutter_ces/main.dart';
import 'package:patrol/patrol.dart';

import '../../login/robot/login_robot.dart';
import '../robot/cart_robot.dart';

void main() {
  patrolTest(
    'crear un carrito de compra y concretarlo',
    ($) async {
      await $.pumpWidgetAndSettle(const MyApp());

      final loginRobot = LoginRobot($);
      final cartRobot = CartRobot($);

      await loginRobot.loginConCredencialesValidas();
      await cartRobot.abrirPrimerProducto();
      await cartRobot.agregarAlCarrito();
      await cartRobot.abrirCarrito();
      await cartRobot.verificarProductoEnCarrito();

      await cartRobot.finalizarCompraDesdeCarrito();
      await cartRobot.continuarDesdeResumen();
      await cartRobot.completarInformacionEntrega();
      await cartRobot.continuarDesdeInformacion();
      await cartRobot.completarPago();
      await cartRobot.confirmarCompra();
      await cartRobot.verificarPedidoExitoso();
    },
  );

  patrolTest(
    'crear un carrito de compra y cancelarlo',
    ($) async {
      await $.pumpWidgetAndSettle(const MyApp());

      final loginRobot = LoginRobot($);
      final cartRobot = CartRobot($);

      await loginRobot.loginConCredencialesValidas();
      await cartRobot.abrirPrimerProducto();
      await cartRobot.agregarAlCarrito();
      await cartRobot.abrirCarrito();
      await cartRobot.cancelarCarrito();
      await cartRobot.verificarCarritoVacio();
    },
  );
}
