# Animation Types - Practical Examples

## Interactive Examples Gallery

### Example 1: Professional Dashboard (SlideAndFade - Default)
```dart
class ProfessionalDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptiveAppShell(
      languageCode: 'en',
      theme: SideBarNavigationTheames.light(
        animationType: AnimationType.slideAndFade,  // Default
        animationDuration: const Duration(milliseconds: 300),
        animationCurve: Curves.easeOutCubic,
      ),
      sidebarItems: [
        RouteItem(
          label: 'Dashboard',
          icon: Icons.dashboard,
          path: '/dashboard',
        ),
        RouteItem(
          label: 'Analytics',
          icon: Icons.analytics,
          path: '/analytics',
        ),
        RouteItem(
          label: 'Reports',
          icon: Icons.assessment,
          path: '/reports',
        ),
      ],
      loclizationLangs: {},
    );
  }
}
```
**Use Case**: Corporate apps, traditional dashboards, professional environments
**Animation Feel**: Smooth, directional, trustworthy

---

### Example 2: Modern App (FadeOnly)
```dart
class MinimalModernApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptiveAppShell(
      languageCode: 'en',
      theme: SideBarNavigationTheames.light(
        animationType: AnimationType.fadeOnly,
        animationDuration: const Duration(milliseconds: 250),
        animationCurve: Curves.easeInOut,
      ),
      sidebarItems: [
        RouteItem(
          label: 'Home',
          icon: Icons.home,
          path: '/home',
        ),
        RouteItem(
          label: 'Explore',
          icon: Icons.explore,
          path: '/explore',
        ),
        RouteItem(
          label: 'Profile',
          icon: Icons.person,
          path: '/profile',
        ),
      ],
      loclizationLangs: {},
    );
  }
}
```
**Use Case**: Social apps, content apps, design-focused interfaces
**Animation Feel**: Subtle, non-intrusive, elegant

---

### Example 3: Premium Experience (ScaleAndFade)
```dart
class PremiumApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptiveAppShell(
      languageCode: 'en',
      theme: SideBarNavigationTheames.dark(
        animationType: AnimationType.scaleAndFade,
        animationDuration: const Duration(milliseconds: 400),
        animationCurve: Curves.elasticOut,
      ),
      animationType: AnimationType.scaleAndFade,
      animationDuration: const Duration(milliseconds: 400),
      sidebarItems: [
        RouteItem(
          label: 'Premium',
          icon: Icons.star,
          path: '/premium',
        ),
        RouteItem(
          label: 'Features',
          icon: Icons.featured_play_list,
          path: '/features',
        ),
        RouteItem(
          label: 'Settings',
          icon: Icons.settings,
          path: '/settings',
        ),
      ],
      loclizationLangs: {},
    );
  }
}
```
**Use Case**: Premium apps, high-end services, games, creative tools
**Animation Feel**: Bouncy, playful, luxurious

---

### Example 4: Gaming UI (RotateAndScale)
```dart
class GamingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptiveAppShell(
      languageCode: 'en',
      theme: SideBarNavigationTheames.light(
        animationType: AnimationType.rotateAndScale,
        animationDuration: const Duration(milliseconds: 600),
        animationCurve: Curves.elasticInOut,
      ),
      sidebarItems: [
        RouteItem(
          label: 'Play',
          icon: Icons.play_circle,
          path: '/play',
        ),
        RouteItem(
          label: 'Leaderboard',
          icon: Icons.leaderboard,
          path: '/leaderboard',
        ),
        RouteItem(
          label: 'Achievements',
          icon: Icons.emoji_events,
          path: '/achievements',
        ),
        RouteItem(
          label: 'Shop',
          icon: Icons.store,
          path: '/shop',
        ),
      ],
      loclizationLangs: {},
    );
  }
}
```
**Use Case**: Games, entertainment apps, attention-grabbing UIs
**Animation Feel**: Dynamic, exciting, engaging

---

