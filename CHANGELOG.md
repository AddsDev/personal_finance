# Change Log

All notable changes to this project will be documented in this file.
See [Conventional Commits](https://conventionalcommits.org) for commit guidelines.

## 2025-12-02

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`auth` - `v0.0.2`](#auth---v002)
 - [`connectivity` - `v0.0.2`](#connectivity---v002)
 - [`core` - `v0.0.2`](#core---v002)
 - [`personal_finance_app` - `v0.1.1`](#personal_finance_app---v011)
 - [`transactions` - `v0.0.2`](#transactions---v002)
 - [`ui_kit` - `v0.0.2`](#ui_kit---v002)

---

#### `auth` - `v0.0.2`

 - **REFACTOR**: remove unused imports and clean up code.
 - **FIX**(auth): update login page.
 - **FEAT**(auth): implement authentication logic and pages.
 - **FEAT**(auth): initial auth feature setup.

#### `connectivity` - `v0.0.2`

 - **REFACTOR**: remove unused imports and clean up code.
 - **FEAT**(connectivity): initialize connectivity package.

#### `core` - `v0.0.2`

 - **REFACTOR**: remove unused imports and clean up code.
 - **REFACTOR**(core): remove unused auth_user entity.
 - **FEAT**(core): add AuthUser entity and Failure class.
 - **FEAT**(core): initial core package setup.

#### `personal_finance_app` - `v0.1.1`

 - **FEAT**(personal_finance_app): add intl dependency and format code.
 - **FEAT**(dashboard): enable navigation to transaction details.
 - **FEAT**(router): add transaction detail route.
 - **FEAT**(app): integrate connectivity feature.
 - **FEAT**(app): initialize app with DI, providers and router.
 - **FEAT**(router): add dashboard and transaction routes.
 - **FEAT**(showcase): add showcase menu for navigation testing.
 - **FEAT**(dashboard): implement dashboard page with transactions list.
 - **FEAT**(personal_finance_app): configure firebase app check and inject transactions dependencies.
 - **FEAT**(app): configure firebase and dependencies.
 - **FEAT**(app): initial personal finance app setup.

#### `transactions` - `v0.0.2`

 - **REFACTOR**: remove unused imports and clean up code.
 - **REFACTOR**(transactions): optimize transaction submission and DI.
 - **FEAT**(transactions): implement transaction detail view.
 - **FEAT**(transactions): implement presentation layer.
 - **FEAT**(transactions): implement domain and data layers.
 - **FEAT**(transactions): initial transactions feature setup.

#### `ui_kit` - `v0.0.2`

 - **FEAT**(dashboard): enable navigation to transaction details.
 - **FEAT**(ui-kit): add transaction detail view components.
 - **FEAT**(ui_kit): update components and add currency helper.
 - **FEAT**(ui_kit): add auth forms and validators.
 - **FEAT**(ui): implement templates (auth, dashboard).
 - **FEAT**(ui): implement organisms (forms, dashboard sections).
 - **FEAT**(ui): implement molecules for dashboard.
 - **FEAT**(ui): implement design system foundation, theme extensions and base atoms.
 - **FEAT**(ui): initial ui_kit package setup.

# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0-beta.1] - 2025-12-02

### Added
- **Authentication Feature**: Complete user authentication system with login/logout functionality
  - Email and password authentication
  - Session management with Firebase
  - Auth state persistence
  - Comprehensive unit tests for auth feature

- **Dashboard**: Main dashboard with financial overview
  - Transaction summary cards (income, expenses, balance)
  - Recent transactions list
  - Quick access to transaction management
  - Responsive design for all screen sizes

- **Transaction Management**: Full CRUD operations for transactions
  - Add new transactions with category selection
  - Edit existing transactions
  - Delete transactions
  - Transaction list with filtering and sorting
  - Category-based organization

- **Transaction Detail View**: Detailed view for individual transactions
  - Complete transaction information display
  - Edit and delete actions
  - Category visualization
  - Date and amount formatting

- **Statistics View**: Financial analytics and insights
  - Category-based expense breakdown
  - Income vs expenses comparison
  - Visual charts and graphs
  - Period-based filtering

- **Offline Support**: Full offline functionality
  - Local data persistence with Hive
  - Automatic sync when online
  - Connectivity status monitoring
  - Offline-first architecture

- **UI Kit & Design System**: Comprehensive design system implementation
  - Atomic design structure (atoms, molecules, organisms, templates)
  - Consistent theming and styling
  - Reusable components
  - Responsive layouts

- **Testing**: Comprehensive unit test coverage
  - Auth feature tests (models, repositories, use cases, bloc, pages)
  - Connectivity feature tests
  - Transactions feature tests
  - UI Kit component tests
  - High code coverage across all packages

- **Project Structure**: Modular monorepo architecture
  - Melos workspace configuration
  - Feature-based package organization
  - Clean architecture implementation
  - Dependency injection with GetIt

### Changed
- Applied consistent code formatting with `dart format`
- Updated dependencies to latest stable versions

### Documentation
- Added MIT LICENSE to project and all packages
- Created comprehensive README
- Documented project structure and architecture

---

## Release Notes

This is the first beta release of the Personal Finance application. It includes all core features needed for managing personal finances:

- ✅ User authentication
- ✅ Transaction management (CRUD)
- ✅ Dashboard with financial overview
- ✅ Statistics and analytics
- ✅ Offline support
- ✅ Comprehensive test coverage

The application follows clean architecture principles and is built with Flutter for cross-platform support (Android, iOS, Web).

### Known Limitations
- This is a beta release intended for testing purposes
- Some features may require further refinement based on user feedback

### Next Steps
- Gather user feedback
- Performance optimizations
- Additional features based on user requests
- Prepare for production release (v1.0.0)
