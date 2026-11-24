import 'package:flutter/material.dart';

import '../core/routes.dart';
import '../core/theme.dart';
import '../core/ui.dart';
import '../data/mock.dart';

class AiMixScreen extends StatefulWidget {
  const AiMixScreen({super.key});

  @override
  State<AiMixScreen> createState() => _AiMixScreenState();
}

class _AiMixScreenState extends State<AiMixScreen> {
  String _prompt = '';
  String _mood = '';
  bool _generated = false;

  static const _moods = [
    ('🥳', 'Party'),
    ('🙏', 'Devotion'),
    ('💪', 'Workout'),
    ('⚽', 'Sport'),
    ('✈️', 'Travel'),
    ('🏖️', 'Beach'),
  ];

  void _generate() {
    if (_prompt.trim().isEmpty && _mood.isEmpty) {
      return;
    }
    setState(() => _generated = true);
  }

  @override
  Widget build(BuildContext context) {
    if (_generated)
      return _PlaylistView(onEdit: () {
        setState(() => _generated = false);
      });

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              children: [
                const TopBar([]),
                const SizedBox(height: 26),
                const Text(
                  'Welcome to',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                ),
                Text.rich(
                  TextSpan(
                    children: const [
                      TextSpan(
                        text: 'Ai ',
                        style: TextStyle(
                          color: AppColors.pink,
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      TextSpan(
                        text: 'Mix',
                        style: TextStyle(
                          color: AppColors.dark,
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                const Align(
                  alignment: Alignment.topLeft,
                  child: CircleBtn(
                    Icons.auto_awesome,
                    size: 48,
                  ),
                ),
                const SizedBox(height: 18),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _moods.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.55,
                  ),
                  itemBuilder: (context, index) {
                    final mood = _moods[index];
                    final selected = _mood == mood.$2;
                    return InkWell(
                      onTap: () => setState(() => _mood = mood.$2),
                      borderRadius: BorderRadius.circular(12),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        decoration: BoxDecoration(
                          color: selected
                              ? const Color(0xFFFFEDF3)
                              : AppColors.grey,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color:
                                selected ? AppColors.pink : Colors.transparent,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(mood.$1, style: const TextStyle(fontSize: 20)),
                            const SizedBox(height: 4),
                            Text(
                              mood.$2,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 32),
                Container(
                  height: 56,
                  padding: const EdgeInsets.fromLTRB(12, 6, 6, 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFEDF3),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.auto_awesome,
                          size: 18, color: AppColors.pink),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          key: const Key('ai-mix-prompt'),
                          onChanged: (value) => setState(() => _prompt = value),
                          onSubmitted: (_) => _generate(),
                          style: const TextStyle(fontSize: 11),
                          decoration: const InputDecoration(
                            hintText: 'Tell Me About Your Mood...',
                            hintStyle: TextStyle(
                              fontSize: 10,
                              color: AppColors.hint,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      CircleBtn(
                        Icons.mic,
                        size: 44,
                        primary: true,
                        onTap: _generate,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PlaylistView extends StatelessWidget {
  final VoidCallback onEdit;
  const _PlaylistView({required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              children: [
                TopBar([
                  CircleBtn(Icons.share_outlined, onTap: onEdit),
                  CircleBtn(Icons.shuffle),
                ]),
                const SizedBox(height: 18),
                Center(
                  child: Container(
                    width: 118,
                    height: 118,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFEDF3),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('🥳', style: TextStyle(fontSize: 28)),
                        SizedBox(height: 8),
                        Text(
                          'Ai Party Mix',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.pink,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '25+ Songs',
                          style: TextStyle(fontSize: 9, color: AppColors.hint),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleBtn(Icons.shuffle),
                    const SizedBox(width: 16),
                    CircleBtn(
                      Icons.play_arrow,
                      size: 60,
                      primary: true,
                      onTap: () => Navigator.pushNamed(context, Routes.player),
                    ),
                    const SizedBox(width: 16),
                    const CircleBtn(Icons.queue_music),
                  ],
                ),
                const SizedBox(height: 12),
                for (final song in songs)
                  SongTile(
                    song,
                    showMeta: true,
                    onTap: () => Navigator.pushNamed(context, Routes.player),
                  ),
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
        ),
      ),
    );
  }
}
