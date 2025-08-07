# 🚀 Flutter MVVM BLoC & Cubit Architecture (Using SOLID Principles)
A scalable Flutter architecture that combines MVVM (Model-View-ViewModel), BLoC & Cubit state management, and follows the SOLID principles to maintain clean, maintainable, and testable code.

&nbsp;
&nbsp;
&nbsp;
&nbsp;
&nbsp;
&nbsp;

## 💡 SOLID Principles Applied
This project follows a clean, layered architecture:

| Principle                     | Description                                                             |
|-------------------------------|-------------------------------------------------------------------------|
| **S - Single Responsibility** | Each class/component has one clear responsibility                       |
| **O - Open/Closed**           | Entities are open for extension, closed for modification                |
| **L - Liskov Substitution**   | Interfaces implemented by substitutable components                      |
| **I - Interface Segregation** | No client is forced to depend on unused methods                         |
| **D - Dependency Inversion**  | High-level modules depend on abstractions, not concretions              |


&nbsp;
&nbsp;
&nbsp;
&nbsp;
&nbsp;
&nbsp;


## 📦 Project Structure
This project follows a clean, layered architecture:

- MVVM design pattern for clear separation of concerns
- BLoC & Cubit for reactive state management
- Strict adherence to SOLID principles
- Dependency Injection using get_it
- Scalable and testable folder structure
- Error handling using sealed UIState pattern


```text
lib/
├── core/                             # App initialization, base states, firebase config
│   └── Contains foundational setup files like app_initialization, base states, firebase config
│
├── data/                             # API services, network layer, response models
│   ├── model/                        # Generic data models like Result, Serializable
│   ├── network/                      # API calls and configuration (URLs, base service)
│   │   └── env/                      # Environment-specific variables or config
│   ├── storage/                      # Local storage or shared preferences (if any)
│   └── ui_state/                     # UIState abstraction for handling loading/error/success states
│
├── dependency_injection/            # Service locator setup (e.g., GetIt)
│   └── Central registration point for all services, repositories, cubits
│
├── enum/                             # Application-wide enums (e.g., user roles, status types)
│
├── features/                         # Feature-specific folders (modular architecture)
│   ├── authentication/              # Auth-related logic
│   │   ├── api_request/             # Request payloads (DTOs)
│   │   ├── cubit/                   # Cubit classes for state management
│   │   ├── model/                   # Feature-specific models (e.g., login response)
│   │   ├── repository/              # Abstraction and implementation of auth repository
│   │   ├── service/                 # Business logic layer (calls API or local DB)
│   │   └── view/                    # UI screens, widgets for authentication
│   ├── profile/                     # Profile-related logic
│   │   ├── api_request/             # Request payloads for updating/fetching profile
│   │   ├── cubit/                   # Profile state management
│   │   ├── model/                   # Profile models (e.g., UserProfile)
│   │   ├── repository/              # Profile repo abstractions and implementations
│   │   ├── service/                 # Profile business logic
│   │   └── view/                    # Profile UI
│   └── splash/                      # Splash screen feature (intro, logo, navigation)
│
├── helpers/                          # Utility functions
│   └── analytics_helper.dart        # Firebase or analytics-related logic
│   └── date_helper.dart             # Date formatting and time utilities
│
├── routing/                          # App routing and navigation
│   ├── app_route_name.dart          # Route name constants
│   └── app_routes.dart              # Route configuration and navigation logic
│
├── service/                          # Independent services used across the app
│   ├── hasInternet/                 # Connectivity check service
│   └── push_notification/           # Push notification config, payload, display logic
│       ├── notification_helper.dart
│       ├── notification_payload.dart
│       ├── notification_service.dart
│       └── notification_view.dart
│
├── utils/                            # Reusable UI components and extensions
│   ├── common_dialog_view/         # Custom dialogs
│   ├── extensions/                 # String, DateTime, Iterable extensions, etc.
│   ├── text_field_input_formatter/    # Input formatting logic
│   ├── upload_images_and_documents/ # Uploading utility
│   ├── app_application_bar.dart    # Custom app bar widget
│   ├── app_bottom_sheet_body.dart  # Bottom sheet UI
│   ├── app_button.dart             # Button component
│   ├── app_button_style.dart       # Button styles
│   ├── app_check_box.dart          # Checkbox UI
│   ├── app_colors.dart             # App color palette
│   ├── app_dropdown.dart           # Dropdown UI
│   ├── app_global_variables.dart   # Shared global values/constants
│   ├── app_icon_button.dart        # Icon button UI
│   ├── app_icons.dart              # Centralized icon set
│   ├── app_image.dart              # Image UI handler
│   ├── app_json.dart               # JSON-related utilities
│   ├── app_route.dart              # Route helper or redirection logic
│   ├── app_search_bar.dart         # Custom search bar UI
│   └── app_string.dart             # Centralized string constants
│
└── main.dart                         # Application entry point
```

