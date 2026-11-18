import 'package:flutter/material.dart';
import '../core/routes.dart';
import '../core/theme.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  static const _gradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [AppColors.pink, Color(0xFFFF3B4E)],
  );

  @override
  Widget build(BuildContext context) {
    const base = TextStyle(
      fontSize: 60,
      fontWeight: FontWeight.w800,
      height: 1.18,
      color: AppColors.dark,
      letterSpacing: -1,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Soft peach -> white fade at the top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 240,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFFFFD9BF).withOpacity(0.85),
                    const Color(0xFFFFEFF3).withOpacity(0.6),
                    Colors.white.withOpacity(0),
                  ],
                ),
              ),
            ),
          ),

          // Photo anchored to the bottom, full width
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Image.asset(
              'lib/assets/images/Onboarding.png',
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomCenter,
            ),
          ),

          // Headline + button
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(28, 48, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Dive', style: base),
                  Row(
                    children: [
                      ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (r) => _gradient.createShader(r),
                        child: const Text('Deep', style: base),
                      ),
                      const Text(' into', style: base),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('MUSIC', style: base),
                      const SizedBox(width: 18),
                      GestureDetector(
                        onTap: () => Navigator.pushReplacementNamed(
                            context, Routes.loginEmail),
                        child: Container(
                          width: 125,
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: _gradient,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.pink.withOpacity(0.3),
                                blurRadius: 14,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              3,
                              (i) => Align(
                                widthFactor: 0.55,
                                child: Icon(
                                  Icons.chevron_right,
                                  size: 24,
                                  color: Colors.white
                                      .withOpacity(0.55 + i * 0.2),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}