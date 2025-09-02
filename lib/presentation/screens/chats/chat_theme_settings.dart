import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/theme/theme_cubit.dart';
import '../../cubits/theme/theme_state.dart';
import '../../widgets/custom_snack_bar.dart';

class ChatThemeSettings extends StatefulWidget {
  const ChatThemeSettings({super.key});

  @override
  State<ChatThemeSettings> createState() => _ChatThemeSettingsState();
}

class _ChatThemeSettingsState extends State<ChatThemeSettings> {
  List<Map<String, String>> backgrounds = [
    {
      "Confetti": 'assets/images/chat_background/confetti.jpg',
    },
    {
      "Cute Car": 'assets/images/chat_background/cute_car.jpg',
    },
    {
      "Dream": 'assets/images/chat_background/dream.jpg',
    },
    {
      "Love": 'assets/images/chat_background/love.jpg',
    },
    {
      "Pikachu": 'assets/images/chat_background/pikachu.jpg',
    },
    {
      "Pretty": 'assets/images/chat_background/pretty.jpg',
    },
    {
      "Astrophile": 'assets/images/chat_background/stars_and_astronomy.jpg',
    },
    {
      "Stars and Clouds": 'assets/images/chat_background/stars_and_cloud.jpg',
    },
    {
      "Yolo": 'assets/images/chat_background/yolo.jpg',
    },
  ];
  @override
  Widget build(BuildContext context) {
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
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text('Chat Theme Settings'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Select a background:",
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: backgrounds.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                        'Preview: ${backgrounds[index].keys.first}'),
                                    content: Container(
                                      width: double.maxFinite,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              backgrounds[index].values.first),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          context
                                              .read<ThemeCubit>()
                                              .setChatBackground(
                                                backgrounds[index].values.first,
                                              );
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Set Background'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: AssetImage(
                                      backgrounds[index].values.first),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          backgrounds[index].keys.first,
                        ),
                        const SizedBox(height: 12),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
