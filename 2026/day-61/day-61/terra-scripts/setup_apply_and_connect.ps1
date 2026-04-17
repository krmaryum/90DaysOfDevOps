$ErrorActionPreference = "Stop"

# Always run from the folder where this script is saved
Set-Location -Path $PSScriptRoot

# Terraform command fallback
$terraformCmd = "terraform"
if (-not (Get-Command terraform -ErrorAction SilentlyContinue)) {
    $terraformCmd = "C:\terraform\terraform.exe"
}

$keyName = "terra-automate-key"
$publicKey = "$keyName.pub"

Write-Host "===== STEP 1: SSH Key Setup ====="

if ((Test-Path $keyName) -or (Test-Path $publicKey)) {
    Write-Host "Key already exists."
    $confirm = Read-Host "Do you want to overwrite it? (yes/no)"

    if ($confirm -eq "yes") {
        if (Test-Path $keyName) { Remove-Item $keyName -Force }
        if (Test-Path $publicKey) { Remove-Item $publicKey -Force }
        Write-Host "Old key removed."
    }
    else {
        Write-Host "Skipping key creation."
    }
}

if (-not (Test-Path $keyName)) {
    Write-Host "Creating SSH key..."
    ssh-keygen -t ed25519 -f ".\$keyName" -C "terraform-key"
    Write-Host "SSH key created."
}

Write-Host "Private key: $(Join-Path (Get-Location) $keyName)"
Write-Host "Public key:  $(Join-Path (Get-Location) $publicKey)"

Write-Host ""
Write-Host "===== STEP 2: Terraform Execution ====="

Write-Host "Initializing Terraform..."
& $terraformCmd init

Write-Host "Validating Terraform..."
& $terraformCmd validate

Write-Host "Planning Terraform changes..."
& $terraformCmd plan

Write-Host "Applying Terraform..."
& $terraformCmd apply -auto-approve

Write-Host ""
Write-Host "===== STEP 3: Fetch Public IP ====="

$publicIp = ""
try {
    $publicIp = (& $terraformCmd output -raw public_ip).Trim()
}
catch {
    $publicIp = ""
}

if ([string]::IsNullOrWhiteSpace($publicIp)) {
    Write-Host "Could not read Terraform output named 'public_ip'."
    Write-Host "Add this to your Terraform code:"
    Write-Host ""
    Write-Host 'output "public_ip" {'
    Write-Host '  value = aws_instance.my_instance.public_ip'
    Write-Host '}'
    exit
}

Write-Host "EC2 Public IP: $publicIp"
Write-Host ""
Write-Host "SSH command:"
Write-Host "ssh -i .\$keyName ubuntu@$publicIp"
Write-Host ""

$connectNow = Read-Host "Do you want to connect now? (yes/no)"
if ($connectNow -eq "yes") {
    ssh -i ".\$keyName" "ubuntu@$publicIp"
}
else {
    Write-Host "Connection skipped."
}