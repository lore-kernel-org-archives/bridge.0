Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 May 2010 13:17:07 -0700
Message-ID: <F24C979D1AFD4E4292B911441CBA242407FCC1@2putt.int.lantronix.com>
From: "Umar Qureshey" <umar.qureshey@lantronix.com>
Subject: [Bridge] Hardware requirements for bridging wired+wireless together
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi,

I have been trolling the 'net as well as the archives of this list for
quite a while now.

I am still unclear on the requirements for getting an Ethernet and
Wireless interface to bridge together.

Currently, I am working with an esoteric radio that only supports Ad-Hoc
and Managed modes.  There seemingly is not support for WDS (Wireless
Distribution System) on this radio.

I have been trying to bridge my eth0 and wlan0 but it doesn't seem to
work.  Currently, my commands to get the bridge up are:

ifconfig eth0 0.0.0.0
ifconfig wlan0 0.0.0.0
brctl addbr br0
brctl addif br0 eth0
brctl setfd br0 1           #BusyBox version of brctl doesn't take 0 as
a time parameter so I change it to 1 (sec)
ifconfig br0 up
wpa_supplicant -Dwext -iwlan0 -bbr0 -c/root/wpa_supplicant.conf

Then I try to run udhcpc (DHCP client) on the bridge hoping to get DHCP
from the AP/router:

# udhcpc -ibr0 -b
udhcpc (v1.15.2) started
Sending discover...
Sending discover...
Sending discover...
No lease, forking to background

What I'd like to inquire is that is WDS support in the firmware/hardware
of the radio required to bridge eth0 and wlan0?
Any other tips to get the above interfaces to successfully bridge
together would be great.

Thanks,
Umar
=20
**********************************************************************
This e-mail is the property of Lantronix. It is intended only for the =
person or entity to which it is addressed and may contain information =
that is privileged, confidential, or otherwise protected from =
disclosure. Distribution or copying of this e-mail, or the information =
contained herein, to anyone other than the intended recipient is =
prohibited.
