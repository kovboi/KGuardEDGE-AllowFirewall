# KGuardEDGE Firewall Installer

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
