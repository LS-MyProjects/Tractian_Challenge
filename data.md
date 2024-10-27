# Data Layer Documentation

The Data layer is responsible for managing data interactions within the application, specifically for fetching, structuring, and providing data to other layers. It includes three main components: Data Sources, Models, and Repositories. Each of these components has distinct responsibilities to ensure a clean, consistent data flow.

## Structure

- **Data Sources**: Handle API requests and manage data retrieval from external services.
- **Models**: Define the structure of data objects and manage serialization/deserialization between JSON and Dart objects.
- **Repositories**: Act as an intermediary between the Data Sources and the Domain layer, implementing logic for data formatting and retrieval.

---

## Data Sources

Data sources in this layer interact directly with the API, executing HTTP requests and managing data retrieval.

### 1. `CompaniesRemoteDataSource`

- **Purpose**: Manages API calls related to company data, fetching a list of companies from the server.
- **Interface**: `CompaniesRemoteDataSource` defines a method called `getCompanies()` that returns a `Future<List<CompanyModel>>`. This asynchronous function represents a deferred list of `CompanyModel` objects.

#### Key Methods and Functions:
- **`getCompanies()`**:
  - Sends an HTTP GET request to retrieve a list of companies from the API.
  - Uses `http.Client.get()` with `Uri.parse` to construct the API endpoint.
  - Sets a `timeout` of 5 seconds to handle network delays; if exceeded, it triggers an error.
  - Parses the JSON response using `json.decode`, and maps each item to a `CompanyModel` instance using `CompanyModel.fromJson`.
  - Returns a `Future` containing a list of companies if successful, or throws an exception if the request fails.

### 2. `LocationsRemoteDataSource`

- **Purpose**: Manages API calls to fetch location data specific to a company.
- **Interface**: `LocationsRemoteDataSource` defines `getLocations(companyId)`, which returns a `Future<List<LocationModel>>`.

#### Key Methods and Functions:
- **`getLocations(String companyId)`**:
  - Constructs the URL endpoint using `companyId` to fetch locations associated with a specific company.
  - Executes a GET request with a 5-second timeout.
  - Decodes the JSON response and maps each item to a `LocationModel` using the `LocationModel.fromJson` method.
  - Returns a `Future` with a list of `LocationModel` instances or throws an exception for error handling.

### 3. `AssetsRemoteDataSource`

- **Purpose**: Handles the retrieval of assets and their components from the API.
- **Interface**: Defines two methods:
  - `getAssets(companyId)`: Retrieves assets for a given company.
  - `getComponents(assetId)`: Retrieves components associated with a specific asset.

#### Key Methods and Functions:
- **`getAssets(String companyId)`**:
  - Constructs the endpoint using `companyId` and sends a GET request to fetch assets related to the company.
  - Uses a 15-second timeout to accommodate potentially larger data sets.
  - Decodes the JSON response and maps it into a list of `AssetModel` instances using `AssetModel.fromJson`.
  - Returns a `Future` containing a list of assets or throws an exception if the request fails.

- **`getComponents(String assetId)`**:
  - Constructs the endpoint with `assetId` to fetch components for a specific asset.
  - Uses a 15-second timeout to accommodate potentially larger data sets.
  - Parses the JSON response and maps each item to a `ComponentModel` instance.
  - Returns a `Future` with a list of components or throws an exception if there’s a failure.

---

## Models

Models define the structure of data objects used within the app, converting between API JSON and application-specific data formats.

### 1. `CompanyModel`

- **Purpose**: Represents a company entity with attributes like `id` and `name`.
- **Attributes**:
  - `id`: Unique identifier for the company.
  - `name`: Name of the company.

#### Key Methods and Functions:
- **`fromJson(Map<String, dynamic> json)`**:
  - A factory constructor that creates a `CompanyModel` instance from a JSON map.
  - Parses fields from JSON, mapping `id` and `name` directly to the instance properties.
  
