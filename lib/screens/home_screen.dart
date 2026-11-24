import 'package:flutter/material.dart';
import '../core/routes.dart';
import '../core/theme.dart';
import '../core/ui.dart';
import '../data/mock.dart';

const _quickPlayImages = [
  'https://images.unsplash.com/photo-1516280440614-37939bbacd81?auto=format&fit=crop&w=240&q=80',
  'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?auto=format&fit=crop&w=240&q=80',
  'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?auto=format&fit=crop&w=240&q=80',
  'https://images.unsplash.com/photo-1501386761578-eac5c94b800a?auto=format&fit=crop&w=240&q=80',
];

const _mixImages = [
  'https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?auto=format&fit=crop&w=600&q=80',
  'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?auto=format&fit=crop&w=600&q=80',
  'https://images.unsplash.com/photo-1506157786151-b8491531f063?auto=format&fit=crop&w=600&q=80',
];

const _trackImages = [
  'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?auto=format&fit=crop&w=240&q=80',
  'https://images.unsplash.com/photo-1516280440614-37939bbacd81?auto=format&fit=crop&w=240&q=80',
];

const _beatImages = [
  'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?auto=format&fit=crop&w=400&q=80',
  'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?auto=format&fit=crop&w=400&q=80',
  'https://images.unsplash.com/photo-1501386761578-eac5c94b800a?auto=format&fit=crop&w=400&q=80',
];

const _artistImages = [
  'https://images.unsplash.com/photo-1508700115892-45ecd05ae2ad?auto=format&fit=crop&w=240&q=80',
  'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=240&q=80',
  'https://images.unsplash.com/photo-1508700115892-45ecd05ae2ad?auto=format&fit=crop&w=240&q=80',
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _open(BuildContext context) =>
      Navigator.pushNamed(context, Routes.playlist);

  @override
  Widget build(BuildContext context) => SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final horizontalPadding = constraints.maxWidth >= 900
                ? 28.0
                : constraints.maxWidth >= 600
                    ? 22.0
                    : 16.0;
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1120),
                child: ListView(
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    12,
                    horizontalPadding,
                    20,
                  ),
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: 'Hello.! ',
                                  children: [
                                    TextSpan(
                                      text: 'Pavan',
                                      style: TextStyle(color: AppColors.pink),
                                    ),
                                    TextSpan(text: ' 👋'),
                                  ],
                                ),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Good Morning',
                                style: TextStyle(
                                    fontSize: 12, color: AppColors.hint),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            gradient: const LinearGradient(
                              colors: [Color(0xFFFFF1E8), Color(0xFFFFE7F0)],
                            ),
                            border: Border.all(color: const Color(0xFFFFD1D8)),
                          ),
                          child: TextButton.icon(
                            onPressed: () =>
                                Navigator.pushNamed(context, Routes.aiMix),
                            icon: const Icon(Icons.auto_awesome,
                                size: 17, color: AppColors.pink),
                            label: const Text(
                              'Ai Mix',
                              style: TextStyle(
                                  color: AppColors.dark, fontSize: 12),
                            ),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    HList(
                      44,
                      [
                        for (final item in const [
                          ('🙏', 'Devotion'),
                          ('💪', 'Workout'),
                          ('🥳', 'Party'),
                          ('💗', 'Romance'),
                        ])
                          _MoodChip(emoji: item.$1, label: item.$2),
                      ],
                    ),
                    const SectionHeader('Quick Play', Icons.auto_awesome),
                    HList(
                      96,
                      [
                        for (final entry in [
                          ('Strom H...', _quickPlayImages[0]),
                          ('Jui - LoFi', _quickPlayImages[1]),
                          ('Saul Mate', _quickPlayImages[2]),
                          ('Jack - Sui', _quickPlayImages[3]),
                        ])
                          _QuickPlayCard(
                            title: entry.$1,
                            imageUrl: entry.$2,
                            onTap: () =>
                                Navigator.pushNamed(context, Routes.player),
                          ),
                      ],
                    ),
                    const SectionHeader('Daily Mix', Icons.music_note),
                    HList(
                      190,
                      [
                        for (var i = 0; i < _mixImages.length; i++)
                          _DailyMixCard(
                            index: i,
                            imageUrl: _mixImages[i],
                            onTap: () => _open(context),
                          ),
                      ],
                    ),
                    SectionHeader(
                      'Energetic Hollywood',
                      Icons.bolt,
                      onViewAll: () => _open(context),
                    ),
                    for (var i = 0; i < 2; i++)
                      _HomeSongTile(
                        song: songs[i],
                        imageUrl: _trackImages[i],
                        onTap: () => _open(context),
                      ),
                    SectionHeader(
                      'Untouched Beats',
                      Icons.music_note,
                      onViewAll: () => _open(context),
                    ),
                    HList(
                      174,
                      [
                        for (var i = 0; i < _beatImages.length; i++)
                          _BeatCard(
                            title: [
                              'Anova Bee',
                              'Pink Dream',
                              'Night Drive',
                            ][i],
                            artist: ['Amma Brok', 'Emma Brok', 'DJ Nova'][i],
                            imageUrl: _beatImages[i],
                            onTap: () => _open(context),
                          ),
                      ],
                    ),
                    SectionHeader('Top Voices', Icons.mic_none,
                        onViewAll: () {}),
                    HList(
                      116,
                      [
                        for (var i = 0; i < artistNames.length; i++)
                          _HomeArtist(
                            name: artistNames[i],
                            imageUrl: _artistImages[i],
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
}

class _MoodChip extends StatelessWidget {
  final String emoji;
  final String label;

  const _MoodChip({required this.emoji, required this.label});

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          border: Border.all(color: const Color(0xFFE9E9EC)),
          boxShadow: const [
            BoxShadow(
                color: Color(0x08000000), blurRadius: 10, offset: Offset(0, 3)),
          ],
        ),
        child: Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 8),
            Text(label,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
          ],
        ),
      );
}

