import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../core/ui.dart';
import '../data/mock.dart';

const _currentArtworkUrl =
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=640&q=80';

/// Full-screen music player. Tap the artwork to switch circle <-> vinyl.
class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});
  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _spin =
      AnimationController(vsync: this, duration: const Duration(seconds: 12))
        ..repeat();
  bool _vinyl = false;
  int _tab = 1;

  @override
  void dispose() {
    _spin.dispose();
    super.dispose();
  }

  Widget _art(double size) => _vinyl
      ? ClipOval(
          child: SizedBox(
            width: size,
            height: size,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Transform.scale(
                  scale: 1.3,
                  child: Image.asset(
                    'lib/assets/Media/desk.jpg',
                    key: const Key('player-vinyl-image'),
                    fit: BoxFit.cover,
                  ),
                ),
                Center(
                  child: ClipOval(
                    child: CoverArt(
                      2,
                      w: size * .29,
                      icon: Icons.person,
                      imageUrl: _currentArtworkUrl,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      : ClipOval(
          child: CoverArt(
            2,
            w: size,
            icon: Icons.person,
            imageUrl: _currentArtworkUrl,
          ),
        );

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final artworkSize =
                  (constraints.maxWidth - 48).clamp(170.0, 280.0).toDouble();
              return Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 760),
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      Center(
                        child: GestureDetector(
                          onTap: () => Navigator.maybePop(context),
                          child: Container(
                            width: 40,
                            height: 4,
                            decoration: BoxDecoration(
                              color: const Color(0xFFDDDDDD),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: GestureDetector(
                          key: const Key('player-artwork'),
                          onTap: () => setState(() => _vinyl = !_vinyl),
                          child: RotationTransition(
                            turns: _spin,
                            child: _art(artworkSize),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Saul Mate - By Emmy Stark',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Emmy Stark, Jhon Snow, Eddy brok',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 11, color: AppColors.hint),
                      ),
                      const SizedBox(height: 8),
                      PlayerControls(
                        onPlayChanged: (playing) =>
                            playing ? _spin.repeat() : _spin.stop(),
                      ),
                      const SizedBox(height: 12),
                      UnderlineTabs(
                        const ['Similar', 'Up Next'],
                        const [Icons.auto_awesome, Icons.list],
                        _tab,
                        (index) => setState(() => _tab = index),
                      ),
                      const SizedBox(height: 8),
                      for (final song in (_tab == 0 ? songs.reversed : songs))
                        SongTile(
                          song,
                          showMeta: false,
                          trailing: const Icon(
                            Icons.drag_handle,
                            color: AppColors.hint,
                          ),
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
