import 'package:flutter/material.dart';
import 'package:Chat_app/features/chat/presentation/pages/chat_detail_page.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final chats = List.generate(
      8,
      (i) => {
        "name": "User $i",
        "lastMessage": "This is a sample message from User $i",
        "time": "2 min ago",
        "unread": i % 3 == 0,
        "avatar": "assets/user${(i % 3) + 1}.png",
      },
    );

    return Scaffold(
      backgroundColor: const Color(0xFF4A90E2),
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          onRefresh: () async {},
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              const SizedBox(height: 12),
              const _Header(),
              const SizedBox(height: 12),
              _StatusStrip(
                chats: chats
                    .map((c) => {
                          "name": c["name"] as String,
                          "avatar": c["avatar"] as String
                        })
                    .toList(),
              ),
              const SizedBox(height: 12),
              _ChatContainer(
                child: chats.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 48.0),
                        child: Center(child: Text('No chats yet')),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.only(top: 8, bottom: 32),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: chats.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 4),
                        itemBuilder: (context, index) {
                          final chat = chats[index];
                          return _ChatRow(
                            name: chat["name"] as String,
                            lastMessage: chat["lastMessage"] as String,
                            time: chat["time"] as String,
                            unread: chat["unread"] as bool,
                            avatar: chat["avatar"] as String,
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xFFE8EEF5),
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: const [
                  Icon(Icons.search, color: Colors.black54),
                  SizedBox(width: 8),
                  Text('Search', style: TextStyle(color: Colors.black54)),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          const CircleAvatar(
            radius: 22,
            backgroundImage: AssetImage("assets/me.png"),
          ),
        ],
      ),
    );
  }
}

class _StatusStrip extends StatelessWidget {
  final List<Map<String, String>> chats;
  const _StatusStrip({required this.chats});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: chats.length.clamp(0, 10) + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _StatusAvatar(
              label: 'My status',
              isMine: true,
              avatar: "assets/me.png",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ChatDetailPage(userName:'user'),
                  ),
                );
              },
            );
          }
          final chat = chats[index - 1];
          return _StatusAvatar(
            label: chat["name"]!,
            avatar: chat["avatar"]!,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChatDetailPage(userName: chat["name"]!),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _StatusAvatar extends StatelessWidget {
  final String label;
  final bool isMine;
  final String avatar;
  final VoidCallback? onTap;

  const _StatusAvatar({
    required this.label,
    required this.avatar,
    this.isMine = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundImage: AssetImage(avatar),
                ),
                if (isMine)
                  Positioned(
                    bottom: -2,
                    right: -2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(2),
                      child: const CircleAvatar(
                        radius: 10,
                        backgroundColor: Color(0xFF1C59D2),
                        child: Icon(Icons.add, size: 14, color: Colors.white),
                      ),
                    ),
                  )
              ],
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: 60,
            child: Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatContainer extends StatelessWidget {
  final Widget child;
  const _ChatContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      child: child,
    );
  }
}

class _ChatRow extends StatelessWidget {
  final String name;
  final String lastMessage;
  final String time;
  final bool unread;
  final String avatar;

  const _ChatRow({
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.unread,
    required this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChatDetailPage(userName: name),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatDetailPage(userName: name),
                  ),
                );
              },
              child: CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage(avatar),
                backgroundColor: Colors.grey[300],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        time,
                        style: const TextStyle(
                            fontSize: 11, color: Colors.black54),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          lastMessage,
                          style: const TextStyle(
                              fontSize: 12, color: Colors.black87),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (unread) ...[
                        const SizedBox(width: 8),
                        Container(
                          width: 16,
                          height: 16,
                          decoration: const BoxDecoration(
                            color: Color(0xFF1C59D2),
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: const Text('1',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 10)),
                        )
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
