import 'package:bmi/pages/bmi_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'Given weightInfoCard When user click + button Then weight increment by 1',
    (tester) async {
      //Arrange
      await tester.pumpWidget(
        const CupertinoApp(
          home: BMIPage(),
        ),
      );
      var weightIncrementButton = find.byKey(
        const Key('weight_plus'),
      );
      //Act
      await tester.tap(weightIncrementButton);
      await tester.pump();
      //Assert
      var text = find.text('76');
      expect(text, findsOneWidget);
    },
  );

  testWidgets(
    'Given weightInfoCard When user click - button Then weight decremented by 1',
    (tester) async {
      //Arrange
      await tester.pumpWidget(
        const CupertinoApp(
          home: BMIPage(),
        ),
      );
      var weightIncrementButton = find.byKey(
        const Key('weight_minus'),
      );
      //Act
      await tester.tap(weightIncrementButton);
      await tester.pump();
      //Assert
      var text = find.text('74');
      expect(text, findsOneWidget);
    },
  );
}
