# ==========================================
# Logger Module
# IT Knowledge Lab
# ==========================================

function Write-KLLog {

    param(

        [Parameter(Mandatory)]
        [string]$Message,

        [ValidateSet("Info","Success","Warning","Error")]
        [string]$Level = "Info"

    )

    switch ($Level) {

        "Info" {

            Write-Host "[INFO]    $Message" -ForegroundColor Cyan

        }

        "Success" {

            Write-Host "[SUCCESS] $Message" -ForegroundColor Green

        }

        "Warning" {

            Write-Host "[WARNING] $Message" -ForegroundColor Yellow

        }

        "Error" {

            Write-Host "[ERROR]   $Message" -ForegroundColor Red

        }

    }

}

Export-ModuleMember -Function Write-KLLog