Date: Wed, 16 Jun 2004 10:19:04 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-Id: <20040616101904.27121bd8@dell_ss3.pdx.osdl.net>
In-Reply-To: <1087379588.72784.vanyew@mail2000.com.tw>
References: <1087379588.72784.vanyew@mail2000.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: bridge can't get ip by "dhcpcd br0"
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: vanyew@mail2000.com.tw
Cc: bridge@osdl.org

On Wed, 16 Jun 2004 17:53:08 +0800 (CST)
"vanyew" <vanyew@mail2000.com.tw> wrote:

> Dear Stephen,
> 
> I'm a Linux embedded developer.
> We want to build the bridge function on our product.
> 
> We use brctl to build the bridge device.
> 
> [root@localhost /]# brctl show
> bridge name     bridge id               STP enabled     interfaces
> [root@localhost /]# brctl addbr br0
> [root@localhost /]# brctl show
> bridge name     bridge id               STP enabled     interfaces
> br0             8000.000000000000       yes
> [root@localhost /]# brctl addif br0 eth1
> [root@localhost /]# brctl addif br0 eth2
> [root@localhost /]# brctl show
> bridge name     bridge id               STP enabled     interfaces
> br0             8000.000c294b1073       yes             eth1
>                                                         eth2
> [root@localhost /]#
> 
> By default,we hope our bridge device can get ip from both staic and dhcp.
> 
> We can successfully set static ip to br0 by
> ifconfig br0 192.168.1.99 netmask 255.255.255.0 up
> 
> But when we try to get ip from dhcp server for br0,
> we failed to do this.
> [root@localhost /]#dhcpcd br0
> 
> The bridge device get no ip from dhcpcd server,
> and I also use ethereal to listen the traffic on eth1 and eth2,
> we found no any dhcp discover packet was sent out.
> Only 802.1d (Spanning Tree Protocol) packet was seen.
> 
> I have read all articles on http://bridge.sourceforge.net/.
> I found no any solution to this problem.
> Do you have any idea to this problem?

It is possible to use DHCP on the bridge device.  The problem is that
the bridge takes some time to go through initial learning states to acquire
the addresses of other bridges.  This delay is required by the 802 spec to keep
bridges from disturbing networks.

You can see the state by doing:
	brctl showstp br0

After the port is in the "Forwarding" state, it is fully operational.
At that point, you can start dhcp.  


-- 
Stephen Hemminger 		mailto:shemminger@osdl.org
Open Source Development Lab	http://developer.osdl.org/shemminger
