import 'package:flutter/material.dart';
import '../data/mock.dart';
import 'routes.dart';
import 'theme.dart';

const palette = [
  Color(0xFF3B2BFF), Color(0xFF8E2DE2), Color(0xFFE53935), Color(0xFFFF8A00), Color(0xFF00B8D4),
];

LinearGradient gradientFor(int seed) => LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [palette[seed % 5], palette[(seed + 2) % 5]],
    );

/// Placeholder artwork. Swap for Image.asset / Image.network later.
class CoverArt extends StatelessWidget {
  final int seed;
  final double w;
  final double? h;
  final double radius;
  final IconData icon;
  const CoverArt(this.seed,
      {super.key, this.w = 48, this.h, this.radius = 8, this.icon = Icons.music_note});

  @override
  Widget build(BuildContext context) => Container(
        width: w,
        height: h ?? w,
        decoration: BoxDecoration(
            gradient: gradientFor(seed), borderRadius: BorderRadius.circular(radius)),
        child: Icon(icon, color: Colors.white70, size: (h ?? (w.isFinite ? w : 80)) * .4),
      );
}

class PosterCard extends StatelessWidget {
  final String text;
  final int seed;
  final double w, h;
  const PosterCard(this.text, this.seed, {super.key, this.w = 116, this.h = 124});

  @override
  Widget build(BuildContext context) => Container(
        width: w,
        height: h,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(10),
        alignment: Alignment.bottomLeft,
        decoration:
            BoxDecoration(gradient: gradientFor(seed), borderRadius: BorderRadius.circular(12)),
        child: Text(text,
            style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
      );
}

class CircleBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final double size;
  final bool primary;
  const CircleBtn(this.icon, {super.key, this.onTap, this.size = 40, this.primary = false});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: primary ? null : AppColors.grey,
            gradient: primary
                ? const LinearGradient(colors: [Color(0xFFFF5A7E), AppColors.pink])
                : null,
            boxShadow: primary
                ? const [BoxShadow(color: Color(0x59FF2D6F), blurRadius: 14, offset: Offset(0, 6))]
                : null,
          ),
          child: Icon(icon, size: size * .5, color: primary ? Colors.white : AppColors.dark),
        ),
      );
}

class PlayOutline extends StatelessWidget {
  final VoidCallback? onTap;
  const PlayOutline({super.key, this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
              shape: BoxShape.circle, border: Border.all(color: const Color(0xFFFFD0DC))),
          child: const Icon(Icons.play_arrow_outlined, size: 18, color: AppColors.pink),
        ),
      );
}

class SongTile extends StatelessWidget {
  final Song s;
  final VoidCallback? onTap;
  final Widget? trailing;
  final double art;
  final double? artH;
  final bool showMeta;
  const SongTile(this.s,
      {super.key, this.onTap, this.trailing, this.art = 48, this.artH, this.showMeta = true});

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(children: [
            CoverArt(s.seed, w: art, h: artH),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(s.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                const SizedBox(height: 3),
                Text(s.artists,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 10, color: AppColors.hint)),
                if (showMeta && s.meta.isNotEmpty)
                  Text(s.meta,
                      style: const TextStyle(fontSize: 10, color: AppColors.hint)),
              ]),
            ),
            const SizedBox(width: 8),
            trailing ?? PlayOutline(onTap: onTap),
          ]),
        ),
      );
}

class SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onViewAll;
  const SectionHeader(this.title, this.icon, {super.key, this.onViewAll});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(0, 18, 0, 10),
        child: Row(children: [
          Icon(icon, size: 16, color: AppColors.dark),
          const SizedBox(width: 8),
          Expanded(
              child: Text(title,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600))),
          if (onViewAll != null)
            GestureDetector(
                onTap: onViewAll,
                child: const Text('View All',
                    style: TextStyle(fontSize: 10, color: AppColors.hint))),
        ]),
      );
}

class HList extends StatelessWidget {
  final double height;
  final List<Widget> children;
  const HList(this.height, this.children, {super.key});
  @override
  Widget build(BuildContext context) => SizedBox(
      height: height,
      child: ListView(scrollDirection: Axis.horizontal, children: children));
}

class TopBar extends StatelessWidget {
  final List<Widget> actions;
  const TopBar(this.actions, {super.key});

