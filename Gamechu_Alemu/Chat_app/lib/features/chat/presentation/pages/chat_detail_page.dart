import 'package:flutter/material.dart';
class ChatDetailPage extends StatefulWidget {
  final String userName;

  const ChatDetailPage({super.key, required this.userName});

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}


class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scroll = ScrollController();

  final List<Map<String, dynamic>> messages = [
    {
      "sender": "Annel Ellison",
      "avatar": "assets/user1.png", 
      "content": "Have a great working week!!",
      "isMe": false,
      "time": "09:25 AM",
      "type": "text"
    },
    {
      "sender": "Annel Ellison",
      "avatar": "assets/user2.png",
      "content": "This is my new 3d design",
      "isMe": false,
      "time": "09:25 AM",
      "type": "text"
    },
    {
      "sender": "Annel Ellison",
      "avatar": "assets/user2.png",
      "content": "https://picsum.photos/200",
      "isMe": false,
      "time": "09:25 AM",
      "type": "image"
    },
    {
      "sender": "Me",
      "avatar": "assets/user2.png",
      "content": "You did your job well",
      "isMe": true,
      "time": "09:25 AM",
      "type": "text"
    },
    {
      "sender": "Annel Ellison",
      "avatar": "assets/user2.png",
      "content": "audio_sample.mp3",
      "isMe": false,
      "time": "09:25 AM",
      "duration": "00:16",
      "type": "voice"
    },
    {
      "sender": "Me",
      "avatar": "assets/user2.png",
      "content": "You did your job well",
      "isMe": true,
      "time": "09:25 AM",
      "type": "text"
    },
  ];

  Color get outgoingColor => const Color(0xFF4B4FFD);
  Color get incomingColor => const Color(0xFFF0F2FF);
  Color get bgColor => const Color(0xFFF8F9FB);

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      messages.add({
        "sender": "Me",
        "avatar": "assets/user1.png",
        "content": text,
        "isMe": true,
        "time": "09:26 AM",
        "type": "text"
      });
    });
    _controller.clear();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(
          _scroll.position.maxScrollExtent + 80,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("assets/user1.png"), 
              radius: 18,
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Sabila Sayma", style: TextStyle(color: Colors.black)),
                Text(
                  "8 members, 5 online",
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                )
              ],
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: const [
          Icon(Icons.call, color: Colors.black),
          SizedBox(width: 12),
          Icon(Icons.videocam, color: Colors.black),
          SizedBox(width: 12),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scroll,
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final m = messages[index];
                return _MessageBubble(
                  sender: m["sender"] ?? "",
                  avatar: m["avatar"] ?? "assets/user1.png",
                  message: m["content"] ?? "",
                  isMe: m["isMe"] ?? false,
                  type: m["type"] ?? "text",
                  time: m["time"] ?? "",
                  duration: m["duration"] ?? "",
                  outgoingColor: outgoingColor,
                  incomingColor: incomingColor,
                );
              },
            ),
          ),
          _InputBar(
            controller: _controller,
            onSend: _send,
            primaryColor: outgoingColor,
          )
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final String sender;
  final String avatar;
  final String message;
  final bool isMe;
  final String type;
  final String time;
  final String duration;
  final Color outgoingColor;
  final Color incomingColor;

  const _MessageBubble({
    required this.sender,
    required this.avatar,
    required this.message,
    required this.isMe,
    required this.type,
    required this.time,
    required this.duration,
    required this.outgoingColor,
    required this.incomingColor,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.only(
      topLeft: const Radius.circular(18),
      topRight: const Radius.circular(18),
      bottomLeft: Radius.circular(isMe ? 18 : 4),
      bottomRight: Radius.circular(isMe ? 4 : 18),
    );

    Widget content;
    if (type == 'image') {
      content = ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          message,
          width: 220,
          fit: BoxFit.cover,
        ),
      );
    } else if (type == 'voice') {
      content = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.play_arrow, color: Colors.white),
          const SizedBox(width: 8),
          Container(
            width: 80,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(duration, style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      );
    } else {
      content = Text(
        message,
        style: TextStyle(
          color: isMe ? Colors.white : Colors.black87,
          fontSize: 14,
        ),
      );
    }

    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        if (!isMe) ...[
          Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(avatar),
                radius: 16,
              ),
              const SizedBox(width: 8),
              Text(sender, style: const TextStyle(fontSize: 13, color: Colors.black54)),
            ],
          ),
          const SizedBox(height: 4),
        ],
        Container(
          margin: EdgeInsets.only(
            bottom: 4,
            left: isMe ? 60 : 0,
            right: isMe ? 0 : 60,
          ),
          padding: type == 'image'
              ? EdgeInsets.zero
              : const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: type == 'image'
                ? Colors.transparent
                : isMe
                    ? outgoingColor
                    : incomingColor,
            borderRadius: radius,
          ),
          child: content,
        ),
        Padding(
          padding: EdgeInsets.only(
            left: isMe ? 0 : 40,
            right: isMe ? 0 : 40,
          ),
          child: Text(
            time,
            style: TextStyle(fontSize: 11, color: Colors.grey[600]),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _InputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final Color primaryColor;
  const _InputBar({
    required this.controller,
    required this.onSend,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 6,
              offset: Offset(0, -2),
              color: Color(0x11000000),
            ),
          ],
        ),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.attach_file, color: Colors.grey),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.camera_alt, color: Colors.grey),
              onPressed: () {},
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F3F7),
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: controller,
                  minLines: 1,
                  maxLines: 4,
                  textInputAction: TextInputAction.newline,
                  decoration: const InputDecoration(
                    hintText: 'Write your message',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: onSend,
              child: CircleAvatar(
                backgroundColor: primaryColor,
                radius: 20,
                child: const Icon(Icons.mic, color: Colors.white, size: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
}
