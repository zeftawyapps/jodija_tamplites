import 'package:flutter/material.dart';
import '../theam/theam.dart';

/// واجهة عنصر الشريط الجانبي
class SidebarItemWidget extends StatefulWidget {
    IconData icon;
    IconData? selectedIcon;

    String label;
    bool isSelected;
    VoidCallback onTap;
    SideBarNavigationTheames theme;

    SidebarItemWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    this.selectedIcon,

    required this.onTap,
    required this.theme,
  });

  @override
  State<SidebarItemWidget> createState() => _SidebarItemWidgetState();
}

class _SidebarItemWidgetState extends State<SidebarItemWidget> {
  bool isHovered = false;
  bool isColumn =   false  ;
  @override
  Widget build(BuildContext context) {
 isColumn = widget.theme.isSidebarInCulomn ;
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: widget.theme.hoverTransitionDuration,
          curve: widget.theme.hoverTransitionCurve,
          height: widget.theme.itemHeight,
          decoration: widget.theme.getItemDecoration(
            isHovered: isHovered,
            isSelected: widget.isSelected,
          ),
          padding: widget.theme.itemPadding,
          child:
           isColumn ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
              widget.isSelected ?  widget.selectedIcon ??

                widget.icon: widget.icon,
                color: widget.theme.getIconColor(
                  isHovered: isHovered,
                  isSelected: widget.isSelected,
                ),
                size: widget.theme.iconSize,
              ),
              SizedBox(height: widget.theme.iconTextSpacing),
              Text(
                widget.label,
                style: widget.theme.getTextStyle(
                  isHovered: isHovered,
                  isSelected: widget.isSelected,
                ),
              ),
            ],
          ) :
          Row(
            children: [
              Icon(
                widget.isSelected ?  widget.selectedIcon ??

                    widget.icon: widget.icon,
                color: widget.theme.getIconColor(
                  isHovered: isHovered,
                  isSelected: widget.isSelected,
                ),
                size: widget.theme.iconSize,
              ),
              SizedBox(width: widget.theme.iconTextSpacing),
              Text(
                widget.label,
                style: widget.theme.getTextStyle(
                  isHovered: isHovered,
                  isSelected: widget.isSelected,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
