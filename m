Message-ID: <20051230173928.99908.qmail@web33513.mail.mud.yahoo.com>
Date: Fri, 30 Dec 2005 09:39:28 -0800 (PST)
From: Jeff Sadowski <jeff_sadowski@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [Bridge] trouble shooting?
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org, madwifi-users@lists.sourceforge.net

Ok here is what I know so far.

I am bridging an openvpn tap0 device with a eth0
ethernet device.
Works just fine.
here is how I do that

ifconfig eth0 up promisc 0.0.0.0
ifconfig tap0 up promisc 0.0.0.0
brctl addbr br0
brctl addif br0 eth0
brctl addif br0 tap0
dhclient br0

and then any machine that connects to the tap0 device
can also get a
dhcp ipaddress through the bridge.

ok that all said and done that all works great now for
the tricky part
I want to change the ethernet device to a wireless
ethernet device.

I am using the madwifi-ng drivers and try to keep them
up to date.
I think I got it working some of the times and only
times I was bridging
through wired ethernet first. then I would add
wireless and remove the
wired from the bridge. But receintly I havn't even
gotten this to work
the madwifi-ng drivers supposidly allow for seemless
bridging and should
allow this to work. If anyone has some experience with
this I'd like some
help.

this is what I tried

ifconfig wifi0 up promisc 0.0.0.0
wlanconfig ath0 create wlandev wifi0
iwpriv ath0 wds 1
ifconfig ath0 up promisc 0.0.0.0
wpa_supplicant -Bw -Dmadwifi -iath0
-c/etc/wpa_supplicant.conf
ifconfig tap0 up promisc 0.0.0.0

then I check till im connected using
wpa_cli -i ath0 status
to check

then I start the bridge
brctl addbr br0
brctl addif br0 ath0
brctl addif br0 tap0
dhclient br0
(which gets an address)

but all my openvpn clients cannot get an ipaddress
I'm not sure why. If there are some trouble shooting
steps
I'd like to know how to begin. I have tried sniffing
ath0
using ethereal.

When using ethereal I see dhcp requests from the
openvpn clients
but no replys.

I'm filtering of the mac address of the openvpn
clients tap device
Its as though madwifi-ng drivers aren't really in
promisc mode
but when I check with ifconfig it still says promisc

Does anyone have any further things I can try to
trouble shoot what
is going wrong?

Thanks

Jeff Sadowski



	
		
__________________________________ 
Yahoo! for Good - Make a difference this year. 
http://brand.yahoo.com/cybergivingweek2005/
