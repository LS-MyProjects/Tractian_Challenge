# Tractian Challenge - Asset Management

This project is an asset management application developed for the Tractian challenge. The application enables users to view companies, locations, assets, and components with detailed information and provides filtering options for efficient navigation.

## Technology Stack

- **Flutter**: Framework for cross-platform mobile development.
- **Flutter Bloc**: State management using the BLoC pattern.
- **Clean Architecture**: Modular and scalable structure, separating `Domain`, `Data`, and `Presentation` layers.
- **HTTP**: Used to connect to the API for data retrieval.
- **Dart**: Programming language used in Flutter development.

## Features

- **Company Display**: Lists all available companies with navigation to their respective assets.
- **Hierarchical Asset View**: Displays the asset tree, including components and locations, in an expandable format.
- **Filters**: Allows filtering of assets by sensor type (e.g., energy) and status (e.g., critical).
- **Status and Type Icons**: Displays visual indicators for critical status (alert) and energy sensors.

## Project Structure

The project follows Clean Architecture principles, with clear separation between `Domain`, `Data`, and `Presentation` layers. Below is an overview of the main directories and files:

### lib/assets
This directory contains static assets such as images used in the app:
- `asset.png`: Icon representing an asset.
- `component.png`: Icon representing a component.
- `location.png`: Icon representing a location.

### lib/core
Contains global configurations and styling used throughout the app.

- **config**:
  - `api_constants.dart`: Contains constants for the API endpoints and other configuration values.

- **ui**:
  - `app_background.dart`: Defines the app’s background gradient.
  - `app_colors.dart`: Defines the primary colors used throughout the app.
  - `app_text_styles.dart`: Specifies the text styles for the app, ensuring consistency.

### lib/features/assets_tree

This is the main feature directory, containing all the code related to asset management functionality. It is organized into subdirectories for data handling, domain logic, and presentation.

#### data
The `Data` layer manages data retrieval from the API. It includes data sources, repositories, and models to handle data interactions and map API responses.

- **datasources**:
  - `assets_remote_datasource.dart`: Fetches asset and component data.
  - `companies_remote_datasource.dart`: Fetches company data.
  - `locations_remote_datasource.dart`: Fetches location data.

- **models**:
  - `asset_model.dart`: Represents the asset model for the API data.
  - `company_model.dart`: Represents the company model for the API data.
  - `component_model.dart`: Represents the component model for the API data.
  - `location_model.dart`: Represents the location model for the API data.

- **repositories**:
  - `assets_repository_impl.dart`: Implements `AssetsRepository`, handling asset data retrieval and manipulation.
  - `companies_repository_impl.dart`: Implements `CompaniesRepository`, handling company data retrieval and manipulation.
  - `locations_repository_impl.dart`: Implements `LocationsRepository`, handling location data retrieval and manipulation.

- **Detailed information**:
  - See the [Data layer documentation](data.md) for more details.

#### domain
The `Domain` layer represents the core business logic of the application, independent of any external dependencies like APIs or Flutter widgets. It contains entities, repositories (abstract), and use cases.

- **entities**:
  - `asset.dart`: Represents an asset entity.
  - `company.dart`: Represents an company entity.
  - `component.dart`: Represents an component entity.
  - `location.dart`: Represents an location entity.

- **repositories**:
  - `assets_repository.dart`: Abstract definition for interacting with asset data.
  - `companies_repository.dart`: Abstract definition for interacting with company data.
  - `locations_repository.dart`: Abstract definition for interacting with location data.

- **usecases**:
  - `filter_assets_usecase.dart`: Use case for filtering assets by criteria such as sensor type and status.
  - `get_assets_usecase.dart`: Use case for retrieving assets associated with a company.
  - `get_companies_usecase.dart`: Use case for retrieving a list of companies.
  - `get_components_usecase.dart`: Use case for retrieving components associated with an asset.
  - `get_locations_usecase.dart`: Use case for retrieving locations associated with a company.