### Example 5: Top-Down Flow (SlideFromTop)
```dart
class WaterfallMenuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptiveAppShell(
      languageCode: 'en',
      theme: SideBarNavigationTheames.light(
        animationType: AnimationType.slideFromTop,
        animationDuration: const Duration(milliseconds: 350),
        animationCurve: Curves.decelerate,
      ),
      sidebarItems: [
        RouteItem(
          label: 'News',
          icon: Icons.newspaper,
          path: '/news',
        ),
        RouteItem(
          label: 'Categories',
          icon: Icons.category,
          path: '/categories',
        ),
        RouteItem(
          label: 'Bookmarks',
          icon: Icons.bookmark,
          path: '/bookmarks',
        ),
        RouteItem(
          label: 'Settings',
          icon: Icons.settings,
          path: '/settings',
        ),
      ],
      loclizationLangs: {},
    );
  }
}
```
**Use Case**: News apps, information portals, top-down hierarchies
**Animation Feel**: Flowing, cascading, organized

---

### Example 6: Bottom-Up Navigation (SlideFromBottom)
```dart
class ElevationMenuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptiveAppShell(
      languageCode: 'en',
      theme: SideBarNavigationTheames.light(
        animationType: AnimationType.slideFromBottom,
        animationDuration: const Duration(milliseconds: 350),
        animationCurve: Curves.fastOutSlowIn,
      ),
      sidebarItems: [
        RouteItem(
          label: 'Home',
          icon: Icons.home,
          path: '/home',
        ),
        RouteItem(
          label: 'Inbox',
          icon: Icons.inbox,
          path: '/inbox',
        ),
        RouteItem(
          label: 'Messages',
          icon: Icons.message,
          path: '/messages',
        ),
        RouteItem(
          label: 'More',
          icon: Icons.more_horiz,
          path: '/more',
        ),
      ],
      loclizationLangs: {},
    );
  }
}
```
**Use Case**: Chat apps, messaging, email clients
**Animation Feel**: Rising, emerging, uplifting

---

### Example 7: Growth Emphasis (ScaleUp)
```dart
class GrowthFocusedApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptiveAppShell(
      languageCode: 'en',
      theme: SideBarNavigationTheames.light(
        animationType: AnimationType.scaleUp,
        animationDuration: const Duration(milliseconds: 400),
        animationCurve: Curves.easeOutBack,
      ),
      sidebarItems: [
        RouteItem(
          label: 'Progress',
          icon: Icons.trending_up,
          path: '/progress',
        ),
        RouteItem(
          label: 'Goals',
          icon: Icons.flag,
          path: '/goals',
        ),
        RouteItem(
          label: 'Achievements',
          icon: Icons.star,
          path: '/achievements',
        ),
        RouteItem(
          label: 'Community',
          icon: Icons.group,
          path: '/community',
        ),
      ],
      loclizationLangs: {},
    );
  }
}
```
**Use Case**: Productivity apps, fitness trackers, learning platforms
**Animation Feel**: Expanding, growing, achieving

---

### Example 8: RTL with Custom Animation (Arabic)
```dart
class ArabicDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptiveAppShell(
      languageCode: 'ar',  // Automatically RTL
      theme: SideBarNavigationTheames.light(
        animationType: AnimationType.slideAndFade,  // Respects RTL
        animationDuration: const Duration(milliseconds: 300),
        animationCurve: Curves.easeOutCubic,
      ),
      sidebarItems: [
        RouteItem(
          label: 'لوحة التحكم',
          icon: Icons.dashboard,
          path: '/dashboard',
        ),
        RouteItem(
          label: 'التقارير',
          icon: Icons.assessment,
          path: '/reports',
        ),
        RouteItem(
          label: 'الإعدادات',
          icon: Icons.settings,
          path: '/settings',
        ),
      ],
      loclizationLangs: {},
    );
  }
}
```
**Use Case**: Arabic apps, Middle Eastern regions, RTL support
**Animation Feel**: Direction-aware, localized, respectful

---

