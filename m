Return-Path: <michel@west.nl>
Message-ID: <53DB91CD.2070106@west.nl>
From: Michel Wilson <michel@west.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] tg3 not working in bridged mode
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Fri, 01 Aug 2014 13:17:55 -0000
To: bridge@lists.linux-foundation.org

Hello,

I have a weird issue using a BCM95721 in bridged mode. In a production 
server I have eth0: Tigon3 [partno(BCM95721) rev 4201] (PCI Express), 
which is part of a bridge, with some tap interfaces on which some 
virtual machines reside. Everything works like a charm. This server runs 
Debian squeeze, 2.6.32-5-amd64 kernel.

On a testing server I have eth0: Tigon3 [partno(BCM95721) rev 4101] (PCI 
Express) (older revision, same hardware?). Here, the card will not work 
properly in briding mode: it does not 'see' packets not destined for its 
own MAC address. Even running a tcpdump in promiscous mode does not show 
these packets. Running it non-bridged works fine.

The result is that, if the bridge MAC is different from the eth0 MAC, 
the host is not reachable. If the bridge MAC happens to be the same as 
the eth0 MAC, the host itself is reachable, but bridging obviously still 
doesn't work.

I tested the testing server using the same 2.6.32-5-amd64 kernel as the 
production machine uses (including firmware), and to my surprise that 
kernel also doesn't work. So apparently rev 4101 contains some kind of 
bug wrt bridging mode. It almost seems like promiscous mode is reset 
somehow, kind of like the (very old) problem described here: 
http://www.spinics.net/lists/linux-ethernet-bridging/msg00756.html
This is on a very old version however, I could not reuse those steps in 
debugging this issue on my kernel version.

To rule out hardware issues, I have another identical machine (hw and 
sw) with the same issue. Also, plugging in an intel card which I 
happened to have lying around works just fine...

Does anyone have any ideas on how to test/debug/fix this issue?

Michel.
