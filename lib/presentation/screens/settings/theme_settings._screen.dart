import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/models/theme_settings.dart';
import '../../cubits/theme/theme_cubit.dart';
import '../../cubits/theme/theme_state.dart';
import '../../widgets/custom_snack_bar.dart';

class ThemeSettingsScreen extends StatelessWidget {
  const ThemeSettingsScreen({super.key});

  // Predefined color options
  static const List<ColorOption> colorOptions = [
    ColorOption(name: 'Purple', color: Colors.purple),
    ColorOption(name: 'Blue', color: Colors.blue),
    ColorOption(name: 'Green', color: Colors.green),
    ColorOption(name: 'Red', color: Colors.red),
    ColorOption(name: 'Orange', color: Colors.orange),
    ColorOption(name: 'Teal', color: Colors.teal),
    ColorOption(name: 'Pink', color: Colors.pink),
    ColorOption(name: 'Indigo', color: Colors.indigo),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocConsumer<ThemeCubit, ThemeState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          CustomSnackBar.show(
            context: context,
            message: state.errorMessage!,
            type: SnackBarType.error,
          );
          context.read<ThemeCubit>().resetError();
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: AppBar(
            title: Text(
              'Theme Settings',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            elevation: 0,
            centerTitle: true,
          ),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Theme Mode Section
                _buildSettingsSection(
                  context: context,
                  title: 'Theme Mode',
                  child: Column(
                    children: [
                      _buildRadioTile(
                        context: context,
                        title: 'Light',
                        subtitle: 'Always use light theme',
                        value: MyThemeMode.light,
                        groupValue: state.themeMode,
                        onChanged: (value) {
                          context.read<ThemeCubit>().setThemeMode(value!);
                        },
                      ),
                      _buildRadioTile(
                        context: context,
                        title: 'Dark',
                        subtitle: 'Always use dark theme',
                        value: MyThemeMode.dark,
                        groupValue: state.themeMode,
                        onChanged: (value) {
                          context.read<ThemeCubit>().setThemeMode(value!);
                        },
                      ),
                      _buildRadioTile(
                        context: context,
                        title: 'System',
                        subtitle: 'Follow system theme',
                        value: MyThemeMode.system,
                        groupValue: state.themeMode,
                        onChanged: (value) {
                          context.read<ThemeCubit>().setThemeMode(value!);
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Accent Color Section
                _buildSettingsSection(
                  context: context,
                  title: 'Accent Color',
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        for (final option in colorOptions)
                          _buildColorOption(
                            context: context,
                            option: option,
                            isSelected:
                                state.accentColor.value == option.color.value,
                            currentAccentColor: state.accentColor,
                          ),
                      ],
                    ),
                  ),
                ),

                if (state.isLoading)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSettingsSection(
      {required BuildContext context,
      required String title,
      required Widget child}) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 8),
          child: Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: child,
        ),
      ],
    );
  }

  Widget _buildRadioTile({
    required BuildContext context,
    required String title,
    required String subtitle,
    required MyThemeMode value,
    required MyThemeMode groupValue,
    required ValueChanged<MyThemeMode?> onChanged,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return RadioListTile<MyThemeMode>(
      title: Text(title, style: theme.textTheme.titleMedium),
      subtitle: Text(subtitle, style: theme.textTheme.bodyMedium),
      value: value,
      groupValue: groupValue,
      activeColor: colorScheme.primary,
      onChanged: onChanged,
    );
  }

  Widget _buildColorOption({
    required BuildContext context,
    required ColorOption option,
    required bool isSelected,
    required Color currentAccentColor,
  }) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        context.read<ThemeCubit>().setAccentColor(option.color);
      },
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: option.color,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected
                    ? theme.brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black12
                    : Colors.transparent,
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: option.color.withOpacity(0.5),
                  blurRadius: 10,
                  spreadRadius: isSelected ? 2 : 0,
                ),
              ],
            ),
            child: isSelected
                ? Icon(Icons.check,
                    color: ThemeData.estimateBrightnessForColor(option.color) ==
                            Brightness.dark
                        ? Colors.white
                        : Colors.black,
                    size: 30)
                : null,
          ),
          const SizedBox(height: 8),
          Text(
            option.name,
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class ColorOption {
  final String name;
  final Color color;

  const ColorOption({
    required this.name,
    required this.color,
  });
}