### Example 9: Dynamic Animation Selection
```dart
class DynamicAnimationApp extends StatefulWidget {
  @override
  State<DynamicAnimationApp> createState() => _DynamicAnimationAppState();
}

class _DynamicAnimationAppState extends State<DynamicAnimationApp> {
  late AnimationType selectedAnimation;

  @override
  void initState() {
    super.initState();
    selectedAnimation = AnimationType.slideAndFade;
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveAppShell(
      languageCode: 'en',
      theme: SideBarNavigationTheames.light(
        animationType: selectedAnimation,
        animationDuration: const Duration(milliseconds: 350),
      ),
      sidebarItems: [
        RouteItem(
          label: 'Settings',
          icon: Icons.settings,
          path: '/settings',
          isChildItem: true,
          parentName: 'Configuration',
        ),
        RouteItem(
          label: 'Animations',
          icon: Icons.animation,
          path: '/animations',
        ),
      ],
      loclizationLangs: {},
    );
  }
}
```
**Use Case**: Settings screens, animation preference selection
**Animation Feel**: Customizable, user-controlled

---

### Example 10: Comparison - All Animations Side by Side
```dart
class AnimationShowcase extends StatefulWidget {
  @override
  State<AnimationShowcase> createState() => _AnimationShowcaseState();
}

class _AnimationShowcaseState extends State<AnimationShowcase> {
  int selectedIndex = 0;
  
  final animations = [
    AnimationType.slideAndFade,
    AnimationType.scaleUp,
    AnimationType.fadeOnly,
    AnimationType.slideFromTop,
    AnimationType.slideFromBottom,
    AnimationType.scaleAndFade,
    AnimationType.rotateAndScale,
  ];
  
  final animationNames = [
    'Slide & Fade',
    'Scale Up',
    'Fade Only',
    'Slide From Top',
    'Slide From Bottom',
    'Scale & Fade',
    'Rotate & Scale',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation: ${animationNames[selectedIndex]}'),
      ),
      body: Row(
        children: [
          // Animation preview on left
          Expanded(
            child: Container(
              color: Colors.grey.shade100,
              child: AdaptiveAppShell(
                languageCode: 'en',
                theme: SideBarNavigationTheames.light(
                  animationType: animations[selectedIndex],
                  animationDuration: const Duration(milliseconds: 500),
                ),
                sidebarItems: _generateTestItems(),
                loclizationLangs: {},
              ),
            ),
          ),
          // Animation selector on right
          SizedBox(
            width: 200,
            child: ListView.builder(
              itemCount: animations.length,
              itemBuilder: (context, index) => ListTile(
                selected: index == selectedIndex,
                title: Text(animationNames[index]),
                onTap: () => setState(() => selectedIndex = index),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<RouteItem> _generateTestItems() {
    return [
      RouteItem(label: 'Item 1', icon: Icons.home, path: '/1'),
      RouteItem(label: 'Item 2', icon: Icons.person, path: '/2'),
      RouteItem(label: 'Item 3', icon: Icons.settings, path: '/3'),
      RouteItem(label: 'Item 4', icon: Icons.info, path: '/4'),
      RouteItem(label: 'Item 5', icon: Icons.help, path: '/5'),
    ];
  }
}
```
**Use Case**: Animation gallery, showcasing all options
**Animation Feel**: Educational, interactive

---

### Example 11: Adaptive Selection Based on Theme
```dart
class ThemeAdaptiveApp extends StatelessWidget {
  final bool isDarkMode;

  const ThemeAdaptiveApp({required this.isDarkMode});

  AnimationType _selectAnimationForTheme() {
    if (isDarkMode) {
      return AnimationType.scaleAndFade;  // Bouncy for dark
    } else {
      return AnimationType.slideAndFade;  // Professional for light
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveAppShell(
      languageCode: 'en',
      theme: isDarkMode
          ? SideBarNavigationTheames.dark(
              animationType: _selectAnimationForTheme(),
            )
          : SideBarNavigationTheames.light(
              animationType: _selectAnimationForTheme(),
            ),
      sidebarItems: [],
      loclizationLangs: {},
    );
  }
}
```
**Use Case**: Theme-aware apps with theme-specific animations
**Animation Feel**: Coherent, intentional

---

