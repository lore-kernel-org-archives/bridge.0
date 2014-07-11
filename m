Return-Path: <Igor@galilsoft.com>
From: Igor Bezukh <Igor@galilsoft.com>
Date: Fri, 11 Jul 2014 11:36:32 +0000
Message-ID: <2bac19ce5f704178b25628b5e9e08344@DBXPR07MB093.eurprd07.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] A question about Wireless dongle HW and driver support -
 best practice
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>

Hi All,=0A=
=0A=
We have an embedded system that consists of Atmel AT91SAM9G20 SoC ( singgle=
 core ARMv5).=0A=
This SoC also has USB 1.1 ( 11Mbps).=0A=
=0A=
Kernel version is 2.6.32.=0A=
=0A=
The solution should have two wireless dongles - one acting as Acess Point a=
nd the other acting as WiFi client.=0A=
=0A=
In other words, we need the system to be a wireless repeater bridge.=0A=
=0A=
We had a lot of issues with the Atheros CARL9170 drivers and with Ralink 28=
70.=0A=
=0A=
Ralink 2870 doesn't have support for AP mode, at least in it's 5572 driver =
pack for linux from Meidatek website.=0A=
=0A=
We need the driver to support both Master and Managed modes, and working on=
 a single CPU core, no SMP.=0A=
=0A=
Can you please suggest a good chipset for such a solution hance from driver=
 perspective and HW performance perspective?=0A=
=0A=
TIA,=0A=
=0A=
Igor Bezukh=0A=
