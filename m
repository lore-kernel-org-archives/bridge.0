Message-ID: <4086A65C.8060005@austin.rr.com>
Date: Wed, 21 Apr 2004 11:50:36 -0500
From: TC Hough <tchough@austin.rr.com>
MIME-Version: 1.0
References: <Pine.LNX.4.33L2.0404201432270.26511-100000@tosko>
In-Reply-To: <Pine.LNX.4.33L2.0404201432270.26511-100000@tosko>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: Misbehaving bridge...
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: andyb@island.net
Cc: bridge@lists.osdl.org

I never figured out a solution, but I did come up with a work around. 
The problem I figured out I was having was that when my prism2 card was 
configured as a client to my wireless access point, promiscuous mode 
would not function as expected. When I started up iptraf and monitored 
traffic, I would only see the traffic destined for my machine instead of 
all network traffic. I suspect that this may be a protocol limitation 
because I had the same results with all possible combinations of the 
following hardware:

D-Link DWL-520 Rev. E1 802.11b Wireless PCI Card with Prism2 chipset 
using HostAP drivers and 1.8.0 firmware.
Netgear WG511 802.11g Wireless PC Card with Prism54 chipset using 
Prism54.org drivers
Belkin F5D7130tt 802.11g Wireless Access Point with latest U.S. firmware.
Netgear WG602 v2 802.11g Wireless Access Point with latest U.S. firmware.

My work around was to setup my wireless card as a master and use WDS to 
bridge the two wireless networks. I accomplished this by first using 
iwconfig to setup the card as a master with the same encryption 
settings, ESSID and channel as the hardware access point. Then I used 
iwpriv to bridge the network with the following commands:

iwpriv wlan0 max_wds 1
iwpriv wlan0 wds_type 4
iwpriv wlan0 wds_add XX:XX:XX:XX:XX:XX

Just fill in your access point's MAC address for the X's. When I run the 
commands, I get some errors, but they don't seem to affect whether or 
not the bridge functions properly. I then had to edit my AP's settings 
and give it my wireless card's MAC address for bridging.

The wds_add command creates a fake adaptor called wlan0wds0. Just bring 
it up by typing:

ifconfig wlan0wds0 up

After that, all that's left is configuring the actual bridge. Just make 
sure that the interface you're using is wlan0wds0 and not wlan0.

To have this all happen automatically on my Debian system, I had to do 
some tinkering with /etc/network/interfaces. Here's the settings I used, 
just in case it'll help:

# /etc/network/interfaces -- configuration file for ifup(8), ifdown(8)

# The loopback interface
auto lo eth0 wlan0 wlan0wds0 br0
iface lo inet loopback

# The first network card - this entry was created during the Debian 
installation
# (network, broadcast and gateway are optional)

iface eth0 inet static
address 0.0.0.0
netmask 255.255.255.0

iface wlan0 inet static
address 0.0.0.0
netmask 0.0.0.0
pre-up /usr/sbin/hostap_fw_load wlan0
pre-up /sbin/iwconfig wlan0 mode master essid tlci channel 9 key `cat /e
tc/apkey`
pre-up /sbin/iwpriv wlan0 max_wds 1
pre-up /sbin/iwpriv wlan0 wds_type 4
pre-up /sbin/iwpriv wlan0 wds_add 00:09:5B:5B:C0:7B

iface wlan0wds0 inet static
address 0.0.0.0
netmask 0.0.0.0
iface br0 inet static
pre-up brctl addbr br0
pre-up brctl addif br0 eth0
pre-up brctl addif br0 wlan0wds0
pre-up brctl stp br0 on
post-down brctl delbr br0
address 192.168.0.126
netmask 255.255.255.0
network 192.168.0.0
broadcast 192.168.0.255
gateway 192.168.0.254

You'll have to replace the network settings with your own, but that 
should give you a basic idea. Unless you're using the DWL-520 Rev. E1, 
you probably won't need the hostap_fw_load line, either.

Hope this information helps you. I'm CCing the mailing list just in case 
someone else decides to search through the archive.

TC

andy barlak wrote:

>Saw your post archived on the bridge mailing list.
>But no followups as the last archive update was April 16.
>
>I too have a prism2 card, and have similar bridging difficulties on
>these soekris access points.
>
>Have you received any help from the list?  Any success?
>
>  
>


