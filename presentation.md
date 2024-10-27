# Presentation Layer Documentation

The Presentation layer is responsible for the user interface and handling user interactions in the application. It uses BLoC for state management and includes UI components such as pages and widgets. The main components are organized as follows:

## Structure

- **Pages**: Screens representing different parts of the application, each typically tied to a specific feature.
- **Widgets**: Reusable UI components that make up the visual elements of the pages.
- **BLoC (Business Logic Component)**: Manages state and handles events to separate business logic from UI, following the BLoC pattern.

---

## Pages

Pages in the Presentation layer represent the primary screens of the application. They display data, manage interactions, and often incorporate widgets and BLoCs to handle business logic and state.

### 1. `HomePage`

- **Purpose**: The main entry point of the application, displaying a list of companies and handling navigation to the asset tree view for each company.
- **BLoC Integration**: Uses `CompaniesBloc` to manage company data loading and state.

#### Key Methods and Functions:
- **`build()`**:
  - Builds the `Scaffold` widget with an `AppBar` and a `BlocBuilder` to render UI based on the `CompaniesBloc` state.
  - Displays a loading indicator while company data is being fetched.
  - Shows a list of `CompanyItemWidget` instances, each representing a company, when data loading is complete.
  - Shows an error message if loading fails, ensuring a smooth user experience with feedback for different states&#8203;:contentReference[oaicite:0]{index=0}.

### 2. `AssetsTreePage`

- **Purpose**: Displays the hierarchical asset tree for a selected company, with options for filtering and searching assets.
- **BLoC Integration**: Uses `AssetsBloc` for managing asset data and applying filters.

#### Key Methods and Functions:
- **`initState()`**:
  - Triggers the `LoadAssets` event to fetch assets when the page is loaded, initializing the asset data based on the selected company.

- **`_applyFilters()`**:
  - Updates asset display by triggering the `ApplyFilters` event in `AssetsBloc` based on the current search query, sensor type, and status filters.

- **`build()`**:
  - Builds the `Scaffold` with an `AppBar` and a layout consisting of search input, filter checkboxes, and an expandable list of assets.
  - Uses `BlocBuilder` to listen to `AssetsBloc` states and render either a loading spinner, a filtered asset list, or an error message&#8203;:contentReference[oaicite:1]{index=1}.

---

## Widgets

Widgets are reusable components within the Presentation layer, designed to build the user interface with modular and flexible elements.

### 1. `FilterWidget`

- **Purpose**: Provides dropdowns for filtering assets by sensor type and status, enhancing asset search functionality.
- **BLoC Integration**: Uses `FiltersBloc` to manage filter state changes.

#### Key Methods and Functions:
- **`build()`**:
  - Creates a column with dropdown menus for selecting `sensorType` and `status` filters.
  - Triggers filter events (`FilterBySensorType` and `FilterByStatus`) based on user selections, updating the asset list view according to the chosen filters&#8203;:contentReference[oaicite:2]{index=2}.

### 2. `SearchWidget`

- **Purpose**: Allows users to search for assets by name within the asset tree view.
- **BLoC Integration**: Uses `SearchBloc` to handle search events and manage search state.

#### Key Methods and Functions:
- **`build()`**:
  - Builds a `TextField` with a search icon and input decoration.
  - Listens for text changes, triggering `SearchByName` events in `SearchBloc` as the user types, enabling dynamic search functionality&#8203;:contentReference[oaicite:3]{index=3}.

### 3. `AssetsTreeWidget`

- **Purpose**: Renders the hierarchical structure of assets and components for a company in an expandable tree format.
- **Attributes**:
  - `assets`: List of `Asset` objects to be displayed in the tree structure.

#### Key Methods and Functions:
- **`build()`**:
  - Filters root assets (those without a `parentId`) and builds an expandable list using a `ListView.builder`.

- **`_buildAssetNode(Asset asset)`**:
  - Recursively builds each asset node with expansion capabilities for child assets.
  - Displays indicators for critical status (e.g., an alert icon) and sensor type (e.g., a flash icon for energy sensors), providing visual cues for asset properties&#8203;:contentReference[oaicite:4]{index=4}.