&nbsp;
&nbsp;
&nbsp;
&nbsp;
&nbsp;
&nbsp;


## 🧩 Asset Management & Icon Configuration
Assets are well-organized in the assets/icons/ directory and are referenced through a centralized Dart file, ensuring clean code, easy access, and consistency across the app.
This Flutter project adheres strictly to naming and structural conventions to ensure scalability and maintainability.

&nbsp;
&nbsp;
&nbsp;
&nbsp;
&nbsp;
&nbsp;

## 🎨 Folder Structure: assets/icons/
All asset files follow the snake_case naming convention:

```text
assets/
└── icons/
    ├── png/
    │   └── image_break.png
    ├── gif/
    └── svg/
        ├── camera.svg
        ├── clear_outline.svg
        ├── close_circle_outline.svg
```

- Dart class filenames should be in snake_case.dart (e.g., app_icons.dart)
- Folder names should be in snake_case/ (e.g., utils/, features/, etc.)
- Asset files should use snake_case
- Dart variable names should follow camelCase

&nbsp;
&nbsp;
&nbsp;
&nbsp;
&nbsp;
&nbsp;

## 📁 Feature Folder Structure Explained
🔷 Root: features/
Organizes the app by independent modules, making it scalable and maintainable.

Example:
```text
features/
├── authentication/
└── splash/
``` 
Each feature contains its own logic, views, state, and service layer, keeping responsibilities isolated.

&nbsp;
&nbsp;

📁 authentication/
A self-contained module responsible for login, signup, OTP, password reset, etc.

✅ Subfolders:

```text
| Folder             | Purpose                                                                                                                             |
| ------------------ | ----------------------------------------------------------------------------------------------------------------------------------- |
| **`api_request/`** | Contains **DTO (Data Transfer Object)** models or request body classes for API calls.<br>🔹 e.g., `LoginRequest`, `RegisterPayload` |
| **`cubit/`**       | Houses **Cubit** or **Bloc** classes for state management.<br>🔹 e.g., `AuthCubit`, `LoginState`                                    |
| **`model/`**       | Contains response models or shared business models.<br>🔹 e.g., `UserModel`, `LoginResponse`                                        |
| **`repository/`**  | Defines abstract interfaces and concrete implementations that call services.<br>🔹 e.g., `IAuthRepository`, `AuthRepositoryImpl`    |
| **`service/`**     | Contains classes responsible for actual **API calls or business logic**.<br>🔹 e.g., `AuthService`, `FirebaseAuthService`           |
| **`view/`**        | UI layer: Screens, pages, widgets used to build the authentication flow.<br>🔹 e.g., `login_screen.dart`, `otp_widget.dart`         |
``` 

&nbsp;
&nbsp;

💡 Example Workflow (Login Feature)
```text
1. View (login_screen.dart)
   ⬇ calls
2. Cubit (auth_cubit.dart)
   ⬇ calls
3. Repository (auth_repository.dart)
   ⬇ calls
4. Service (auth_service.dart)
   ⬇ calls
5. Sends API Request (login_request.dart)
   ⬅ Receives Response (login_response.dart)
6. Model parsed and handled
``` 
This follows the MVVM + BLoC pattern, where View → ViewModel (Cubit) → Repository → Service → API/Local

&nbsp;
&nbsp;
&nbsp;
&nbsp;
&nbsp;
&nbsp;

## 🧱 Benefits of This Structure
- Scalable: Easy to add new features without affecting others.
- Testable: You can test cubit, service, and repository independently.
- Maintainable: Clean separation of responsibilities aligns with SRP from SOLID.
- Extensible: New features (like profile/, settings/) can follow the same structure.

