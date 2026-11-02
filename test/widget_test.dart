import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quanly/main.dart';

void main() {
  testWidgets('App loads Quản lý công việc title', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MyApp(),
      ),
    );

    expect(find.text('Quản lý công việc'), findsOneWidget);
  });
}
