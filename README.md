# Ansible Sandbox

Test and make experiments of Ansible automation features with minimalist Docker containers acting as managed nodes, ready to connect with host, acting as controller node.

# Requirements

Ansible works fine on Linux distributions.

If using on Windows, you must install Ansible under WSL (Windows Subsystem Linux).

To install [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) on Windows:

```powershell
wsl --install
```

## Control-node requirements

Install [pipx](https://pipx.pypa.io/latest/installation/):

```bash
$ sudo apt update
$ sudo apt install pipx
$ pipx ensurepath
$ eval "$(register-python-argcomplete pipx)" #Allows autocomplete in bash. For other shells instructions, run pipx completions
```

Install [ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

```bash
$ pipx install --include-deps ansible
$ pipx inject --include-apps ansible argcomplete #Adds shell autocompletion
```

## Managed-Node requirements

- SSH server up and running
- python 3.6 or higher version

# Ping check

After starting containers, run the command from project root folder to make sure ansible communication is working

```bash
ansible myhosts -m ping -i inventory.ini
```

# Windows Managed-Node

## Linux Control-Node setup

Install [pywinrm](https://docs.ansible.com/ansible/latest/os_guide/windows_winrm.html#what-is-winrm) python module.

```bash
pipx inject ansible pywinrm 
```

Ensure your [Inventory Options](https://docs.ansible.com/ansible/latest/os_guide/windows_winrm.html#inventory-options) are set correctly. Example `inventory.yaml`:

```yaml
selfhost:
    hosts:
    windows_host:
        ansible_host: 172.29.192.1
        ansible_user: Rodolfredo
        ansible_connection: winrm
        ansible_winrm_server_cert_validation: ignore
        ansible_winrm_transport: ntlm
        ansible_port: 5985
```

## Windows Managed-Node setup

Enable [WinRM](https://docs.ansible.com/ansible/latest/os_guide/windows_setup.html#winrm-setup) service:

```powershell
# Run as Administrator
winrm quickconfig
```

The winrm quickconfig command performs these operations:

- Starts the WinRM service, and sets the service startup type to auto-start.
  - The get the current status of the [WinRM service](https://docs.ansible.com/ansible/latest/os_guide/windows_setup.html#winrm-service-options), run `winrm get winrm/config/Service` and `winrm get winrm/config/Winrs`
- Configures a listener for the ports that send and receive WS-Management protocol messages using HTTP on any IP address.
  - Check status of [WinRM Listener](https://docs.ansible.com/ansible/latest/os_guide/windows_setup.html#winrm-listener) by running `winrm enumerate winrm/config/listener`
- Defines Firewall exceptions for the WinRM service, and opens the ports for HTTP.
  - Affected firewall rule: Windows Remote Management (HTTP-In)

## Test connection

Once the WinRM service is up and running, test the connection from the control-node:

```bash
ansible windows_host -i inventory.yaml -m win_ping --ask-pass
```

## WinRM authentication options

Check ansible [documentation](https://docs.ansible.com/ansible/latest/os_guide/windows_winrm.html#winrm-authentication-options) for details about the available authentication options:

| Option      | Local Accounts | Active Directory Accounts | Credential Delegation | HTTP Encryption |
|-------------|:--------------:|:-------------------------:|:---------------------:|:---------------:|
| Basic       |       Yes      |             No            |           No          |        No       |
| Certificate |       Yes      |             No            |           No          |        No       |
| Kerberos    |       No       |            Yes            |          Yes          |       Yes       |
| NTLM        |       Yes      |            Yes            |           No          |       Yes       |
| CredSSP     |       Yes      |            Yes            |          Yes          |       Yes       |