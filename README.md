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