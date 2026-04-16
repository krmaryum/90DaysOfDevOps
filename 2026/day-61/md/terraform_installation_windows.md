# Terraform Installation on Windows

## Step 1: Download Terraform

Go to the official Terraform website:
https://developer.hashicorp.com/terraform/downloads

Download: - Windows (AMD64)

## Step 2: Extract

-   Extract the downloaded ZIP file
-   You will get `terraform.exe`

## Step 3: Move the File

Create a folder: C:`\terraform`{=tex}

Move `terraform.exe` into this folder.

## Step 4: Add to PATH

1.  Open Start Menu and search for "Environment Variables"
2.  Click "Edit the system environment variables"
3.  Click "Environment Variables"
4.  Under System Variables, find and select "Path"
5.  Click "Edit" → "New"
6.  Add: C:`\terraform`{=tex}
7.  Click OK and close all windows

## Step 5: Restart Terminal

Close and reopen PowerShell or Command Prompt.

## Step 6: Verify Installation

Run: 
```
terraform --version
```
```text
Terraform v1.14.8
on windows_amd64
```

### Quick test

```Powershell
Get-Command terraform
terraform -help
```
OR
```Powershell
where.exe terraform
```
If it shows:

CommandType     Name         Version    Source
-----------     ----         -------    ------
Application     terraform.exe           C:\terraform\terraform.exe

👉 then PATH is correct



## Notes

-   Terraform AMD64 works on Windows ARM using emulation.
-   Ensure PATH is correctly set if command is not recognized.
