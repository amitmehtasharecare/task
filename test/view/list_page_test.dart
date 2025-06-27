import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:poketest/controller/list_controller.dart';
import 'package:poketest/model/user_model.dart';
import 'package:poketest/view/list_page.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() {
    // Prevent network image errors in tests
    FlutterError.onError = (FlutterErrorDetails details) {
      if (details.exceptionAsString().contains('NetworkImageLoadException') ||
          details.exceptionAsString().contains('NoSuchMethodError')) {
        // Ignore network image and HttpClient errors
        return;
      }
      FlutterError.presentError(details);
    };
  });

  group('ListPage Widget Tests', () {
    setUp(() {
      Get.reset();
      final controller = Get.put(ListController());
      controller.userList = [
        Data(
          id: '1',
          name: 'Test User',
          images: CardImages(large: 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/wcAAgMBAp6l2AAAAABJRU5ErkJggg=='),
        ),
      ];
      // Use setTestState() to set state for obx
      controller.setTestState(controller.userList);
    });

    testWidgets('renders search TextField and GridView', (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          home: ListPage(),
        ),
      );

      // Check for search TextField
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
      // Check for GridView
      expect(find.byType(GridView), findsOneWidget);
    });

    testWidgets('TextField input triggers controller.setText', (WidgetTester tester) async {
      final controller = Get.find<ListController>();
      await tester.pumpWidget(
        GetMaterialApp(
          home: ListPage(),
        ),
      );
      final textField = find.byType(TextField);
      await tester.enterText(textField, 'abc');
      await tester.pump();
      expect(controller.text.value, 'abc');
      await tester.enterText(textField, 'ab');
      await tester.pump();
      expect(controller.text.value, '');
    });
  });
}
