# Changelog

All notable changes to the `JoDija_tamplites` package will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [3.0.3] - 2026-09-05

### Added
- **Official Brand Identity & Logo Assets:**
  - Integrated official **JODIJA** brand identity, logo assets, and visuals across the repository and documentation portals (`assets/` and `doc/assets/`).
  - Official brand tagline: *"Simplifying Flutter Workflows And Universal Cross-Platform Solutions"*.
- **Dynamic Form Engine (`CellFieldBuilder`):**
  - Introduced `CellFieldBuilder` for reactive, cell-driven input/output binding and dynamic form rendering.
  - Added complete architectural workflows for local storage and SQLite CRUD operations.

### Refactored & Improved
- **Form Validation Logic:**
  - Streamlined and optimized form validation architecture in `text_form_validation.dart`.
  - Removed duplicate validation code and unified localized error messaging.

---

## [1.5.0] - 2026-08-28

### Added
- **Real UI Showcase:**
  - Added production screenshots from live apps (e.g., Delta Mager Pro products and categories screens) featuring RTL navigation and responsive sidebars.
- **Architectural Documentation:**
  - Documented the core philosophy comparing Single-Solution apps (`matger-client-app`) and Multi-Solution enterprise ecosystems (`font logic`, `matger-management-app`).
  - Documented backend contract integration using `matger-express` for centralized API contracts, dynamic configurations, and feature flags.
- **Arabic Localization & RTL Guides:**
  - Published comprehensive Arabic documentation ([README.ar.md](README.ar.md)).
  - Documented native RTL layout adaptation, dynamic locale switching, and Google Fonts integration.
- **Documentation Restructuring:**
  - Reorganized documentation into modular directories:
    - `01_architecture/` (Philosophy, Architecture, Configuration)
    - `02_templates/` (Adaptive App Shell Guide)
    - `03_utils/` (Shared Utilities, BLoC, Cell Models, Storage)
    - `04_integrations/` (Matger Ecosystem Integration Guide)

### Improved
- **Configuration & Networking:**
  - Standardized `DataViewConfigraion` and `AppHttpConnector` for unified app lifecycle management and network connectivity.
- **DartDoc Code Comments:**
  - Added comprehensive documentation comments across all primary public APIs: `AdaptiveAppShell`, `RouteItem`, `AppBarConfig`, `DataSourceBloc`, `CellModels`, `SharedPrefranceData`, `AppColors`, `AppThemes`, and `FormValidators`.
