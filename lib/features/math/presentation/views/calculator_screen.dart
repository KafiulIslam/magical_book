import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _display = '0';
  double _firstNumber = 0;
  String _operation = '';
  bool _shouldResetDisplay = false;

  void _onNumberPressed(String number) {
    setState(() {
      if (_shouldResetDisplay) {
        _display = number;
        _shouldResetDisplay = false;
      } else {
        _display = _display == '0' ? number : _display + number;
      }
    });
  }

  void _onOperationPressed(String operation) {
    setState(() {
      if (_operation.isNotEmpty && !_shouldResetDisplay) {
        _calculate();
      } else {
        _firstNumber = double.parse(_display);
      }
      _operation = operation;
      _shouldResetDisplay = true;
    });
  }

  void _calculate() {
    final secondNumber = double.parse(_display);
    double result = 0;

    switch (_operation) {
      case '+':
        result = _firstNumber + secondNumber;
        break;
      case '-':
        result = _firstNumber - secondNumber;
        break;
      case '×':
        result = _firstNumber * secondNumber;
        break;
      case '÷':
        if (secondNumber != 0) {
          result = _firstNumber / secondNumber;
        } else {
          _display = 'Error';
          _operation = '';
          _shouldResetDisplay = true;
          return;
        }
        break;
    }

    setState(() {
      _display = result % 1 == 0
          ? result.toInt().toString()
          : result.toStringAsFixed(2);
      _firstNumber = result;
      _operation = '';
      _shouldResetDisplay = true;
    });
  }

  void _onEqualsPressed() {
    if (_operation.isNotEmpty) {
      _calculate();
    }
  }

  void _onClearPressed() {
    setState(() {
      _display = '0';
      _firstNumber = 0;
      _operation = '';
      _shouldResetDisplay = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ক্যালকুলেটর',
          style: BanglaTypo.headline1.copyWith(fontSize: 24.sp),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Display Area
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(24),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 20,
                    offset: Offset(0, 8),
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (_operation.isNotEmpty)
                    Text(
                      '${_firstNumber.toInt()} $_operation',
                      style: EnglishTypo.bodyMedium.copyWith(
                        fontSize: 18.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  const SizedBox(height: 8),
                  Text(
                    _display,
                    style: EnglishTypo.headline1.copyWith(
                      fontSize: 48.sp,
                      fontWeight: FontWeight.w900,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // Buttons Grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // Row 1: Clear, Divide, Multiply, Subtract
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(child: _buildButton('C', AppColors.action, _onClearPressed)),
                          const SizedBox(width: 12),
                          Expanded(child: _buildButton('÷', AppColors.reward, () => _onOperationPressed('÷'))),
                          const SizedBox(width: 12),
                          Expanded(child: _buildButton('×', AppColors.reward, () => _onOperationPressed('×'))),
                          const SizedBox(width: 12),
                          Expanded(child: _buildButton('-', AppColors.reward, () => _onOperationPressed('-'))),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Row 2: 7, 8, 9, Add
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(child: _buildButton('7', AppColors.primary, () => _onNumberPressed('7'))),
                          const SizedBox(width: 12),
                          Expanded(child: _buildButton('8', AppColors.primary, () => _onNumberPressed('8'))),
                          const SizedBox(width: 12),
                          Expanded(child: _buildButton('9', AppColors.primary, () => _onNumberPressed('9'))),
                          const SizedBox(width: 12),
                          Expanded(child: _buildButton('+', AppColors.reward, () => _onOperationPressed('+'))),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Row 3 & 4: 4, 5, 6, 1, 2, 3 with Equals spanning 2 rows
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(child: _buildButton('4', AppColors.primary, () => _onNumberPressed('4'))),
                                      const SizedBox(width: 12),
                                      Expanded(child: _buildButton('5', AppColors.primary, () => _onNumberPressed('5'))),
                                      const SizedBox(width: 12),
                                      Expanded(child: _buildButton('6', AppColors.primary, () => _onNumberPressed('6'))),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(child: _buildButton('1', AppColors.primary, () => _onNumberPressed('1'))),
                                      const SizedBox(width: 12),
                                      Expanded(child: _buildButton('2', AppColors.primary, () => _onNumberPressed('2'))),
                                      const SizedBox(width: 12),
                                      Expanded(child: _buildButton('3', AppColors.primary, () => _onNumberPressed('3'))),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildButton('=', AppColors.success, _onEqualsPressed),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Row 5: 0 (spanning 2 columns), .
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: _buildButton('0', AppColors.primary, () => _onNumberPressed('0')),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildButton('.', AppColors.info, () => _onNumberPressed('.')),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(
    String text,
    Color color,
    VoidCallback onPressed,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color,
            color.withOpacity(0.8),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
            spreadRadius: 1,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              text,
              style: EnglishTypo.headline1.copyWith(
                fontSize: 32.sp,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                shadows: const [
                  Shadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