class _QuickPlayCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback onTap;

  const _QuickPlayCard({
    required this.title,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: 76,
          height: 88,
          margin: const EdgeInsets.only(right: 10),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: Stack(
            fit: StackFit.expand,
            children: [
              _OnlineArtwork(imageUrl: imageUrl, seed: title.length),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Color(0xCC000000)],
                    stops: [0.45, 1],
                  ),
                ),
              ),
              Positioned(
                left: 7,
                right: 4,
                bottom: 7,
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

class _DailyMixCard extends StatelessWidget {
  final int index;
  final String imageUrl;
  final VoidCallback onTap;

  const _DailyMixCard({
    required this.index,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final mixNumber = index + 1;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 176,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 132,
              clipBehavior: Clip.antiAlias,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(18)),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _OnlineArtwork(imageUrl: imageUrl, seed: mixNumber),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0x44000000), Color(0xB8000000)],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 14,
                    top: 14,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Daily',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: .8),
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'Mix $mixNumber',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: CircleAvatar(
                      radius: 17,
                      backgroundColor: Colors.white.withValues(alpha: .25),
                      child: const Icon(Icons.play_arrow,
                          color: Colors.white, size: 21),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Daily Mix $mixNumber',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 3),
            const Text(
              'Pritam, Arijit Singh, ...',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 11, color: AppColors.hint),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeSongTile extends StatelessWidget {
  final Song song;
  final String imageUrl;
  final VoidCallback onTap;

  const _HomeSongTile({
    required this.song,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(11),
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: _OnlineArtwork(imageUrl: imageUrl, seed: song.seed),
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      song.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      song.artists,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          const TextStyle(fontSize: 11, color: AppColors.dark),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      song.meta,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          const TextStyle(fontSize: 10, color: AppColors.hint),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              PlayOutline(onTap: onTap),
            ],
          ),
        ),
      );
}

class _BeatCard extends StatelessWidget {
  final String title;
  final String artist;
  final String imageUrl;
  final VoidCallback onTap;

  const _BeatCard({
    required this.title,
    required this.artist,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: 148,
          height: 164,
          margin: const EdgeInsets.only(right: 12),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          child: Stack(
            fit: StackFit.expand,
            children: [
              _OnlineArtwork(imageUrl: imageUrl, seed: title.length),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Color(0xE6000000)],
                    stops: [0.35, 1],
                  ),
                ),
              ),
              Positioned(
                left: 12,
                right: 8,
                bottom: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'by $artist',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 10),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}

class _HomeArtist extends StatelessWidget {
  final String name;
  final String imageUrl;

  const _HomeArtist({required this.name, required this.imageUrl});

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 92,
        child: Column(
          children: [
            ClipOval(
              child: SizedBox(
                width: 72,
                height: 72,
                child: _OnlineArtwork(imageUrl: imageUrl, seed: name.length),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      );
}

class _OnlineArtwork extends StatelessWidget {
  final String imageUrl;
  final int seed;

  const _OnlineArtwork({required this.imageUrl, required this.seed});

  @override
  Widget build(BuildContext context) => Image.network(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          decoration: BoxDecoration(gradient: gradientFor(seed)),
          child: const Center(
            child: Icon(Icons.music_note, color: Colors.white70, size: 26),
          ),
        ),
      );
}