  @override
  Widget build(BuildContext context) => Row(children: [
        CircleBtn(Icons.chevron_left, onTap: () => Navigator.maybePop(context)),
        const Spacer(),
        for (final a in actions) Padding(padding: const EdgeInsets.only(left: 10), child: a),
      ]);
}

class UnderlineTabs extends StatelessWidget {
  final List<String> labels;
  final List<IconData> icons;
  final int index;
  final ValueChanged<int> onChanged;
  const UnderlineTabs(this.labels, this.icons, this.index, this.onChanged, {super.key});

  @override
  Widget build(BuildContext context) => Row(
        children: List.generate(labels.length, (i) {
          final sel = i == index;
          return Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onChanged(i),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: sel ? AppColors.pink : AppColors.grey, width: sel ? 2 : 1))),
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(icons[i], size: 16, color: sel ? AppColors.pink : AppColors.hint),
                  const SizedBox(width: 6),
                  Text(labels[i],
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                ]),
              ),
            ),
          );
        }),
      );
}

class PillChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback? onTap;
  const PillChip(this.label, this.icon, {super.key, this.selected = false, this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(right: 10),
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFFFFF1F5) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: selected ? AppColors.pink : const Color(0xFFE6E6E6)),
          ),
          child: Row(children: [
            Icon(icon, size: 16, color: selected ? AppColors.pink : AppColors.hint),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
          ]),
        ),
      );
}

class ArtistAvatar extends StatelessWidget {
  final int seed;
  final String name;
  final double size;
  const ArtistAvatar(this.seed, this.name, {super.key, this.size = 76});

  @override
  Widget build(BuildContext context) => SizedBox(
        width: size + 10,
        child: Column(children: [
          ClipOval(child: CoverArt(seed, w: size, icon: Icons.person)),
          const SizedBox(height: 6),
          Text(name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w500)),
        ]),
      );
}

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => Navigator.pushNamed(context, Routes.player),
        child: Container(
          margin: const EdgeInsets.fromLTRB(12, 0, 12, 6),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [BoxShadow(color: Color(0x1A000000), blurRadius: 14)],
          ),
          child: Row(children: [
            const ClipOval(child: CoverArt(2, w: 44, icon: Icons.person)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Saul Mate - By...',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: const LinearProgressIndicator(
                      value: .25,
                      minHeight: 4,
                      color: AppColors.pink,
                      backgroundColor: AppColors.grey),
                ),
              ]),
            ),
            const SizedBox(width: 10),
            const CircleBtn(Icons.skip_next_outlined, size: 38),
            const SizedBox(width: 8),
            const CircleBtn(Icons.play_arrow, size: 40, primary: true),
          ]),
        ),
      );
}

/// Progress slider + shuffle / prev / play / next / queue buttons.
class PlayerControls extends StatefulWidget {
  final ValueChanged<bool>? onPlayChanged;
  const PlayerControls({super.key, this.onPlayChanged});
  @override
  State<PlayerControls> createState() => _PlayerControlsState();
}

class _PlayerControlsState extends State<PlayerControls> {
  double _pos = 92; // seconds
  bool _playing = true;
  static const _total = 312.0;

  String _fmt(double s) =>
      '${(s ~/ 60).toString().padLeft(2, '0')}:${(s.toInt() % 60).toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) => Column(children: [
        Slider(
          value: _pos,
          max: _total,
          activeColor: AppColors.pink,
          inactiveColor: AppColors.grey,
          onChanged: (v) => setState(() => _pos = v),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(_fmt(_pos), style: const TextStyle(fontSize: 10)),
            Text(_fmt(_total), style: const TextStyle(fontSize: 10)),
          ]),
        ),
        const SizedBox(height: 14),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const CircleBtn(Icons.shuffle),
          const CircleBtn(Icons.skip_previous_outlined),
          CircleBtn(_playing ? Icons.pause : Icons.play_arrow,
              size: 64,
              primary: true,
              onTap: () {
                setState(() => _playing = !_playing);
                widget.onPlayChanged?.call(_playing);
              }),
          const CircleBtn(Icons.skip_next_outlined),
          const CircleBtn(Icons.queue_music),
        ]),
      ]);
}