- **Detailed information**:
  - See the [Domain layer documentation](domain.md) for more details.

#### presentation
The `Presentation` layer is responsible for the user interface and handling user interactions. It includes BLoCs for state management, widgets, and pages.

- **bloc**:
  - `assets_bloc.dart`: Manages the state of assets.
  - `companies_bloc.dart`: Manages the state of companies.
  - `filters_bloc.dart`: Manages the state of filters function.
  - `search_bloc.dart`: Manages the state of the search function.

- **pages**:
  - `home_page.dart`: Displays the list of companies.
  - `assets_tree_page.dart`: Shows the hierarchical view of assets, locations, and components with filters and search options.

- **widgets**:
  - `assets_tree_widget.dart`: Renders the asset tree with expandable nodes and indicators for critical status and energy sensors.
  - `company_item_widget.dart`: Custom widget for displaying each company item with a consistent style.
  - `filter_widget.dart`: Provides UI components for asset filtering options.
  - `rounded_button.dart`: A customizable button widget with rounded corners.
  - `search_widget.dart`: A search input field widget.
  
- **Detailed information**:
  - See the [Presentation layer documentation](presentation.md) for more details.

### main.dart
The main entry point of the application. It initializes the app with providers for each BLoC, sets up the theme, and loads the `HomePage`.

---

## Video demonstration
- https://github.com/user-attachments/assets/5c6bb957-0786-4140-85d3-dbcb37864c03



## Future improvements
- See the [Future improvements section](improvements.md) for more details.

---

## Installation and Setup

To set up and run this project locally, follow these steps:

### Prerequisites

Ensure you have the following installed on your machine:

1. **Flutter SDK**: [Install Flutter](https://flutter.dev/docs/get-started/install) and set up the environment variables.
2. **Dart**: Comes with Flutter, but ensure it's correctly configured.
3. **Android Studio or VS Code** (recommended): IDE with Flutter and Dart plugins for development.
4. **API Server**: Ensure the backend server is running or accessible. If using a local API, make sure it’s started before running the app.

### Clone the Repository

1. Open a terminal or command prompt.
2. Clone this repository by running:
   ```bash
    git clone https://github.com/YourUsername/Tractian_Challenge.git
    cd Tractian_Challenge
### Install Dependencies

Inside the project directory, install the necessary packages by running:

1. Open a terminal or command prompt.
2. Clone this repository by running:
   ```bash
    flutter pub get
    ```
    
### Configure API Endpoints

If using a custom or local API, update the API base URL in the configuration files.
Open `lib/core/config/api_constants.dart` and update `baseUrl`:

1. Open a terminal or command prompt.
2. Clone this repository by running:
   ```bash
     class ApiConstants { 
        static const String baseUrl = 'http://127.0.0.1:5000';  // or your live API URL
     }
   ```
   - You can test it using my api: `https://api-tractian-1.onrender.com` , but make sure it's available online first.
   
 
### Install Dependencies
1. Connect a device or start an emulator:
-   Ensure your Android or iOS device is connected, or start an emulator from Android Studio or your device manager.
2. Run the App:
- Execute the following command in the terminal to start the app:
```bash
   flutter run
   ```
- For specific platforms, you can run:
```bash
    flutter run -d android  # for Android
    flutter run -d ios      # for iOS
   ```
   
### Troubleshooting
- Dependency Issues: If you encounter errors related to packages, try running:
```bash
    flutter pub get
    flutter clean
    flutter pub get
   ```
   - Dependency Issues: If you encounter errors related to packages, try running:
```bash
    flutter pub get
    flutter clean
    flutter pub get
   ```
- **API Issues:** Ensure the API server is accessible. If running locally, confirm the API server is started and the base URL matches the configuration.
- **Platform-Specific Errors:** Check Flutter doctor for any environment-specific issues:
```bash
    flutter doctor
   ```
