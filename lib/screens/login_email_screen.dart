import 'package:flutter/material.dart';
import '../core/routes.dart';
import '../core/theme.dart';
import '../core/widgets.dart';

class LoginEmailScreen extends StatelessWidget {
  const LoginEmailScreen({super.key});

  @override
  Widget build(BuildContext context) => GradientScaffold(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
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
                      top: 'Over',
                      pink: '3M+',
                      rest: ' Songs',
                      sub: '& Podcasts',
                      fontSize:
                          46 * (constraints.maxWidth / 353).clamp(0.55, 1.0),
                      subFontSize:
                          28 * (constraints.maxWidth / 353).clamp(0.55, 1.0),
                      lineHeight: 1.08,
                    ),
                    const SizedBox(height: 38),
                    const AppTextField(
                      hint: 'designer.wrteam@gmail.com',
                      icon: Icons.mail_outline,
                      active: true,
                      keyboard: TextInputType.emailAddress,
                      height: 58,
                      borderRadius: 16,
                    ),
                    const SizedBox(height: 14),
                    const AppTextField(
                      hint: 'Enter Your Password',
                      icon: Icons.lock_outline,
                      obscure: true,
                      height: 58,
                      borderRadius: 16,
                      suffix: Icon(Icons.visibility_outlined,
                          size: 20, color: AppColors.hint),
                    ),
                    const SizedBox(height: 14),
                    const Row(children: [
                      Icon(Icons.info_outline, size: 17, color: AppColors.dark),
                      SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.pink,
                            decoration: TextDecoration.underline,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ]),
                    const SizedBox(height: 20),
                    AppButton(
                      label: 'Get Started',
                      icon: Icons.arrow_forward,
                      height: 62,
                      borderRadius: 16,
                      fontSize: 15,
                      iconSize: 22,
                      iconGap: 12,
                      onTap: () => Navigator.pushNamed(context, Routes.profile),
                    ),
                    const SizedBox(height: 16),
                    AppButton(
                      label: 'Continue With Mobile',
                      icon: Icons.phone_outlined,
                      filled: false,
                      height: 62,
                      borderRadius: 16,
                      fontSize: 15,
                      iconSize: 22,
                      iconGap: 12,
                      onTap: () => Navigator.pushReplacementNamed(
                          context, Routes.loginMobile),
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
                      onTap: () => Navigator.pushNamed(context, Routes.profile),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
