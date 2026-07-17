#Requires -Version 7.0

Set-StrictMode -Version Latest
# ==========================================
# ConfigProvider
# Knowledge Engine - Providers Layer
# ==========================================

<#
.SYNOPSIS
Provides configuration management for the Knowledge Engine.

.DESCRIPTION
This provider abstracts all configuration-related operations for the Knowledge Engine.
It handles loading, initializing, merging, and validating configuration objects.

Functions:
- Get-KLConfiguration: Reads and returns the effective configuration
- Initialize-KLConfiguration: Creates a default configuration object
- Merge-KLConfiguration: Merges user config with defaults
- Test-KLConfiguration: Validates configuration object structure and values
#>

# ==========================================
# Initialize-KLConfiguration
# ==========================================

<#
.SYNOPSIS
Creates a default Knowledge Engine configuration object.

.DESCRIPTION
Initializes and returns a new PSCustomObject with all default configuration settings
required by the Knowledge Engine. This serves as the baseline configuration that can
be merged with user-provided overrides.

.PARAMETER None

.OUTPUTS
PSCustomObject
A custom object with the following properties:
- OutputPath: Default output directory for generated documentation
- TemplatePath: Path to template files
- Language: Default language (en-US or ar-EG)
- Category: Default category filter (null = all)
- Topic: Default topic filter (null = all)
- GenerateIndex: Whether to generate search indexes
- GenerateTOC: Whether to generate table of contents
- GenerateLinks: Whether to generate cross-references
- OverwriteExisting: Whether to overwrite existing files
- DryRun: Whether to run in preview mode without writing

.EXAMPLE
$defaultConfig = Initialize-KLConfiguration
$defaultConfig.Language = "ar-EG"

.NOTES
This function has no parameters because it always returns the same default structure.
Customization is done via Merge-KLConfiguration.
#>
function Initialize-KLConfiguration {
    [CmdletBinding()]
    param()

    Write-Verbose "Initializing default Knowledge Engine configuration"

   $defaultConfig = [ordered]@{
    ConfigurationVersion = '1.0'

    OutputPath           = Join-Path $PSScriptRoot '..\..\..\Output'
    TemplatePath         = Join-Path $PSScriptRoot '..\..\..\Templates'

    Language             = 'en-US'

    Category             = $null
    Topic                = $null

    GenerateIndex        = $true
    GenerateTOC          = $true
    GenerateLinks        = $true

    OverwriteExisting    = $false
    DryRun               = $false
}

    $configObject = [PSCustomObject]$defaultConfig

    Write-Verbose "Default configuration created with $(($defaultConfig.Keys | Measure-Object).Count) properties"

    return $configObject
}

# ==========================================
# Merge-KLConfiguration
# ==========================================

<#
.SYNOPSIS
Merges user configuration with default configuration.

.DESCRIPTION
Takes a default configuration object and overlays user-provided configuration values
onto it. This allows users to specify only the properties they want to override while
keeping defaults for everything else.

Properties that are $null or not specified in UserConfig will retain their default values.
Properties specified in UserConfig will override their default values.

.PARAMETER DefaultConfig
The default configuration object (typically from Initialize-KLConfiguration).
This parameter is mandatory.

.PARAMETER UserConfig
The user-provided configuration object containing overrides. Can be $null or empty,
in which case the DefaultConfig is returned as-is.
This parameter is optional.

.OUTPUTS
PSCustomObject
A merged configuration object combining defaults with user overrides.

.EXAMPLE
$defaults = Initialize-KLConfiguration
$userConfig = @{ Language = "ar-EG"; DryRun = $true }
$merged = Merge-KLConfiguration -DefaultConfig $defaults -UserConfig $userConfig
$merged.Language  # Returns "ar-EG"
$merged.DryRun    # Returns $true
$merged.GenerateIndex  # Returns $true (from defaults)

.NOTES
Non-null values in UserConfig take precedence over DefaultConfig.
Null values in UserConfig do not override DefaultConfig values.
#>
function Merge-KLConfiguration {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $false)]
        [ValidateNotNull()]
        [PSCustomObject]$DefaultConfig,

        [Parameter(Mandatory = $false, ValueFromPipeline = $false)]
        [PSCustomObject]$UserConfig
    )

    Write-Verbose "Merging user configuration with defaults"

    # If no user config provided, return defaults as-is
    if ($null -eq $UserConfig) {
        Write-Verbose "No user configuration provided; returning default configuration"
        return $DefaultConfig
    }

    # Create a copy of the default config to preserve the original
    $mergedConfig = $DefaultConfig | Select-Object *

    # Get all properties from UserConfig and overlay non-null values
    $userProperties = $UserConfig | Get-Member -MemberType NoteProperty
    $mergedCount = 0

    foreach ($property in $userProperties) {
        $propertyName = $property.Name
        $userValue = $UserConfig.$propertyName

        # Only override if user value is not null
        if ($null -ne $userValue) {
            Write-Verbose "Overriding property '$propertyName' with user value: $userValue"
            $mergedConfig.$propertyName = $userValue
            $mergedCount++
        }
    }

    Write-Verbose "Merged configuration: $mergedCount properties overridden"

    return $mergedConfig
}

# ==========================================
# Test-KLConfiguration
# ==========================================

<#
.SYNOPSIS
Validates a Knowledge Engine configuration object.

