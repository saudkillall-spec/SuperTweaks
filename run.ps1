# ============================================
#   SuperTweaks GUI - Ultimate Windows Tool
#   Run as Administrator
# ============================================

Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase
Add-Type -AssemblyName System.Windows.Forms

# ---------- Admin Check ----------
$principal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    [System.Windows.Forms.MessageBox]::Show("الرجاء تشغيل PowerShell كمسؤول (Run as Administrator)","SuperTweaks",0,48) | Out-Null
    exit
}

# ---------- XAML UI ----------
[xml]$xaml = @'
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="SuperTweaks - أقوى أداة لتحسين ويندوز"
        Height="780" Width="980"
        WindowStartupLocation="CenterScreen"
        Background="#0A0E14"
        FontFamily="Segoe UI">
    <Window.Resources>
        <Style TargetType="CheckBox">
            <Setter Property="Foreground" Value="#E6F1FF"/>
            <Setter Property="FontSize" Value="13"/>
            <Setter Property="Margin" Value="6"/>
        </Style>
        <Style x:Key="NeonBtn" TargetType="Button">
            <Setter Property="Background" Value="#00FFA3"/>
            <Setter Property="Foreground" Value="#02150F"/>
            <Setter Property="FontWeight" Value="Bold"/>
            <Setter Property="Padding" Value="16,10"/>
            <Setter Property="Margin" Value="6"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border Background="{TemplateBinding Background}" CornerRadius="8">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
        <Style x:Key="OutlineBtn" TargetType="Button" BasedOn="{StaticResource NeonBtn}">
            <Setter Property="Background" Value="#132436"/>
            <Setter Property="Foreground" Value="#E6F1FF"/>
        </Style>
        <Style x:Key="DangerBtn" TargetType="Button" BasedOn="{StaticResource NeonBtn}">
            <Setter Property="Background" Value="#00C8FF"/>
            <Setter Property="Foreground" Value="#02150F"/>
        </Style>
        <Style TargetType="TabItem">
            <Setter Property="Foreground" Value="#E6F1FF"/>
            <Setter Property="FontWeight" Value="Bold"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="TabItem">
                        <Border Name="Bd" Background="#131B28" BorderBrush="#1c2733" BorderThickness="1" CornerRadius="6,6,0,0" Padding="14,10">
                            <ContentPresenter ContentSource="Header" TextElement.Foreground="{TemplateBinding Foreground}" HorizontalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsSelected" Value="True">
                                <Setter TargetName="Bd" Property="Background" Value="#0F2A22"/>
                                <Setter TargetName="Bd" Property="BorderBrush" Value="#00FFA3"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
    </Window.Resources>

    <Grid Margin="0">
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="130"/>
            <RowDefinition Height="Auto"/>
        </Grid.RowDefinitions>

        <!-- Header -->
        <Border Grid.Row="0" Background="#101722" BorderBrush="#1c2733" BorderThickness="0,0,0,1" Padding="20,16">
            <StackPanel>
                <TextBlock FontSize="26" FontWeight="Black">
                    <Run Text="Super" Foreground="#FFFFFF"/><Run Text="Tweaks" Foreground="#00FFA3"/>
                </TextBlock>
                <TextBlock Text="أقوى أداة لتسريع وتنظيف وحماية خصوصية ويندوز" Foreground="#8ea0b5" FontSize="13" Margin="0,4,0,0"/>
            </StackPanel>
        </Border>

        <!-- Tabs -->
        <TabControl Grid.Row="1" Background="#0A0E14" BorderThickness="0" Margin="15">

            <TabItem Header="🗑️ حذف التطبيقات">
                <ScrollViewer><WrapPanel Margin="10">
                    <CheckBox x:Name="chkXbox" Content="تطبيقات Xbox"/>
                    <CheckBox x:Name="chkOfficeHub" Content="Office Hub"/>
                    <CheckBox x:Name="chkSolitaire" Content="Solitaire Collection"/>
                    <CheckBox x:Name="chkSkype" Content="Skype"/>
                    <CheckBox x:Name="chkTeams" Content="Teams"/>
                    <CheckBox x:Name="chkWeatherNews" Content="الطقس والأخبار"/>
                    <CheckBox x:Name="chkGetHelp" Content="Get Help / Tips"/>
                    <CheckBox x:Name="chk3D" Content="أدوات 3D"/>
                    <CheckBox x:Name="chkMixedReality" Content="Mixed Reality"/>
                    <CheckBox x:Name="chkYourPhone" Content="Your Phone"/>
                    <CheckBox x:Name="chkZune" Content="Music/Video (Zune)"/>
                    <CheckBox x:Name="chkClipchamp" Content="Clipchamp"/>
                    <CheckBox x:Name="chkPowerAutomate" Content="Power Automate"/>
                    <CheckBox x:Name="chkPeopleMaps" Content="People / Maps"/>
                    <CheckBox x:Name="chkMessaging" Content="Messaging"/>
                </WrapPanel></ScrollViewer>
            </TabItem>

            <TabItem Header="🕵️ الخصوصية">
                <ScrollViewer><WrapPanel Margin="10">
                    <CheckBox x:Name="chkTelemetry" Content="إيقاف التتبع (Telemetry)"/>
                    <CheckBox x:Name="chkAdvertisingId" Content="إيقاف معرف الإعلانات"/>
                    <CheckBox x:Name="chkActivityHistory" Content="إيقاف سجل النشاط"/>
                    <CheckBox x:Name="chkLocationTracking" Content="إيقاف تتبع الموقع"/>
                    <CheckBox x:Name="chkDiagnosticData" Content="إيقاف البيانات التشخيصية"/>
                    <CheckBox x:Name="chkTailoredExp" Content="إيقاف التجارب المخصصة"/>
                    <CheckBox x:Name="chkCortanaSearch" Content="إيقاف Cortana"/>
                    <CheckBox x:Name="chkWebSearch" Content="إيقاف البحث عبر الويب"/>
                </WrapPanel></ScrollViewer>
            </TabItem>

            <TabItem Header="🚀 الأداء">
                <ScrollViewer><WrapPanel Margin="10">
                    <CheckBox x:Name="chkPowerPlan" Content="تفعيل خطة الأداء العالي"/>
                    <CheckBox x:Name="chkVisualEffects" Content="أفضل أداء بصري (تقليل التأثيرات)"/>
                    <CheckBox x:Name="chkMenuDelay" Content="تسريع فتح القوائم"/>
                    <CheckBox x:Name="chkPriority" Content="تحسين أولوية المعالج"/>
                    <CheckBox x:Name="chkStartupDelay" Content="إلغاء تأخير برامج بدء التشغيل"/>
                    <CheckBox x:Name="chkHibernation" Content="إيقاف السكون (Hibernation)"/>
                    <CheckBox x:Name="chkIndexing" Content="إيقاف فهرسة البحث"/>
                </WrapPanel></ScrollViewer>
            </TabItem>

            <TabItem Header="🧹 التنظيف">
                <ScrollViewer><WrapPanel Margin="10">
                    <CheckBox x:Name="chkTempFiles" Content="الملفات المؤقتة" IsChecked="True"/>
                    <CheckBox x:Name="chkPrefetch" Content="Prefetch" IsChecked="True"/>
                    <CheckBox x:Name="chkWinUpdateCache" Content="كاش Windows Update" IsChecked="True"/>
                    <CheckBox x:Name="chkRecycleBin" Content="سلة المهملات" IsChecked="True"/>
                    <CheckBox x:Name="chkThumbCache" Content="كاش الصور المصغرة"/>
                    <CheckBox x:Name="chkErrorReports" Content="تقارير الأخطاء"/>
                    <CheckBox x:Name="chkDeliveryOpt" Content="ملفات Delivery Optimization"/>
                    <CheckBox x:Name="chkWindowsOld" Content="مجلد Windows.old (احذر!)"/>
                </WrapPanel></ScrollViewer>
            </TabItem>

            <TabItem Header="⚙️ الخدمات">
                <ScrollViewer><WrapPanel Margin="10">
                    <CheckBox x:Name="chkDiagTrackSvc" Content="إيقاف خدمة DiagTrack"/>
                    <CheckBox x:Name="chkWMPNetwork" Content="إيقاف مشاركة الوسائط"/>
                    <CheckBox x:Name="chkFax" Content="إيقاف خدمة الفاكس"/>
                    <CheckBox x:Name="chkRemoteRegistry" Content="إيقاف الوصول عن بعد للريجستري"/>
                    <CheckBox x:Name="chkMapsBroker" Content="إيقاف تحديث الخرائط"/>
                    <CheckBox x:Name="chkXboxServices" Content="إيقاف خدمات Xbox"/>
                    <CheckBox x:Name="chkPrintSpooler" Content="إيقاف الطباعة (لو ما تستخدم طابعة)"/>
                </WrapPanel></ScrollViewer>
            </TabItem>

            <TabItem Header="🎮 وضع الألعاب">
                <ScrollViewer><WrapPanel Margin="10">
                    <CheckBox x:Name="chkGameDVR" Content="إيقاف Game DVR / Game Bar"/>
                    <CheckBox x:Name="chkNetworkThrottle" Content="إيقاف تقييد الشبكة (Network Throttling)"/>
                    <CheckBox x:Name="chkGPUSched" Content="تفعيل جدولة GPU المتقدمة (HAGS)"/>
                    <CheckBox x:Name="chkSysResponsive" Content="تحسين استجابة النظام للألعاب"/>
                    <CheckBox x:Name="chkMouseAccel" Content="إيقاف تسارع الماوس"/>
                    <CheckBox x:Name="chkFSO" Content="إيقاف تحسينات ملء الشاشة"/>
                </WrapPanel></ScrollViewer>
            </TabItem>

        </TabControl>

        <!-- Log -->
        <Border Grid.Row="2" Background="#050A10" BorderBrush="#1e2b3a" BorderThickness="1" Margin="15,0,15,10" CornerRadius="8">
            <TextBox x:Name="txtLog" Background="Transparent" Foreground="#00FFA3" BorderThickness="0"
                     FontFamily="Consolas" FontSize="12" IsReadOnly="True" VerticalScrollBarVisibility="Auto"
                     TextWrapping="Wrap" Padding="10"/>
        </Border>

        <!-- Footer -->
        <StackPanel Grid.Row="3" Orientation="Horizontal" HorizontalAlignment="Center" Margin="0,0,0,15">
            <Button x:Name="btnSelectAll" Content="✅ تحديد الكل" Style="{StaticResource OutlineBtn}"/>
            <Button x:Name="btnDeselectAll" Content="❌ إلغاء التحديد" Style="{StaticResource OutlineBtn}"/>
            <Button x:Name="btnRestore" Content="🛡️ نقطة استعادة" Style="{StaticResource DangerBtn}"/>
            <Button x:Name="btnRunSelected" Content="▶️ تشغيل المحدد" Style="{StaticResource NeonBtn}"/>
            <Button x:Name="btnRunAll" Content="🔥 SUPER TWEAK (تشغيل الكل)" Style="{StaticResource NeonBtn}" Width="230"/>
        </StackPanel>
    </Grid>
