import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _locationEnabled = true;
  bool _soundEnabled = true;
  double _fontSize = 16.0;

  Widget _buildSectionHeader(String title, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
      child: Text(
        title,
        style: theme.textTheme.labelMedium,
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
    ThemeData? theme,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: theme?.colorScheme.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: theme?.colorScheme.onPrimary,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: theme?.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle,
                style: theme?.textTheme.bodyMedium?.copyWith(),
              )
            : null,
        trailing: trailing,
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    ThemeData? theme,
  }) {
    return _buildSettingsTile(
      icon: icon,
      title: title,
      subtitle: subtitle,
      theme: theme,
      trailing: Transform.scale(
        scale: 0.8,
        child: CupertinoSwitch(
          value: value,
          onChanged: onChanged,
          activeTrackColor: theme?.colorScheme.primary,
          inactiveTrackColor: Colors.grey[400],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Settings',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Preferences Section
              _buildSectionHeader('PREFERENCES', theme),
              _buildSwitchTile(
                icon: Icons.notifications_outlined,
                title: 'Notifications',
                subtitle: 'Receive push notifications',
                value: _notificationsEnabled,
                onChanged: (value) =>
                    setState(() => _notificationsEnabled = value),
                theme: theme,
              ),
              const SizedBox(height: 8),
              _buildSettingsTile(
                icon: Icons.dark_mode_outlined,
                title: 'Theme',
                subtitle: 'Select theme and appearance',
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  context.pushNamed('themeSettings');
                },
                theme: theme,
              ),
              const SizedBox(height: 8),
              _buildSwitchTile(
                icon: Icons.location_on_outlined,
                title: 'Location Services',
                subtitle: 'Allow location access',
                value: _locationEnabled,
                onChanged: (value) => setState(() => _locationEnabled = value),
                theme: theme,
              ),
              const SizedBox(height: 8),
              _buildSwitchTile(
                icon: Icons.volume_up_outlined,
                title: 'Sound Effects',
                subtitle: 'Play sound effects',
                value: _soundEnabled,
                onChanged: (value) => setState(() => _soundEnabled = value),
                theme: theme,
              ),

              // Font Size Setting
              const SizedBox(height: 8),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.text_fields,
                              color: theme.colorScheme.onPrimary,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Font Size',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: theme.colorScheme.primary,
                          inactiveTrackColor: Colors.grey[400],
                          thumbColor: theme.colorScheme.primary,
                          overlayColor: theme.colorScheme.primary.withAlpha(40),
                        ),
                        child: Slider(
                          value: _fontSize,
                          min: 12.0,
                          max: 24.0,
                          divisions: 6,
                          label: '${_fontSize.round()}px',
                          onChanged: (value) =>
                              setState(() => _fontSize = value),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Account Section
              _buildSectionHeader('ACCOUNT', theme),
              _buildSettingsTile(
                icon: Icons.person_outline,
                title: 'Profile Settings',
                subtitle: 'Update your profile information',
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
                theme: theme,
              ),
              const SizedBox(height: 8),
              _buildSettingsTile(
                icon: Icons.security_outlined,
                title: 'Privacy & Security',
                subtitle: 'Manage your privacy settings',
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
                theme: theme,
              ),
              const SizedBox(height: 8),
              _buildSettingsTile(
                icon: Icons.payment_outlined,
                title: 'Billing & Payments',
                subtitle: 'Manage subscription and payments',
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
                theme: theme,
              ),

              // Support Section
              _buildSectionHeader('SUPPORT', theme),
              _buildSettingsTile(
                icon: Icons.help_outline,
                title: 'Help Center',
                subtitle: 'Get help and support',
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
                theme: theme,
              ),
              const SizedBox(height: 8),
              _buildSettingsTile(
                icon: Icons.feedback_outlined,
                title: 'Send Feedback',
                subtitle: 'Help us improve the app',
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
                theme: theme,
              ),
              const SizedBox(height: 8),
              _buildSettingsTile(
                icon: Icons.info_outline,
                title: 'About',
                subtitle: 'App version and information',
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
                theme: theme,
              ),

              // Logout Section
              const SizedBox(height: 24),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Show logout confirmation dialog
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(
                          'Logout',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        content: Text(
                          'Are you sure you want to logout?',
                          style: theme.textTheme.bodyMedium,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              'Cancel',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              // Handle logout logic
                            },
                            child: Text(
                              'Logout',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: Text(
                    'Logout',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
