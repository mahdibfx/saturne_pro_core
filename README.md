<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# Saturne Pro Core

A comprehensive Flutter package that encapsulates the design system and shared UI components for Saturne Pro applications. This package provides a consistent, modern, and professional look across all Saturne Pro apps while ensuring maintainability and reusability of UI components.

## Features

- 🎨 **Complete Design System**

  - Custom color palette with semantic color definitions
  - Typography system with predefined text styles
  - Consistent spacing and border radius scales
  - Custom gradients for visual enhancement
  - Custom icon font (SaturneProIcons)

- 📱 **Responsive Components**

  - Built-in responsive sizing utilities
  - Device-aware layout helpers
  - Adaptive components that work across different screen sizes

- 🧩 **Reusable UI Components**

  - Custom cards with consistent styling
  - Flexible gap system for layout spacing
  - Custom calendar widget with multiple selection modes
  - File upload component with dotted border
  - Page indicators and tab bars
  - And many more...

- 🎯 **Developer Experience**
  - Easy-to-use theme extension system
  - Comprehensive documentation
  - Type-safe design system access
  - Consistent API design

## Getting started

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  saturne_pro_core: ^0.0.1
```

## Usage

### Setting up the Design System

To use the design system in your app, wrap your `MaterialApp` with the appropriate theme:

```dart
import 'package:flutter/material.dart';
import 'package:saturne_pro_core/saturne_pro_core.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: SaturneProDesignSystem.lightMode,
      // or use darkMode for dark theme
      // theme: SaturneProDesignSystem.darkMode,
      home: const MyHomePage(),
    );
  }
}
```

### Using Design System Values

Access design system values through the BuildContext extension:

```dart
Widget build(BuildContext context) {
  final ds = context.designSystem;

  return Container(
    padding: EdgeInsets.all(ds.spacing.l),
    decoration: BoxDecoration(
      color: ds.colors.primary.shade500,
      borderRadius: BorderRadius.circular(ds.borderRadii.radiusM),
    ),
    child: Text(
      'Hello World',
      style: ds.typography.bodyL,
    ),
  );
}
```

### Using Components

The package provides various pre-built components that follow the design system:

```dart
// Using the CustomCard widget
CustomCard(
  child: Text('Card content'),
  isFullWidth: false,
  padding: EdgeInsets.all(16.0),
);

// Using the CustomGap widget
Column(
  children: [
    Text('First item'),
    CustomGap(gapSize: GapSize.l),
    Text('Second item'),
  ],
);

// Using the Calendar widget
Calendar(
  selectionType: CalendarSelectionType.single,
  onDateSelected: (dates) {
    // Handle date selection
  },
);
```

## Additional Information

### Requirements

- Flutter SDK: >=1.17.0
- Dart SDK: ^3.7.2

### Dependencies

The package uses several well-maintained dependencies:

- `gap`: ^3.0.1
- `smooth_page_indicator`: ^1.2.1
- `tap_builder`: ^0.5.0
- `dotted_border`: ^3.0.1
- `pinput`: ^5.0.1
- `calendar_date_picker2`: ^2.0.0
- `animations`: ^2.0.11

### Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

### License

This project is licensed under the MIT License - see the LICENSE file for details.
