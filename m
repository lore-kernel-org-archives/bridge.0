Message-ID: <47D57881.2020503@redfish-solutions.com>
Date: Mon, 10 Mar 2008 11:05:53 -0700
From: Philip Prindeville <philipp_subx@redfish-solutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Question about using brctl and changing MAC addresses
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@osdl.org

I'm using Linux 2.6.20 (yes, I'll be upgrading to 2.6.24 as soon as it's
stable).

I have 4 VIA rhine ethernet controllers on my Soekris net5501, plus an
ADSL PCI card (a Sangoma S-518) that runs in AAL5-SNAP mode, so it looks
like an Ethernet controller.

I'm trying to bridge eth0 and w1ad (the ADSL interface) into "br0".  And
I'm trying to force the traffic on br0 to have the MAC address that my
ISP insists I use (i.e. that of the crappy little Westell 6100 modem
they sent me).

The issue is the following.  If I do:

ifconfig w1ad down hw ether x:x:x:x:x:x up

followed by either:

brctl addbr br0
brctl addif br0 eth0
brctl addif br0 w1ad

or:

brctl addbr br0
brctl addif br0 w1ad
brctl addif br0 eth0

the bridge ends up taking the MAC address of eth0 either way, which I
don't get (how does it decide which to use?).

I can clone the same MAC address to both eth0 and w1ad, but I don't know
if that would cause me any problems or not (I haven't read the STP spec
in about 15 years).

What's the solution?

Is there a way to explicitly set the MAC address of the bridge interface?

I tried:

ifconfig br0 down hw ether x:x:x:x:x:x up

but that just results in:

ifconfig: SIOCSIFHWADDR: Cannot assign requested address

So, I'm not clear what the best solution is.

Any guidance is appreciated.

Thanks,

-Philip
