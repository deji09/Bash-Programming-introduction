# trackpro
## Names and matriculation numbers

|**Name**|**Matriculation Number**|
| --- | --- |
| **Ayodeji Shote** | 180004145 |
| **Max Fyall** | 180011724 |
| **Max Kelly** | 180004073 |


## Boastful Introduction
Designed with meticulous detail, we present to you our own version control system. No where has seen anything like this before. It's also our group project for the module Computer Systems 2A at the University of Dundee.

## Installation
### Types of Installation
trackpro comes with support for 3 major types of installation: 
* Manual - basically DIY, just copy this directory to where you want it and access the program from the source folder
* Global - run the install.sh script and the program will be installed for all users in /usr/bin
* Local - run the install.sh script and the program will be installed for the current user in their home directory

|  | Manual | Global | Local |
| --- | --- |---| ---|
| **Base Command** | ./trackpro.sh (in source directory) | trackpro | trackpro |
| **Superuser privileges required during (un)installation** | No | Yes | No |
| **Installation Path** | Your choice | /usr/local/bin/trackpro | $HOME/bin/trackpro
| **Config file location** | ./source/config/trackpro.conf | /etc/trackpro.conf | $HOME/.trackpro/trackpro.conf |

### Global Install
To install globally, open up a terminal and run the following command, browse the directory in which trackpro has been downloaded and type in the following command
```bash 
sudo ./install.sh
```

### Local Install
To install globally, open up a terminal and run the following command, browse the directory in which trackpro has been downloaded and type in the following command
```bash
./install.sh
```
## Howto
To run the command after installation use the following command structure:
```bash
trackpro [options] [target]
```

### Options

| Shorthand Command | Full Command | Action |
| --- | --- | --- |
| -c | --changesettings | Used to change settings for each user, all users and for each repository |
| -h | --help | Displays this help screen |
| -m | --makerepo | Makes a trackpro repository |
| -l | --listrepos | Lists the trackpro repositories stored in the trackpro configuration file |
| -s | --storechanges | Stores changes of a trackpro repository |
| -t | --tar | Compresses a version of a trackpro repository |
| -u | --undochange | Undoes a change built into a trackpro repository |

### Target

| Shorthand Commands | Full commands | Target |
| --- | --- | --- |
| -m, -t, -u | --makerepo, --tar, --undochange | Repository name or path |
| -s | --storechanges | Repository name, path or all |
| -c, -h, -l | --changesettings, --help, --listrepos | No target required |

## Source structure

## Uninstallation
To uninstall trackpro, use the uninstall script, this can be done in this directory (with sudo being omitted for a local uninstallation, just like the installation):
```bash
(sudo) ./uninstall.sh [options]
```
### Options

| Options | Action |
| --- | --- |
| --deep | Deletes configuration files during uninstall | 
| -y | Prevents the user from being asked to uninstall |