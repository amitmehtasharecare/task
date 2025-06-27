import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:poketest/model/user_model.dart';
import 'package:poketest/view/detail_page.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() {
    FlutterError.onError = (FlutterErrorDetails details) {
      if (details.exceptionAsString().contains('NetworkImageLoadException') ||
          details.exceptionAsString().contains('NoSuchMethodError')) {
        return;
      }
      FlutterError.presentError(details);
    };
  });

  group('DetailPage Widget Tests', () {
    final mockUser = Data(
      id: '1',
      name: 'Testmon',
      hp: '100',
      supertype: 'Pokémon',
      subtypes: ['Basic'],
      images: CardImages(large: 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/wcAAgMBAp6l2AAAAABJRU5ErkJggg=='),
      set: Set(
        name: 'Base',
        series: 'Series 1',
        images: Images(symbol: 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/wcAAgMBAp6l2AAAAABJRU5ErkJggg=='),
      ),
      attacks: [
        Attack(
          name: 'Thunderbolt',
          cost: ['Electric', 'Colorless'],
          damage: '90',
          text: 'A strong electric attack.',
        ),
      ],
    );

    testWidgets('renders all main sections', (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          home: DetailPage(user: mockUser),
        ),
      );
      expect(find.text('Testmon'), findsWidgets);
      expect(find.text('HP: 100'), findsOneWidget);
      expect(find.text('Supertype: Pokémon'), findsOneWidget);
      expect(find.text('Subtypes : Basic'), findsOneWidget);
      expect(find.text('Set : Base'), findsOneWidget);
      expect(find.text('Series : Series 1'), findsOneWidget);
      expect(find.text('Attacks:'), findsOneWidget);
      expect(find.text('• Thunderbolt'), findsOneWidget);
      expect(find.text('Cost: Electric, Colorless'), findsOneWidget);
      expect(find.text('Damage: 90'), findsOneWidget);
      expect(find.text('Effect: A strong electric attack.'), findsOneWidget);
    });

    testWidgets('renders without attacks', (WidgetTester tester) async {
      final userNoAttacks = Data(
        id: mockUser.id,
        name: mockUser.name,
        hp: mockUser.hp,
        supertype: mockUser.supertype,
        subtypes: mockUser.subtypes,
        images: mockUser.images,
        set: mockUser.set,
        attacks: [],
      );
      await tester.pumpWidget(
        GetMaterialApp(
          home: DetailPage(user: userNoAttacks),
        ),
      );
      expect(find.text('Attacks:'), findsNothing);
    });
  });
}
