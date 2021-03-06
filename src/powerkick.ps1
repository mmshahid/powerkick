﻿#requires -version 2	
[CmdLetBinding()]
param(	
	[Parameter(Position=0, Mandatory=0)]
	[string]$Environment = 'Local',
	[Parameter(Position=1, Mandatory=0)]
	[string[]]$Roles = @('All'),
	[Parameter(Position=2, Mandatory=0)]
	[switch]$WhatIf = $false,
	[Parameter(Position=3, Mandatory=0)]
	[switch]$EnableTranscript = $false,
	[Parameter(Position=4, Mandatory=0)]
	[switch]$Confirm = $false,
	[Parameter(Position=5, Mandatory=0)]
	[string]$PlanFile = $(Join-Path (pwd) plan.ps1)
)
$scriptPath = $(Split-Path -Parent $MyInvocation.MyCommand.path)
$PlanFile = Resolve-Path $PlanFile
Get-Item "$scriptPath\powerkick\*.psm1" | Where {(Get-Module -Name $_.BaseName)} | 
	%{Remove-Module $_.BaseName}
Get-Item "$scriptPath\powerkick\*.psm1" | %{Import-Module $_}	

Invoke-powerkick $PlanFile $Environment -Roles $Roles -ScriptPath $scriptPath -WhatIf:$WhatIf -EnableTranscript:$EnableTranscript -Confirm:$Confirm