</Window>
'@

$reader = New-Object System.Xml.XmlNodeReader $xaml
$window = [Windows.Markup.XamlReader]::Load($reader)

# ---------- Get Controls ----------
$txtLog          = $window.FindName("txtLog")
$btnSelectAll    = $window.FindName("btnSelectAll")
$btnDeselectAll  = $window.FindName("btnDeselectAll")
$btnRestore      = $window.FindName("btnRestore")
$btnRunSelected  = $window.FindName("btnRunSelected")
$btnRunAll       = $window.FindName("btnRunAll")

# ---------- Helper Functions ----------
function Write-Log {
    param([string]$msg)
    $time = Get-Date -Format "HH:mm:ss"
    $txtLog.AppendText("[$time] $msg`r`n")
    $txtLog.ScrollToEnd()
    [System.Windows.Forms.Application]::DoEvents()
}

function Remove-AppPackages {
    param([string[]]$patterns, [string]$label)
    Write-Log "[+] حذف $label ..."
    foreach ($p in $patterns) {
        Get-AppxPackage -Name $p -AllUsers -ErrorAction SilentlyContinue | Remove-AppxPackage -ErrorAction SilentlyContinue
        Get-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue | Where-Object DisplayName -like $p | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue
    }
    Write-Log "[OK] تم حذف $label"
}

