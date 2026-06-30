import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/route_names.dart';
import '../../../shared/widgets/pub_photo.dart';
import '../../../app/theme/app_theme.dart';
import '../../../app/theme/pub_tokens.dart';
import '../../../shared/widgets/design_status_bar.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  bool _isPartnerTyping = false;
  int _replyIndex = 0;

  static const _partnerReplies = [
    '응, 나도 그렇게 생각했어 💜',
    '좋아! 그때 연락할게 😊',
    '지연아, 오늘 하루도 힘내!',
    '나도 보고 싶었어 🥰',
    '완전 좋아! 기대된다 ✨',
  ];

  static const _quickReplies = [
    '너무 기대돼 💜',
    '나도 보고 싶어',
    '오늘도 힘내',
    '좋은 하루 보내',
  ];

  final List<_ChatMessage> _messages = [
    const _ChatMessage(isMe: false, text: '안녕, 지연아 ☀️\n좋은 아침이야!', time: '09:12'),
    const _ChatMessage(isMe: true, text: '민준아 좋은 아침 😊\n오늘 뭐 할까?', time: '09:13'),
    const _ChatMessage(
      isMe: false,
      text: '날씨가 너무 좋아서 메가커피 그란데 들고\n한강 산책 어때? 🌿',
      time: '09:14',
    ),
    const _ChatMessage(isMe: true, text: '완전 좋아 💜\n오후 3시쯤 어때?', time: '09:15'),
    const _ChatMessage(
      isMe: false,
      text: '좋아 좋아! 그때 봐 🥰\n미리 자리 맡아둘게',
      time: '09:16',
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOut,
      );
    });
  }

  void _sendMessage([String? text]) {
    final body = (text ?? _controller.text).trim();
    if (body.isEmpty || _isPartnerTyping) return;

    final now = TimeOfDay.now();
    final time =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

    setState(() {
      _messages.add(_ChatMessage(isMe: true, text: body, time: time));
      _controller.clear();
    });
    _scrollToBottom();
    _schedulePartnerReply();
  }

  Future<void> _schedulePartnerReply() async {
    await Future<void>.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;

    setState(() => _isPartnerTyping = true);
    _scrollToBottom();

    await Future<void>.delayed(const Duration(milliseconds: 1400));
    if (!mounted) return;

    final now = TimeOfDay.now();
    final time =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
    final reply = _partnerReplies[_replyIndex % _partnerReplies.length];
    _replyIndex++;

    setState(() {
      _isPartnerTyping = false;
      _messages.add(_ChatMessage(isMe: false, text: reply, time: time));
    });
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Scaffold(
      backgroundColor: PubTokens.chatBg,
      body: Column(
        children: [
          const DesignStatusBar(),
          _ChatHeader(
            colors: colors,
            onCall: () => context.push(RouteNames.voiceCall),
            onVideo: () => context.push(RouteNames.modelViewer),
          ),
          Expanded(
            child: ListView(
              controller: _scrollController,
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: colors.brand.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      '오늘 5월 18일 토요일',
                      style: TextStyle(fontSize: 11, color: colors.ink3),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ..._messages.map((m) => _MessageBubble(message: m, colors: colors)),
                if (_isPartnerTyping) ...[
                  const SizedBox(height: 8),
                  _TypingBubble(colors: colors),
                ],
                const SizedBox(height: 12),
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: PubTokens.heartGradient,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  child: const Text('🧸', style: TextStyle(fontSize: 40)),
                ),
              ],
            ),
          ),
          _WarmthStrip(
            colors: colors,
            onCharge: () => context.push(RouteNames.warmthShop),
          ),
          SizedBox(
            height: 44,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
              itemCount: _quickReplies.length,
              separatorBuilder: (_, index) => const SizedBox(width: 7),
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: () => _sendMessage(_quickReplies[i]),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
                    decoration: BoxDecoration(
                      color: colors.surface,
                      border: Border.all(color: PubTokens.purple100Light),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      _quickReplies[i],
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: PubTokens.purple600,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          _InputBar(
            colors: colors,
            controller: _controller,
            onSend: () => _sendMessage(),
            onVoice: () => context.push(RouteNames.voiceCall),
          ),
        ],
      ),
    );
  }
}

class _ChatMessage {
  const _ChatMessage({
    required this.isMe,
    required this.text,
    required this.time,
  });

  final bool isMe;
  final String text;
  final String time;
}

class _TypingBubble extends StatelessWidget {
  const _TypingBubble({required this.colors});