- **`toJson()`**:
  - Converts a `CompanyModel` instance back to JSON format.
  - Creates a `Map<String, dynamic>` with keys `id` and `name` to maintain compatibility with the API.

### 2. `LocationModel`

- **Purpose**: Represents a location entity with attributes like `id`, `name`, and `parentId`.
- **Attributes**:
  - `id`: Unique identifier for the location.
  - `name`: Name of the location.
  - `parentId`: References the parent company.

#### Key Methods and Functions:
- **`fromJson(Map<String, dynamic> json)`**:
  - Converts JSON data into a `LocationModel` instance.
  - Maps the `id`, `name`, and `parentId` fields to the instance properties.

- **`toJson()`**:
  - Converts a `LocationModel` instance into JSON format.
  - Produces a map with keys corresponding to the `id`, `name`, and `parentId` for API compatibility.

### 3. `AssetModel`

- **Purpose**: Represents an asset entity with data attributes like `id`, `name`, `locationId`, `parentId`, `sensorType`, and `status`.
- **Attributes**:
  - `id`: Unique identifier of the asset.
  - `name`: Asset’s name.
  - `locationId`: Location ID where the asset is found.
  - `parentId`: ID of the parent asset (if applicable).
  - `sensorType`: Type of sensor associated with the asset.
  - `status`: Operational status of the asset.

#### Key Methods and Functions:
- **`fromJson(Map<String, dynamic> json)`**:
  - Parses JSON to create an `AssetModel` instance.
  - Maps `id`, `name`, `locationId`, `parentId`, `sensorType`, and `status` from JSON to instance properties.

- **`toJson()`**:
  - Serializes an `AssetModel` into JSON format, creating a `Map<String, dynamic>` for API requests.

### 4. `ComponentModel`

- **Purpose**: Represents a component entity related to an asset.
- **Attributes**:
  - `id`: Component’s unique identifier.
  - `name`: Name of the component.
  - `sensorType`: Sensor type, if applicable.
  - `status`: Operational status of the component.
  - `parentId`: ID of the parent asset to which it belongs.

#### Key Methods and Functions:
- **`fromJson(Map<String, dynamic> json)`**:
  - Parses JSON data to create a `ComponentModel` instance.
  - Maps the `id`, `name`, `sensorType`, `status`, and `parentId` fields to instance properties.

- **`toJson()`**:
  - Converts a `ComponentModel` instance to JSON format for API interactions.

---

## Repositories

Repositories act as intermediaries between the Data Sources and the Domain layer, providing a structured API for data retrieval and managing data flow.

### 1. `CompaniesRepositoryImpl`

- **Purpose**: Implements `CompaniesRepository`, handling data retrieval for company information.
- **Data Source**: Depends on `CompaniesRemoteDataSource`.
- **Key Methods and Functions**:
  - **`getCompanies()`**: Calls `getCompanies` on the remote data source to retrieve a list of companies. Returns a `Future<List<Company>>` and handles any exceptions thrown by the data source.

### 2. `LocationsRepositoryImpl`

- **Purpose**: Implements `LocationsRepository` for managing location data retrieval.
- **Data Source**: Uses `LocationsRemoteDataSource`.
- **Key Methods and Functions**:
  - **`getLocations(String companyId)`**: Retrieves location data by calling `getLocations` in `LocationsRemoteDataSource` with a `companyId`. Returns a `Future<List<Location>>` or throws an exception for error handling.

### 3. `AssetsRepositoryImpl`

- **Purpose**: Implements `AssetsRepository`, responsible for retrieving assets and components.
- **Data Source**: Uses `AssetsRemoteDataSource`.
- **Key Methods and Functions**:
  - **`getAssets(String companyId)`**: Calls `getAssets` from the remote data source with a `companyId`. Returns a list of `Asset` entities for the given company.
  - **`getComponents(String assetId)`**: Retrieves components by calling `getComponents` in `AssetsRemoteDataSource` with an `assetId`. Returns a list of `Component` entities related to the asset.
