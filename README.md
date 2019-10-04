# NOTE: Max and Deji, write your code in either in the source/trackpro.sh file or the source/scripts folder, just makes the install script easier to write. Turns out we can run other scripts from another but we can't import functions like on C so keep that in mind. We could also work in seperate files for now and then combine them later.

# trackpro
## Boastful Introduction
Designed with meticulous detail, we present to you our own version control system. No where has seen anything like this before. It's also our group project for the module Computer Systems 2A at the University of Dundee

## Install script
### Types of Installation
trackpro comes with support for 3 major types of installation: 
* Manual - basically DIY, just copy this directory and access the program from the source folder
* Global - run the install.sh script and the program will be installed for all users in /usr/bin
* Local - run the install.sh script and the program will be installed for the current user in their home directory

|  | Manual | Global | Local |
| --- | --- |---| ---|
| **Base Command** | ./trackpro (in README directory) | trackpro | trackpro |
| **Superuser privileges required during installation** | No | Yes | No |
| **Installation Path** | Your choice | /usr/local/bin/trackpro | $HOME/bin/trackpro
| **Config file location** | ./source/config/trackpro.conf | /etc/trackpro.conf | $HOME/.trackpro/trackpro.conf |

## Uninstall script

## Source