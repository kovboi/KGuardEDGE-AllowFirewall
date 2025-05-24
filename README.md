# KGuardEDGE Güvenlik Duvarı Kurulum Aracı (Türkçe)

Bu proje, GitHub’dan bir PowerShell script’i çekerek Windows Güvenlik Duvarı kuralını en güncel IP adresleriyle otomatik olarak güncelleyen bir kurulum aracıdır.

## Kurulum

Aşağıdaki adımları izleyerek `Install-KGuardEDGE-Task.bat` dosyasını masaüstünüze indirin ve yönetici olarak çalıştırın:

1. Normal bir Komut İstemi (CMD) penceresi açın ve şu komutu yapıştırıp Enter tuşuna basın:

   ```cmd
   curl -L https://raw.githubusercontent.com/kovboi/KGuardEDGE-AllowFirewall/main/Install.bat -o "%USERPROFILE%\Desktop\Install-KGuardEDGE.bat"
   ```

2. Masaüstünüzde oluşan `Install-KGuardEDGE.bat` dosyasına sağ tıklayın ve **Yönetici olarak çalıştır** seçeneğini seçin.

## Kullanım

* Bu işlem, her 5 dakikada bir SYSTEM hesabı altında `Update-KGuardEDGE-FW` adlı bir Zamanlanmış Görev oluşturacak; bu görev GitHub’dan en güncel PS1 script’ini çekip çalıştıracaktır.

## Geri Bildirim

Herhangi bir sorunla karşılaşırsanız veya öneriniz varsa, lütfen GitHub deposunda bir issue açın.

---

# KGuardEDGE Firewall Installer (English)

This project provides an installer that automatically updates a Windows Firewall rule with the latest IP addresses by fetching a PowerShell script from GitHub.

## Installation

Follow these steps to download the `Install-KGuardEDGE-Task.bat` file to your desktop and run it as an administrator:

1. Open a standard Command Prompt (CMD) window and paste the following command, then press Enter:

   ```cmd
   curl -L https://raw.githubusercontent.com/kovboi/KGuardEDGE-AllowFirewall/main/Install.bat -o "%USERPROFILE%\Desktop\Install-KGuardEDGE.bat"
   ```

2. On your desktop, find the `Install-KGuardEDGE.bat` file, right-click it, and select **Run as administrator**.

## Usage

* This process will create a Scheduled Task named `Update-KGuardEDGE-FW` that runs every 5 minutes under the SYSTEM account, fetching and executing the latest PS1 script from GitHub.

## Feedback

If you encounter any issues or have suggestions, please open an issue in the GitHub repository.
