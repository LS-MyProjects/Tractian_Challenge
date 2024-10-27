# Domain Layer Documentation

The Domain layer is responsible for the core business logic of the application, separate from external dependencies like APIs or UI components. It includes three main components: Entities, Repositories, and Use Cases. Each of these components plays a distinct role in ensuring a clean, decoupled business logic.

## Structure

- **Entities**: Core data structures within the application, representing business objects.
- **Repositories (abstract)**: Define interfaces for data interactions without implementation details, ensuring separation of concerns.
- **Use Cases**: Execute specific business logic or operations by interacting with repositories and entities.

---

## Entities

Entities represent fundamental data models in the application, acting as pure representations of business data with minimal logic.

### 1. `Company`

- **Purpose**: Represents a company entity within the application.
- **Attributes**:
  - `id`: Unique identifier for the company.
  - `name`: Name of the company.

#### Key Characteristics:
- Defines the foundational data structure for company information.

### 2. `Location`

- **Purpose**: Represents a physical or logical location associated with a company or asset.
- **Attributes**:
  - `id`: Unique identifier for the location.
  - `name`: Name of the location.
  - `parentId`: ID referencing the parent entity (e.g., a company or asset) to which this location belongs.

#### Key Characteristics:
- Defines the foundational data structure for locations information.

### 3. `Asset`

- **Purpose**: Represents an asset managed by the system, such as equipment or machinery.
- **Attributes**:
  - `id`: Unique identifier for the asset.
  - `name`: Name of the asset.
  - `locationId`: ID representing the asset's location.
  - `sensorType`: Type of sensor associated with the asset.
  - `status`: Operational status of the asset (e.g., active, inactive).
  - `parentId`: ID representing a parent asset.

#### Key Characteristics:
- Defines the foundational data structure for assets information.

### 4. `Component`

- **Purpose**: Represents a component associated with an asset.
- **Attributes**:
  - `id`: Unique identifier for the component.
  - `name`: Name of the component.
  - `sensorType`: Sensor type associated with the component.
  - `status`: Operational status of the component.
  - `parentId`: ID of the asset to which this component belongs.

#### Key Characteristics:
- Defines the foundational data structure for components information.

---

## Repositories (Abstract)

Repositories in the Domain layer are abstract classes that define the contracts for data interaction. They outline methods that the Data layer will implement, keeping the Domain layer decoupled from specific data-fetching logic.

### 1. `CompaniesRepository`

- **Purpose**: Defines methods for accessing company data.
- **Interface**: Contains `getCompanies()` method that returns a `Future<List<Company>>`, representing a list of `Company` entities.

#### Key Methods and Functions:
- **`getCompanies()`**:
  - Initiates an asynchronous request to retrieve a list of companies.
  - Ensures that data retrieval is abstracted from implementation details, providing a clean API for fetching company information.
  - Returns a `Future<List<Company>>` representing a list of companies, or throws an error if data retrieval fails.

### 2. `LocationsRepository`

- **Purpose**: Provides an interface for retrieving location data associated with companies.
- **Interface**: Contains `getLocations(companyId)` that takes a `companyId` as input and returns a `Future<List<Location>>`.

#### Key Methods and Functions:
- **`getLocations(String companyId)`**:
  - Initiates a request to fetch location data for a specific company based on its `companyId`.
  - Abstracts the location retrieval process, allowing data access without exposing the underlying data source.
  - Returns a `Future<List<Location>>`, providing a list of `Location` entities linked to the given `companyId`.

### 3. `AssetsRepository`

- **Purpose**: Defines methods for retrieving assets and their associated components.
- **Interface**: Contains `getAssets(companyId)` and `getComponents(assetId)`.

#### Key Methods and Functions:
- **`getAssets(String companyId)`**:
  - Requests a list of assets associated with a company by `companyId`.
  - Encapsulates the logic for asset retrieval, returning a `Future<List<Asset>>` without revealing implementation specifics.
  - Ensures that any errors encountered during data retrieval are handled properly.

- **`getComponents(String assetId)`**:
  - Fetches components for a specific asset using the `assetId`.
  - Returns a `Future<List<Component>>` containing all components linked to the given `assetId`, facilitating modular management of asset parts.

---

## Use Cases

Use Cases encapsulate specific business logic, interacting with repositories to carry out required operations in line with the application’s needs.

### 1. `GetCompaniesUseCase`

- **Purpose**: Fetches a list of companies from `CompaniesRepository`.
- **Interface**: Defines a `call()` method that executes the use case to retrieve companies.

#### Key Methods and Functions:
- **`call()`**:
  - Starts the asynchronous process to retrieve a list of companies.
  - Calls `getCompanies` from `CompaniesRepository`, and returns a `Future<List<Company>>`.
  - Ensure a robust data access process.

### 2. `GetComponentsUseCase`

- **Purpose**: Retrieves a list of components associated with a specific asset.
- **Interface**: Contains a `call(assetId)` method.

#### Key Methods and Functions:
- **`call(String assetId)`**:
  - Executes a request to retrieve components based on the provided `assetId`.
  - Calls `getComponents` from `AssetsRepository`, and returns a `Future<List<Component>>`.
  - Ensures that components for a specific asset are retrieved efficiently.

### 3. `GetLocationsUseCase`

- **Purpose**: Fetches locations for a given company using `LocationsRepository`.
- **Interface**: Contains a `call(companyId)` method.

#### Key Methods and Functions:
- **`call(String companyId)`**:
  - Executes an operation to retrieve a list of locations for the specified `companyId`.
  - Calls `getLocations` from `LocationsRepository`, and returns a `Future<List<Location>>`.
  - Ensures that locations are retrieved efficiently.

### 4. `FilterAssetsUseCase`

- **Purpose**: Filters assets by criteria like `sensorType` and `status`.
- **Interface**: Defines `call(companyId, {sensorType, status})`.

#### Key Methods and Functions:
- **`call(String companyId, {String? sensorType, String? status})`**:
  - Initiates filtering on assets based on the provided `companyId`, `sensorType`, and `status` parameters.
  - Calls `getAssets` from `AssetsRepository`, applies filters locally, and returns a `List<Asset>`.
  - Enables flexible filtering while maintaining separation from the presentation layer.

### 5. `GetAssetsUseCase`

- **Purpose**: Retrieves assets associated with a company.
- **Interface**: Contains `call(companyId)`.

#### Key Methods and Functions:
- **`call(String companyId)`**:
  - Initiates an operation to fetch all assets associated with a specific `companyId`.
  - Calls `getAssets` from `AssetsRepository` and returns a `Future<List<Asset>>`.
  - Ensures that assets are retrieved efficiently.
