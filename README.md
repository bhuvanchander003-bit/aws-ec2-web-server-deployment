# AWS EC2 Web Server Deployment

## 📌 Project Overview

This project demonstrates how to design and deploy a Linux-based web server on Amazon Web Services (AWS) using Amazon EC2.

I created a custom VPC with a public subnet, configured Internet connectivity using an Internet Gateway and Route Table, launched an Amazon Linux EC2 instance, installed Apache Web Server, and deployed a basic HTML/CSS website.

I also configured Security Groups for secure network access, associated an Elastic IP with the EC2 instance, and used Amazon CloudWatch to monitor the server.

---

## 🎯 Project Objective

The main objective of this project is to understand how a basic web application can be hosted on AWS using EC2 and related networking services.

### What I built

```text
                         Internet
                            │
                            ▼
                    Internet Gateway
                            │
                            ▼
                    ┌───────────────┐
                    │     VPC       │
                    │  10.0.0.0/16  │
                    │               │
                    │ Public Subnet │
                    │  10.0.1.0/24  │
                    │       │       │
                    │       ▼       │
                    │ Security      │
                    │ Group         │
                    │       │       │
                    │       ▼       │
                    │ EC2 Instance  │
                    │ Amazon Linux  │
                    │       │       │
                    │       ▼       │
                    │    Apache     │
                    │       │       │
                    │       ▼       │
                    │ HTML + CSS    │
                    │   Website     │
                    └───────────────┘
                            │
                            ▼
                       CloudWatch
```

---

## 🛠️ Technologies Used

* Amazon EC2
* Amazon VPC
* Public Subnet
* Internet Gateway
* Route Tables
* Security Groups
* Elastic IP
* Amazon Linux
* Apache HTTP Server
* HTML
* CSS
* Amazon CloudWatch

---

# 🏗️ Architecture

The architecture consists of the following components:

### 1. VPC

Created a custom VPC using the CIDR block:

```text
10.0.0.0/16
```

The VPC provides an isolated network environment for the AWS resources.

### 2. Public Subnet

Created a public subnet inside the VPC:

```text
10.0.1.0/24
```

The subnet is associated with a route table that provides Internet connectivity.

### 3. Internet Gateway

Created and attached an Internet Gateway to the VPC.

The Internet Gateway allows communication between the VPC and the Internet.

### 4. Route Table

Configured a route:

```text
Destination: 0.0.0.0/0
Target: Internet Gateway
```

This allows Internet-bound traffic from the public subnet.

### 5. Security Group

Created a Security Group to control inbound traffic to the EC2 instance.

| Type | Protocol | Port | Source    |
| ---- | -------- | ---: | --------- |
| HTTP | TCP      |   80 | 0.0.0.0/0 |
| SSH  | TCP      |   22 | My IP     |

HTTP port 80 allows users to access the website.

SSH port 22 allows administrative access to the EC2 server.

> For production environments, SSH should be restricted to trusted IP addresses or managed using more secure access methods.

### 6. EC2 Instance

Launched an Amazon Linux EC2 instance inside the public subnet.

The EC2 instance acts as the web server.

### 7. Elastic IP

Associated an Elastic IP with the EC2 instance to provide a persistent public IPv4 address.

### 8. Apache Web Server

Installed Apache HTTP Server on the EC2 instance.

Apache receives HTTP requests and serves the website files.

### 9. HTML/CSS Website

Created a simple website using:

```text
index.html
style.css
```

The files were placed in Apache's web directory:

```text
/var/www/html/
```

### 10. CloudWatch

Used Amazon CloudWatch to monitor EC2 metrics such as CPU utilization and network activity.

---

# 🚀 Implementation Steps

## Step 1 — Create the VPC

Created a custom VPC:

```text
Name: MyWebServer-VPC
CIDR: 10.0.0.0/16
```

---

## Step 2 — Create Public Subnet

Created a public subnet:

```text
Name: Public-Subnet
CIDR: 10.0.1.0/24
```

The subnet was created inside the custom VPC.

---

## Step 3 — Create Internet Gateway

Created an Internet Gateway and attached it to the VPC.

```text
Internet
    │
    ▼
Internet Gateway
    │
    ▼
VPC
```

---

## Step 4 — Configure Route Table

Created a public route table and added:

```text
Destination: 0.0.0.0/0
Target: Internet Gateway
```

The route table was associated with the public subnet.

---

## Step 5 — Create Security Group

Configured inbound traffic:

```text
HTTP → Port 80 → Internet
SSH  → Port 22 → My IP
```

This allows web traffic while restricting SSH access.

---

## Step 6 — Launch EC2 Instance

Launched an Amazon Linux EC2 instance.

Configuration included:

```text
Operating System: Amazon Linux
Subnet: Public-Subnet
Security Group: WebServer-SG
Public IPv4: Enabled
```

---

## Step 7 — Connect to EC2

Connected to the EC2 instance using SSH / EC2 Instance Connect.

Example:

```bash
ssh -i my-web-server-key.pem ec2-user@<PUBLIC-IP>
```

---

## Step 8 — Update Linux Packages

Updated the server packages:

```bash
sudo dnf update -y
```

---

## Step 9 — Install Apache

Installed Apache:

```bash
sudo dnf install httpd -y
```

Started Apache:

```bash
sudo systemctl start httpd
```

Enabled Apache to start automatically after reboot:

```bash
sudo systemctl enable httpd
```

Checked the Apache service:

```bash
sudo systemctl status httpd
```

Expected result:

```text
Active: active (running)
```

---

## Step 10 — Deploy Website

Moved into the Apache web directory:

```bash
cd /var/www/html
```

