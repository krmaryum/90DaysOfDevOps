# AWS CLI on Windows

## Install AWS CLI

### Step 1: Download
Download AWS CLI from:
https://aws.amazon.com/cli/

Choose Windows 64-bit MSI installer.

---

### Step 2: Install
- Double click the .msi file
- Click Next → Install → Finish

---

### Step 3: Verify Installation

Open PowerShell and run:

```
aws --version
```

Expected output:

```
aws-cli/2.x.x Python/3.x Windows/11 exe/AMD64
```

---

## Configure AWS CLI

Run:

```
aws configure
```

Enter:

```
AWS Access Key ID:     YOUR_KEY
AWS Secret Access Key: YOUR_SECRET
Default region name:   us-east-2
Default output format: json
```

---

## Config Files Location

Stored at:

```
C:\Users\<your-user>\.aws\
```

---

## Test AWS CLI

List S3 buckets:

```
aws s3 ls
```

---

## Useful Commands

### List EC2 Instances
```
aws ec2 describe-instances
```

### List S3 Buckets
```
aws s3 ls
```

### Create S3 Bucket
```
aws s3 mb s3://your-bucket-name
```

---

## Common Issues

### aws not recognized

Add to PATH:

```
C:\Program Files\Amazon\AWSCLIV2\
```

---

### Permission issues

Attach IAM policy:
AdministratorAccess (for testing)

---

## Notes

- Never share access keys
- Use IAM roles in production
- Terraform uses AWS CLI credentials automatically
