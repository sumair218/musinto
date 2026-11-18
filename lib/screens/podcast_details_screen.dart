import 'package:flutter/material.dart';
import '../core/routes.dart';
import '../core/theme.dart';
import '../core/ui.dart';
import '../data/mock.dart';

class PodcastDetailsScreen extends StatefulWidget {
  const PodcastDetailsScreen({super.key});
  @override
  State<PodcastDetailsScreen> createState() => _PodcastDetailsScreenState();
}

class _PodcastDetailsScreenState extends State<PodcastDetailsScreen> {
  int _tab = 0;
  bool _following = false;

  Widget _stat(String v, String l) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(v, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        Text(l, style: const TextStyle(fontSize: 10, color: AppColors.hint)),
      ]);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: ListView(padding: const EdgeInsets.all(16), children: [
            const TopBar([
              CircleBtn(Icons.share_outlined),
              CircleBtn(Icons.queue_music),
              CircleBtn(Icons.shuffle),
            ]),
            const SizedBox(height: 16),
            Row(children: [
              const CoverArt(4, w: 100, radius: 12, icon: Icons.mic),
              const SizedBox(width: 16),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [_stat('12.5k', 'Followers'), const SizedBox(width: 24), _stat('12M+', 'Listeners')]),
                  const SizedBox(height: 10),
                  Row(children: [
                    Expanded(
                      child: FilledButton(
                        onPressed: () => setState(() => _following = !_following),
                        style: FilledButton.styleFrom(backgroundColor: AppColors.pink),
                        child: Text(_following ? 'Following' : 'Follow',
                            style: const TextStyle(fontSize: 11)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: FilledButton(
                        onPressed: () {},
                        style: FilledButton.styleFrom(
                            backgroundColor: AppColors.grey, foregroundColor: AppColors.dark),
                        child: const Text('About', style: TextStyle(fontSize: 11)),
                      ),
                    ),
                  ]),
                ]),
              ),
            ]),
            const SizedBox(height: 16),
            const Text("Lilly's Life - Podcast",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            const Text(
                'From personal growth to everyday wins, we cover it all. Listen, learn, and live your best life.',
                style: TextStyle(fontSize: 11, color: AppColors.hint)),
            const SizedBox(height: 12),
            UnderlineTabs(const ['Episodes', 'Similar'], const [Icons.list, Icons.auto_awesome],
                _tab, (i) => setState(() => _tab = i)),
            const SizedBox(height: 8),
            for (final e in episodes)
              SongTile(e,
                  art: 76,
                  artH: 44,
                  trailing: const SizedBox.shrink(),
                  onTap: () => Navigator.pushNamed(context, Routes.podcastPlayer)),
          ]),
        ),
      );
}
