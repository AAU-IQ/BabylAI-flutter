<p align="center">
  <img src="https://babylai.net/assets/33-C9VTGXuK.png" alt="BabylAI Logo" height="200"/>
</p>

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

# BabylAI Flutter Package

A Flutter package that provides integration with BabylAI chat functionality, supporting multiple themes and languages.

## Features

- 🚀 Easy integration with BabylAI chat
- 🌓 Support for light and dark themes
- 🌍 Multilingual support (English and Arabic)
- 📬 Message receiving callback for custom notification handling
- ⚡ Quick access to active chats
- 🏗️ Environment-based configuration (Production/Development)
- 🔒 Secure, predefined API endpoints

## Installation

Since this is a private package, you'll need to add it to your `pubspec.yaml`:

```yaml
dependencies:
  babylai:
    git:
      url: https://github.com/your-organization/babylai.git
      ref: master  # or specify a version tag
```

If the repository requires authentication, you'll need to configure your Git credentials or use an access token.

## Usage

### 1. Initialize BabylAI with Environment Configuration

First, initialize BabylAI with the appropriate environment configuration and set up the token callback:

```dart
void main() {
  // Initialize BabylAI with environment configuration
  BabylAI.initialize(
    environmentConfig: EnvironmentConfig.development(), // or .production()
    screenId: 'YOUR_SCREEN_ID',
  );
  
  // IMPORTANT: You MUST set up a token callback for the package to work
  BabylAI.setTokenCallback(() async {
    // Example implementation to get a token
    return await getToken(); // Return your access token as string
  });
  
  runApp(MyApp());
}
```

> ⚠️ **Important**: You must call `BabylAI.initialize()` and `BabylAI.setTokenCallback()` before using any other BabylAI functionality. Failure to do so will result in authentication errors when trying to launch the chat interface.

### Environment Configuration

The package supports two environments:

- **Production**: Uses production API endpoints, logging disabled by default
- **Development**: Uses development API endpoints, logging enabled by default

You can customize additional settings:

```dart
// Production environment with custom settings
BabylAI.initialize(
  environmentConfig: EnvironmentConfig.production(
    enableLogging: false,
    connectionTimeout: 30000,
    receiveTimeout: 15000,
  ),
  screenId: 'YOUR_SCREEN_ID',
);

// Development environment with custom settings
BabylAI.initialize(
  environmentConfig: EnvironmentConfig.development(
    enableLogging: true,
    connectionTimeout: 30000,
    receiveTimeout: 15000,
  ),
  screenId: 'YOUR_SCREEN_ID',
);
```

### 2. Basic Implementation

Here's a simple example of how to integrate BabylAI in your Flutter app:

```dart
import 'package:babylai/babylai.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              BabylAI.launch(
                'en',  // language code
                ThemeMode.light,  // theme mode
                context,
                onMessageReceived: (message) {
                  // Handle new message notifications
                  print('New message: $message');
                },
              );
            },
            child: Text('Open BabylAI Chat'),
          ),
        ),
      ),
    );
  }
}
```

### 3. Advanced Implementation

For a more complete implementation with theme and language switching:

```dart
class BabylAIExample extends StatelessWidget {
  final ThemeMode themeMode;
  final String locale;
  final ValueChanged<bool> onThemeToggle;
  final ValueChanged<bool> onLanguageToggle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        BabylAI.launch(
          locale,
          themeMode,
          context,
          onMessageReceived: (message) {
            // Implement your own notification handling here
            // You can use any notification package or custom implementation
          },
        );
      },
      child: Text('Launch Babyl AI'),
    );
  }
}
```

## API Reference

### BabylAI Class

#### Methods

- `BabylAI.initialize({required EnvironmentConfig environmentConfig, required String screenId})`: Initialize BabylAI with environment configuration
- `BabylAI.setTokenCallback(Future<String> Function() callback)`: Set a callback function that will be called when the token needs to be refreshed
- `BabylAI.launch(String locale, ThemeMode themeMode, BuildContext context, {Function(String) onMessageReceived})`: Launch the BabylAI chat interface
- `BabylAI.lauchActiveChat()`: Open the currently active chat session

#### Environment Configuration

- `EnvironmentConfig.production({bool enableLogging, int connectionTimeout, int receiveTimeout})`: Create production environment configuration
- `EnvironmentConfig.development({bool enableLogging, int connectionTimeout, int receiveTimeout})`: Create development environment configuration

### Token Callback

The token callback is essential for authentication with the BabylAI service. The callback should:

1. Make an API request to get a fresh token
2. Parse the response correctly (the token is at the root level with key "token")
3. Return the token as a string
4. Handle errors appropriately

Example response structure:
```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "expiresIn": 900
}
```

### Automatic Token Refresh

The package automatically handles token expiration by:

1. Detecting 401 (Unauthorized) or 403 (Forbidden) HTTP errors
2. Automatically calling your token callback to get a fresh token
3. Storing the new token for subsequent requests

This ensures that your users won't experience disruptions when their token expires during a session.

### Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| locale | String | Language code ('en' for English, 'ar' for Arabic) |
| themeMode | ThemeMode | Flutter's ThemeMode (light/dark) |
| onMessageReceived | Function(String) | Callback for handling new messages |

## Message Handling

The package provides a callback for handling new messages through the `onMessageReceived` parameter. You can implement your own notification system or message handling logic. Here's an example of how you might handle new messages:

```dart
BabylAI.launch(
  locale,
  themeMode,
  context,
  onMessageReceived: (message) {
    // Implement your preferred notification system
    // For example, using flutter_local_notifications
    // or any other notification package
    showCustomNotification(message);
  },
);
```

## Contributing

For any issues or feature requests, please contact the package maintainers or submit an issue on the repository.

## License

Copyright © 2024 BabylAI

This software is provided under a custom license agreement. Usage is permitted only with explicit authorization from BabylAI. This software may not be redistributed, modified, or used in derivative works without written permission from BabylAI.

All rights reserved.
