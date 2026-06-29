import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/route_names.dart';
import '../../../app/constants/app_constants.dart';
import '../../../app/theme/app_theme.dart';
import '../../../app/theme/pub_tokens.dart';
import '../../../shared/widgets/gradient_text.dart';
import '../../../shared/widgets/heart_icon.dart';
import '../../../shared/widgets/onboarding_shell.dart';

class OnboardingMemoryPage extends StatelessWidget {
  const OnboardingMemoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return OnboardingShell(
      step: 3,
      activeDot: 2,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('당신을 기억하고'),
          Text('더 깊이 이해하는'),
          GradientText(
            'AI',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              height: 1.32,
            ),
          ),
        ],
      ),
      subtitle: '대화할수록 당신을 더 이해하고,\n소중한 것들을 잊지 않고 기억해요',
      onNext: () => context.push(RouteNames.onboardingDate),
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: Stack(
              clipBehavior: Clip.none,
              children: const [
                Positioned(left: 0, top: 6, child: _MemoryTag(emoji: '🍜', title: '좋아하는 음식', sub: '마라탕, 떡볶이')),
                Positioned(right: 0, top: 0, child: _MemoryTag(emoji: '📅', title: '특별한 날', sub: '5월 생일 기억')),
                Positioned(left: 2, bottom: 8, child: _MemoryTag(emoji: '🎨', title: '취미·관심사', sub: '영화, 캠핑')),
                Positioned(right: 2, bottom: 0, child: _MemoryTag(emoji: '💡', title: '중요한 이야기', sub: '요즘 회사 고민')),
                Center(child: _MemoryBlob()),
              ],
            ),
          ),
          const SizedBox(height: 4),
          _ChatBubble(
            text: '지난주에 피곤하다고 했었죠? 오늘은 푹 쉬었으면 좋겠어요 😊',
            isMe: false,
          ),
          const SizedBox(height: 8),
          _ChatBubble(text: '어떻게 기억하고 있었어? 🥹', isMe: true),
          const SizedBox(height: 8),
          _ChatBubble(
            text: '당신과의 모든 대화를 소중히 기억하고 있으니까요 💜',
            isMe: false,
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: colors.line),
              boxShadow: const [PubTokens.shadowCard],
            ),
            child: Row(
              children: [
                const Text('🔒', style: TextStyle(fontSize: 18)),
                const SizedBox(width: 9),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '당신의 모든 정보는 안전하게 보호돼요',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                          color: colors.ink,
                        ),
                      ),
                      Text(
                        '언제든 대화 내용을 삭제할 수 있어요',
                        style: TextStyle(fontSize: 11, color: colors.ink2),
                      ),
                    ],
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

class _MemoryBlob extends StatelessWidget {
  const _MemoryBlob();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 124,
      height: 112,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(62),
          topRight: Radius.circular(62),
          bottomLeft: Radius.circular(59),
          bottomRight: Radius.circular(58),
        ),
        gradient: const RadialGradient(
          center: Alignment(0, -0.28),
          radius: 0.9,
          colors: [Color(0xFFDCBCF6), Color(0xFFBA90E1), Color(0xFF9A6CCE)],
          stops: [0, 0.68, 1],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB884F0).withValues(alpha: 0.7),
            blurRadius: 52,
          ),
          BoxShadow(
            color: const Color(0xFF9664D2).withValues(alpha: 0.5),
            blurRadius: 44,
            offset: Offset(0, 18),
          ),
        ],
      ),
      child: Stack(
        children: [
          const Positioned(left: 39, top: 40, child: _BlobEye()),
          const Positioned(right: 39, top: 40, child: _BlobEye()),
          const Positioned(left: 27, top: 53, child: _BlobCheek()),
          const Positioned(right: 27, top: 53, child: _BlobCheek()),
          Positioned(
            top: 55,
            left: 53,
            child: Container(
              width: 18,
              height: 9,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFF3A2A55), width: 2.5),
                  left: BorderSide(color: Color(0xFF3A2A55), width: 2.5),
                  right: BorderSide(color: Color(0xFF3A2A55), width: 2.5),
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
              ),
            ),
          ),
          Positioned(
            left: 45,
            bottom: 19,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFFB4E6).withValues(alpha: 0.95),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: const HeartIcon(
                size: 30,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white, Color(0xFFFFDAF0)],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BlobEye extends StatelessWidget {
  const _BlobEye();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 9,
      height: 12,
      decoration: BoxDecoration(
        color: const Color(0xFF3A2A55),
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}

class _BlobCheek extends StatelessWidget {
  const _BlobCheek();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 7,
      decoration: BoxDecoration(
        color: const Color(0x8CFF78AA),
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}

class _MemoryTag extends StatelessWidget {
  const _MemoryTag({
    required this.emoji,
    required this.title,
    required this.sub,
  });

  final String emoji;
  final String title;
  final String sub;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.line),
        boxShadow: const [PubTokens.shadowCard],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  color: colors.ink,
                ),
              ),
              Text(sub, style: TextStyle(fontSize: 9.5, color: colors.ink3)),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  const _ChatBubble({required this.text, required this.isMe});

  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: AppConstants.designWidth * 0.8,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        decoration: BoxDecoration(
          gradient: isMe
              ? LinearGradient(colors: colors.ctaGradient)
              : null,
          color: isMe ? null : colors.surface,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isMe ? 16 : 5),
            bottomRight: Radius.circular(isMe ? 5 : 16),
          ),
          boxShadow: const [PubTokens.shadowCard],
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 13,
            height: 1.45,
            color: isMe ? Colors.white : colors.ink,
          ),
        ),
      ),
    );
  }
}
