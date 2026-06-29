import 'package:flutter/material.dart';

import '../../../app/constants/app_constants.dart';
import '../../../app/theme/app_theme.dart';
import '../../../app/theme/pub_tokens.dart';
import '../../../shared/widgets/pub_photo.dart';

class WizardTip extends StatelessWidget {
  const WizardTip({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isDark
              ? colors.brand.withValues(alpha: 0.15)
              : PubTokens.purple100Light,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 10.5,
            fontWeight: FontWeight.w700,
            color: PubTokens.purple600,
          ),
        ),
      ),
    );
  }
}

class WizardQuestionHeader extends StatelessWidget {
  const WizardQuestionHeader({
    super.key,
    required this.step,
    required this.title,
    required this.subtitle,
  });

  final int step;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'STEP $step / 7',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: PubTokens.purple400,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            height: 1.32,
            letterSpacing: -0.3,
            color: colors.ink,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(fontSize: 12.5, height: 1.5, color: colors.ink2),
        ),
      ],
    );
  }
}

class WizardOptionTile extends StatelessWidget {
  const WizardOptionTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.selected,
    required this.onTap,
    this.imageHeight = 58,
    this.compact = false,
    this.imageTint,
  });

  final String title;
  final String? subtitle;
  final bool selected;
  final VoidCallback onTap;
  final double imageHeight;
  final bool compact;
  final Color? imageTint;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.all(compact ? 6 : 8),
            decoration: BoxDecoration(
              color: selected ? PubTokens.purple50(context) : colors.surface,
              border: Border.all(
                color: selected ? PubTokens.purple400 : colors.line,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(14),
              boxShadow: selected
                  ? [
                      BoxShadow(
                        color: colors.brand.withValues(alpha: 0.25),
                        blurRadius: 20,
                      ),
                    ]
                  : const [PubTokens.shadowCard],
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: PubPhoto(
                    variant: PubPhotoVariant.body,
                    height: imageHeight,
                    width: double.infinity,
                    overlay: imageTint?.withValues(alpha: 0.38),
                  ),
                ),
                SizedBox(height: compact ? 4 : 6),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: compact ? 11 : 12.5,
                    fontWeight: FontWeight.w800,
                    color: colors.ink,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10, color: colors.ink3),
                  ),
                ],
              ],
            ),
          ),
          if (selected)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: colors.ctaGradient),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Text(
                  '✓',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class WizardPreviewImage extends StatelessWidget {
  const WizardPreviewImage({
    super.key,
    this.aspectRatio = 3 / 4,
    this.tint,
  });

  final double aspectRatio;
  final Color? tint;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: PubPhoto(
          variant: PubPhotoVariant.body,
          overlay: tint?.withValues(alpha: 0.32),
        ),
      ),
    );
  }
}

class WizardPreviewCard extends StatelessWidget {
  const WizardPreviewCard({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.line),
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [PubTokens.shadowCard],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
              color: colors.ink,
            ),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}

class WizardFeatureRow extends StatelessWidget {
  const WizardFeatureRow(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: PubTokens.purple300,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 7),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 11, color: colors.ink2),
            ),
          ),
        ],
      ),
    );
  }
}

class WizardSplitBody extends StatelessWidget {
  const WizardSplitBody({
    super.key,
    required this.options,
    required this.preview,
    this.optionsFlex = 54,
    this.previewFlex = 44,
  });

  final Widget options;
  final Widget preview;
  final int optionsFlex;
  final int previewFlex;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: optionsFlex, child: options),
        const SizedBox(width: 12),
        Expanded(flex: previewFlex, child: preview),
      ],
    );
  }
}

class WizardCategoryChips extends StatefulWidget {
  const WizardCategoryChips({super.key, required this.labels});

  final List<String> labels;

  @override
  State<WizardCategoryChips> createState() => _WizardCategoryChipsState();
}

class _WizardCategoryChipsState extends State<WizardCategoryChips> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Row(
      children: List.generate(widget.labels.length, (i) {
        final on = i == _selected;
        return Padding(
          padding: EdgeInsets.only(right: i < widget.labels.length - 1 ? 7 : 0),
          child: GestureDetector(
            onTap: () => setState(() => _selected = i),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 6),
              decoration: BoxDecoration(
                gradient: on ? LinearGradient(colors: colors.ctaGradient) : null,
                color: on ? null : colors.surface,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: on ? Colors.transparent : colors.line),
              ),
              child: Text(
                widget.labels[i],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: on ? Colors.white : colors.ink2,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class WizardPersonalitySlider extends StatelessWidget {
  const WizardPersonalitySlider({
    super.key,
    required this.leftLabel,
    required this.rightLabel,
    required this.value,
    required this.onChanged,
  });

  final String leftLabel;
  final String rightLabel;
  final double value;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final pct = (value * 100).round();

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.fromLTRB(14, 13, 14, 13),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.line),
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [PubTokens.shadowCard],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(leftLabel, style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: colors.ink3)),
              const Spacer(),
              Text(
                '$pct%',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: PubTokens.purple400,
                ),
              ),
              const Spacer(),
              Text(
                rightLabel,
                style: const TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  color: PubTokens.purple600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 7,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
              overlayShape: SliderComponentShape.noOverlay,
            ),
            child: Slider(
              value: value,
              onChanged: onChanged,
              activeColor: PubTokens.purple400,
              inactiveColor: PubTokens.purple100Light,
            ),
          ),
        ],
      ),
    );
  }
}

class WizardVoiceOption extends StatelessWidget {
  const WizardVoiceOption({
    super.key,
    required this.title,
    required this.subtitle,
    this.tag,
    required this.selected,
    required this.onTap,
    this.isCustom = false,
  });

  final String title;
  final String subtitle;
  final String? tag;
  final bool selected;
  final VoidCallback onTap;
  final bool isCustom;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? PubTokens.purple50(context) : colors.surface,
          border: Border.all(
            color: selected ? PubTokens.purple400 : colors.line,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(13),
          boxShadow: const [PubTokens.shadowCard],
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                gradient: isCustom ? null : LinearGradient(colors: colors.ctaGradient),
                color: isCustom ? colors.brand.withValues(alpha: 0.12) : null,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                isCustom ? '＋' : '▶',
                style: TextStyle(
                  color: isCustom ? colors.brand : Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w800,
                            color: colors.ink,
                          ),
                        ),
                      ),
                      if (tag != null) ...[
                        const SizedBox(width: 5),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1),
                          decoration: BoxDecoration(
                            color: colors.brand.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            tag!,
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                              color: colors.brand,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  Text(subtitle, style: TextStyle(fontSize: 10, color: colors.ink3)),
                ],
              ),
            ),
            if (selected)
              Text('✓', style: TextStyle(color: colors.brand, fontWeight: FontWeight.w900)),
          ],
        ),
      ),
    );
  }
}

class WizardSummaryRow extends StatelessWidget {
  const WizardSummaryRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.onEdit,
  });

  final String icon;
  final String label;
  final String value;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      margin: const EdgeInsets.only(bottom: 7),
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 9),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.line),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [PubTokens.shadowCard],
      ),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: colors.brand.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(icon, style: const TextStyle(fontSize: 14)),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(fontSize: 10.5, color: colors.ink3)),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    color: colors.ink,
                  ),
                ),
              ],
            ),
          ),
          if (onEdit != null)
            GestureDetector(
              onTap: onEdit,
              child: Text(
                '수정',
                style: TextStyle(fontSize: 11, color: colors.brand2),
              ),
            ),
        ],
      ),
    );
  }
}

double wizardListWidth(BuildContext context) =>
    AppConstants.designWidth * 0.6;
