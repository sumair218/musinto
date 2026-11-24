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

  Widget _stat(String v, String l) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(v,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
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
            LayoutBuilder(
              builder: (context, constraints) {
                final compact = constraints.maxWidth < 360;
                final coverSize = compact ? 76.0 : 100.0;
                final statGap = compact ? 10.0 : 24.0;
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: coverSize,
                      height: coverSize,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF78D5FF),
                            Color(0xFF55A5FF),
                            Color(0xFFFF80A8),
                          ],
                        ),
                      ),
                      child: const Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(Icons.mic, size: 54, color: Colors.white),
                          Positioned(
                            right: 10,
                            bottom: 10,
                            child: Icon(
                              Icons.podcasts,
                              size: 24,
                              color: Color(0xFF171B32),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              _stat('12.5k', 'Followers'),
                              SizedBox(width: statGap),
                              _stat('12M+', 'Listeners'),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: FilledButton(
                                  onPressed: () =>
                                      setState(() => _following = !_following),
                                  style: FilledButton.styleFrom(
                                      backgroundColor: AppColors.pink),
                                  child: Text(
                                    _following ? 'Following' : 'Follow',
                                    style: const TextStyle(fontSize: 9),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: FilledButton(
                                  onPressed: () {},
                                  style: FilledButton.styleFrom(
                                    backgroundColor: AppColors.grey,
                                    foregroundColor: AppColors.dark,
                                  ),
                                  child: const Text(
                                    'About',
                                    style: TextStyle(fontSize: 9),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            const Text("Lilly's Life - Podcast",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            const Text(
                'From personal growth to everyday wins, we cover it all. Listen, learn, and live your best life.',
                style: TextStyle(fontSize: 11, color: AppColors.hint)),
            const SizedBox(height: 12),
            UnderlineTabs(
                const ['Episodes', 'Similar'],
                const [Icons.list, Icons.auto_awesome],
                _tab,
                (i) => setState(() => _tab = i)),
            const SizedBox(height: 8),
            for (final e in episodes)
              SongTile(e,
                  art: 76,
                  artH: 44,
                  trailing: const SizedBox.shrink(),
                  onTap: () =>
                      Navigator.pushNamed(context, Routes.podcastPlayer)),
          ]),
        ),
      );
}
