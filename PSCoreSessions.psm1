function Enter-PsCoreSession {

    [CmdletBinding(DefaultParameterSetName = 'ComputerName')]

    [Alias('ecsn')]

    param(
        [Alias('cn')]
        [Parameter(
            ParameterSetName = 'ComputerName',
            Mandatory,
            Position = 0,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [string]$ComputerName,

        [Alias('URI', 'cu')]
        [Parameter(
            ParameterSetName = 'Uri',
            Position = 1,
            ValueFromPipelineByPropertyName
        )]
        [uri]$ConnectionUri,

        [Parameter(ParameterSetName = 'Uri')]
        [Parameter(ParameterSetName = 'ComputerName')]
        [switch]$EnableNetworkAccess,

        [Alias('VMGuid')]
        [Parameter(
            ParameterSetName = 'VMId',
            Mandatory,
            Position = 0,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [guid]$VMId,

        [Parameter(
            ParameterSetName = 'VMName',
            Mandatory,
            Position = 0,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [string]$VMName,

        [Parameter(
            ParameterSetName = 'VMId',
            Mandatory,
            Position = 1,
            ValueFromPipelineByPropertyName
        )]
        [Parameter(
            ParameterSetName = 'Uri',
            Mandatory,
            Position = 1,
            ValueFromPipelineByPropertyName
        )]
        [Parameter(
            ParameterSetName = 'ComputerName',
            Mandatory,
            Position = 1,
            ValueFromPipelineByPropertyName
        )]
        [Parameter(
            ParameterSetName = 'VMName',
            Mandatory,
            Position = 1,
            ValueFromPipelineByPropertyName
        )]
        [pscredential]$Credential,

        [Parameter(
            ParameterSetName = 'ContainerId',
            Mandatory,
            Position = 0,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [string]$ContainerId,

        [Parameter(
            ParameterSetName = 'VMName',
            ValueFromPipelineByPropertyName
        )]
        [Parameter(
            ParameterSetName = 'Uri',
            ValueFromPipelineByPropertyName
        )]
        [Parameter(
            ParameterSetName = 'ContainerId',
            ValueFromPipelineByPropertyName
        )]
        [Parameter(
            ParameterSetName = 'VMId',
            ValueFromPipelineByPropertyName
        )]
        [Parameter(
            ParameterSetName = 'ComputerName',
            ValueFromPipelineByPropertyName
        )]
        [string]$ConfigurationName = 'PowerShell.7',

        [Parameter(ParameterSetName = 'ContainerId')]
        [switch]$RunAsAdministrator,

        [Parameter(ParameterSetName = 'ComputerName')]
        [int]$Port,

        [Parameter(ParameterSetName = 'ComputerName')]
        [switch]$UseSSL,

        [Parameter(
            ParameterSetName = 'ComputerName',
            ValueFromPipelineByPropertyName
        )]
        [string]$ApplicationName,

        [Parameter(ParameterSetName = 'Uri')]
        [switch]$AllowRedirection,

        [Parameter(ParameterSetName = 'ComputerName')]
        [Parameter(ParameterSetName = 'Uri')]
        [PSSessionOption]$SessionOption,

        [Parameter(ParameterSetName = 'ComputerName')]
        [Parameter(ParameterSetName = 'Uri')]
        [AuthenticationMechanism]$Authentication,

        [Parameter(ParameterSetName = 'ComputerName')]
        [Parameter(ParameterSetName = 'Uri')]
        [string]$CertificateThumbprint,

        [Alias('nfb')]
        [switch]$NoFallBack
    )

    process {
        if ($NoFallBack) {
            Enter-PSSession @PSBoundParameters
        }
        else {
            try {
                Enter-PSSession @PSBoundParameters -ErrorAction 'Stop'
            }
            catch [System.Management.Automation.Remoting.PSRemotingTransportException] {
                Write-Verbose -Message 'Fallback to Windows PowerShell'
                Enter-PSSession @PSBoundParameters -ConfigurationName 'microsoft.powershell'
            }
            catch { throw $PSItem }
        }
    }
}

function New-PsCoreSession {

    [CmdletBinding(DefaultParameterSetName = 'ComputerName')]

    [Alias('ecsn')]

    param(
        [Alias('cn')]
        [Parameter(
            ParameterSetName = 'ComputerName',
            Position = 0,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [string[]]$ComputerName,

        [Parameter(
            ParameterSetName = 'VMId',
            Position = 1,
            ValueFromPipelineByPropertyName
        )]
        [Parameter(
            ParameterSetName = 'Uri',
            Position = 1,
            ValueFromPipelineByPropertyName
        )]
        [Parameter(
            ParameterSetName = 'ComputerName',
            Position = 1,
            ValueFromPipelineByPropertyName
        )]
        [Parameter(
            ParameterSetName = 'VMName',
            Position = 1,
            ValueFromPipelineByPropertyName
        )]
        [pscredential]$Credential,

        [Parameter(ParameterSetName = 'Uri')]
        [Parameter(ParameterSetName = 'ComputerName')]
        [switch]$EnableNetworkAccess,

        [Parameter(
            ParameterSetName = 'VMName',
            ValueFromPipelineByPropertyName
        )]
        [Parameter(
            ParameterSetName = 'Uri',
            ValueFromPipelineByPropertyName
        )]
        [Parameter(
            ParameterSetName = 'ContainerId',
            ValueFromPipelineByPropertyName
        )]
        [Parameter(
            ParameterSetName = 'VMId',
            ValueFromPipelineByPropertyName
        )]
        [Parameter(
            ParameterSetName = 'ComputerName',
            ValueFromPipelineByPropertyName
        )]
        [string]$ConfigurationName = 'PowerShell.7',

        [Alias('VMGuid')]
        [Parameter(
            ParameterSetName = 'VMId',
            Mandatory,
            Position = 0,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [guid[]]$VMId,

        [Parameter(
            ParameterSetName = 'VMName',
            Mandatory,
            Position = 0,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [string[]]$VMName,

        [Parameter(
            ParameterSetName = 'ContainerId',
            Mandatory,
            Position = 0,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [string[]]$ContainerId,

        [Parameter(ParameterSetName = 'ContainerId')]
        [switch]$RunAsAdministrator,

        [Parameter(ParameterSetName = 'ComputerName')]
        [int]$Port,

        [Parameter(ParameterSetName = 'ComputerName')]
        [switch]$UseSSL,

        [Parameter(
            ParameterSetName = 'ComputerName',
            ValueFromPipelineByPropertyName
        )]
        [string]$ApplicationName,

        [Parameter(ParameterSetName = 'ComputerName')]
        [Parameter(ParameterSetName = 'Uri')]
        [Parameter(ParameterSetName = 'ContainerId')]
        [Parameter(ParameterSetName = 'VMId')]
        [Parameter(ParameterSetName = 'VMName')]
        [int]$ThrottleLimit,

        [Alias('URI', 'cu')]
        [Parameter(
            ParameterSetName = 'Uri',
            Mandatory,
            Position = 1,
            ValueFromPipelineByPropertyName
        )]
        [uri[]]$ConnectionUri,

        [Parameter(ParameterSetName = 'Uri')]
        [switch]$AllowRedirection,

        [Parameter(ParameterSetName = 'ComputerName')]
        [Parameter(ParameterSetName = 'Uri')]
        [PSSessionOption]$SessionOption,

        [Parameter(ParameterSetName = 'ComputerName')]
        [Parameter(ParameterSetName = 'Uri')]
        [AuthenticationMechanism]$Authentication,

        [Parameter(ParameterSetName = 'ComputerName')]
        [Parameter(ParameterSetName = 'Uri')]
        [string]$CertificateThumbprint,

        [Alias('nfb')]
        [switch]$NoFallBack
    )

    process {
        if ($NoFallBack) {
            New-PSSession @PSBoundParameters
        }
        else {
            switch ($PSCmdlet.ParameterSetName) {
                'ComputerName' {
                    try {
                        New-PSSession @PSBoundParameters -ErrorAction 'Stop'
                    }
                    catch [System.Management.Automation.Remoting.PSRemotingTransportException] {
                        Write-Verbose -Message 'Fallback to Windows PowerShell'
                        New-PSSession @PSBoundParameters -ConfigurationName 'microsoft.powershell'
                    }
                    catch { Write-Error -Message $PSItem }
                }
                'ContainerId' { }
                'VMId' { }
                'VMName' { }
                Default {
                    $Message = 'Internal Error! Unhandled parameter set:{0}' -f $PSItem
                    Throw $Message
                }
            }
        }
    }
}

function Invoke-PSCoreCommand {

    [CmdletBinding(DefaultParameterSetName = 'ComputerName')]

    [Alias('iccm')]

    param(
        [Alias('cn')]
        [Parameter(
            ParameterSetName = 'ComputerName',
            Position = 0
        )]
        [Parameter(
            ParameterSetName = 'FilePathComputerName',
            Position = 0
        )]
        [string[]]$ComputerName,

        [Parameter(
            ParameterSetName = 'ComputerName',
            ValueFromPipelineByPropertyName
        )]
        [Parameter(
            ParameterSetName = 'Uri',
            ValueFromPipelineByPropertyName
        )]
        [Parameter(
            ParameterSetName = 'FilePathComputerName',
            ValueFromPipelineByPropertyName
        )]
        [Parameter(
            ParameterSetName = 'FilePathUri',
            ValueFromPipelineByPropertyName
        )]
        [Parameter(
            ParameterSetName = 'VMId',
            ValueFromPipelineByPropertyName
        )]
        [Parameter(
            ParameterSetName = 'VMName',
            ValueFromPipelineByPropertyName
        )]
        [Parameter(
            ParameterSetName = 'FilePathVMId',
            ValueFromPipelineByPropertyName
        )]
        [Parameter(
            ParameterSetName = 'FilePathVMName',
            ValueFromPipelineByPropertyName
        )]
        [pscredential]$Credential,

        [Parameter(ParameterSetName = 'ComputerName')]
        [Parameter(ParameterSetName = 'FilePathComputerName')]
        [int]$Port,

        [Parameter(ParameterSetName = 'ComputerName')]
        [Parameter(ParameterSetName = 'FilePathComputerName')]
        [switch]$UseSSL,

        [Parameter(
            ParameterSetName = 'ComputerName',
            ValueFromPipelineByPropertyName
        )]
        [Parameter(
            ParameterSetName = 'FilePathComputerName',
            ValueFromPipelineByPropertyName
        )]
        [string]$ApplicationName,

        [Parameter(
            ParameterSetName = 'VMName',
            ValueFromPipelineByPropertyName
        )]
        [Parameter(
            ParameterSetName = 'Uri',
            ValueFromPipelineByPropertyName
        )]
        [Parameter(
            ParameterSetName = 'ContainerId',
            ValueFromPipelineByPropertyName
        )]
        [Parameter(
            ParameterSetName = 'VMId',
            ValueFromPipelineByPropertyName
        )]
        [Parameter(
            ParameterSetName = 'ComputerName',
            ValueFromPipelineByPropertyName
        )]
        [Parameter(
            ParameterSetName = 'FilePathComputerName',
            ValueFromPipelineByPropertyName
        )]
        [Parameter(
            ParameterSetName = 'FilePathUri',
            ValueFromPipelineByPropertyName
        )]
        [Parameter(
            ParameterSetName = 'FilePathContainerId',
            ValueFromPipelineByPropertyName
        )]
        [Parameter(
            ParameterSetName = 'FilePathVMId',
            ValueFromPipelineByPropertyName
        )]
        [Parameter(
            ParameterSetName = 'FilePathVMName',
            ValueFromPipelineByPropertyName
        )]
        [string]$ConfigurationName = 'PowerShell.7',

        [Parameter(ParameterSetName = 'VMName')]
        [Parameter(ParameterSetName = 'Uri')]
        [Parameter(ParameterSetName = 'VMId')]
        [Parameter(ParameterSetName = 'ComputerName')]
        [Parameter(ParameterSetName = 'ContainerId')]
        [Parameter(ParameterSetName = 'FilePathUri')]
        [Parameter(ParameterSetName = 'FilePathComputerName')]
        [Parameter(ParameterSetName = 'FilePathRunspace')]
        [Parameter(ParameterSetName = 'FilePathVMId')]
        [Parameter(ParameterSetName = 'FilePathVMName')]
        [Parameter(ParameterSetName = 'FilePathContainerId')]
        [int]$ThrottleLimit,

        [Alias('URI', 'CU')]
        [Parameter(
            ParameterSetName = 'Uri',
            Position = 0
        )]
        [Parameter(
            ParameterSetName = 'FilePathUri',
            Position = 0
        )]
        [uri[]]$ConnectionUri,

        [Parameter(ParameterSetName = 'VMName')]
        [Parameter(ParameterSetName = 'Uri')]
        [Parameter(ParameterSetName = 'VMId')]
        [Parameter(ParameterSetName = 'ComputerName')]
        [Parameter(ParameterSetName = 'ContainerId')]
        [Parameter(ParameterSetName = 'FilePathUri')]
        [Parameter(ParameterSetName = 'FilePathComputerName')]
        [Parameter(ParameterSetName = 'FilePathRunspace')]
        [Parameter(ParameterSetName = 'FilePathVMId')]
        [Parameter(ParameterSetName = 'FilePathVMName')]
        [Parameter(ParameterSetName = 'FilePathContainerId')]
        [switch]$AsJob,

        [Alias('Disconnected')]
        [Parameter(ParameterSetName = 'Uri')]
        [Parameter(ParameterSetName = 'ComputerName')]
        [Parameter(ParameterSetName = 'FilePathUri')]
        [Parameter(ParameterSetName = 'FilePathComputerName')]
        [switch]$InDisconnectedSession,

        [Alias('HCN')]
        [Parameter(ParameterSetName = 'VMName')]
        [Parameter(ParameterSetName = 'Uri')]
        [Parameter(ParameterSetName = 'VMId')]
        [Parameter(ParameterSetName = 'ComputerName')]
        [Parameter(ParameterSetName = 'ContainerId')]
        [Parameter(ParameterSetName = 'FilePathUri')]
        [Parameter(ParameterSetName = 'FilePathComputerName')]
        [Parameter(ParameterSetName = 'FilePathRunspace')]
        [Parameter(ParameterSetName = 'FilePathVMId')]
        [Parameter(ParameterSetName = 'FilePathVMName')]
        [Parameter(ParameterSetName = 'FilePathContainerId')]
        [switch]$HideComputerName,

        [Parameter(ParameterSetName = 'Uri')]
        [Parameter(ParameterSetName = 'ComputerName')]
        [Parameter(ParameterSetName = 'ContainerId')]
        [Parameter(ParameterSetName = 'FilePathUri')]
        [Parameter(ParameterSetName = 'FilePathComputerName')]
        [Parameter(ParameterSetName = 'FilePathRunspace')]
        [Parameter(ParameterSetName = 'FilePathContainerId')]
        [string]$JobName,

        [Alias('Command')]
        [Parameter(
            ParameterSetName = 'Uri',
            Mandatory,
            Position = 1
        )]
        [Parameter(
            ParameterSetName = 'ComputerName',
            Mandatory,
            Position = 1
        )]
        [Parameter(
            ParameterSetName = 'VMId',
            Mandatory,
            Position = 1
        )]
        [Parameter(
            ParameterSetName = 'VMName',
            Mandatory,
            Position = 1
        )]
        [Parameter(
            ParameterSetName = 'ContainerId',
            Mandatory,
            Position = 1
        )]
        [scriptblock]$scriptBlock,

        [Alias('PSPath')]
        [Parameter(
            ParameterSetName = 'FilePathUri',
            Mandatory,
            Position = 1
        )]
        [Parameter(
            ParameterSetName = 'FilePathComputerName',
            Mandatory,
            Position = 1
        )]
        [Parameter(
            ParameterSetName = 'FilePathRunspace',
            Mandatory,
            Position = 1
        )]
        [Parameter(
            ParameterSetName = 'FilePathVMId',
            Mandatory,
            Position = 1
        )]
        [Parameter(
            ParameterSetName = 'FilePathVMName',
            Mandatory,
            Position = 1
        )]
        [Parameter(
            ParameterSetName = 'FilePathContainerId',
            Mandatory,
            Position = 1
        )]
        [string]$FilePath,

        [Parameter(ParameterSetName = 'Uri')]
        [Parameter(ParameterSetName = 'FilePathUri')]
        [switch]$AllowRedirection,

        [Parameter(ParameterSetName = 'ComputerName')]
        [Parameter(ParameterSetName = 'Uri')]
        [Parameter(ParameterSetName = 'FilePathComputerName')]
        [Parameter(ParameterSetName = 'FilePathUri')]
        [PSSessionOption]$SessionOption,

        [Parameter(ParameterSetName = 'ComputerName')]
        [Parameter(ParameterSetName = 'Uri')]
        [Parameter(ParameterSetName = 'FilePathComputerName')]
        [Parameter(ParameterSetName = 'FilePathUri')]
        [AuthenticationMechanism]$Authentication,

        [Parameter(ParameterSetName = 'ComputerName')]
        [Parameter(ParameterSetName = 'Uri')]
        [Parameter(ParameterSetName = 'FilePathComputerName')]
        [Parameter(ParameterSetName = 'FilePathUri')]
        [switch]$EnableNetworkAccess,

        [Parameter(ParameterSetName = 'ContainerId')]
        [Parameter(ParameterSetName = 'FilePathContainerId')]
        [switch]$RunAsAdministrator,

        [Parameter(ValueFromPipeline)]
        [psobject]$InputObject,

        [Alias('Args')]
        [object[]]$ArgumentList,

        [Alias('VMGuid')]
        [Parameter(
            ParameterSetName = 'VMId',
            Mandatory,
            Position = 0,
            ValueFromPipelineByPropertyName
        )]
        [Parameter(
            ParameterSetName = 'FilePathVMId',
            Mandatory,
            Position = 0,
            ValueFromPipelineByPropertyName
        )]
        [guid[]]$VMId,

        [Parameter(
            ParameterSetName = 'VMName',
            Mandatory,
            ValueFromPipelineByPropertyName
        )]
        [Parameter(
            ParameterSetName = 'FilePathVMName',
            Mandatory,
            ValueFromPipelineByPropertyName
        )]
        [string]$VMName,

        [Parameter(
            ParameterSetName = 'ContainerId',
            Mandatory
        )]
        [Parameter(
            ParameterSetName = 'ContainerId',
            Mandatory
        )]
        [string]$ContainerId,

        [Parameter(ParameterSetName = 'ComputerName')]
        [Parameter(ParameterSetName = 'Uri')]
        [string]$CertificateThumbprint,

        [Alias('nfb')]
        [switch]$NoFallBack
    )

    process {
        if ($NoFallBack) {
            Invoke-Command @PSBoundParameters
        }
        else {
            try {
                Invoke-Command @PSBoundParameters -ErrorAction 'Stop'
            }
            catch [System.Management.Automation.Remoting.PSRemotingTransportException] {
                Write-Verbose -Message 'Fallback to Windows PowerShell'
                Invoke-Command @PSBoundParameters -ConfigurationName 'microsoft.powershell'
            }
            catch { Write-Error -Message $PSItem }
        }
    }
}
