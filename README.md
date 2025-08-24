# Flutter Clean Architecture with Cubit Guide

A comprehensive Flutter project demonstrating Clean Architecture principles with Cubit state management, featuring a complete authentication flow.

## 🏗️ Architecture Overview

This project follows Clean Architecture principles with a clear separation of concerns:

```bash
lib/
├── app/                    # Application layer
│   ├── app.dart          # Main app configuration
│   ├── di/               # Dependency injection
│   ├── router/           # Navigation and routing
│   └── config/           # Environment and build configuration
├── core/                  # Core functionality
│   ├── error/            # Error handling and failures
│   ├── network/          # HTTP client and interceptors
│   ├── storage/          # Local storage interfaces
│   ├── utils/            # Utility functions and validators
│   └── constants/        # App constants and keys
├── features/              # Feature modules
│   ├── auth/             # Authentication feature
│   │   ├── domain/       # Business logic and entities
│   │   ├── data/         # Data sources and repositories
│   │   └── presentation/ # UI and state management
│   └── home/             # Home feature
└── shared/                # Shared components
    ├── widgets/           # Reusable UI components
    ├── theme/             # App theming
    └── localization/      # Internationalization
```

## 🚀 Features

- **Clean Architecture**: Clear separation of concerns with domain, data, and presentation layers
- **State Management**: Flutter Bloc (Cubit) for predictable state management
- **Dependency Injection**: GetIt for service locator pattern
- **HTTP Client**: Dio with custom interceptors for authentication and logging
- **Local Storage**: Secure storage for tokens and SharedPreferences for user data
- **Routing**: GoRouter for declarative routing with guards
- **Error Handling**: Comprehensive error handling with domain-specific failures
- **Validation**: Form validation utilities
- **Theming**: Material 3 design with light/dark theme support

## 📱 Authentication Flow

1. **Splash Screen**: Checks authentication status on app start
2. **Login/Register**: User authentication with form validation
3. **Token Management**: Automatic token refresh and secure storage
4. **Protected Routes**: Authentication-based navigation
5. **Profile Management**: User profile viewing and editing

## 🛠️ Dependencies

### Core Dependencies

- `flutter_bloc`: State management
- `dio`: HTTP client
- `get_it`: Dependency injection
- `go_router`: Navigation
- `equatable`: Value equality
- `json_annotation`: JSON serialization

### Storage Dependencies

- `shared_preferences`: Local key-value storage
- `flutter_secure_storage`: Secure token storage

### Development Dependencies

- `build_runner`: Code generation
- `injectable_generator`: DI code generation
- `json_serializable`: JSON code generation

### Build Configuration

The app automatically detects build types and enables appropriate features:

- **Debug**: Full logging, debug features
- **Profile**: Performance monitoring, limited logging
- **Release**: Analytics, crash reporting, minimal logging

## 🏗️ Project Structure

### Domain Layer

- **Entities**: Core business objects (User, AuthTokens)
- **Repositories**: Abstract interfaces for data operations
- **Use Cases**: Business logic implementation

### Data Layer

- **Models**: Data transfer objects with JSON serialization
- **Data Sources**: Remote (API) and local (storage) data access
- **Repository Implementations**: Concrete implementations of domain repositories

### Presentation Layer

- **Pages**: Full-screen UI components
- **Widgets**: Reusable UI components
- **Cubits**: State management for UI logic
- **States**: Immutable state representations

## 🔐 Authentication Implementation

### Token Management

- Access tokens with automatic refresh
- Secure storage using flutter_secure_storage
- Interceptor-based token injection

### Error Handling

- Domain-specific failure types
- Automatic error mapping from exceptions
- User-friendly error messages

### State Management

- Authentication state management with Cubit
- Loading, success, error, and authenticated states
- Automatic navigation based on auth state

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
