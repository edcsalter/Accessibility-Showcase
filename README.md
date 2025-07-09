# Accessibility Showcase

A comprehensive iOS app demonstrating how to implement essential accessibility features in your applications. This project serves as a practical guide for developers to learn about and implement accessibility best practices in iOS development.

## 🌟 Overview

The Accessibility Showcase app demonstrates various accessibility features that make iOS applications more inclusive and usable for everyone, including users with disabilities. The app focuses on practical implementations that can be directly applied to real-world applications.

## ✨ Features

### Currently Implemented

- **Dynamic Type Size Support** - Complete implementation of system-wide Dynamic Type scaling for web content
- **WebKit Accessibility Integration** - Demonstrates how to make web content accessible within native iOS apps
- **JavaScript Font Scaling** - Automated font scaling for web pages based on user preferences
- **Accessibility Size Categories** - Support for all accessibility size categories (up to 200% scaling)

### Planned Features

- **VoiceOver Integration** - Screen reader support and optimization
- **Voice Control** - Voice navigation and control implementation
- **Full Keyboard Access** - Complete keyboard navigation support
- **Orientation Support** - Adaptive layouts for different orientations
- **Reduced Motion** - Respecting user preferences for reduced animations
- **Button Input** - External hardware button support

## 🚀 Getting Started

### Prerequisites

- Xcode 15.0 or later
- iOS 17.0 or later
- Swift 5.9 or later

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/yourusername/accessibility-showcase.git
   cd accessibility-showcase
   ```

2. Open the project in Xcode:

   ```bash
   open "Accessibility Showcase.xcodeproj"
   ```

3. Build and run the project on a simulator or device.

## 🔧 Implementation Details

### Dynamic Type Size

The app demonstrates comprehensive Dynamic Type support through:

- **Scale Factor Mapping**: Maps all iOS Dynamic Type sizes to appropriate scale factors (0.8x to 2.0x)
- **Real-time Updates**: Automatically responds to system-wide Dynamic Type changes
- **Web Content Scaling**: Injects JavaScript to scale fonts in web pages
- **Accessibility Categories**: Full support for accessibility1 through accessibility5 categories

```swift
private func scaleForDynamicType(_ dynamicTypeSize: DynamicTypeSize) -> CGFloat {
    switch dynamicTypeSize {
    case .xSmall: return 0.8
    case .small: return 0.9
    case .medium: return 1.0
    case .large: return 1.1
    case .xLarge: return 1.2
    case .xxLarge: return 1.3
    case .xxxLarge: return 1.4
    case .accessibility1: return 1.5
    case .accessibility2: return 1.6
    case .accessibility3: return 1.7
    case .accessibility4: return 1.8
    case .accessibility5: return 2.0
    @unknown default: return 1.0
    }
}
```

### WebView Accessibility

The project includes a sophisticated WebView implementation that:

- Monitors Dynamic Type changes using SwiftUI's `@Environment(\.dynamicTypeSize)`
- Injects JavaScript to scale all text elements on web pages
- Normalizes font sizes for consistent scaling
- Removes navigation elements to focus on content
- Provides debugging console output for troubleshooting

## 📱 Testing Accessibility Features

### Dynamic Type Testing

1. Open the app
2. Go to Settings > Accessibility > Display & Text Size > Larger Text
3. Adjust the slider to test different text sizes
4. Return to the app to see real-time scaling

### Using Accessibility Inspector

1. Open Xcode's Accessibility Inspector
2. Connect to your simulator or device
3. Navigate through the app to test VoiceOver descriptions
4. Use the inspector to audit accessibility compliance

## 🎯 Key Accessibility Principles Demonstrated

### 1. **Responsive Design**

- Adapts to user preferences without breaking functionality
- Maintains readability across all Dynamic Type sizes

### 2. **Web Content Accessibility**

- Bridges native app accessibility with web content
- Demonstrates JavaScript injection for accessibility enhancements

### 3. **Real-time Adaptation**

- Responds immediately to system preference changes
- No app restart required for accessibility features

### 4. **Debugging Support**

- Comprehensive console logging for troubleshooting
- Clear implementation patterns for developers

## 📚 Learning Resources

### Apple Documentation

- [Accessibility Programming Guide](https://developer.apple.com/accessibility/)
- [Dynamic Type](https://developer.apple.com/documentation/swiftui/font/dynamic-type)
- [VoiceOver](https://developer.apple.com/documentation/accessibility/voiceover)

### Testing Tools

- **Accessibility Inspector** - Built into Xcode for testing
- **VoiceOver** - System screen reader for testing
- **Voice Control** - Voice navigation testing

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

1. **Add New Features**: Implement VoiceOver, Voice Control, or other accessibility features
2. **Improve Documentation**: Help document implementation patterns
3. **Fix Issues**: Report and fix accessibility bugs
4. **Add Tests**: Create accessibility-focused unit and UI tests

### Development Guidelines

- Follow iOS accessibility best practices
- Include comprehensive documentation
- Add appropriate accessibility labels and hints
- Test with actual accessibility tools

## 📝 Code Structure

```
Accessibility Showcase/
├── Accessibility_ShowcaseApp.swift     # Main app entry point
├── ContentView.swift                   # Primary view container
├── Dynamic Type Size/
│   └── WebView.swift                  # WebView with Dynamic Type support
├── Assets.xcassets/                   # App icons and assets
└── Tests/                            # Unit and UI tests
```

## 🐛 Known Issues

- Web content scaling requires page reload for updates
- Some web elements may not scale properly with complex CSS
- Performance impact on pages with many elements

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- Apple's Accessibility Team for comprehensive documentation
- The iOS accessibility community for best practices
- Contributors who help improve accessibility for all users

---

**Note**: This project is actively developed to showcase accessibility implementations. More features will be added over time to demonstrate additional accessibility capabilities.
