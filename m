Subject: Re: [Bridge] Neighbour table overflow
From: Bart De Schuymer <bdschuym@pandora.be>
In-Reply-To: <41DAD4CD.7040606@softhome.net>
References: <41DAD4CD.7040606@softhome.net>
Content-Type: text/plain
Date: Tue, 04 Jan 2005 22:04:20 +0100
Message-Id: <1104872660.3376.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: WL Siew <wlsiew@softhome.net>
Cc: bridge@lists.osdl.org

Op wo, 05-01-2005 te 01:39 +0800, schreef WL Siew:
> Hi,
> 
> I had successfully setup my bridge (br0) but after few minutes the br0 
> interface seems not working.
> 
> ifconfig eth0 0.0.0.0
> ifconfig eth5 0.0.0.0
> 
> brctl addbr br0
> 
> brctl addif br0 eth0
> brctl addif br0 eth5
> 
> brctl stp br0 on

From the information you give, it seems that you assigned the IP address
0.0.0.0 to your bridge ports and you didn't to start the bridge itself.
Your box therefore has no IP address and will therefore not respond to
icmp messages.

Try
# ifconfig br0 $IP_ADDRESS
A ping to $IP_ADDRESS from another host should then work (after you
start the bridge it can take a few seconds before the bridge responds).

> I check on my system's /var/log/syslog file.  It shows something strange 
> messages as below: -
> 
> Jan  2 10:44:22 fw01 kernel: ipt_tcpmss_target: bad length (64 bytes)
> Jan  2 10:44:32 fw01 last message repeated 11 times
> Jan  2 12:27:08 fw01 kernel: Neighbour table overflow.
> Jan  2 12:27:11 fw01 last message repeated 9 times
> Jan  2 12:27:13 fw01 kernel: NET: 10 messages suppressed.

Perhaps these are triggered by the fact that your network devices enter
promiscuous mode.

> I unplug the network cable connected to the eth5 and run a ping to my 
> router...the network is up again...I am able to ping my router.

I'm assuming you are talking about the bridge box when you are talking
about the router? The bridge ports of a bridge are by default not
separately pingable. Only the IP address of the bridge (br0) device
itself is pingable.
You can change that behaviour by making a brouter. You can then assign
IP addresses to the bridge ports and use them.

cheers,
Bart


