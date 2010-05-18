Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 May 2010 16:38:54 -0700
Message-ID: <F24C979D1AFD4E4292B911441CBA242407FCC7@2putt.int.lantronix.com>
References: <F24C979D1AFD4E4292B911441CBA242407FCC1@2putt.int.lantronix.com>
	<4BF2EB38.4060408@free.fr>
From: "Umar Qureshey" <umar.qureshey@lantronix.com>
Subject: Re: [Bridge] Hardware requirements for bridging wired+wireless
	together
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?iso-8859-1?Q?Nicolas_de_Peslo=FCan?= <nicolas.2p.debian@free.fr>
Cc: bridge@lists.linux-foundation.org

-----Original Message-----
From: Nicolas de Peslo=FCan [mailto:nicolas.2p.debian@free.fr]=20
Sent: Tuesday, May 18, 2010 12:32 PM
To: Umar Qureshey
Cc: bridge@lists.linux-foundation.org
Subject: Re: [Bridge] Hardware requirements for bridging wired+wireless =
together

Umar Qureshey wrote:
> Hi,
>
> I have been trolling the 'net as well as the archives of this list for
> quite a while now.
>
> I am still unclear on the requirements for getting an Ethernet and
> Wireless interface to bridge together.
>
> Currently, I am working with an esoteric radio that only supports =
Ad-Hoc
> and Managed modes.  There seemingly is not support for WDS (Wireless
> Distribution System) on this radio.
>
> I have been trying to bridge my eth0 and wlan0 but it doesn't seem to
> work.  Currently, my commands to get the bridge up are:
>
> ifconfig eth0 0.0.0.0
> ifconfig wlan0 0.0.0.0
> brctl addbr br0
> brctl addif br0 eth0
> brctl setfd br0 1           #BusyBox version of brctl doesn't take 0 =
as
> a time parameter so I change it to 1 (sec)
> ifconfig br0 up
> wpa_supplicant -Dwext -iwlan0 -bbr0 -c/root/wpa_supplicant.conf

I think you forgot to add wlan0 to the bridge:

brctl addif br0 wlan0

	Nicolas.

> Then I try to run udhcpc (DHCP client) on the bridge hoping to get =
DHCP
> from the AP/router:
>
> # udhcpc -ibr0 -b
> udhcpc (v1.15.2) started
> Sending discover...
> Sending discover...
> Sending discover...
> No lease, forking to background
>
> What I'd like to inquire is that is WDS support in the =
firmware/hardware
> of the radio required to bridge eth0 and wlan0?
> Any other tips to get the above interfaces to successfully bridge
> together would be great.
>
> Thanks,
> Umar
>

Hi,

I just wrote it wrong in a rush.  My board has two interfaces: eth0 and =
wlan0.  My sequence is as follows now:

ifconfig eth0 0.0.0.0
ifconfig wlan0 0.0.0.0
brctl addbr br0
brctl addif br0 eth0
brctl setfd br0 1
ifconfig br0 hw ether [MAC address of wlan0]
wpa_supplicant -Dwext -iwlan0 -bbr0 -c/root/wpa_supplicant.conf -B
brctl addif br0 wlan0
ifconfig br0 192.168.1.100 up

With the above sequence, I can ping the AP at 192.168.1.1 from the board =
ok.
However, when I try to ping the wireless AP from a computer connected =
via an Ethernet crosswire cable to eth0, I get the following in my =
kernel buffer log for *each* incoming ping:

[   88.510000] wlan0: received packet with  own address as source =
address
[   94.010000] wlan0: received packet with  own address as source =
address
[   97.360000] wlan0: received packet with  own address as source =
address
[  109.190000] wlan0: received packet with  own address as source =
address


I tried two permutations on the above scenario:

#1) Using the same exact above sequence but omitting the "ifconfig br0 =
hw ether [MAC address of wlan0]" command, I notice the br0 takes the MAC =
address of eth0.  In this case when I ping 192.168.1.1 from the board, I =
get the same warning in my kernel log:

[  124.800000] wlan0: received packet with  own address as source =
address
[  292.900000] wlan0: received packet with  own address as source =
address

I am also unable to ping from the computer connected via an Ethernet =
crosswire cable to eth0.


#2) Now if I use the same exact sequence above but spoof the MAC address =
to a fake one with the "ifconfig br0 hw ether [spoofed MAC address]" =
command, I cannot ping the AP at 192.168.1.1 anymore from the board.  =
For each ping that goes out from the board, in the kernel log buffer I =
get:

[  355.160000] wlan0: received packet with  own address as source =
address
[  359.660000] wlan0: received packet with  own address as source =
address

I am still unable to ping from the computer connected via an Ethernet =
crosswire cable to eth0.


So, in conclusion, I tried assigning to the bridge (br0) the wlan0's MAC =
address in which case I could ping the AP from the board.  In case of =
assigning the bridge the MAC address of eth0, I could not ping the AP =
from the board anymore.  Finally, assigning br0 a totally spoofed MAC =
address, I was still unable to ping the AP from the board.
In all cases above, I am unable to ping the AP via a machine that is =
connected to eth0 with a Ethernet crosswire cable.  This is what would =
really prove the bridge is working because the Linux board would be =
receiving the ICMP request on its eth0 interface which it would bridge =
to wlan0 interface which would then send that ICMP ping to the AP.  The =
AP would respond to the ping and send response to wlan0 which would =
bridge it to eth0 which would pass it back to the destination machine =
(the reverse route of outgoing).

I am wondering where and how WDS would come in to get the bridge to =
work.

Regards,
Umar
=20
**********************************************************************
This e-mail is the property of Lantronix. It is intended only for the =
person or entity to which it is addressed and may contain information =
that is privileged, confidential, or otherwise protected from =
disclosure. Distribution or copying of this e-mail, or the information =
contained herein, to anyone other than the intended recipient is =
prohibited.
