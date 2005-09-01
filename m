Date: Thu, 1 Sep 2005 10:10:37 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] rcu_dereference() error in coldfire arch
Message-ID: <20050901101037.181c6de3@dxpl.pdx.osdl.net>
In-Reply-To: <20050901135348.10868.qmail@webmaild.fe1.aruba.it>
References: <20050901135348.10868.qmail@webmaild.fe1.aruba.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: overet@securitydate.it
Cc: bridge@lists.osdl.org

On Thu, 01 Sep 2005 15:53:48 +0200
overet@securitydate.it wrote:

> Hi,
> i'm trying to develop an embedded system with ColdFire architecture (similar 
> at m68k) and i have some problems. 
> 
> The bridge module is loaded properly in the kernel. When an ARP packet is 
> sent to the port of the bridge there are 2 situations: 
> 
>  - If destination MAC address is FF:FF:FF:FF:FF:FF the packet is forwarded.
>  - If destination MAC address is not a broadcast address the packet is 
> droped. 

Have you waited long enough for the bridge port to get out of
the LEARNING state?

> Then, if i send an ICMP packet whit static ARP entries on the two hosts the 
> packet are droped. 

What is the contents of the bridge forwarding table? 
	brctl showmacs br0

> So, i look in the source tree to search the bug and i can see that in the 
> handle_bridge() function in net/core/dev.c at this point:
>  ---------------------------------------------------------------------
>        if ((*pskb)->pkt_type == PACKET_LOOPBACK ||
>            (port = rcu_dereference((*pskb)->dev->br_port)) == NULL)
>                return 0;
>  ---------------------------------------------------------------------
> the condition if () succeded whit port == NULL (but it shouldn't) and the 
> packet are droped. 
> 
> How can i do to resolv this problem in m68k compliant architecture? 
> 
> Best regards,
> oveRet 

rcu_dereference is a macro that does nothing except on SMP Alpha.
So think of it as:
#define rcu_dereference(x) (x)

That test in net/core/dev.c says:
	if packet is loopback
	   or device is not a member of a bridge
		then return 0 (don't pass it to bridge)

Are you sure that the ethernet device you are using correctly sets
the pkt_type and the device pointer on received packets before
calling netif_receive?


