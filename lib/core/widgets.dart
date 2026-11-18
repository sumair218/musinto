import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'theme.dart';

/// Pink -> orange fading header used on onboarding/login screens.
class GradientScaffold extends StatelessWidget {
  final Widget child;
  const GradientScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFFFD6E2), Color(0xFFFFE6D5), Colors.white],
              stops: [0, 0.18, 0.4],
            ),
          ),
          child: SafeArea(child: child),
        ),
      );
}

/// Big three-line headline: "Over / **3M+** Songs / & Podcasts".
class Headline extends StatelessWidget {
  final String top, pink, rest, sub;
  final double fontSize, subFontSize, lineHeight;
  const Headline({
    super.key,
    required this.top,
    required this.pink,
    required this.rest,
    required this.sub,
    this.fontSize = 40,
    this.subFontSize = 24,
    this.lineHeight = 1.2,
  });

  @override
  Widget build(BuildContext context) {
    final base = TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      height: lineHeight,
      color: AppColors.dark,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(top, style: base),
        Text.rich(
          TextSpan(children: [
            TextSpan(text: pink, style: base.copyWith(color: AppColors.pink)),
            TextSpan(text: rest),
          ]),
          style: base,
        ),
        Text(sub, style: base.copyWith(fontSize: subFontSize)),
      ],
    );
  }
}

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final IconData? icon;
  final bool filled;
  final double height, borderRadius, fontSize, iconSize, iconGap;
  const AppButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.filled = true,
    this.height = 50,
    this.borderRadius = 14,
    this.fontSize = 13,
    this.iconSize = 18,
    this.iconGap = 8,
  });

  @override
  Widget build(BuildContext context) {
    final fg = filled ? Colors.white : AppColors.dark;
    return SizedBox(
      width: double.infinity,
      height: height,
      child: Material(
        color: filled ? AppColors.dark : AppColors.grey,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null && !filled) ...[
                Icon(icon, size: iconSize, color: fg),
                SizedBox(width: iconGap)
              ],
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: fg,
                    fontSize: fontSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (icon != null && filled) ...[
                SizedBox(width: iconGap),
                Icon(icon, size: iconSize, color: fg)
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class SocialButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color? iconColor;
  final bool googleLogo;
  final double height, borderRadius, fontSize;
  const SocialButton({
    super.key,
    required this.label,
    required this.icon,
    this.iconColor,
    this.googleLogo = false,
    this.height = 46,
    this.borderRadius = 12,
    this.fontSize = 12,
  });

  @override
  Widget build(BuildContext context) => Expanded(
        child: OutlinedButton.icon(
          onPressed: () {},
          icon: googleLogo
              ? const GoogleMark()
              : Icon(icon, color: iconColor ?? AppColors.dark),
          label: Text(label,
              style: TextStyle(color: AppColors.dark, fontSize: fontSize)),
          style: OutlinedButton.styleFrom(
            minimumSize: Size.fromHeight(height),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            side: const BorderSide(color: Color(0xFFE3E3E3)),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius)),
          ),
        ),
      );
}

class GoogleMark extends StatelessWidget {
  const GoogleMark({super.key});

  @override
  Widget build(BuildContext context) => SvgPicture.asset(
        'lib/assets/icons/google.svg',
        width: 25,
        height: 25,
        semanticsLabel: 'Google',
      );
}

class SocialRow extends StatelessWidget {
  final double buttonHeight, borderRadius, buttonFontSize;
  final String secondLabel;
  const SocialRow({
    super.key,
    this.buttonHeight = 46,
    this.borderRadius = 12,
    this.buttonFontSize = 12,
    this.secondLabel = 'Apple',
  });
  @override
  Widget build(BuildContext context) => Row(children: [
        SocialButton(
          label: 'Google',
          icon: Icons.g_mobiledata,
          googleLogo: true,
          height: buttonHeight,
          borderRadius: borderRadius,
          fontSize: buttonFontSize,
        ),
        const SizedBox(width: 12),
        SocialButton(
          label: secondLabel,
          icon: Icons.apple,
          height: buttonHeight,
          borderRadius: borderRadius,
          fontSize: buttonFontSize,
        ),
      ]);
}

class AppTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final bool obscure;
  final bool active;
  final TextInputType? keyboard;
  final Widget? suffix;
  final double height, borderRadius;
  const AppTextField({
    super.key,
    required this.hint,
    required this.icon,
    this.obscure = false,
    this.active = false,
    this.keyboard,
    this.suffix,
    this.height = 50,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) => Container(
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: active ? Colors.white : AppColors.grey,
          borderRadius: BorderRadius.circular(borderRadius),
          border:
              Border.all(color: active ? AppColors.dark : Colors.transparent),
        ),
        child: Row(children: [
          Icon(icon, size: 18, color: AppColors.pink),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              obscureText: obscure,
              keyboardType: keyboard,
              style: const TextStyle(fontSize: 12),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(fontSize: 12, color: AppColors.hint),
                border: InputBorder.none,
              ),
            ),
          ),
          if (suffix != null) suffix!,
        ]),
      );
}

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});
  @override
  Widget build(BuildContext context) => const Center(
        child: Text('Or continue with',
            style: TextStyle(fontSize: 11, color: AppColors.hint)),
      );
}

class BottomLink extends StatelessWidget {
  final String text, action;
  final VoidCallback onTap;
  const BottomLink(
      {super.key,
      required this.text,
      required this.action,
      required this.onTap});

  @override
  Widget build(BuildContext context) => Center(
        child: GestureDetector(
          onTap: onTap,
          child: Text.rich(
            TextSpan(text: '$text ', children: [
              TextSpan(
                text: action,
                style: const TextStyle(
                    color: AppColors.pink,
                    decoration: TextDecoration.underline),
              ),
            ]),
            style: const TextStyle(fontSize: 11, color: AppColors.dark),
          ),
        ),
      );
}
