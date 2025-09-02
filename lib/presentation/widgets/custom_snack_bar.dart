import 'package:flutter/material.dart';

enum SnackBarType { success, error, warning, info }

enum SnackBarPosition { top, bottom }

class CustomSnackBar {
  static void show({
    required BuildContext context,
    required String message,
    SnackBarType type = SnackBarType.success,
    SnackBarPosition position = SnackBarPosition.bottom,
    Duration duration = const Duration(seconds: 3),
    String? actionLabel,
    VoidCallback? onActionPressed,
    VoidCallback? onDismissed,
  }) {
    final OverlayState overlayState = Overlay.of(context);
    OverlayEntry? overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return _CustomSnackBarWidget(
          message: message,
          type: type,
          position: position,
          duration: duration,
          actionLabel: actionLabel,
          onActionPressed: onActionPressed,
          onDismissed: () {
            overlayEntry?.remove();
            onDismissed?.call();
          },
        );
      },
    );

    overlayState.insert(overlayEntry);
  }
}

class _CustomSnackBarWidget extends StatefulWidget {
  final String message;
  final SnackBarType type;
  final SnackBarPosition position;
  final Duration duration;
  final String? actionLabel;
  final VoidCallback? onActionPressed;
  final VoidCallback onDismissed;

  const _CustomSnackBarWidget({
    required this.message,
    required this.type,
    required this.position,
    required this.duration,
    required this.onDismissed,
    this.actionLabel,
    this.onActionPressed,
  });

  @override
  State<_CustomSnackBarWidget> createState() => _CustomSnackBarWidgetState();
}

class _CustomSnackBarWidgetState extends State<_CustomSnackBarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    final Offset beginOffset = widget.position == SnackBarPosition.top
        ? const Offset(0, -1)
        : const Offset(0, 1);

    _slideAnimation = Tween<Offset>(
      begin: beginOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.forward();

    // Auto dismiss
    Future.delayed(widget.duration, () {
      if (mounted) {
        _animationController.reverse().then((_) {
          widget.onDismissed();
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Color _getTypeColor() {
    switch (widget.type) {
      case SnackBarType.success:
        return Colors.green.shade600;
      case SnackBarType.error:
        return Colors.red.shade600;
      case SnackBarType.warning:
        return Colors.amber.shade600;
      case SnackBarType.info:
        return Colors.blue.shade600;
    }
  }

  IconData _getTypeIcon() {
    switch (widget.type) {
      case SnackBarType.success:
        return Icons.check_circle_outline;
      case SnackBarType.error:
        return Icons.error_outline;
      case SnackBarType.warning:
        return Icons.warning_amber_outlined;
      case SnackBarType.info:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    final safeAreaPaddingBottom = padding.bottom;
    final safeAreaPaddingTop = padding.top;

    return Positioned(
      left: 16,
      right: 16,
      top: widget.position == SnackBarPosition.top
          ? safeAreaPaddingTop + 16
          : null,
      bottom: widget.position == SnackBarPosition.bottom
          ? safeAreaPaddingBottom + 16
          : null,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: Material(
            elevation: 6,
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border:
                    Border.all(color: _getTypeColor().withAlpha(77), width: 1),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Icon(
                      _getTypeIcon(),
                      color: _getTypeColor(),
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        widget.message,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    if (widget.actionLabel != null)
                      TextButton(
                        onPressed: () {
                          widget.onActionPressed?.call();
                          _animationController.reverse().then((_) {
                            widget.onDismissed();
                          });
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: _getTypeColor(),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          minimumSize: const Size(0, 36),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(widget.actionLabel!,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints:
                          const BoxConstraints(maxHeight: 40, maxWidth: 40),
                      icon: const Icon(Icons.close, size: 20),
                      onPressed: () {
                        _animationController.reverse().then((_) {
                          widget.onDismissed();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
