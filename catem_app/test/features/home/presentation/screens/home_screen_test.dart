import 'package:catem_app/features/home/presentation/screens/home_screen.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/pump_app.dart';

void main() {
  testWidgets('HomeScreen muestra el nombre de la app', (tester) async {
    await tester.pumpApp(const HomeScreen());

    expect(find.text('Catem'), findsOneWidget);
  });
}
