# 🚀 Flutter MVVM BLoC & Cubit Architecture (Using SOLID Principles)⁣
⁣
A scalable Flutter architecture that combines MVVM (Model-View-ViewModel), BLoC & Cubit state management, and follows the SOLID principles to maintain clean, maintainable, and testable code.⁣
⁣
## 📦 Project Structure⁣
⁣
This project follows a clean, layered architecture:⁣
⁣
lib/⁣
├── core/                             # App initialization, base states, firebase config⁣
│   └── Contains foundational setup files like app_initialization, base states, firebase config⁣
│⁣
├── data/                             # API services, network layer, response models⁣
│   ├── model/                        # Generic data models like Result, Serializable⁣
│   ├── network/                      # API calls and configuration (URLs, base service)⁣
│   │   └── env/                      # Environment-specific variables or config⁣
│   ├── storage/                      # Local storage or shared preferences (if any)⁣
│   └── ui_state/                     # UIState abstraction for handling loading/error/success states⁣
│⁣
├── dependency_injection/            # Service locator setup (e.g., GetIt)⁣
│   └── Central registration point for all services, repositories, cubits⁣
│⁣
├── enum/                             # Application-wide enums (e.g., user roles, status types)⁣
│⁣
├── features/                         # Feature-specific folders (modular architecture)⁣
│   ├── authentication/              # Auth-related logic⁣
│   │   ├── api_request/             # Request payloads (DTOs)⁣
│   │   ├── cubit/                   # Cubit classes for state management⁣
│   │   ├── model/                   # Feature-specific models (e.g., login response)⁣
│   │   ├── repository/              # Abstraction and implementation of auth repository⁣
│   │   ├── service/                 # Business logic layer (calls API or local DB)⁣
│   │   └── view/                    # UI screens, widgets for authentication⁣
│   ├── profile/                     # Profile-related logic⁣
│   │   ├── api_request/             # Request payloads for updating/fetching profile⁣
│   │   ├── cubit/                   # Profile state management⁣
│   │   ├── model/                   # Profile models (e.g., UserProfile)⁣
│   │   ├── repository/              # Profile repo abstractions and implementations⁣
│   │   ├── service/                 # Profile business logic⁣
│   │   └── view/                    # Profile UI⁣
│   └── splash/                      # Splash screen feature (intro, logo, navigation)⁣
│⁣
├── helpers/                          # Utility functions⁣
│   └── analytics_helper.dart        # Firebase or analytics-related logic⁣
│   └── date_helper.dart             # Date formatting and time utilities⁣
│⁣
├── routing/                          # App routing and navigation⁣
│   ├── app_route_name.dart          # Route name constants⁣
│   └── app_routes.dart              # Route configuration and navigation logic⁣
│⁣
├── service/                          # Independent services used across the app⁣
│   ├── hasInternet/                 # Connectivity check service⁣
│   └── pushNotification/           # Push notification config, payload, display logic⁣
│       ├── notification_helper.dart⁣
│       ├── notification_payload.dart⁣
│       ├── notification_service.dart⁣
│       └── notification_view.dart⁣
│⁣
├── utils/                            # Reusable UI components and extensions⁣
│   ├── common_dialog_view/         # Custom dialogs⁣
│   ├── extensions/                 # String, DateTime, Iterable extensions, etc.⁣
│   ├── textFieldInputFormatter/    # Input formatting logic⁣
│   ├── upload_images_and_documents/ # Uploading utility⁣
│   ├── app_application_bar.dart    # Custom app bar widget⁣
│   ├── app_bottom_sheet_body.dart  # Bottom sheet UI⁣
│   ├── app_button.dart             # Button component⁣
│   ├── app_button_style.dart       # Button styles⁣
│   ├── app_check_box.dart          # Checkbox UI⁣
│   ├── app_colors.dart             # App color palette⁣
│   ├── app_dropdown.dart           # Dropdown UI⁣
│   ├── app_global_variables.dart   # Shared global values/constants⁣
│   ├── app_icon_button.dart        # Icon button UI⁣
│   ├── app_icons.dart              # Centralized icon set⁣
│   ├── app_image.dart              # Image UI handler⁣
│   ├── app_json.dart               # JSON-related utilities⁣
│   ├── app_route.dart              # Route helper or redirection logic⁣
│   ├── app_search_bar.dart         # Custom search bar UI⁣
│   └── app_string.dart             # Centralized string constants⁣
│⁣
└── main.dart                         # Application entry point⁣
⁣
⁣
⁣
## 📦 Project Structure⁣
⁣
This project follows a clean, layered architecture:⁣
⁣
- [MVVM design pattern for clear separation of concerns]⁣
- [BLoC & Cubit for reactive state management]⁣
- [Strict adherence to SOLID principles]⁣
- [Dependency Injection using get_it]⁣
- [Scalable and testable folder structure]⁣
- [Error handling using sealed UIState pattern]⁣
  ⁣
  ⁣
  ⁣
## 💡 SOLID Principles Applied⁣
⁣
This project follows a clean, layered architecture:⁣
⁣
Principle	                      Description⁣
S - Single Responsibility	      Each class/component has one clear responsibility⁣
O - Open/Closed	                  Entities are open for extension, closed for modification⁣
L - Liskov Substitution	          Interfaces implemented by substitutable components⁣
I - Interface Segregation	      No client is forced to depend on unused methods⁣
D - Dependency Inversion	      High-level modules depend on abstractions, not concretions⁣
⁣
⁣
⁣
