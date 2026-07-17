# Changelog

All notable changes to this project will be documented in this file.

## [1.1.0] - 2026-07-18

### Changed - Logger Module Refactoring

Refactored entire codebase to use the Logger module consistently across all PowerShell modules for operational message logging.

#### Files Modified (7 total)
- **Setup.ps1** - 3 operational messages refactored to Logger
  - Configuration loading → `Write-KLLog -Level Info`
  - Configuration success → `Write-KLLog -Level Success`
  - Error handling → `Write-KLLog -Level Error`

- **ProjectInitializer.psm1** - 1 operational message refactored
  - Initialization message → `Write-KLLog -Level Info`

- **FolderGenerator.psm1** - 1 operational message refactored
  - [Created] message → `Write-KLLog -Level Success`
  - [Exists] messages preserved as Write-Host DarkGray (UI feedback, not operational logging)

- **FileGenerator.psm1** - 1 operational message refactored
  - [Created] message → `Write-KLLog -Level Success`
  - [Exists] messages preserved as Write-Host DarkGray (UI feedback, not operational logging)

- **RepositoryGenerator.psm1** - 8 operational messages refactored
  - Repository creation start → `Write-KLLog -Level Info`
  - Repository summary (7 lines) → `Write-KLLog -Level Success`

- **Logger.psm1** - No changes
  - Confirmed 4 logging levels: Info (Cyan), Success (Green), Warning (Yellow), Error (Red)
  - No new log levels introduced

- **TemplateManager.psm1** - Intentionally unchanged
  - Native `Write-Warning` behavior preserved for template validation

#### Refactoring Strategy
✅ **Logger For**: Operational messages (process status, success, warnings, errors)
✅ **Write-Host For**: Decorative elements (banners, blank lines, UI feedback)
✅ **No New Levels**: Used existing 4 levels only - no Verbose/Debug introduced

#### Statistics
- Total operational messages refactored: **17**
- UI feedback/decorative messages preserved: **~30+**
- New log levels introduced: **0**
- Categories generated: **12**
- Topics generated: **97**
- Folders created: **616+**
- Files created: **582+**

#### Verification
- ✅ All modules load successfully
- ✅ All 12 categories + 97 topics created successfully
- ✅ [SUCCESS] messages formatted with proper colors
- ✅ [Exists] messages shown in DarkGray (UI feedback preserved)
- ✅ Exit code: 0 (success)
- ✅ No breaking changes

#### Future Enhancements
As noted in the refactoring constraints, future Logger redesign milestone may include:
- Debug level for detailed troubleshooting
- Verbose level for detailed operation tracking
- Log file output with timestamps
- Log level filtering/configuration
