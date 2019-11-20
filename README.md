# trackpro
## Names and matriculation numbers

|**Name**|**Matriculation Number**|
| --- | --- |
| **Ayodeji Shote** | Censored |
| **Max Fyall** | Censored |
| **Max Kelly** | Censored |

## Boastful Introduction
Designed with meticulous detail, we present to you our own version control system. No where has seen anything like this before. It's also our group project for the module Computer Systems 2A at the University of Dundee.

## Documentation
The documenation folder contains the report and the joint peer assessment sheet.

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
### Installer Options

| Options | Action |
| --- | --- |
| --deep | Overwrites configuration file during install | 

## Howto
To run the command after installation use the following command structure:
```bash
trackpro [options] [target]
```

### Options

| Shorthand Command | Full Command | Action |
| --- | --- | --- |
| -a | --access | Changes the terminal's directory |
| -c | --changesettings | Used to change settings for each user, all users and for each repository |
| -e | --edit | Allows the user to edit trackpro configuration files |
| -h | --help | Displays this help screen |
| -i | --import | Imports a trackpro respository from a different computer |
| -m | --make | Makes a trackpro repository |
| -l | --list | Lists the trackpro repositories stored in the trackpro configuration file |
| -s | --store | Stores changes of a trackpro repository |
| -t | --tar | Compresses a version of a trackpro repository |
| -u | --undo | Undoes a change built into a trackpro repository |
| -v | --view | Displays the list of all files within the repository recursively |

#### Unimplemented option
Due to issues with changing permissions, it is not offically on our help script, but it can still be accessed in the final program.

| Shorthand Command | Full Command | Action |
| --- | --- | --- |
| -p | --permissions | Allows the user to change permissions of repositories |

### Target

| Shorthand Commands | Full commands | Target |
| --- | --- | --- |
| -a, -i, -m, -s, -t, -u, -v | --access, --import, --make, --store, --tar, --undo, --view | Repository name or path |
| -c, -h, -l | --changesettings, --help, --list | No target required |

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