function Set-Reg {
    param($Path,$Name,$Value,$Type="DWord")
    if (!(Test-Path $Path)) { New-Item -Path $Path -Force | Out-Null }
    Set-ItemProperty -Path $Path -Name $Name -Value $Value -Type $Type -Force -ErrorAction SilentlyContinue
}

function New-RestorePointSafe {
    Write-Log "[+] إنشاء نقطة استعادة للنظام..."
    try {
        Enable-ComputerRestore -Drive "$env:SystemDrive\" -ErrorAction SilentlyContinue
        Checkpoint-Computer -Description "SuperTweaks Backup" -RestorePointType "MODIFY_SETTINGS" -ErrorAction Stop
        Write-Log "[OK] تم إنشاء نقطة الاستعادة بنجاح ✅"
    } catch {
        Write-Log "[ERROR] فشل إنشاء نقطة الاستعادة: $($_.Exception.Message)"
    }
}

# ---------- Tweak Actions Map ----------
$TweakActions = [ordered]@{
    "chkXbox" = { Remove-AppPackages @("Microsoft.Xbox.TCUI","Microsoft.XboxApp","Microsoft.XboxGameOverlay","Microsoft.XboxGamingOverlay","Microsoft.XboxIdentityProvider","Microsoft.XboxSpeechToTextOverlay","Microsoft.GamingApp") "تطبيقات Xbox" }
    "chkOfficeHub" = { Remove-AppPackages @("Microsoft.MicrosoftOfficeHub") "Office Hub" }
    "chkSolitaire" = { Remove-AppPackages @("Microsoft.MicrosoftSolitaireCollection") "Solitaire" }
    "chkSkype" = { Remove-AppPackages @("Microsoft.SkypeApp") "Skype" }
    "chkTeams" = { Remove-AppPackages @("MicrosoftTeams") "Teams" }
    "chkWeatherNews" = { Remove-AppPackages @("Microsoft.BingWeather","Microsoft.BingNews") "الطقس والأخبار" }
    "chkGetHelp" = { Remove-AppPackages @("Microsoft.GetHelp","Microsoft.Getstarted") "Get Help/Tips" }
    "chk3D" = { Remove-AppPackages @("Microsoft.3DBuilder","Microsoft.Microsoft3DViewer","Microsoft.Print3D") "أدوات 3D" }
    "chkMixedReality" = { Remove-AppPackages @("Microsoft.MixedReality.Portal") "Mixed Reality" }
    "chkYourPhone" = { Remove-AppPackages @("Microsoft.YourPhone") "Your Phone" }
    "chkZune" = { Remove-AppPackages @("Microsoft.ZuneMusic","Microsoft.ZuneVideo") "Zune Music/Video" }
    "chkClipchamp" = { Remove-AppPackages @("Clipchamp.Clipchamp") "Clipchamp" }
    "chkPowerAutomate" = { Remove-AppPackages @("Microsoft.PowerAutomateDesktop") "Power Automate" }
    "chkPeopleMaps" = { Remove-AppPackages @("Microsoft.People","Microsoft.WindowsMaps","Microsoft.OneConnect") "People/Maps" }
    "chkMessaging" = { Remove-AppPackages @("Microsoft.Messaging","microsoft.windowscommunicationsapps") "Messaging" }

    "chkTelemetry" = {
        Write-Log "[+] إيقاف التتبع..."
        Set-Reg "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" "AllowTelemetry" 0
        Set-Service "DiagTrack" -StartupType Disabled -ErrorAction SilentlyContinue
        Stop-Service "DiagTrack" -Force -ErrorAction SilentlyContinue
        Write-Log "[OK] تم إيقاف التتبع"
    }
    "chkAdvertisingId" = {
        Write-Log "[+] إيقاف معرف الإعلانات..."
        Set-Reg "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" "Enabled" 0
        Write-Log "[OK] تم"
    }
    "chkActivityHistory" = {
        Write-Log "[+] إيقاف سجل النشاط..."
        Set-Reg "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" "EnableActivityFeed" 0
        Set-Reg "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" "PublishUserActivities" 0
        Write-Log "[OK] تم"
    }
    "chkLocationTracking" = {
        Write-Log "[+] إيقاف تتبع الموقع..."
        Set-Reg "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" "Value" "Deny" "String"
        Write-Log "[OK] تم"
    }
    "chkDiagnosticData" = {
        Write-Log "[+] إيقاف البيانات التشخيصية..."
        Set-Reg "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" "LimitDiagnosticLogCollection" 1
        Write-Log "[OK] تم"
    }
    "chkTailoredExp" = {
        Write-Log "[+] إيقاف التجارب المخصصة..."
        Set-Reg "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" "DisableTailoredExperiencesWithDiagnosticData" 1
        Write-Log "[OK] تم"
    }
    "chkCortanaSearch" = {
        Write-Log "[+] إيقاف Cortana..."
        Set-Reg "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" "AllowCortana" 0
        Write-Log "[OK] تم"
    }
    "chkWebSearch" = {
        Write-Log "[+] إيقاف البحث عبر الويب..."
        Set-Reg "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" "DisableWebSearch" 1
        Write-Log "[OK] تم"
    }

    "chkPowerPlan" = {
        Write-Log "[+] تفعيل خطة الأداء العالي..."
        powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 2>$null
        Write-Log "[OK] تم"
    }
    "chkVisualEffects" = {
        Write-Log "[+] ضبط أفضل أداء بصري..."
        Set-Reg "HKCU:\Control Panel\Desktop" "UserPreferencesMask" ([byte[]](0x90,0x12,0x03,0x80,0x10,0x00,0x00,0x00)) "Binary"
        Write-Log "[OK] تم"
    }
    "chkMenuDelay" = {
        Write-Log "[+] تسريع فتح القوائم..."
        Set-Reg "HKCU:\Control Panel\Desktop" "MenuShowDelay" 0 "String"
        Write-Log "[OK] تم"
    }
    "chkPriority" = {
        Write-Log "[+] تحسين أولوية المعالج..."
        Set-Reg "HKLM:\SYSTEM\CurrentControlSet\Control\PriorityControl" "Win32PrioritySeparation" 26
        Write-Log "[OK] تم"
    }
    "chkStartupDelay" = {
        Write-Log "[+] إلغاء تأخير برامج بدء التشغيل..."
        Set-Reg "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Serialize" "StartupDelayInMSec" 0
        Write-Log "[OK] تم"
    }
    "chkHibernation" = {
        Write-Log "[+] إيقاف السكون..."
        powercfg -h off 2>$null
        Write-Log "[OK] تم"
    }
    "chkIndexing" = {
        Write-Log "[+] إيقاف فهرسة البحث..."
        Set-Service "WSearch" -StartupType Disabled -ErrorAction SilentlyContinue
        Stop-Service "WSearch" -Force -ErrorAction SilentlyContinue
        Write-Log "[OK] تم"
    }

    "chkTempFiles" = {
        Write-Log "[+] تنظيف الملفات المؤقتة..."
        Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
        Remove-Item "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
        Write-Log "[OK] تم"
    }
    "chkPrefetch" = {
        Write-Log "[+] تنظيف Prefetch..."
        Remove-Item "C:\Windows\Prefetch\*" -Recurse -Force -ErrorAction SilentlyContinue
        Write-Log "[OK] تم"
    }
    "chkWinUpdateCache" = {
        Write-Log "[+] تنظيف كاش Windows Update..."
        Stop-Service wuauserv -Force -ErrorAction SilentlyContinue
        Remove-Item "C:\Windows\SoftwareDistribution\Download\*" -Recurse -Force -ErrorAction SilentlyContinue
        Start-Service wuauserv -ErrorAction SilentlyContinue
        Write-Log "[OK] تم"
    }
    "chkRecycleBin" = {
        Write-Log "[+] تفريغ سلة المهملات..."
        Clear-RecycleBin -Force -ErrorAction SilentlyContinue
        Write-Log "[OK] تم"
    }
    "chkThumbCache" = {
        Write-Log "[+] تنظيف كاش الصور المصغرة..."
        Remove-Item "$env:LOCALAPPDATA\Microsoft\Windows\Explorer\thumbcache_*.db" -Force -ErrorAction SilentlyContinue
        Write-Log "[OK] تم"
    }
    "chkErrorReports" = {
        Write-Log "[+] تنظيف تقارير الأخطاء..."
        Remove-Item "C:\ProgramData\Microsoft\Windows\WER\*" -Recurse -Force -ErrorAction SilentlyContinue
        Write-Log "[OK] تم"
    }
    "chkDeliveryOpt" = {
        Write-Log "[+] تنظيف Delivery Optimization..."
        Remove-Item "C:\Windows\SoftwareDistribution\DeliveryOptimization\*" -Recurse -Force -ErrorAction SilentlyContinue
        Write-Log "[OK] تم"
    }
    "chkWindowsOld" = {
        Write-Log "[+] حذف مجلد Windows.old..."
        Remove-Item "C:\Windows.old" -Recurse -Force -ErrorAction SilentlyContinue
        Write-Log "[OK] تم (إن وجد)"
    }

    "chkDiagTrackSvc" = { Write-Log "[+] إيقاف DiagTrack..."; Set-Service DiagTrack -StartupType Disabled -EA SilentlyContinue; Stop-Service DiagTrack -Force -EA SilentlyContinue; Write-Log "[OK] تم" }
    "chkWMPNetwork" = { Write-Log "[+] إيقاف WMPNetworkSvc..."; Set-Service WMPNetworkSvc -StartupType Disabled -EA SilentlyContinue; Stop-Service WMPNetworkSvc -Force -EA SilentlyContinue; Write-Log "[OK] تم" }
    "chkFax" = { Write-Log "[+] إيقاف Fax..."; Set-Service Fax -StartupType Disabled -EA SilentlyContinue; Stop-Service Fax -Force -EA SilentlyContinue; Write-Log "[OK] تم" }
    "chkRemoteRegistry" = { Write-Log "[+] إيقاف RemoteRegistry..."; Set-Service RemoteRegistry -StartupType Disabled -EA SilentlyContinue; Stop-Service RemoteRegistry -Force -EA SilentlyContinue; Write-Log "[OK] تم" }
    "chkMapsBroker" = { Write-Log "[+] إيقاف MapsBroker..."; Set-Service MapsBroker -StartupType Disabled -EA SilentlyContinue; Stop-Service MapsBroker -Force -EA SilentlyContinue; Write-Log "[OK] تم" }
    "chkXboxServices" = {
        Write-Log "[+] إيقاف خدمات Xbox..."
        foreach($s in @("XblAuthManager","XblGameSave","XboxNetApiSvc")) {
            Set-Service $s -StartupType Disabled -ErrorAction SilentlyContinue
            Stop-Service $s -Force -ErrorAction SilentlyContinue
        }
        Write-Log "[OK] تم"
    }
    "chkPrintSpooler" = { Write-Log "[+] إيقاف Print Spooler..."; Set-Service Spooler -StartupType Disabled -EA SilentlyContinue; Stop-Service Spooler -Force -EA SilentlyContinue; Write-Log "[OK] تم" }

    "chkGameDVR" = {
        Write-Log "[+] إيقاف Game DVR..."
        Set-Reg "HKCU:\System\GameConfigStore" "GameDVR_Enabled" 0
        Set-Reg "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" "AppCaptureEnabled" 0
        Write-Log "[OK] تم"
    }
    "chkNetworkThrottle" = {
        Write-Log "[+] إيقاف تقييد الشبكة..."
        Set-Reg "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" "NetworkThrottlingIndex" 0xffffffff
        Write-Log "[OK] تم"
    }
    "chkGPUSched" = {
        Write-Log "[+] تفعيل جدولة GPU المتقدمة (HAGS)..."
        Set-Reg "HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" "HwSchMode" 2
        Write-Log "[OK] تم (يحتاج إعادة تشغيل)"
    }
    "chkSysResponsive" = {
        Write-Log "[+] تحسين استجابة النظام للألعاب..."
        Set-Reg "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" "SystemResponsiveness" 0
        Write-Log "[OK] تم"
    }
    "chkMouseAccel" = {
        Write-Log "[+] إيقاف تسارع الماوس..."
        Set-Reg "HKCU:\Control Panel\Mouse" "MouseSpeed" "0" "String"
        Set-Reg "HKCU:\Control Panel\Mouse" "MouseThreshold1" "0" "String"
        Set-Reg "HKCU:\Control Panel\Mouse" "MouseThreshold2" "0" "String"
        Write-Log "[OK] تم"
    }
    "chkFSO" = {
        Write-Log "[+] إيقاف تحسينات ملء الشاشة..."
        Set-Reg "HKCU:\System\GameConfigStore" "GameDVR_FSEBehaviorMode" 2
        Write-Log "[OK] تم"
    }
}

