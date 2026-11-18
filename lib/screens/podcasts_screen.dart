import 'package:flutter/material.dart';
import '../core/routes.dart';
import '../core/theme.dart';
import '../core/ui.dart';

class PodcastsScreen extends StatelessWidget {
  const PodcastsScreen({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
        child: ListView(padding: const EdgeInsets.fromLTRB(16, 12, 16, 16), children: [
          const Row(children: [
            Icon(Icons.mic, size: 20),
            SizedBox(width: 8),
            Text('Podcasts', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          ]),
          const SizedBox(height: 4),
          const Text('Enjoy Trending Podcasts & Shows',
              style: TextStyle(fontSize: 11, color: AppColors.hint)),
          const SizedBox(height: 14),
          HList(40, [
            for (final c in ['Virus', 'Science', 'Science']) PillChip(c, Icons.biotech_outlined),
          ]),
          const SizedBox(height: 14),
          for (final seed in [0, 3])
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, Routes.podcastDetails),
              child: Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 10)],
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Row(children: [
                    ClipOval(child: CoverArt(4, w: 34, icon: Icons.mic)),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text("Lilly's Life",
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                        Text('Ep - 42', style: TextStyle(fontSize: 10, color: AppColors.pink)),
                      ]),
                    ),
                    PlayOutline(),
                    SizedBox(width: 8),
                    Icon(Icons.menu_open, size: 20),
                  ]),
                  const SizedBox(height: 10),
                  CoverArt(seed, w: double.infinity, h: 130, icon: Icons.mic),
                  const SizedBox(height: 10),
                  const Text('Tough Life #42 - The Last Fight | Lilly Menon Ft. Mr Fantastic',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  const Text(
                      "Discover inspiring stories, practical tips, and real-life moments from Lilly's journey.",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 10, color: AppColors.hint)),
                ]),
              ),
            ),
        ]),
      );
}
