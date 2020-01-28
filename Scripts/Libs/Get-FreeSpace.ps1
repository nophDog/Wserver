Function New-Line{
    Param(
    [parameter(ValueFromPipeline)][String]$StringIn,
    [switch]$Reverse
    )

    If ($reverse) {
        "-" * $stringIn.Length;
        $StringIn
    } Else {
        $StringIn
        "-" * $StringIn.Length
    } # END if
} # END New-Line


function Get-FreeSpace(
                $Drivers=@(),
                [switch]$All,
                [switch]$Help
                )
{
    $driveData = Get-WmiObject -Class win32_LogicalDisk

    ## ------------------------------------------------------
    # printing function
    function Print-Disk(
        [System.Management.ManagementObject]$driveObj
        )
    {
        $deviceAnchor = $driveObj.DeviceID; "$deviceAnchor {0:n1} G  ==-»>  {1:n1} G" -f ($driveObj.FreeSpace/1GB),($driveObj.Size/1GB)
    }
    # END Print-Disk
    ## ------------------------------------------------------

    ## HERE STRING
    If ($Help) {
        $helpString = @"
NAME
    Get-FreeSpace

SYNOPSIS
    Displays a summary about your PC drives' storage

SYNTAX
    Get-FreeSpace [[-Drives] [Array] [-All] [-Help]]

EXAMPLE
    Get-FreeSpace
    This command just returns the system disk storage infomation.

    Get-FreeSpace -Drives C,D
    This command gets drives info you specified.

    Get-FreeSpace -All
    This command gets all existing drives info table.
"@
        $helpString
            break # exits the function early
    }
    ## HERE STRING

    "Avaliable storage in Your PC 👇🏻" | New-Line  # Display headline

    If ($All) {
        foreach ($driver in $driveData) { Print-Disk -driveObj $driver}
    } Else {
        $driverList = @{};
        foreach ($driver in $driveData) {
                $driverList[$driver.DeviceID[0].ToString()] = $driver
            };
        If ($Drivers.Length -eq 0) {
            Print-Disk -driveObj $driveData[0]
            } Else {
                foreach ($item in $Drivers) {
                    if ($item -in $driverList.Keys) {
                        Print-Disk -driveObj $driverList.$item
                    } Else {
                        "Driver $item is not valid :("
                    } # END If
                } # END foreach
            } # END if
        } # END If
} # END Get-FreeSpace