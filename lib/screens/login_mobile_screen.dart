import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import '../core/routes.dart';
import '../core/theme.dart';
import '../core/widgets.dart';

class LoginMobileScreen extends StatefulWidget {
  const LoginMobileScreen({super.key});

  @override
  State<LoginMobileScreen> createState() => _LoginMobileScreenState();
}

class _LoginMobileScreenState extends State<LoginMobileScreen> {
  String _countryCode = 'IN';
  String _countryName = 'India';
  String _flagEmoji = '🇮🇳';
  String _phoneCode = '91';

  void _selectCountry() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      favorite: const ['IN'],
      countryListTheme: CountryListThemeData(
        backgroundColor: Colors.white,
        textStyle: const TextStyle(color: AppColors.dark, fontSize: 15),
        bottomSheetHeight: MediaQuery.sizeOf(context).height * 0.75,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        inputDecoration: InputDecoration(
          hintText: 'Search country or code',
          prefixIcon: const Icon(Icons.search, color: AppColors.hint),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE3E3E3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.pink),
          ),
        ),
      ),
      onSelect: (country) {
        setState(() {
          _countryCode = country.countryCode;
          _countryName = country.name;
          _flagEmoji = country.flagEmoji;
          _phoneCode = country.phoneCode;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) => GradientScaffold(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final scale = (constraints.maxWidth / 353).clamp(0.55, 1.0);
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 36, 20, 20),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight:
                      (constraints.maxHeight - 56).clamp(0, double.infinity),
                ),
                child: IntrinsicHeight(
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
                      const SizedBox(height: 34),
                      const Text.rich(
                        TextSpan(
                          text: 'Make sure your ',
                          children: [
                            TextSpan(
                              text: 'Mobile Number',
                              style: TextStyle(
                                color: AppColors.dark,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text:
                                  ' is Active and Available to receive SMS Code',
                            ),
                          ],
                        ),
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          color: AppColors.hint,
                        ),
                      ),
                      const SizedBox(height: 24),
                      _CountryPhoneField(
                        countryCode: _countryCode,
                        countryName: _countryName,
                        flagEmoji: _flagEmoji,
                        phoneCode: _phoneCode,
                        onTap: _selectCountry,
                      ),
                      const SizedBox(height: 16),
                      AppButton(
                        label: 'Get Started',
                        icon: Icons.arrow_forward,
                        height: 62,
                        borderRadius: 16,
                        fontSize: 15,
                        iconSize: 22,
                        iconGap: 12,
                        onTap: () => Navigator.pushNamed(context, Routes.otp),
                      ),
                      const SizedBox(height: 16),
                      AppButton(
                        label: 'Continue With Email',
                        icon: Icons.mail_outline,
                        filled: false,
                        height: 62,
                        borderRadius: 16,
                        fontSize: 15,
                        iconSize: 22,
                        iconGap: 12,
                        onTap: () => Navigator.pushReplacementNamed(
                            context, Routes.loginEmail),
                      ),
                      const SizedBox(height: 28),
                      const OrDivider(),
                      const SizedBox(height: 18),
                      const SocialRow(
                        buttonHeight: 62,
                        borderRadius: 16,
                        buttonFontSize: 14,
                      ),
                      const Spacer(),
                      BottomLink(
                        text: "Don't Have an Account",
                        action: 'Create One',
                        onTap: () =>
                            Navigator.pushNamed(context, Routes.profile),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
}

class _CountryPhoneField extends StatelessWidget {
  final String countryCode;
  final String countryName;
  final String flagEmoji;
  final String phoneCode;
  final VoidCallback onTap;

  const _CountryPhoneField({
    required this.countryCode,
    required this.countryName,
    required this.flagEmoji,
    required this.phoneCode,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => Container(
        height: 58,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.dark, width: 1.5),
        ),
        child: Row(
          children: [
            Semantics(
              button: true,
              label: 'Select country: $countryName, +$phoneCode',
              child: InkWell(
                key: const Key('country-selector'),
                borderRadius: BorderRadius.circular(12),
                onTap: onTap,
                child: Container(
                  height: 42,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: AppColors.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      countryCode == 'IN'
                          ? const _IndiaFlagIcon()
                          : _CountryFlagIcon(
                              flagEmoji: flagEmoji,
                              countryName: countryName,
                            ),
                      const SizedBox(width: 6),
                      Text(
                        '+$phoneCode',
                        style: const TextStyle(
                          color: AppColors.dark,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.chevron_right,
                          size: 20, color: AppColors.dark),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: TextField(
                keyboardType: TextInputType.phone,
                style: TextStyle(fontSize: 14, color: AppColors.dark),
                decoration: InputDecoration(
                  hintText: 'Enter Mobile Number',
                  hintStyle: TextStyle(fontSize: 14, color: AppColors.hint),
                  border: InputBorder.none,
                  isCollapsed: true,
                ),
              ),
            ),
          ],
        ),
      );
}

class _CountryFlagIcon extends StatelessWidget {
  final String flagEmoji;
  final String countryName;

  const _CountryFlagIcon({
    required this.flagEmoji,
    required this.countryName,
  });

  @override
  Widget build(BuildContext context) => Semantics(
        label: '$countryName flag',
        child: ExcludeSemantics(
          child: ClipOval(
            child: SizedBox(
              width: 28,
              height: 28,
              child: Center(
                child: Text(flagEmoji, style: const TextStyle(fontSize: 22)),
              ),
            ),
          ),
        ),
      );
}

class _IndiaFlagIcon extends StatelessWidget {
  const _IndiaFlagIcon();

  @override
  Widget build(BuildContext context) => Semantics(
        label: 'India flag',
        child: SizedBox(
          width: 28,
          height: 28,
          child: CustomPaint(painter: _IndiaFlagPainter()),
        ),
      );
}

class _IndiaFlagPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bounds = Offset.zero & size;
    canvas.save();
    canvas.clipPath(Path()..addOval(bounds));

    final stripeHeight = size.height / 3;
    final stripeColors = [
      const Color(0xFFFF9933),
      Colors.white,
      const Color(0xFF138808),
    ];
    for (var i = 0; i < stripeColors.length; i++) {
      canvas.drawRect(
        Rect.fromLTWH(0, i * stripeHeight, size.width, stripeHeight),
        Paint()..color = stripeColors[i],
      );
    }

    final center = Offset(size.width / 2, size.height / 2);
    final chakraRadius = size.width * 0.12;
    final chakraPaint = Paint()
      ..color = const Color(0xFF000080)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.75;
    canvas.drawCircle(center, chakraRadius, chakraPaint);
    for (var spoke = 0; spoke < 24; spoke++) {
      final angle = spoke * math.pi / 12;
      canvas.drawLine(
        Offset(
          center.dx + math.cos(angle) * chakraRadius * 0.2,
          center.dy + math.sin(angle) * chakraRadius * 0.2,
        ),
        Offset(
          center.dx + math.cos(angle) * chakraRadius * 0.9,
          center.dy + math.sin(angle) * chakraRadius * 0.9,
        ),
        chakraPaint,
      );
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _IndiaFlagPainter oldDelegate) => false;
}
