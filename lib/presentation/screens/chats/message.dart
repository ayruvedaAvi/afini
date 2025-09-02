import 'package:flutter/material.dart';
import 'dart:ui';

import 'chats_screen.dart';

class Message extends StatelessWidget {
  const Message({
    super.key,
    required this.message,
  });

  final DummyChatModel message;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    return Align(
      alignment: message.isSelf ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (!message.isSelf)
              ClipPath(
                clipper: HeartClipper(),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(message.avatarUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            const SizedBox(width: 8),
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
                bottomLeft: Radius.circular(message.isSelf ? 16 : 0),
                bottomRight: Radius.circular(message.isSelf ? 0 : 16),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: message.isSelf
                          ? [
                              primaryColor.withAlpha(150),
                              primaryColor.withAlpha(50),
                            ]
                          : [
                              Colors.grey[700]!.withAlpha(100),
                              Colors.grey[700]!.withAlpha(80),
                            ],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.message,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        message.time,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .fontSize! -
                                  2,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (message.isSelf) const SizedBox(width: 8),
            if (message.isSelf)
              ClipPath(
                clipper: HeartClipper(),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(message.avatarUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class HeartClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final width = size.width;
    final height = size.height;

    // Start from the bottom center point
    path.moveTo(width * 0.5, height * 0.9);

    // Left side of the heart
    path.cubicTo(
      width * 0.2,
      height * 0.6,
      width * 0.1,
      height * 0.45,
      width * 0.1,
      height * 0.35,
    );

    // Left curve
    path.cubicTo(
      width * 0.1,
      height * 0.2,
      width * 0.25,
      height * 0.1,
      width * 0.4,
      height * 0.15,
    );

    // Center dip
    path.cubicTo(
      width * 0.45,
      height * 0.17,
      width * 0.48,
      height * 0.2,
      width * 0.5,
      height * 0.25,
    );

    // Mirror for right side
    path.cubicTo(
      width * 0.52,
      height * 0.2,
      width * 0.55,
      height * 0.17,
      width * 0.6,
      height * 0.15,
    );

    // Right curve
    path.cubicTo(
      width * 0.75,
      height * 0.1,
      width * 0.9,
      height * 0.2,
      width * 0.9,
      height * 0.35,
    );

    // Right side of the heart
    path.cubicTo(
      width * 0.9,
      height * 0.45,
      width * 0.8,
      height * 0.6,
      width * 0.5,
      height * 0.9,
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
