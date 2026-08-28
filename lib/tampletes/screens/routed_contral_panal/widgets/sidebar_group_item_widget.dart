import 'package:flutter/material.dart';
import '../theam/theam.dart';

class SidebarGroupItemWidget extends StatefulWidget {
  final String parentName;
  final IconData? parentIcon;
  final SideBarNavigationTheames theme;
  final bool isExpanded;
  final bool isParentSelected;
  final ValueChanged<bool> onExpansionChanged;
  final List<Widget> children;

  const SidebarGroupItemWidget({
    super.key,
    required this.parentName,
    this.parentIcon,
    required this.theme,
    required this.isExpanded,
    required this.isParentSelected,
    required this.onExpansionChanged,
    required this.children,
  });

  @override
  State<SidebarGroupItemWidget> createState() => _SidebarGroupItemWidgetState();
}

class _SidebarGroupItemWidgetState extends State<SidebarGroupItemWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;

    // Determine background color
    Color getBgColor() {
      if (_isHovered) return theme.hoverBackgroundColor;
      if (widget.isExpanded) return theme.expandedBackgroundColor;
      if (widget.isParentSelected) return theme.selectedBackgroundColor;
      return theme.backgroundColor;
    }

    // Determine leading icon color
    Color getIconColor() {
      if (_isHovered) return theme.hoverTextColor;
      if (widget.isExpanded) return theme.expandedIconColor;
      if (widget.isParentSelected) return theme.selectedTextColor;
      return theme.iconColor;
    }

    // Determine text color
    Color getTextColor() {
      if (_isHovered) return theme.hoverTextColor;
      if (widget.isExpanded) return theme.expandedTextColor;
      if (widget.isParentSelected) return theme.selectedTextColor;
      return theme.textColor;
    }

    // Determine arrow color
    Color getArrowColor() {
      if (_isHovered) return theme.hoverTextColor;
      if (widget.isExpanded) return theme.expandedArrowColor;
      if (widget.isParentSelected) return theme.selectedTextColor;
      return theme.iconColor;
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Theme(
        // Prevent default ExpansionTile border lines and colors
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          key: ValueKey(widget.parentName),
          shape: const Border(),
          collapsedShape: const Border(),
          initiallyExpanded: widget.isExpanded,
          leading: Icon(
            widget.parentIcon ?? Icons.folder,
            color: getIconColor(),
            size: theme.iconSize,
          ),
          title: Text(
            widget.parentName,
            style: TextStyle(
              fontFamily: theme.fontFamily ?? 'Cairo',
              color: getTextColor(),
              fontSize: theme.fontSize,
              fontWeight: theme.selectedFontWeight,
            ),
          ),
          iconColor: getArrowColor(),
          collapsedIconColor: getArrowColor(),
          backgroundColor: getBgColor(),
          collapsedBackgroundColor: getBgColor(),
          onExpansionChanged: widget.onExpansionChanged,
          children: widget.children,
        ),
      ),
    );
  }
}
