echo "Install Chocolately before continuing: https://chocolatey.org/install"
Read-Host "Press anything and then 'enter' to continue"

echo "Enabling Windows Subsystem for Linux."
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux

echo "Install [Ubuntu, Windows Terminal] from the Windows Store."
Read-Host "Press anything and then 'enter' to continue"

Read-Host "Install Visual Studio: https://visualstudio.microsoft.com/download"
Read-Host "Install Rust: https://www.rust-lang.org/tools/install"

Read-Host "Press anything and then 'enter' to continue to the next phase: Chocolatey installations."

echo "Installing Visual Studio Code."
choco install vscode -y

echo "Installing LLVM."
choco install llvm -y

echo "Installing git."
choco install git -y

echo "Installing ProtonVPN."
choco install protonvpn -y

echo "Installing Firefox."
choco install firefox

echo "Installing Steam."
choco install steam

echo "Installing Discord."
choco install discord
