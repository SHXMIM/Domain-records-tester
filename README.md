# 🛠 RecHunter

**RecHunter** is a **DNS enumeration tool** built with **bash**. It simplifies querying DNS records and domain information for cybersecurity professionals and enthusiasts. From DNS lookups to WHOIS queries, RecHunter combines essential functionalities in a user-friendly, menu-driven interface.

---

## 🌐 What is DNS Enumeration?

**DNS Enumeration** involves gathering DNS records and domain-related information to identify vulnerabilities and map the structure of a target domain. RecHunter automates this process, enabling quick and effective reconnaissance.

---

## 🚀 Features

- **Interactive Interface**: Easy-to-use menu-driven design.
- **DNS Record Lookups**:
  - A, AAAA, CNAME, MX, and TXT records.
- **WHOIS Lookup**: Retrieve detailed domain registration information.
- **Comprehensive Output**: Save results for future reference.
- **All-in-One Mode**: Execute all operations in one go.
- **Customizable**: Extend functionality by adding new DNS record types.

---

## 📥 Installation

### Prerequisites:
Ensure `dig` and `whois` utilities are installed:

```bash
sudo apt update
sudo apt install dnsutils whois
```
### Clone the repository
```
git clone https://github.com/shxim/RecHunter.git
```
### Navigate to the directory
```
cd RecHunter
```
### Make the script executable
```
chmod +x RecHunter.sh
```
### Execute the script
```
./RecHunter.sh <domain_name>
```
## Usage Instructions

### Select an Operation

Once the tool launches, you will be presented with the following menu options:

- **1:** Query A record  
- **2:** Query AAAA record  
- **3:** Query CNAME record  
- **4:** Query MX record  
- **5:** Query TXT record  
- **6:** Perform WHOIS lookup  
- **7:** Perform all operations  
- **q:** Exit the tool

# Example Use Case: Querying an A Record

1. Run `./RecHunter.sh example.com`.
2. Select `1` (Query A Record) from the menu.
3. View the results on-screen and save them if needed.

## ⚠️ Warnings and Legal Note

- **Ethical Usage**: Use this tool only for authorized purposes. Unauthorized use may lead to legal consequences.
- **Dependencies**: Ensure `dig` and `whois` are installed for the tool to function correctly.

# 📄 Scanning Options Explained

| Option                | Description                                                                 |
|-----------------------|-----------------------------------------------------------------------------|
| Query A Record        | Fetches IPv4 addresses associated with the domain.                          |
| Query AAAA Record     | Fetches IPv6 addresses associated with the domain.                          |
| Query CNAME Record    | Retrieves canonical names (aliases) of the domain.                          |
| Query MX Record       | Finds the mail exchange servers for the domain.                             |
| Query TXT Record      | Retrieves TXT records, often used for domain verification or SPF.           |
| WHOIS Lookup          | Provides domain registration and ownership information.                     |
| Perform All           | Executes all DNS lookups and WHOIS queries in a single operation.           |

---

## 🖼️ Screenshot

![Screenshot from 2024-09-22 22-06-40](![RecHunter](https://github.com/user-attachments/assets/6b830370-c548-48e7-955c-d84f68a83476)

---

## 🤝 Contributing
Feel free to contribute by creating pull requests or submitting issues. All contributions are welcome!

---

## 🧑‍💻 Author
### SHAMEEM KABEER
#### A passionate cybersecurity enthusiast who enjoys developing simple, effective tools to identify vulnerabilities.





