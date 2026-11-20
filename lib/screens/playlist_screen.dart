import 'package:flutter/material.dart';
import '../core/routes.dart';
import '../core/theme.dart';
import '../core/ui.dart';
import '../data/mock.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({super.key});

  void _play(BuildContext c) => Navigator.pushNamed(c, Routes.player);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final coverSize =
                  (constraints.maxWidth - 64).clamp(170.0, 260.0).toDouble();
              return Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 760),
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(18, 12, 18, 24),
                    children: [
                      const TopBar([CircleBtn(Icons.share_outlined)]),
                      const SizedBox(height: 16),
                      Center(
                        child: CoverArt(
                          0,
                          w: coverSize,
                          h: coverSize,
                          radius: 18,
                          icon: Icons.graphic_eq,
                          imageUrl: songs.first.artworkUrl,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Center(
                        child: Text(
                          'Edm House - By Unimagines',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Center(
                        child: Text(
                          'Unimagine Foxes, Jhon Snow, Eddy brok',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 11, color: AppColors.hint),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircleBtn(Icons.shuffle),
                          const SizedBox(width: 16),
                          CircleBtn(
                            Icons.play_arrow,
                            size: 60,
                            primary: true,
                            onTap: () => _play(context),
                          ),
                          const SizedBox(width: 16),
                          const CircleBtn(Icons.queue_music),
                        ],
                      ),
                      const SizedBox(height: 12),
                      for (final song in songs.skip(1))
                        SongTile(song, onTap: () => _play(context)),
                      const SectionHeader(
                        'Recommended For You',
                        Icons.music_note,
                      ),
                      HList(
                        164,
                        [
                          for (var i = 1; i < songs.length; i++)
                            PosterCard(
                              songs[i].title,
                              songs[i].seed,
                              w: 148,
                              h: 150,
                              imageUrl: songs[i].artworkUrl,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
}
