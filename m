Date: Sat, 22 Nov 2008 22:40:21 -0800
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20081122224021.39238f0c@extreme>
In-Reply-To: <gg92a9$5ot$1@ger.gmane.org>
References: <gg92a9$5ot$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] bridge changes id on addif - is that normal?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: bridge@linux-foundation.org

On Sat, 22 Nov 2008 13:43:37 +0000 (UTC)
Thomas Mueller <thomas@chaschperli.ch> wrote:

> hi 
> 
> i've setup the following on debian etch with bridge-utils 1.4 
> (backported) and kernel 2.6.26 from backports.org:
> 
> vlan10 with raw device eth0
> vlan20 with raw device eth0
> 
> br10 with initial port vlan10
> br20 with initial port vlan20
> 
> i've set hw addr to DE:AD:BE:EF:34:10 for br10 and DE:AD:BE:EF:34:20 for 
> br20
> 
> the bridges are used to connect virtual machine nic's.
> 
> "brctl show" before any other port is attached:
> 
> bridge name     bridge id               STP enabled     interfaces
> br10            8000.deadbeef3410       no              vlan10
> br20            8000.deadbeef3420       no              vlan20
> 
> 
> then after "brctl addif br10 vnet1" and "brctl addif br10 vnet2" brctl 
> show says:
> 
> bridge name     bridge id               STP enabled     interfaces
> br10            8000.00ff351a360c       no              vnet1
>                                                         vlan10
> br20            8000.00ff8fe8ee1d       no              vnet2
>                                                         vlan20
> 
> why the bridge id changed? on delif the bridge id changes back to the 
> original one.
> 
> On "brctl addbr" the following kernel message is printed:
> 
> [426666.180613] br10: Dropping NETIF_F_UFO since no NETIF_F_HW_CSUM 
> feature.
> 
> if i don't set the mac addr to the bridges they get both the hw addr from 
> eth0. the bridge id doesn't change on addif but there are many kernel 
> messages like the one below:
> 
> [405275.752398] vnet1: received packet with  own address as source address
> 
> Any hints appreciated. 
> 

First off the hardware address of the bridge is by default the lowest
of all the interfaces (unless you set it). This was done by original author
to deal with case of interfaces added out of order on boot.

The second issue is because you are making a loop in your network.
If you had STP enabled it would probably scream at you.
