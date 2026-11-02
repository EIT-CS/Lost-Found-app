import 'package:flutter_test/flutter_test.dart';

import 'package:biydaalt/main.dart';

void main() {
  testWidgets('welcome page is shown on app start', (tester) async {
    await tester.pumpWidget(const LostFoundApp());

    expect(find.text('Lost & Found'), findsOneWidget);
    expect(find.text('Эхлэх'), findsOneWidget);
  });
}
