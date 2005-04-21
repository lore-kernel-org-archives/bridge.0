Date: Thu, 21 Apr 2005 12:48:50 +0200 (MEST)
From: "Sascha Dikhoff" <SaschaDikhoff@gmx.de>
MIME-Version: 1.0
Message-ID: <8164.1114080530@www11.gmx.net>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Bridge] Error in usb0 and eth0 bridging on an ARM9 Plattform
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hello,=20
I=B4m using the Linux Bridge on an Atmel Arm9 Plattform with the kernel
2.6.11rc3.

The configuration is the following:

LAN<--Arm9(Ethernet)--Bridge--Arm9(USB-Device)-->Notebook (USB-Host)

or=20

LAN<--Arm9(Ethernet)--Bridge--Arm9(USB-Host)-->Notebook (USB-Host)
(with a Trust USB2.0 Host to Host cable)

When I try to ping my Notebook from LAN and reverse, everything seems to be
fine. But when I use the tool "netio", wich provides a server to client
connection for measuring the ethernet bandwith, only one direction works.
While trying a TCP connection with netio, or trying to open a Website in
Firefox every connection fails.

A measurement between LAN and the bridge (with IP) and Notebook to Bridge
works fine. So I suppose there is a misconfiguration in the bridge.

A second configuration with bridging a USB Host to Host connection and the
Ethernet on my Linux-Notebook, was succesful.
But using the same Host to Host connection on my Arm9 board shows the same
problems like the USB Host to Device connection.

My configuration of the bridge is like:
ifconfig usb0 0.0.0.0 up
ifconfig eth0 0.0.0.0 up
brctl addbr brd
brctl setfd brd 100
brctl addif eth0
brctl addif usb0
ifconfig brd 192.168.1.1

Anybody there who can help?

Regards=20
Sascha Dikhoff

P.S.: For interested readers the link from the tool netio
http://ftp.leo.org/historic/comp/os/os2/leo/systools/netio123.zip

--=20
+++ GMX - Die erste Adresse f=FCr Mail, Message, More +++

1 GB Mailbox bereits in GMX FreeMail http://www.gmx.net/de/go/mail
