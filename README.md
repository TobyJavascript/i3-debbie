# User Manual: i3 Rice Dependencies

This document lists all the dependencies used for my i3 rice setup. It covers the required packages, libraries, and their functionality.

IMPORTANT: This setup is for Debian 12. Therefore I can not guarantee that all libraries or commands are the same for your setup. However, if you are using a Debian fork like Ubuntu or Mint, this guide will probably apply for you as well.

---

## Installation guide

First you need to install the i3 window manager.
Use the terminal command:

`sudo apt-get install i3`

For the next step you need to make sure you have git installed. Use the terminal command:

`sudo apt-get install git`

When you have git installed use the terminal command to install the reposotory:

`git clone https://github.com/TobyJavascript/i3-debbie.git`

Bellow are all the installation commands for the necassary libraries. You can read what each library do further down in this document: 

`sudo apt-get install hsetroot`

`sudo apt-get install miam`

`sudo apt-get install xclip`

`sudo apt-get install i3lock`

`sudo apt-get install dunst`

`sudo apt-get install policykit-1-gnome`

When all the libraries are installed and all files are where they should be, you can use the i3 update command to apply all changes. Note that some require a restart.

`i3-msg reload`

---

## Functionality Dependencies

These libraries and tools are essential for the basic functionality of my i3 setup.

### i3
- **Description**: i3 is a dynamic tiling window manager designed for X11. It is lightweight, fast, and highly configurable, which is why it is the core component of the system.
- **Installation**: `sudo apt install i3`

### hsetroot
- **Description**: hsetroot is used to set a solid color or an image as the background for your X session. It allows you to customize your desktop environment.
- **Installation**: `sudo apt install hsetroot`

### miam
- **Description**: miam is a tool to manage input methods for X11. It is primarily used for configuring language input systems like those for typing in different languages.
- **Installation**: `sudo apt install miam`

### xclip
- **Description**: xclip is a command-line interface to the X11 clipboard. It is used for copying and pasting data between the clipboard and the terminal.
- **Installation**: `sudo apt install xclip`

### i3lock
- **Description**: i3lock is a simple screen locker for X11. It provides an easy-to-use lock screen solution for i3 users.
- **Installation**: `sudo apt install i3lock`

### dunst
- **Description**: Dunst is a lightweight and customizable notification daemon for X11, providing pop-up notifications for system events.
- **Installation**: `sudo apt install dunst`

### policykit-1-gnome
- **Description**: policykit-1-gnome provides a graphical front-end to PolicyKit. It is used for controlling administrative privileges in a user-friendly way.
- **Installation**: `sudo apt install policykit-1-gnome`

---

## Font Dependencies

These fonts enhance the aesthetic of the i3 rice and provide better legibility and style.

### Pango
- **Description**: Pango is a library for layout and rendering of text, with an emphasis on internationalization. It allows for the display of complex text (like right-to-left scripts or non-Latin characters).
- **Installation**: `sudo apt install pango`
- **Note**: Pango is often required as a dependency for applications like i3bar and other GUI elements in your rice setup.

---

## Conclusion

These are the libraries and tools that make up the core functionality of my i3 rice setup. Each package serves a specific purpose. Please ensure all dependencies are installed before configuring your i3 rice.
