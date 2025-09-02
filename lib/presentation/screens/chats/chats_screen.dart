import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../cubits/theme/theme_cubit.dart';
import '../../cubits/theme/theme_state.dart';
import '../../widgets/custom_snack_bar.dart';
import '../../widgets/custom_text_field.dart';
import 'dummy_messages.dart';
import 'message.dart';

class DummyChatModel {
  final bool isSelf;
  final String message;
  final String time;
  final String avatarUrl;

  DummyChatModel({
    required this.isSelf,
    required this.message,
    required this.time,
    required this.avatarUrl,
  });
}

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const String chatName = "Gyaatt space 💗";
    return BlocConsumer<ThemeCubit, ThemeState>(listener: (context, state) {
      if (state.errorMessage != null) {
        CustomSnackBar.show(
          context: context,
          message: state.errorMessage!,
          type: SnackBarType.error,
        );
        context.read<ThemeCubit>().resetError();
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(chatName),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              onSelected: (String value) {
                // Handle menu item selection
                switch (value) {
                  case 'theme':
                    context.pushNamed('chatTheme');
                    break;
                  case 'mute':
                    // Handle mute notifications
                    break;
                  case 'search':
                    // Handle search in chat
                    break;
                  case 'clear':
                    // Handle clear chat
                    break;
                  case 'block':
                    // Handle block user
                    break;
                  case 'report':
                    // Handle report
                    break;
                }
              },
              itemBuilder: (BuildContext context) => [
                const PopupMenuItem<String>(
                  value: 'theme',
                  child: Row(
                    children: [
                      Icon(Icons.color_lens_outlined, size: 20),
                      SizedBox(width: 12),
                      Text('Change background'),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'mute',
                  child: Row(
                    children: [
                      Icon(Icons.notifications_off_outlined, size: 20),
                      SizedBox(width: 12),
                      Text('Mute notifications'),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'search',
                  child: Row(
                    children: [
                      Icon(Icons.search, size: 20),
                      SizedBox(width: 12),
                      Text('Search in chat'),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'clear',
                  child: Row(
                    children: [
                      Icon(Icons.clear_all, size: 20),
                      SizedBox(width: 12),
                      Text('Clear chat'),
                    ],
                  ),
                ),
                const PopupMenuDivider(),
                const PopupMenuItem<String>(
                  value: 'block',
                  child: Row(
                    children: [
                      Icon(Icons.block, size: 20),
                      SizedBox(width: 12),
                      Text('Block user'),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'report',
                  child: Row(
                    children: [
                      Icon(Icons.flag_outlined, size: 20),
                      SizedBox(width: 12),
                      Text('Report'),
                    ],
                  ),
                ),
              ],
            ),
          ],
          centerTitle: true,
          backgroundColor:
              Theme.of(context).appBarTheme.backgroundColor!.withAlpha(230),
        ),
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: Container(
          decoration: BoxDecoration(
            image: state.chatBackground != null
                ? DecorationImage(
                    image: AssetImage(state.chatBackground!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: ListView.builder(
            reverse: true,
            itemCount: dummyMessages.length,
            itemBuilder: (context, index) {
              final message = dummyMessages[dummyMessages.length - 1 - index];
              return Message(message: message);
            },
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.black.withAlpha(80),
          ),
          padding: const EdgeInsets.only(
            bottom: 16.0,
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      hintText: "Type a message",
                      isPassword: false,
                      controller: TextEditingController(),
                      validator: () {},
                    )),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  // Handle send action
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
