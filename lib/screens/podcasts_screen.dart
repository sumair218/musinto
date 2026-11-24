import 'package:flutter/material.dart';
import '../core/routes.dart';
import '../core/theme.dart';
import '../core/ui.dart';

class PodcastsScreen extends StatelessWidget {
  const PodcastsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 760),
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                children: [
                  const Row(
                    children: [
                      Icon(Icons.mic, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Podcasts',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Enjoy Trending Podcasts & Shows',
                    style: TextStyle(fontSize: 11, color: AppColors.hint),
                  ),
                  const SizedBox(height: 14),
                  HList(40, [
                    const PillChip('Virus', Icons.coronavirus_outlined,
                        selected: true),
                    const PillChip('Science', Icons.science_outlined),
                    const PillChip('Science', Icons.science_outlined),
                  ]),
                  const SizedBox(height: 14),
                  for (final index in [0, 1, 2])
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, Routes.podcastDetails),
                      child: _PodcastFeedCard(index: index),
                    ),
                ],
              ),
            ),
          ),
        ),
      );
}

class _PodcastFeedCard extends StatelessWidget {
  final int index;
  const _PodcastFeedCard({required this.index});

  @override
  Widget build(BuildContext context) {
    final alternate = index.isOdd;
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
              color: Color(0x14000000), blurRadius: 10, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFFE3EC),
                ),
                child:
                    const Icon(Icons.podcasts, size: 18, color: AppColors.pink),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Lilly's Life",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Ep - 42',
                      style: TextStyle(fontSize: 10, color: AppColors.pink),
                    ),
                  ],
                ),
              ),
              PlayOutline(
                onTap: () => Navigator.pushNamed(context, Routes.podcastPlayer),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.menu_open, size: 20),
            ],
          ),
          const SizedBox(height: 10),
          _PodcastBanner(alternate: alternate),
          const SizedBox(height: 10),
          Text(
            'Tough Life #42 - The Last Fight | Lilly Menon Ft. Mr Fantastic',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.dark.withValues(alpha: alternate ? 0.72 : 1),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "Discover inspiring stories, practical tips, and real-life moments from Lilly's journey.",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 10, color: AppColors.hint),
          ),
        ],
      ),
    );
  }
}

class _PodcastBanner extends StatelessWidget {
  final bool alternate;
  const _PodcastBanner({this.alternate = false});

  @override
  Widget build(BuildContext context) {
    final colors = alternate
        ? const [Color(0xFFF7C7FF), Color(0xFFFFA8C8), Color(0xFF7474FF)]
        : const [Color(0xFF77D7FF), Color(0xFF54A7FF), Color(0xFFFF83AF)];

    return Container(
      height: 132,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: alternate ? -8 : 12,
            bottom: -18,
            child: Container(
              width: 118,
              height: 118,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.18),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 94,
                    height: 94,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF171B32),
                    ),
                    child: const Icon(Icons.mic,
                        size: 42, color: Color(0xFFFFD7E6)),
                  ),
                  Positioned(
                    right: 4,
                    child: Container(
                      width: 34,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF5BA2),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Tough Life",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  alternate ? 'feminine podcast' : 'PODCAST',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: alternate
                        ? const Color(0xFF6C4AE7)
                        : const Color(0xFFFFD33D),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Listen Now',
                    style: TextStyle(
                      color: alternate ? Colors.white : AppColors.dark,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
