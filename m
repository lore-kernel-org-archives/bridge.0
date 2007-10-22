Date: Mon, 22 Oct 2007 09:13:50 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [Bridge] Bridging firewall issue - which interface are packets
	coming from?
Message-ID: <20071022091350.284c7040@freepuppy.rosehill>
In-Reply-To: <f64cba9929b9.471a9ba5@rmc.ca>
References: <f64cba9929b9.471a9ba5@rmc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: s24067@rmc.ca
Cc: bridge@linux-foundation.org

On Sun, 21 Oct 2007 00:21:57 -0400
s24067@rmc.ca wrote:

> Hello folks, I'm hoping someone can help me here. I'll try to describe the problem in detail.
> 
> I'm attempting to set up a bridging firewall using libipq. I'm running on Ubuntu Server 7.04, out of the box kernel (2.6.20)
> My bridge is set up with the following commands:
> --
> brctl addbr br0 
> brctl stp br0 off
> brctl addif br0 eth1
> brctl addif br0 eth2
> ifconfig eth1 down
> ifconfig eth2 down
> ifconfig eth1 0.0.0.0 up
> ifconfig eth2 0.0.0.0 up
> ifconfig br0 0.0.0.0 up
> --
> 
> IP queue is set up with the following:
> --
> iptables -A FORWARD -j QUEUE
> modprobe ip_queue
> --
> 
> 
> The bridge works fine. Traffic is sent back and forth. My libipq app can see traffic and stop it. However, one thing I would like to be able to find out in user space is which interface a packet arrived on (ie/ which direction it's going). As far as IPQ is concerned, all packets are arriving and leaving on br0.
> After reading a bit more about netfilter, iptables and the FIREWALL document distributed with brctl, I figured my best bet would be do something like this:
> iptables -A INPUT -i eth1 -j MARK --set-mark 1
> iptables -A INPUT -i eth2 -j MARK --set-mark 2
> 
> This way I could just check the mark value when the packet got sent to QUEUE (and up to user space) from the FORWARD chain. However, this doesn't work. From everything I can tell, packets traversing the bridge do not even go through the INPUT chain, as I can put in this rule:
> iptables -A INPUT -j DROP
> 
> yet traffic still flows through fine (as long as my libipq app is running).
> 
> 
> Does anyone here have any ideas? I would really appreciate any suggestions.
> 
> Cheers,
> David Vessey
> 
> 

Ask on netfilter-devel mailing list and Patrick McHardy.

-- 
Stephen Hemminger <shemminger@linux-foundation.org>
