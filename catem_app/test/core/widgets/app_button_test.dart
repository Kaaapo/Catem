import 'package:catem_app/core/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/pump_app.dart';

void main() {
  testWidgets('muestra el texto y ejecuta el callback al tocar', (tester) async {
    var taps = 0;
    await tester.pumpApp(AppButton(label: 'Continuar', onPressed: () => taps++));

    expect(find.text('Continuar'), findsOneWidget);
    await tester.tap(find.byType(FilledButton));

    expect(taps, 1);
  });

  testWidgets('en loading muestra el spinner y no responde al tap', (tester) async {
    var taps = 0;
    await tester.pumpApp(
      AppButton(label: 'Continuar', onPressed: () => taps++, isLoading: true),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Continuar'), findsNothing);
    await tester.tap(find.byType(FilledButton), warnIfMissed: false);

    expect(taps, 0);
  });

  testWidgets('sin onPressed queda deshabilitado', (tester) async {
    await tester.pumpApp(const AppButton(label: 'Continuar', onPressed: null));

    final button = tester.widget<FilledButton>(find.byType(FilledButton));
    expect(button.enabled, isFalse);
  });

  testWidgets('la variante secundaria usa OutlinedButton con icono', (tester) async {
    await tester.pumpApp(
      AppButton(
        label: 'Google',
        onPressed: () {},
        variant: AppButtonVariant.secondary,
        icon: Icons.login,
      ),
    );

    expect(find.byType(OutlinedButton), findsOneWidget);
    expect(find.byIcon(Icons.login), findsOneWidget);
  });
}
