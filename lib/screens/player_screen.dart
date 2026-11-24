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
  final ScrollController _scroll = ScrollController();
  bool _vinyl = false;
  int _tab = 1;
  bool _compact = false;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
  }

  void _onScroll() {
    final compact = _scroll.offset > 220;
    if (compact != _compact) {
      setState(() => _compact = compact);
    }
  }

  @override
  void dispose() {
    _scroll.removeListener(_onScroll);
    _scroll.dispose();
    _spin.dispose();
    super.dispose();
  }

  Widget _art(double size) {
    if (!_vinyl) {
      return Container(
        key: const Key('player-circular-art'),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Color(0x26000000),
              blurRadius: 18,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: ClipOval(
          child: CoverArt(
            2,
            w: size,
            icon: Icons.person,
            imageUrl: _currentArtworkUrl,
          ),
        ),
      );
    }

    return SizedBox(
      key: const Key('player-vinyl-image'),
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const SweepGradient(
                colors: [
                  Color(0xFF09090B),
                  Color(0xFF31343A),
                  Color(0xFF09090B),
                  Color(0xFF454B54),
                  Color(0xFF09090B),
                ],
              ),
              border: Border.all(color: const Color(0xFFBFC5CA), width: 2),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x33000000),
                  blurRadius: 16,
                  offset: Offset(0, 8),
                ),
              ],
            ),
          ),
          ...List.generate(5, (index) {
            final groove = size * (.56 + index * .07);
            return Container(
              width: groove,
              height: groove,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.08),
                  width: 1,
                ),
              ),
            );
          }),
          ClipOval(
            child: CoverArt(
              2,
              w: size * .43,
              icon: Icons.person,
              imageUrl: _currentArtworkUrl,
            ),
          ),
          Positioned(
            right: size * .04,
            top: -size * .12,
            child: Transform.rotate(
              angle: -0.42,
              alignment: Alignment.topRight,
              child: Container(
                width: size * .43,
                height: 7,
                decoration: BoxDecoration(
                  color: const Color(0xFFC7CDD1),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: const Color(0xFF5C6368)),
                ),
              ),
            ),
          ),
          Positioned(
            right: size * .015,
            top: -size * .13,
            child: Container(
              width: 14,
              height: 14,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFE3E7EA),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _compactHeader() => Container(
        key: const Key('player-compact-header'),
        height: 68,
        margin: const EdgeInsets.fromLTRB(12, 8, 12, 0),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 14,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipOval(
              child: CoverArt(
                2,
                w: 48,
                icon: Icons.person,
                imageUrl: _currentArtworkUrl,
              ),
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Saul Mate - By Emmy Stark',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Emmy Stark, Jhon Snow, Eddy brok',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 9, color: AppColors.hint),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const CircleBtn(Icons.play_arrow, size: 44, primary: true),
          ],
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
                  child: Stack(
                    children: [
                      ListView(
                        controller: _scroll,
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
                            style:
                                TextStyle(fontSize: 11, color: AppColors.hint),
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
                          for (final song
                              in (_tab == 0 ? songs.reversed : songs))
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
                      if (_compact)
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: _compactHeader(),
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
