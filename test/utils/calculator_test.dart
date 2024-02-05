import 'package:bmi/utils/calculator.dart';
import 'package:flutter_test/flutter_test.dart';
import "package:mocktail/mocktail.dart";
import 'package:dio/dio.dart';

class DioMock extends Mock implements Dio {}

void main() {
  test(
      'Given height and weight When calculateBMI function invoked then correct bmi is returned ...',
      () {
    // Arrange
    const int height = 176, weight = 73;

    // Act
    double bmi = calculateBMI(height, weight);

    //Assert    // check the result is as we intended
    expect(bmi, 23.56663223140496);
  });

  test('Given url When calculatingBMIAsycn invoked then correct bmi returned',
      () async {
    // Arrange
    final dioMock = DioMock();
    when(() => dioMock.get('https://www.jsonkeeper.com/b/0HDK')).thenAnswer(
      (_) => Future.value(
        Response(
            requestOptions:
                RequestOptions(path: 'https://www.jsonkeeper.com/b/0HDK'),
            data: {
              'Selhadin Abdu': [73, 177]
            }),
      ),
    );
    // Act
    var result = await calculateBMIAsync(dioMock);
    // Assert
    expect(result, 23.301094832264035);
  });
}