$AllCheckBoxes = @()
foreach ($key in $TweakActions.Keys) {
    $cb = $window.FindName($key)
    if ($cb) { $AllCheckBoxes += $cb }
}

# ---------- Core Runner ----------
function Invoke-CheckedTweaks {
    $btnRunSelected.IsEnabled = $false
    $btnRunAll.IsEnabled = $false
    Write-Log "===================================="
    Write-Log "🚀 بدء تنفيذ التعديلات..."
    $count = 0
    foreach ($key in $TweakActions.Keys) {
        $cb = $window.FindName($key)
        if ($cb -and $cb.IsChecked -eq $true) {
            try { & $TweakActions[$key] } catch { Write-Log "[ERROR] $key : $($_.Exception.Message)" }
            $count++
        }
    }
    Write-Log "✅ تم تنفيذ $count تعديل بنجاح!"
    Write-Log "===================================="
    $btnRunSelected.IsEnabled = $true
    $btnRunAll.IsEnabled = $true
    [System.Windows.Forms.MessageBox]::Show("تم تنفيذ $count تعديل بنجاح!`nيفضل إعادة تشغيل الجهاز الآن.","SuperTweaks",0,64) | Out-Null
}

# ---------- Button Events ----------
$btnSelectAll.Add_Click({ foreach ($cb in $AllCheckBoxes) { $cb.IsChecked = $true } })
$btnDeselectAll.Add_Click({ foreach ($cb in $AllCheckBoxes) { $cb.IsChecked = $false } })
$btnRestore.Add_Click({ New-RestorePointSafe })
$btnRunSelected.Add_Click({ Invoke-CheckedTweaks })
$btnRunAll.Add_Click({
    foreach ($cb in $AllCheckBoxes) { $cb.IsChecked = $true }
    Invoke-CheckedTweaks
})

Write-Log "مرحبًا بك في SuperTweaks 🚀 اختر التعديلات وابدأ!"

# ---------- Show Window ----------
$window.ShowDialog() | Out-Null