Created the HTML file:

```bash
sudo nano index.html
```

Created the CSS file:

```bash
sudo nano style.css
```

Apache serves these files to visitors.

Website location:

```text
/var/www/html/
```

---

## Step 11 — Test the Website

Opened the EC2 public IP in a browser:

```text
http://<PUBLIC-IP>
```

The request flows through:

```text
Internet
    ↓
Internet Gateway
    ↓
Route Table
    ↓
Public Subnet
    ↓
Security Group
    ↓
EC2
    ↓
Apache
    ↓
index.html
```

The website is then displayed in the browser.

---

## Step 12 — Configure Elastic IP

Allocated an Elastic IP and associated it with the EC2 instance.

This provides a persistent public IPv4 address for the server.

---

## Step 13 — Monitor Using CloudWatch

Used Amazon CloudWatch to monitor the EC2 instance.

Important metrics include:

```text
CPU Utilization
Network In
Network Out
```

CloudWatch helps identify server performance and resource usage.

---

# 📂 Project Structure

```text
aws-ec2-web-server-deployment/
│
├── README.md
│
├── website/
│   ├── index.html
│   └── style.css
│
├── scripts/
│   └── setup.sh
│
├── architecture/
│   └── architecture.png
│
└── screenshots/
    ├── vpc.png
    ├── subnet.png
    ├── security-group.png
    ├── ec2.png
    ├── apache.png
    ├── website.png
    └── cloudwatch.png
```

---

# 📜 Setup Script

The `scripts/setup.sh` file can automate Apache installation.

```bash
#!/bin/bash

sudo dnf update -y

sudo dnf install httpd -y

sudo systemctl start httpd

sudo systemctl enable httpd

echo "Apache Web Server Installed Successfully"
```

Make it executable:

```bash
chmod +x setup.sh
```

Run:

```bash
./setup.sh
```

---

# 🔐 Security Considerations

The project uses AWS Security Groups to control access.

### HTTP

```text
Port: 80
Purpose: Website access
```

### SSH

```text
Port: 22
Purpose: Server administration
```

SSH should not normally be opened to the entire Internet.

Recommended:

```text
SSH → My IP
```

instead of:

```text
SSH → 0.0.0.0/0
```

---

# 🧪 Testing

The following tests were performed:

### Test 1 — Apache Status

```bash
sudo systemctl status httpd
```

Expected:

```text
active (running)
```

### Test 2 — Website Access

Open:

```text
http://<ELASTIC-IP>
```

Expected:

```text
Website loads successfully
```

### Test 3 — HTTP Connectivity

Verify that Security Group port 80 is open.

### Test 4 — SSH Connectivity

Verify SSH access from the authorized IP address.

### Test 5 — CloudWatch

Verify that EC2 monitoring metrics are available.

---

# 📸 Screenshots

Add screenshots of your AWS environment here.

### VPC

```text
screenshots/vpc.png
```

### Subnet

```text
screenshots/subnet.png
```

### Security Group

```text
screenshots/security-group.png
```

### EC2 Instance

```text
screenshots/ec2.png
```

### Apache Web Server

```text
screenshots/apache.png
```

### Website

```text
screenshots/website.png
```

### CloudWatch

```text
screenshots/cloudwatch.png
```

---

# 📚 What I Learned

Through this project, I gained practical knowledge of:

* Creating a custom AWS VPC
* Working with CIDR blocks
* Creating public subnets
* Configuring Internet Gateways
* Configuring Route Tables
* Configuring Security Groups
* Launching EC2 instances
* Connecting to Linux servers
* Installing Apache
* Hosting HTML/CSS websites
* Using Elastic IP
* Monitoring EC2 with CloudWatch
* Understanding AWS networking and Internet traffic flow

---

# 🎯 Project Outcome

Successfully deployed a Linux-based web server on AWS EC2 and hosted a basic HTML/CSS website.

The project demonstrates the complete flow:

```text
Network Creation
       ↓
VPC
       ↓
Public Subnet
       ↓
Internet Gateway
       ↓
Route Table
       ↓
Security Group
       ↓
EC2
       ↓
Apache
       ↓
HTML/CSS Website
       ↓
Elastic IP
       ↓
CloudWatch Monitoring
```

---

# 💼 Resume Description

**AWS EC2 Web Server Deployment**

* Designed and deployed a Linux-based web server using Amazon EC2.
* Created a custom VPC, public subnet, Internet Gateway, and route table for network connectivity.
* Configured Security Groups to control HTTP and SSH access.
* Installed and configured Apache HTTP Server on Amazon Linux.
* Deployed a basic HTML/CSS website and associated an Elastic IP.
* Monitored EC2 performance using Amazon CloudWatch.

---

# 🗣️ Interview Explanation

> "In this project, I deployed a Linux-based web server on AWS using EC2. I started by creating a custom VPC and public subnet. I configured an Internet Gateway and route table with a default route to provide Internet connectivity. Then I created a Security Group allowing HTTP traffic on port 80 and restricted SSH access on port 22. I launched an Amazon Linux EC2 instance in the public subnet, installed Apache, and deployed an HTML/CSS website. I associated an Elastic IP with the instance and used CloudWatch to monitor EC2 performance. This project helped me understand AWS networking, EC2 administration, security groups, and basic web-server deployment."

---

# 👨‍💻 Author

**Bhuvan Chander**

AWS Cloud / Cloud Infrastructure Enthusiast

---

## ⭐ Key AWS Concepts

```text
VPC
Subnet
Internet Gateway
Route Table
Security Group
EC2
Elastic IP
Apache
CloudWatch
Linux
```
