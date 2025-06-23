import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/navigation_provider.dart';

class CustomSidebar extends StatelessWidget {
  const CustomSidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NavigationProvider>(context);
    final currentIndex = provider.currentIndex;

    return Container(
      color: Theme.of(context).primaryColor,
      width: 250,
      child: Column(
        children: [
          Container(
            height: 100,
            alignment: Alignment.center,
            child: Text(
              'Control Panel',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: provider.navigationItems.length,
              itemBuilder: (context, index) {
                final item = provider.navigationItems[index];
                final isSelected = index == currentIndex;

                return InkWell(
                  onTap: () => provider.navigateTo(context, index),
                  child: Container(
                    color: isSelected
                        ? Theme.of(context).primaryColor.withOpacity(0.7)
                        : Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          item.icon,
                          color: Colors.white,
                          size: 24,
                        ),
                        const SizedBox(width: 16),
                        Text(
                          item.label,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        if (isSelected) ...[
                          const Spacer(),
                          Container(
                            width: 5,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
