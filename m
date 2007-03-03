Sender: ak@suse.de
References: <45E67B04.2060702@linux-foundation.org>
	<20070228.232224.74746939.davem@davemloft.net>
	<45E6802C.2090708@linux-foundation.org>
	<20070228.233034.74746721.davem@davemloft.net>
From: Andi Kleen <andi@firstfloor.org>
Date: 03 Mar 2007 03:14:29 +0100
In-Reply-To: <20070228.233034.74746721.davem@davemloft.net>
Message-ID: <p733b4ncbui.fsf@bingen.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [Bridge] [PATCH] bridge: avoid ptype_all packet handling
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, greearb@candelatech.com, bridge@linux-foundation.org

David Miller <davem@davemloft.net> writes:
> 
> And in fact that effectively makes the new socket option
> pointless, since it doesn't buy us anything since we have
> to support the old stuff fully anyways.

I don't think it's pointless because it would still allow
newer DHCP clients to have less impact on other packets
when they are active. 

This can matter when you have a system with multiple
interfaces where DHCP doesn't get a address on one.

That's pretty common with many x86 server boards because 
they come with two NICs by default but must people only
plug the cable into one. However the distro installers
run DHCP on all.

When this happens all packets are always forced through
ptype_all chains before being rejected by AF_PACKETs device
bind, which adds some overhead to them. 

-Andi
