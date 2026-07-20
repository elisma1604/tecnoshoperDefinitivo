import 'package:flutter/material.dart';
import 'package:flutter_ces/pages/helpers/demo_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

class CartRobot {
  final PatrolIntegrationTester $;

  CartRobot(this.$);

  Future<void> abrirPrimerProducto() async {
    final productoCard = $(const ValueKey('producto_card_1'));
    await productoCard.waitUntilVisible();
    await productoCard.tap();
  }

  Future<void> agregarAlCarrito() async {
    await $(const ValueKey('add_to_cart_button')).tap();
    await $(find.text('Producto agregado correctamente')).waitUntilVisible();
  }

  Future<void> volverAlCatalogo() async {
    await $(find.byIcon(Icons.arrow_back_ios)).tap();
    await $.pumpAndSettle();

    try {
      await $(const ValueKey('bottom_cart_button')).waitUntilVisible();
    } catch (_) {
      await $(find.byIcon(Icons.shopping_cart_outlined)).waitUntilVisible();
    }
  }

  Future<void> abrirCarrito() async {
    await volverAlCatalogo();

    try {
      await $(const ValueKey('bottom_cart_button')).tap();
    } catch (_) {
      await $(find.byIcon(Icons.shopping_cart_outlined)).tap();
    }
  }

  Future<void> verificarProductoEnCarrito() async {
    try {
      await $(const ValueKey('cart_total_text')).waitUntilVisible();
    } catch (_) {
      await $(find.textContaining('Total:')).waitUntilVisible();
    }

    try {
      await $(const ValueKey('cart_finalize_button')).waitUntilVisible();
    } catch (_) {
      await $(find.text('Finalizar Compra')).waitUntilVisible();
    }
  }

  Future<void> finalizarCompraDesdeCarrito() async {
    try {
      await $(const ValueKey('cart_finalize_button')).tap();
    } catch (_) {
      await $(find.text('Finalizar Compra')).tap();
    }
  }

  Future<void> continuarDesdeResumen() async {
    await $(find.text('Siguiente')).waitUntilVisible();
    await $(find.text('Siguiente')).tap();
    await $.pumpAndSettle();
    await $(ValueKey(FormKeys.email)).waitUntilVisible();
  }

  Future<void> completarInformacionEntrega() async {
    await $(ValueKey(FormKeys.email)).waitUntilVisible();
    await $(ValueKey(FormKeys.email)).enterText('checkout@test.com');
    await $(ValueKey(FormKeys.firstName)).enterText('Test');
    await $(ValueKey(FormKeys.lastName)).enterText('Usuario');
    await $(ValueKey(FormKeys.address)).enterText('Av. Siempre Viva 123');
    await $(ValueKey(FormKeys.city)).enterText('Montevideo');
    await $(ValueKey(FormKeys.postal)).enterText('11200');
    await $.pumpAndSettle();
  }

  Future<void> continuarDesdeInformacion() async {
    final continuarAlPagoText = find.text('Continuar al pago');
    final scrollable = find.byType(Scrollable).first;

    debugPrint('[CartRobot] Scroll hasta Continuar al pago');
    await $.tester.dragUntilVisible(
      continuarAlPagoText,
      scrollable,
      const Offset(0, -300),
      maxIteration: 8,
    );
    await $.pumpAndSettle();
    debugPrint('[CartRobot] Tap en Continuar al pago');
    await $(continuarAlPagoText).tap();

    await $.pumpAndSettle();
    await $(ValueKey(FormKeys.ccNumber)).waitUntilVisible();
  }

  Future<void> completarPago() async {
    await $(ValueKey(FormKeys.ccNumber)).waitUntilVisible();
    await $(ValueKey(FormKeys.ccNumber)).enterText('41');
    await $.pumpAndSettle();
    await $(ValueKey(FormKeys.ccNumber)).enterText('4111222233334440');
    await $(ValueKey(FormKeys.ccName)).enterText('Test Usuario');
    await $(ValueKey(FormKeys.ccExpDate)).enterText('12');
    await $.pumpAndSettle();
    await $(ValueKey(FormKeys.ccExpDate)).enterText('12/30');
    await $(ValueKey(FormKeys.ccCode)).enterText('12');
    await $.pumpAndSettle();
    await $(ValueKey(FormKeys.ccCode)).enterText('123');
  }

  Future<void> confirmarCompra() async {
    final comprarText = find.text('Comprar').first;
    final scrollable = find.byType(Scrollable).first;

    try {
      debugPrint('[CartRobot] Tap directo en Comprar');
      await $(comprarText).tap();
    } catch (_) {
      debugPrint('[CartRobot] Comprar no hittable, aplicando scroll');
      await $.tester.dragUntilVisible(
        comprarText,
        scrollable,
        const Offset(0, -300),
        maxIteration: 8,
      );
      await $.pumpAndSettle();
      debugPrint('[CartRobot] Reintento tap en Comprar');
      await $(comprarText).tap();
    }
  }

  Future<void> verificarPedidoExitoso() async {
    await $(find.text('¡Tu pedido ha sido procesado con éxito!')).waitUntilVisible();
  }

  Future<void> cancelarCarrito() async {
    try {
      await $(const ValueKey('cart_delete_button')).tap();
    } catch (_) {
      await $(find.byIcon(Icons.delete).first).tap();
    }
  }

  Future<void> verificarCarritoVacio() async {
    await $(find.text('Total: \$0.0')).waitUntilVisible();
  }
}