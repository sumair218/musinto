import 'package:flutter/material.dart';
import '../screens/complete_profile_screen.dart';
import '../screens/language_screen.dart';
import '../screens/liked_songs_screen.dart';
import '../screens/library_screen.dart';
import '../screens/main_shell.dart';
import '../screens/playlist_screen.dart';
import '../screens/player_screen.dart';
import '../screens/podcast_details_screen.dart';
import '../screens/podcast_player_screen.dart';
import '../screens/login_email_screen.dart';
import '../screens/login_mobile_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/otp_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/ai_mix_screen.dart';

class Routes {
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const loginEmail = '/login-email';
  static const loginMobile = '/login-mobile';
  static const otp = '/otp';
  static const profile = '/profile';
  static const language = '/language';
  static const library = '/library';
  static const main = '/main';
  static const playlist = '/playlist';
  static const player = '/player';
  static const podcastDetails = '/podcast-details';
  static const podcastPlayer = '/podcast-player';
  static const liked = '/liked';
  static const aiMix = '/ai-mix';

  static final Map<String, WidgetBuilder> table = {
    splash: (_) => const SplashScreen(),
    onboarding: (_) => const OnboardingScreen(),
    loginEmail: (_) => const LoginEmailScreen(),
    loginMobile: (_) => const LoginMobileScreen(),
    otp: (_) => const OtpScreen(),
    profile: (_) => const CompleteProfileScreen(),
    language: (_) => const LanguageScreen(),
    library: (_) => const LibraryScreen(),
    main: (_) => const MainShell(),
    playlist: (_) => const PlaylistScreen(),
    player: (_) => const PlayerScreen(),
    podcastDetails: (_) => const PodcastDetailsScreen(),
    podcastPlayer: (_) => const PodcastPlayerScreen(),
    liked: (_) => const LikedSongsScreen(),
    aiMix: (_) => const AiMixScreen(),
  };
}
