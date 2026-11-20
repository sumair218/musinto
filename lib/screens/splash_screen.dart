import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/routes.dart';
import '../core/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 2), () {
      if (mounted) Navigator.pushReplacementNamed(context, Routes.onboarding);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              // Logo + title + tagline, centered in the available space
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'lib/assets/icons/Logo.svg',
                        key: const Key('app-logo'),
                        width: 163,
                        height: 240,
                        fit: BoxFit.contain,
                        semanticsLabel: 'Musinto',
                      ),
                    ],
                  ),
                ),
              ),

              // Footer
              const Padding(
                padding: EdgeInsets.only(bottom: 24),
                child: Text.rich(
                  TextSpan(
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.hint,
                      letterSpacing: 0.3,
                    ),
                    children: [
                      TextSpan(text: 'Made with '),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Icon(Icons.favorite,
                            size: 14, color: Color(0xFFFF3B4E)),
                      ),
                      TextSpan(text: ' By WRTeam Design'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