.DESCRIPTION
Validates the structure and values of a configuration object. Throws descriptive
exceptions if validation fails. Checks for:
- Required properties exist
- Property types are correct
- Property values are valid
- Logical consistency between properties

.PARAMETER Configuration
The configuration object to validate.
This parameter is mandatory.

.OUTPUTS
None. Returns $true if validation succeeds, throws an exception if it fails.

.EXAMPLE
$config = Initialize-KLConfiguration
Test-KLConfiguration -Configuration $config  # No error - configuration is valid

$invalidConfig = @{ Language = "INVALID" }
Test-KLConfiguration -Configuration $invalidConfig  # Throws exception

.NOTES
Throws descriptive exceptions for each validation failure.
Validation includes type checking, value range checking, and logical consistency.
#>
function Test-KLConfiguration {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $false)]
        [ValidateNotNull()]
        [PSCustomObject]$Configuration
    )

    Write-Verbose "Validating Knowledge Engine configuration"

    $requiredProperties = @(
        'OutputPath', 'TemplatePath', 'Language', 'Category', 'Topic',
        'GenerateIndex', 'GenerateTOC', 'GenerateLinks', 'OverwriteExisting', 'DryRun'
    )

    # Check that all required properties exist
    foreach ($property in $requiredProperties) {
        if (-not ($Configuration | Get-Member -Name $property -ErrorAction SilentlyContinue)) {
            throw "Configuration validation failed: Missing required property '$property'"
        }
    }

    Write-Verbose "All required properties present"

    # Validate Language property
   $validLanguages = @('en-US', 'ar-EG')
    if ($Configuration.Language -notin $validLanguages) {
        throw "Configuration validation failed: Language must be one of: $($validLanguages -join ', '). Got: $($Configuration.Language)"
    }

    Write-Verbose "Language property valid: $($Configuration.Language)"

    # Validate boolean properties
    $booleanProperties = @('GenerateIndex', 'GenerateTOC', 'GenerateLinks', 'OverwriteExisting', 'DryRun')
    foreach ($property in $booleanProperties) {
        if ($null -ne $Configuration.$property) {
            if ($Configuration.$property -isnot [bool]) {
                throw "Configuration validation failed: Property '$property' must be a boolean. Got: $($Configuration.$property.GetType().Name)"
            }
        }
    }

    Write-Verbose "All boolean properties valid"

    # Validate string properties (can be null or valid strings)
    $stringProperties = @('OutputPath', 'TemplatePath', 'Category', 'Topic')
    foreach ($property in $stringProperties) {
        if ($null -ne $Configuration.$property) {
            if ($Configuration.$property -isnot [string]) {
                throw "Configuration validation failed: Property '$property' must be a string or null. Got: $($Configuration.$property.GetType().Name)"
            }
            if ([string]::IsNullOrWhiteSpace($Configuration.$property)) {
                throw "Configuration validation failed: Property '$property' cannot be an empty or whitespace-only string"
            }
        }
    }

    Write-Verbose "All string properties valid"

    # Logical validation: If DryRun is true, OverwriteExisting should not matter
    # If OverwriteExisting is false, we won't overwrite anyway
    if ($Configuration.DryRun -and $Configuration.OverwriteExisting) {
        Write-Verbose "Warning: DryRun is true but OverwriteExisting is also true; OverwriteExisting will be ignored in dry-run mode"
    }

    Write-Verbose "Configuration validation successful"

    return $true
}

# ==========================================
# Get-KLConfiguration
# ==========================================

<#
.SYNOPSIS
Reads and returns the effective Knowledge Engine configuration.

.DESCRIPTION
Retrieves the effective configuration for the Knowledge Engine by combining
default configuration with optional user-provided overrides. This is typically
called at the start of Knowledge Engine operations to establish the configuration
context for all subsequent operations.

This function:
1. Initializes default configuration
2. Merges with provided user configuration (if any)
3. Validates the merged configuration
4. Returns the effective configuration object

.PARAMETER UserConfig
Optional user-provided configuration object containing overrides to defaults.
If $null, only defaults are returned (after validation).
This parameter is optional.

.OUTPUTS
PSCustomObject
The effective (merged and validated) configuration object ready for use.

.EXAMPLE
# Get default configuration only
$config = Get-KLConfiguration

# Get configuration with user overrides
$userConfig = @{ Language = "ar-EG"; DryRun = $true }
$config = Get-KLConfiguration -UserConfig $userConfig

.NOTES
Always validates configuration before returning. Throws exception if validation fails.
This ensures all downstream code can trust the configuration is valid.
#>
function Get-KLConfiguration {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false, ValueFromPipeline = $false)]
        [PSCustomObject]$UserConfig
    )

    Write-Verbose "Getting effective Knowledge Engine configuration"

    # Step 1: Initialize defaults
    $defaultConfig = Initialize-KLConfiguration

    # Step 2: Merge with user config if provided
    $effectiveConfig = Merge-KLConfiguration -DefaultConfig $defaultConfig -UserConfig $UserConfig

    # Step 3: Validate merged configuration
    Test-KLConfiguration -Configuration $effectiveConfig | Out-Null

    Write-Verbose "Effective configuration retrieved and validated"

    return $effectiveConfig
}

# ==========================================
# End ConfigProvider
# ==========================================