### 4. `CompanyItemWidget`

- **Purpose**: Represents a single company item in the company list on the `HomePage`, with navigation functionality to the asset tree view.
- **Attributes**:
  - `company`: The `Company` instance represented by the widget.

#### Key Methods and Functions:
- **`build()`**:
  - Builds an `ElevatedButton` styled with a company icon and company name.
  - On tap, navigates to `AssetsTreePage`, passing the selected `companyId` to load the associated asset tree&#8203;:contentReference[oaicite:5]{index=5}.

### 5. `RoundedButton`

- **Purpose**: Provides a customizable rounded button with an icon and text, used within filters and other UI components.
- **Attributes**:
  - `text`: The label displayed on the button.
  - `icon`: The icon shown beside the text.
  - `isActive`: Boolean to control the button’s active/inactive state.
  - `onPressed`: Callback function for button tap events.

#### Key Methods and Functions:
- **`build()`**:
  - Constructs an `ElevatedButton.icon` with dynamic styling based on `isActive`.
  - Styles the button with colors, padding, and rounded corners to enhance the app’s visual consistency&#8203;:contentReference[oaicite:6]{index=6}.

---

## BLoC (Business Logic Component)

The BLoC files in the Presentation layer are essential for managing state and handling user-triggered events. Each BLoC defines events and states relevant to its feature, ensuring a clean separation of logic from the UI.

### 1. `FiltersBloc`

- **Purpose**: Manages state for filtering assets by sensor type and status.
- **Events**:
  - `FilterBySensorType`: Sets the `sensorType` filter.
  - `FilterByStatus`: Sets the `status` filter.
  - `ClearFilters`: Resets all filters to their default state.

#### Key Methods and Functions:
- **`mapEventToState(FiltersEvent event)`**:
  - Responds to `FilterBySensorType`, `FilterByStatus`, and `ClearFilters` events.
  - Updates the `FiltersState` to reflect changes in filter selection, enabling dynamic updates in the filtered asset list&#8203;:contentReference[oaicite:7]{index=7}.

### 2. `SearchBloc`

- **Purpose**: Manages the search state for filtering assets by name.
- **Events**:
  - `SearchByName`: Updates the search query based on user input.

#### Key Methods and Functions:
- **`mapEventToState(SearchEvent event)`**:
  - Listens for `SearchByName` events, updating the `SearchState` to hold the current search query.
  - Allows real-time search functionality, ensuring the asset list displays results matching the query&#8203;:contentReference[oaicite:8]{index=8}.

### 3. `AssetsBloc`

- **Purpose**: Manages the asset data and applies filters based on user selection.
- **Events**:
  - `LoadAssets`: Fetches assets for a specified company.
  - `ApplyFilters`: Filters assets by search query, sensor type, or critical status.

#### Key Methods and Functions:
- **`_onLoadAssets(LoadAssets event, Emitter<AssetsState> emit)`**:
  - Triggers asset data retrieval by calling `getAssetsUseCase` and updating the state with loaded assets or an error message if data retrieval fails.

- **`_onApplyFilters(ApplyFilters event, Emitter<AssetsState> emit)`**:
  - Filters the list of assets based on `searchQuery`, `filterByEnergySensor`, and `filterByCriticalStatus`.
  - Emits a filtered `AssetsLoaded` state, reflecting the applied filters and search criteria&#8203;:contentReference[oaicite:9]{index=9}.

### 4. `CompaniesBloc`

- **Purpose**: Manages the state for loading and displaying companies on the `HomePage`.
- **Events**:
  - `LoadCompanies`: Initiates the retrieval of companies when triggered.

#### Key Methods and Functions:
- **`on<LoadCompanies>((event, emit) async)`**:
  - Calls `getCompaniesUseCase` to retrieve a list of companies.
  - Emits `CompaniesLoaded` with the list of companies on successful data retrieval or `CompaniesError` if an error occurs&#8203;:contentReference[oaicite:10]{index=10}.
