Date: Fri, 21 May 2010 08:24:05 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20100521082405.21917a66@nehalam>
In-Reply-To: <4BF64C67.5070206@si.ct.upc.edu>
References: <4BF64C67.5070206@si.ct.upc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] MAC address in bridge device
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: frank <frank@si.ct.upc.edu>
Cc: bridge@lists.linux-foundation.org

On Fri, 21 May 2010 11:03:35 +0200
frank <frank@si.ct.upc.edu> wrote:

> Hi all,
> we have a couple of Red Hat 5 servers with OpenVZ with some virtual 
> machines (VEs). This virtual machines have veths (virtual ethernet 
> devices), and this devices are attached to a bridge device with main 
> node ethernet.
> 
> # brctl show
> vzbr2        8000.001851cfe1c3    no        veth130.0
>                                                                   eth0
> The bridge device also has an IP because we need to reach host with an 
> IP in this subnet.
> We have noticed a problem:
> 
> When we boot the main host, the bridge takes the IP we have defined to 
> it and the MAC af the eth0 device. That's ok.
> But when a veth is joined to the bridge device, this one takes the MAC 
> of the veth device, so MAC bridge device changes; of course this cause 
> different kind of network problems because all hosts which were 
> connected still has the old MAC in its arp table.
> 
> We have revised a lot of things, but we don't find any explanation. Does 
> anybody  know a possible cause of this behaviour?
> Where can we look to get more information? Is the bridge working as 
> expected?

Unless overridden, the bridge device takes the lowest MAC address
of all the devices in the bridge. I believe the original intention
was to have the bridge device get the same address independent of what
order devices were added.

In current kernels, (RHEL may be too old to have this fix)
you can solve the problem by assigning a MAC address to the bridge device
(one of the slaves). The bridge device then remembers that the address
has been set and no longer changes the MAC address.

There was also a proposal which has not been integrated to have "master
device". It would solve the problem, and make boot up easier.
-- 