  final AppColorTokens colors;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(16),
            bottomLeft: Radius.circular(4),
          ),
          border: Border.all(color: colors.line),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _Dot(delay: 0, color: colors.ink3),
            const SizedBox(width: 4),
            _Dot(delay: 150, color: colors.ink3),
            const SizedBox(width: 4),
            _Dot(delay: 300, color: colors.ink3),
          ],
        ),
      ),
    );
  }
}

class _Dot extends StatefulWidget {
  const _Dot({required this.delay, required this.color});

  final int delay;
  final Color color;

  @override
  State<_Dot> createState() => _DotState();
}

class _DotState extends State<_Dot> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    Future<void>.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _controller.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween(begin: 0.35, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
      ),
      child: Container(
        width: 6,
        height: 6,
        decoration: BoxDecoration(
          color: widget.color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class _ChatHeader extends StatelessWidget {
  const _ChatHeader({
    required this.colors,
    required this.onCall,
    required this.onVideo,
  });

  final AppColorTokens colors;
  final VoidCallback onCall;
  final VoidCallback onVideo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 2, 16, 12),
      decoration: BoxDecoration(
        color: colors.surface,
        boxShadow: [
          BoxShadow(
            color: colors.brand.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.go(RouteNames.home),
            child: Text(
              '‹',
              style: TextStyle(fontSize: 22, color: colors.ink2, height: 1),
            ),
          ),
          const SizedBox(width: 8),
          ClipOval(
            child: PubPhoto(
              variant: PubPhotoVariant.night,
              width: 40,
              height: 40,
            ),
          ),
          const SizedBox(width: 11),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '민준 💜',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: colors.ink,
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Color(0xFF37C871),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '온라인 중',
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF37C871),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: onCall,
            child: Icon(Icons.phone_outlined, color: PubTokens.purple600, size: 22),
          ),
          const SizedBox(width: 14),
          GestureDetector(
            onTap: onVideo,
            child: Icon(Icons.view_in_ar_outlined, color: PubTokens.purple600, size: 22),
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message, required this.colors});

  final _ChatMessage message;
  final AppColorTokens colors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment:
            message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!message.isMe) ...[
            ClipOval(
              child: PubPhoto(
                variant: PubPhotoVariant.night,
                width: 30,
                height: 30,
              ),
            ),
            const SizedBox(width: 8),
          ],
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.sizeOf(context).width * 0.82,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
              decoration: BoxDecoration(
                gradient: message.isMe
                    ? LinearGradient(colors: colors.ctaGradient)
                    : null,
                color: message.isMe ? null : colors.surface,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(message.isMe ? 16 : 5),
                  bottomRight: Radius.circular(message.isMe ? 5 : 16),
                ),
                boxShadow: message.isMe
                    ? null
                    : const [PubTokens.shadowCard],
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.45,
                  color: message.isMe ? Colors.white : colors.ink,
                ),
              ),
            ),
          ),
          const SizedBox(width: 3),
          Text(
            message.time,
            style: TextStyle(fontSize: 9, color: colors.ink3),
          ),
        ],
      ),
    );
  }
}

class _WarmthStrip extends StatelessWidget {
  const _WarmthStrip({required this.colors, required this.onCharge});

  final AppColorTokens colors;
  final VoidCallback onCharge;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.62),
        border: Border(top: BorderSide(color: colors.line)),
      ),
      child: Row(
        children: [
          const Text('🔥', style: TextStyle(fontSize: 14)),
          const SizedBox(width: 7),
          Text(
            '온기 540',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
              color: colors.ink,
            ),
          ),
          Text(
            ' · 메시지당 🔥10 소비',
            style: TextStyle(fontSize: 10.5, color: colors.ink3),
          ),
          const Spacer(),
          GestureDetector(
            onTap: onCharge,
            child: const Text(
              '충전 ›',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: PubTokens.purple600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InputBar extends StatelessWidget {
  const _InputBar({
    required this.colors,
    required this.controller,
    required this.onSend,
    required this.onVoice,
  });

  final AppColorTokens colors;
  final TextEditingController controller;
  final VoidCallback onSend;
  final VoidCallback onVoice;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 8, 14, 16),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: PubTokens.purple100Light,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Text(
              '＋',
              style: TextStyle(fontSize: 20, color: PubTokens.purple600),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(999),
                boxShadow: const [PubTokens.shadowCard],
              ),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      style: TextStyle(fontSize: 13, color: colors.ink),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        hintText: '메시지를 입력하세요…',
                        hintStyle: TextStyle(fontSize: 13, color: colors.ink3),
                      ),
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => onSend(),
                    ),
                  ),
                  const Text('😊', style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: onVoice,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: colors.ctaGradient),
                shape: BoxShape.circle,
                boxShadow: const [PubTokens.shadowCta],
              ),
              alignment: Alignment.center,
              child: const Text('🎤', style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}
