import 'package:calculator/model/calculator_model.dart';
import 'package:test/test.dart';
import 'package:decimal/decimal.dart';

void main() {
  CalculatorModel calculatorModel = CalculatorModel();

  test('addition', () {
    calculatorModel.setInput('3+5');
    calculatorModel.calculate();
    expect(calculatorModel.getOutput(), Decimal.parse('8').toString());
  });

  test('subtraction', () {
    calculatorModel.setInput('11-0.1');
    calculatorModel.calculate();
    expect(calculatorModel.getOutput(), Decimal.parse('10.9').toString());
    calculatorModel.setInput('9328-188927');
    calculatorModel.calculate();
    expect(calculatorModel.getOutput(), Decimal.parse('-179599').toString());
    calculatorModel.setInput('12-5');
    calculatorModel.calculate();
    expect(calculatorModel.getOutput(), Decimal.parse('7').toString());
  });

  test('multiplication', () {
    calculatorModel.setInput('3*40');
    calculatorModel.calculate();
    expect(calculatorModel.getOutput(), Decimal.parse('120').toString());
    calculatorModel.setInput('56.2*6');
    calculatorModel.calculate();
    expect(calculatorModel.getOutput(), Decimal.parse('337.2').toString());
    calculatorModel.setInput('12*12');
    calculatorModel.calculate();
    expect(calculatorModel.getOutput(), Decimal.parse('144').toString());
  });

  test('division', () {
    calculatorModel.setInput('12/3');
    calculatorModel.calculate();
    expect(calculatorModel.getOutput(), Decimal.parse('4').toString());
    calculatorModel.setInput('0.654/0.123');
    calculatorModel.calculate();
    expect(calculatorModel.getOutput(), Decimal.parse('5.31707317').toString());
  });

  test('mixed operations', () {
    calculatorModel.setInput('4+3*2-6/2');
    calculatorModel.calculate();
    expect(calculatorModel.getOutput(), Decimal.parse('7').toString());
  });

  test('more complex input', () {
    calculatorModel.setInput('2+3*4-6/3*2');
    calculatorModel.calculate();
    expect(calculatorModel.getOutput(), Decimal.parse('10').toString());
    calculatorModel.setInput('8-2*2');
    calculatorModel.calculate();
    expect(calculatorModel.getOutput(), Decimal.parse('4').toString());
  });

  // Tests for decimal numbers
  test('decimal addition', () {
    calculatorModel.setInput('0.5+0.25');
    calculatorModel.calculate();
    expect(calculatorModel.getOutput(), Decimal.parse('0.75').toString());
    calculatorModel.setInput('0.5921874+0.282883');
    calculatorModel.calculate();
    expect(calculatorModel.getOutput(), Decimal.parse('0.8750704').toString());
  });

  test('decimal subtraction', () {
    calculatorModel.setInput('1.5-0.5');
    calculatorModel.calculate();
    expect(calculatorModel.getOutput(), Decimal.parse('1.0').toString());
  });

  test('decimal multiplication', () {
    calculatorModel.setInput('2.5*0.4');
    calculatorModel.calculate();
    expect(calculatorModel.getOutput(), Decimal.parse('1.0').toString());
  });

  test('decimal division', () {
    calculatorModel.setInput('1.5/0.5');
    calculatorModel.calculate();
    expect(calculatorModel.getOutput(), Decimal.parse('3.0').toString());
  });

  test('mixed operations with decimals', () {
    calculatorModel.setInput('1.5+2.5*0.5-0.5/0.25');
    calculatorModel.calculate();
    expect(calculatorModel.getOutput(), Decimal.parse('0.75').toString());
  });
}
