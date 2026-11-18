import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/routes.dart';
import '../core/theme.dart';
import '../core/widgets.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  static const _length = 6;
  final _controllers = List.generate(_length, (_) => TextEditingController());
  final _nodes = List.generate(_length, (_) => FocusNode());
  late final TapGestureRecognizer _changeNumberGesture;
  Timer? _timer;
  int _seconds = 176;

  @override
  void initState() {
    super.initState();
    _changeNumberGesture = TapGestureRecognizer()
      ..onTap = () => Navigator.pushReplacementNamed(
            context,
            Routes.loginMobile,
          );
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted || _seconds <= 0) {
        timer.cancel();
        return;
      }
      setState(() => _seconds--);
    });
  }

  String get _time =>
      '${(_seconds ~/ 60).toString().padLeft(2, '0')}:${(_seconds % 60).toString().padLeft(2, '0')}';

  void _onChanged(int index, String value) {
    if (value.isNotEmpty && index < _length - 1) {
      _nodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _nodes[index - 1].requestFocus();
    }
    setState(() {});
  }

  @override
  void dispose() {
    _timer?.cancel();
    _changeNumberGesture.dispose();
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final node in _nodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => GradientScaffold(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final scale =
                (constraints.maxWidth / 353).clamp(0.55, 1.0).toDouble();
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 36, 20, 20),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight:
                      (constraints.maxHeight - 56).clamp(0, double.infinity),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Headline(
                      top: 'Listen',
                      pink: 'Ultra',
                      rest: ' High',
                      sub: 'Quality Songs',
                      fontSize: 46 * scale,
                      subFontSize: 28 * scale,
                      lineHeight: 1.08,
                    ),
                    const SizedBox(height: 38),
                    Text.rich(
                      key: const Key('change-number'),
                      TextSpan(
                        text:
                            'We just sent One Time Password\nto +91 1234567890 - ',
                        children: [
                          TextSpan(
                            text: 'Change Number',
                            style: const TextStyle(
                              color: AppColors.pink,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: _changeNumberGesture,
                          ),
                        ],
                      ),
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color: AppColors.hint,
                      ),
                    ),
                    const SizedBox(height: 28),
                    LayoutBuilder(
                      builder: (context, boxConstraints) {
                        final spacing =
                            (boxConstraints.maxWidth * 0.025).clamp(6.0, 12.0);
                        final boxWidth = ((boxConstraints.maxWidth -
                                    spacing * (_length - 1)) /
                                _length)
                            .clamp(0.0, 56.0)
                            .toDouble();
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            _length,
                            (index) => _box(index, boxWidth),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 28),
                    AppButton(
                      label: 'Verify',
                      height: 62,
                      borderRadius: 16,
                      fontSize: 15,
                      onTap: () => Navigator.pushNamed(context, Routes.profile),
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: _seconds > 0
                          ? Wrap(
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 12,
                              children: [
                                const Text(
                                  'Resend Code in',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.dark,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.access_time,
                                      size: 20,
                                      color: AppColors.pink,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      _time,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: AppColors.dark,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : TextButton(
                              onPressed: () => setState(() {
                                _seconds = 176;
                                _startTimer();
                              }),
                              style: TextButton.styleFrom(
                                foregroundColor: AppColors.pink,
                              ),
                              child: const Text(
                                'Resend Code',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );

  Widget _box(int index, double width) {
    final focused = _nodes[index].hasFocus;
    final hasValue = _controllers[index].text.isNotEmpty;
    final borderColor = focused
        ? AppColors.pink
        : hasValue
            ? const Color(0xFFD8D8D8)
            : Colors.transparent;

    return SizedBox(
      width: width,
      height: 62,
      child: TextField(
        key: Key('otp-digit-$index'),
        controller: _controllers[index],
        focusNode: _nodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        textInputAction:
            index == _length - 1 ? TextInputAction.done : TextInputAction.next,
        autofillHints: const [AutofillHints.oneTimeCode],
        maxLength: 1,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: AppColors.dark,
        ),
        onChanged: (value) => _onChanged(index, value),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: focused || hasValue ? Colors.white : AppColors.grey,
          contentPadding: EdgeInsets.zero,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.pink, width: 1.5),
          ),
        ),
      ),
    );
  }
}