### Example 12: Performance-First (Mobile)
```dart
class MobileOptimizedApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Use lighter animations on mobile
    return AdaptiveAppShell(
      languageCode: 'en',
      theme: SideBarNavigationTheames.light(
        animationType: AnimationType.fadeOnly,  // Lightest animation
        animationDuration: const Duration(milliseconds: 150),  // Faster
        animationCurve: Curves.linear,  // Simpler curve
      ),
      sidebarItems: [],
      loclizationLangs: {},
    );
  }
}
```
**Use Case**: Low-end mobile devices, performance-critical apps
**Animation Feel**: Snappy, responsive

---

## Quick Reference Table

| Example | Animation | Theme | Feel |
|---------|-----------|-------|------|
| Professional Dashboard | SlideAndFade | Light | Corporate |
| Minimal Modern App | FadeOnly | Light | Subtle |
| Premium Experience | ScaleAndFade | Dark | Luxurious |
| Gaming UI | RotateAndScale | Light | Exciting |
| Waterfall Menu | SlideFromTop | Light | Flowing |
| Elevation Menu | SlideFromBottom | Light | Rising |
| Growth Focused | ScaleUp | Light | Expanding |
| Arabic Dashboard | SlideAndFade | Light | Localized |
| Dynamic Selection | Configurable | Light | Flexible |
| Animation Showcase | All Types | Light | Educational |
| Theme Adaptive | Smart | Dynamic | Coherent |
| Mobile Optimized | FadeOnly | Light | Snappy |

---

## Implementation Checklist

When implementing an animation type:

- [ ] Choose animation type that matches app purpose
- [ ] Test on target devices (especially if rotateAndScale or scaleAndFade)
- [ ] Adjust duration for your content (typically 300-500ms)
- [ ] Select appropriate easing curve
- [ ] Test with RTL languages if supported
- [ ] Verify performance on low-end devices
- [ ] Gather user feedback
- [ ] Document chosen animation type for consistency

---

## Tips & Tricks

### Tip 1: Use Stagger for Better UX
The system automatically staggers items with 50ms delay:
```
Item 1: 300ms
Item 2: 350ms
Item 3: 400ms
Item 4: 450ms
```
This creates a natural cascade effect.

### Tip 2: Match Duration to Content
- Quick animations (250ms): Lightweight content, minimal items
- Medium animations (350ms): Standard dashboards
- Slow animations (500ms): Premium experiences, high-end

### Tip 3: Curve Selection
- `Curves.easeOutCubic`: Professional, smooth
- `Curves.elasticOut`: Bouncy, fun
- `Curves.linear`: Technical, modern
- `Curves.fastOutSlowIn`: Material design, reliable

### Tip 4: Test Animation Types
1. Create multiple shells with different animations
2. Show to test users
3. Measure engagement and preference
4. Choose based on metrics and feedback

### Tip 5: Animation in Settings
Let users choose their preferred animation:
```dart
Future<AnimationType?> showAnimationPicker(BuildContext context) {
  return showDialog<AnimationType>(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Choose Animation'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Fade Only'),
            onTap: () => Navigator.pop(context, AnimationType.fadeOnly),
          ),
          ListTile(
            title: const Text('Scale Up'),
            onTap: () => Navigator.pop(context, AnimationType.scaleUp),
          ),
          // ... more options
        ],
      ),
    ),
  );
}
```

---

## Common Issues & Solutions

### Issue: Animation not showing
**Solution**: Verify `StatusProvider.isAppInit` is `false` during init

### Issue: Animation too fast
**Solution**: Increase `animationDuration` to 400-500ms

### Issue: Heavy rotation animation causing jank
**Solution**: Use `FadeOnly` or `SlideUp` on low-end devices

### Issue: RTL animation wrong direction
**Solution**: Use `slideAndFade` which respects languageCode

### Issue: Animation repeats on navigation
**Solution**: Set `StatusProvider.isAppInit = true` after first animation

---

## Next Steps

1. Choose animation type for your app
2. Adjust duration to your preference
3. Test with real content
4. Monitor performance
5. Gather user feedback
6. Iterate and refine

Enjoy your animations! 🎨✨
