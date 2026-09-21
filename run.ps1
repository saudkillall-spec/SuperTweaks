# SuperTweaks - Powerful Windows Optimization Script
# Run as Administrator

Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "           SuperTweaks v1.0             " -ForegroundColor Green
Write-Host "   اقوى اداة لتسريع وتنظيف ويندوز        " -ForegroundColor Yellow
Write-Host "=========================================" -ForegroundColor Cyan

function Remove-Bloatware {
    Write-Host ""
    Write-Host "[+] Removing bloatware apps..." -ForegroundColor Yellow
    $apps = @(
        "Microsoft.3DBuilder",
        "Microsoft.BingWeather",
        "Microsoft.BingNews",
        "Microsoft.GetHelp",
        "Microsoft.Getstarted",
        "Microsoft.Messaging",
        "Microsoft.Microsoft3DViewer",
        "Microsoft.MicrosoftOfficeHub",
        "Microsoft.MicrosoftSolitaireCollection",
        "Microsoft.MixedReality.Portal",
        "Microsoft.OneConnect",
        "Microsoft.People",
        "Microsoft.Print3D",
        "Microsoft.SkypeApp",
        "Microsoft.Wallet",
        "Microsoft.WindowsAlarms",
        "Microsoft.WindowsCamera",
        "microsoft.windowscommunicationsapps",
        "Microsoft.WindowsFeedbackHub",
        "Microsoft.WindowsMaps",
        "Microsoft.WindowsSoundRecorder",
        "Microsoft.Xbox.TCUI",
        "Microsoft.XboxApp",
        "Microsoft.XboxGameOverlay",
        "Microsoft.XboxGamingOverlay",
        "Microsoft.XboxIdentityProvider",
        "Microsoft.XboxSpeechToTextOverlay",
        "Microsoft.YourPhone",
        "Microsoft.ZuneMusic",
        "Microsoft.ZuneVideo",
        "Microsoft.GamingApp",
        "Microsoft.Todos",
        "Microsoft.PowerAutomateDesktop",
        "Clipchamp.Clipchamp",
        "MicrosoftTeams",
        "Microsoft.549981C3F5F10"
    )
    foreach ($app in $apps) {
        Get-AppxPackage -Name $app -AllUsers -ErrorAction SilentlyContinue | Remove-AppxPackage -ErrorAction SilentlyContinue
        Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like $app | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue
    }
    Write-Host "[OK] Bloatware removed." -ForegroundColor Green
}

function Disable-Telemetry {
    Write-Host ""
    Write-Host "[+] Disabling telemetry and data collection..." -ForegroundColor Yellow
    $paths = @(
        "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection",
        "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection"
    )
    foreach ($p in $paths) {
        if (!(Test-Path $p)) { New-Item -Path $p -Force | Out-Null }
        Set-ItemProperty -Path $p -Name "AllowTelemetry" -Value 0 -Type DWord -Force
    }
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" -ErrorAction SilentlyContinue
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Application Experience\ProgramDataUpdater" -ErrorAction SilentlyContinue
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" -ErrorAction SilentlyContinue
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" -ErrorAction SilentlyContinue
    Set-Service "DiagTrack" -StartupType Disabled -ErrorAction SilentlyContinue
    Stop-Service "DiagTrack" -Force -ErrorAction SilentlyContinue
    Write-Host "[OK] Telemetry disabled." -ForegroundColor Green
}

function Clean-System {
    Write-Host ""
    Write-Host "[+] Cleaning temp files, cache and recycle bin..." -ForegroundColor Yellow
    $paths = @(
        "$env:TEMP\*",
        "C:\Windows\Temp\*",
        "C:\Windows\Prefetch\*",
        "C:\Windows\SoftwareDistribution\Download\*",
        "$env:LOCALAPPDATA\Microsoft\Windows\Explorer\thumbcache_*.db"
    )
    foreach ($p in $paths) {
        Remove-Item -Path $p -Recurse -Force -ErrorAction SilentlyContinue
    }
    Clear-RecycleBin -Force -ErrorAction SilentlyContinue
    Write-Host "[OK] System cleaned." -ForegroundColor Green
}

function Optimize-Performance {
    Write-Host ""
    Write-Host "[+] Applying performance tweaks..." -ForegroundColor Yellow
    powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Value 0
    Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseHoverTime" -Value 0
    New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\PriorityControl" -Name "Win32PrioritySeparation" -Value 26 -PropertyType DWord -Force | Out-Null
    Write-Host "[OK] Performance tweaks applied." -ForegroundColor Green
}

function Disable-Cortana-WebSearch {
    Write-Host ""
    Write-Host "[+] Disabling Cortana and Web Search..." -ForegroundColor Yellow
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Force | Out-Null
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -Value 0 -Type DWord
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "DisableWebSearch" -Value 1 -Type DWord
    Write-Host "[OK] Done." -ForegroundColor Green
}

function Disable-Unnecessary-Services {
    Write-Host ""
    Write-Host "[+] Disabling unnecessary services..." -ForegroundColor Yellow
    $services = @("DiagTrack","dmwappushservice","MapsBroker","lfsvc","SharedAccess","WMPNetworkSvc","RemoteRegistry","Fax","XblAuthManager","XblGameSave","XboxNetApiSvc")
    foreach ($s in $services) {
        Set-Service -Name $s -StartupType Disabled -ErrorAction SilentlyContinue
        Stop-Service -Name $s -Force -ErrorAction SilentlyContinue
    }
    Write-Host "[OK] Services optimized." -ForegroundColor Green
}

function Show-Menu {
    Write-Host ""
    Write-Host "1. Remove Bloatware Apps"
    Write-Host "2. Disable Telemetry"
    Write-Host "3. Clean Temp Files and Cache"
    Write-Host "4. Optimize Performance"
    Write-Host "5. Disable Cortana and Web Search"
    Write-Host "6. Disable Unnecessary Services"
    Write-Host "7. RUN ALL (Full Super Tweak)"
    Write-Host "0. Exit"
    Write-Host ""
    $choice = Read-Host "Enter your choice"
    switch ($choice) {
        "1" { Remove-Bloatware }
        "2" { Disable-Telemetry }
        "3" { Clean-System }
        "4" { Optimize-Performance }
        "5" { Disable-Cortana-WebSearch }
        "6" { Disable-Unnecessary-Services }
        "7" { Remove-Bloatware; Disable-Telemetry; Clean-System; Optimize-Performance; Disable-Cortana-WebSearch; Disable-Unnecessary-Services }
        "0" { return }
        default { Write-Host "Invalid option" -ForegroundColor Red }
    }
    Write-Host ""
    Read-Host "Press Enter to continue"
    Show-Menu
}

Show-Menu
