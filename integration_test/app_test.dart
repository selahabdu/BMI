import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:bmi/main.dart' as app;

void main() {
  //ensure widget bindings are initiallized
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  //group is a systematic way of grouping different tests together
  group("end-to-end app test", () {
    //Arrange
    var weightIncrementButton = find.byKey(
      const Key('weight_plus'),
    );
    var ageIncrementButton = find.byKey(
      const Key('age_plus'),
    );
    // there is only one cupertino button on the page
    var calculateBMIButton = find.byType(CupertinoButton);

    testWidgets(
        'Given app run when height, age and calculateBMI button pressed correct ',
        (tester) async {
      //Arrange
      app.main();
      //Act
      await tester.pumpAndSettle();
      await tester.tap(weightIncrementButton);
      await tester.pumpAndSettle();
      await tester.tap(ageIncrementButton);
      await tester.pumpAndSettle();
      await tester.tap(calculateBMIButton);
      await tester.pumpAndSettle();
      final resultText = find.text('Normal');
      //Assert
      expect(resultText, findsOneWidget);
    });
  });
}
