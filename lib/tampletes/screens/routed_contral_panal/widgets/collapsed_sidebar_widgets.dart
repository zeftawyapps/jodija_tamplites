import 'package:flutter/material.dart';
import '../theam/theam.dart';

/// ويدجت لعنصر السايدبار المصغر المستقل (دون فروع) مع تأثير الـ Hover
class CollapsedStandaloneItemWidget extends StatefulWidget {
  final bool isSelected;
  final IconData icon;
  final SideBarNavigationTheames theme;
  final VoidCallback onTap;

  const CollapsedStandaloneItemWidget({
    super.key,
    required this.isSelected,
    required this.icon,
    required this.theme,
    required this.onTap,
  });

  @override
  State<CollapsedStandaloneItemWidget> createState() =>
      _CollapsedStandaloneItemWidgetState();
}

class _CollapsedStandaloneItemWidgetState
    extends State<CollapsedStandaloneItemWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          height: theme.itemHeight,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: widget.isSelected
                ? theme.selectedBackgroundColor
                : (_isHovered ? theme.hoverBackgroundColor : theme.backgroundColor),
          ),
          child: Icon(
            widget.icon,
            color: widget.isSelected
                ? theme.selectedTextColor
                : (_isHovered ? theme.hoverTextColor : theme.iconColor),
            size: theme.iconSize,
          ),
        ),
      ),
    );
  }
}

/// ويدجت لأيقونة المجموعة في السايدبار المصغر (تفتح Popup Menu) مع تأثير الـ Hover
class CollapsedGroupItemWidget extends StatefulWidget {
  final bool isSelected;
  final IconData icon;
  final SideBarNavigationTheames theme;

  const CollapsedGroupItemWidget({
    super.key,
    required this.isSelected,
    required this.icon,
    required this.theme,
  });

  @override
  State<CollapsedGroupItemWidget> createState() =>
      _CollapsedGroupItemWidgetState();
}

class _CollapsedGroupItemWidgetState extends State<CollapsedGroupItemWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        height: theme.itemHeight,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: widget.isSelected
              ? theme.selectedBackgroundColor
              : (_isHovered ? theme.hoverBackgroundColor : theme.backgroundColor),
        ),
        child: Icon(
          widget.icon,
          color: widget.isSelected
              ? theme.selectedTextColor
              : (_isHovered ? theme.hoverTextColor : theme.iconColor),
          size: theme.iconSize,
        ),
      ),
    );
  }
}

/// ويدجت مخصص لعناصر الـ Popup Menu للـ Submenus مع دعم الـ Hover الكامل
class HoverablePopupMenuItemChild extends StatefulWidget {
  final bool isSelected;
  final IconData icon;
  final String label;
  final SideBarNavigationTheames theme;

  const HoverablePopupMenuItemChild({
    super.key,
    required this.isSelected,
    required this.icon,
    required this.label,
    required this.theme,
  });

  @override
  State<HoverablePopupMenuItemChild> createState() =>
      _HoverablePopupMenuItemChildState();
}

class _HoverablePopupMenuItemChildState
    extends State<HoverablePopupMenuItemChild> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: double.infinity,
        height: theme.itemHeight,
        padding: theme.itemPadding,
        decoration: BoxDecoration(
          color: widget.isSelected
              ? theme.selectedBackgroundColor
              : (_isHovered ? theme.hoverBackgroundColor : Colors.transparent),
        ),
        child: Row(
          children: [
            Icon(
              widget.icon,
              color: widget.isSelected
                  ? (theme.selectedTextColor ?? theme.selectedIconColor)
                  : (_isHovered ? theme.hoverTextColor : theme.iconColor),
              size: theme.iconSize * 0.8,
            ),
            const SizedBox(width: 12),
            Text(
              widget.label,
              style: TextStyle(
                fontFamily: theme.fontFamily ?? 'Cairo',
                color: widget.isSelected
                    ? (theme.selectedTextColor ?? theme.selectedIconColor)
                    : (_isHovered ? theme.hoverTextColor : theme.textColor),
                fontSize: theme.fontSize,
                fontWeight: widget.isSelected
                    ? theme.selectedFontWeight
                    : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
