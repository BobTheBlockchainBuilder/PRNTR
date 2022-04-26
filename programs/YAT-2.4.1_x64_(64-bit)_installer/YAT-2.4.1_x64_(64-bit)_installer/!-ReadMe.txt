
****************************************************************************************************
                                     YAT Installation ReadMe.
 --------------------------------------------------------------------------------------------------
                                    YAT - Yet Another Terminal.
     Engineering, testing and debugging of serial communications. Supports RS-232/422/423/485...
   ...as well as TCP/IP Client/Server/AutoSocket, UDP/IP Client/Server/PairSocket and USB Ser/HID.
 --------------------------------------------------------------------------------------------------
                    Visit YAT at https://sourceforge.net/projects/y-a-terminal/.
                     Contact YAT by mailto:y-a-terminal@users.sourceforge.net.
 --------------------------------------------------------------------------------------------------
                    Copyright © 2003-2004 HSR Hochschule für Technik Rapperswil.
                                Copyright © 2003-2021 Matthias Kläy.
                                        All rights reserved.
 --------------------------------------------------------------------------------------------------
                                YAT is licensed under the GNU LGPL.
                   See http://www.gnu.org/licenses/lgpl.html for license details.
****************************************************************************************************


====================================================================================================
1. Installation
====================================================================================================

YAT uses .NET 4.8. The YAT installer ensures that .NET 4.8 is available on the target computer.
The installer also ensures that Windows Installer 4.5 is available on the target computer.

First, chose the most appropriate package:
 > For up-to-date systems, use the compact package "...(32-bit).zip" or "...(64-bit).zip".
   (Windows Installer and .NET are already installed on up-to-date systems.)
 > For outdated systems or offline installation, use a full package "..._with_.NET...zip".
   (Windows Installer and .NET are included for installation.)
 > Alternatively, use a binary distribution, but don't forget to manually install the monospaced
   'DejaVu' font used by YAT as well as assign the .yat/.yaw file extensions to "YAT.exe".

It is recommended to unzip this package to a temporary location before starting the installation.

Run the ".msi" if Windows Installer is installed, otherwise "setup.exe".
 1. Installer will check prerequisites and install what is missing.
 2. Installer will install YAT. Older versions of YAT are automatically replaced.

For installation of a binary distribution, refer to the instructions inside that package.

You can also download .NET and/or Windows Installer from <https://www.microsoft.com/download>
or by googling for "Download Microsoft .NET Framework 4.8" and/or "Windows Installer 4.5".
Installing .NET and/or Windows Installer requires administrator permissions.


x86 (32-bit) -vs- x64 (64-bit)
----------------------------------------------------------------------------------------------------

YAT can be installed as x86 or x64 application. x86 works on either 32-bit or 64-bit systems whereas
x64 can only be installed on 64-bit systems. By default, x86 is installed to "\Program Files (x86)"
whereas x64 is installed to "\Program Files".

It is not possible to install both distributions for the same user. When changing from x86 to x64 of
the same version of YAT, or vice versa, the installed distribution must first be uninstalled before
the other distribution can be installed. If this limitation is not acceptable for somebody, create a
new feature request ticket and describe the impacts/rationale/use case as detailed as possible.


====================================================================================================
2. Execution
====================================================================================================

Run YAT by selecting "Start > Programs > YAT > YAT".

Use "C:\<Program Files>\YAT\YAT.exe" to run YAT normally.
Use "C:\<Program Files>\YAT\YATConsole.exe" to run YAT from console.


****************************************************************************************************
                                   End of YAT Installation ReadMe.
****************************************************************************************************
