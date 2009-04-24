Date: Fri, 24 Apr 2009 23:26:47 +0200
From: Jiri Pirko <jpirko@redhat.com>
Message-ID: <20090424212646.GB3403@psychotron.englab.brq.redhat.com>
References: <20090313183303.GF3436@psychotron.englab.brq.redhat.com>
	<20090415081720.GA21342@psychotron.englab.brq.redhat.com>
	<20090415081819.GB21342@psychotron.englab.brq.redhat.com>
	<20090415180215.GA22540@psychotron.englab.brq.redhat.com>
	<20090417115723.GE9556@psychotron.englab.brq.redhat.com>
	<20090418085848.GC3370@psychotron.englab.brq.redhat.com>
	<20090423085855.526220c3@s6510>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090423085855.526220c3@s6510>
Subject: Re: [Bridge] [Bonding-devel] [PATCH 1/3] net: introduce a list of
	device	addresses dev_addr_list (v4)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: ivecera@redhat.com, bridge@lists.linux-foundation.org, mschmidt@redhat.com, davem@davemloft.net, netdev@vger.kernel.org, fubar@us.ibm.com, bonding-devel@lists.sourceforge.net, dada1@cosmosbay.com, jgarzik@pobox.com

Thu, Apr 23, 2009 at 05:58:55PM CEST, shemminger@vyatta.com wrote:
>On Sat, 18 Apr 2009 10:58:49 +0200
>Jiri Pirko <jpirko@redhat.com> wrote:
>
>> v3 -> v4 (current):
>> -changed kzalloc to kmalloc in __hw_addr_add_ii()
>> -ASSERT_RTNL() avoided in dev_addr_flush() and dev_addr_init()
>> 
>> v2 -> v3:
>> -removed unnecessary rcu read locking
>> -moved dev_addr_flush() calling to ensure no null dereference of dev_addr
>> 
>> v1 -> v2:
>> -added forgotten ASSERT_RTNL to dev_addr_init and dev_addr_flush
>> -removed unnecessary rcu_read locking in dev_addr_init
>> -use compare_ether_addr_64bits instead of compare_ether_addr
>> -use L1_CACHE_BYTES as size for allocating struct netdev_hw_addr
>> -use call_rcu instead of rcu_synchronize
>> -moved is_etherdev_addr into __KERNEL__ ifdef
>> 
>> This patch introduces a new list in struct net_device and brings a set of
>> functions to handle the work with device address list. The list is a replacement
>> for the original dev_addr field and because in some situations there is need to
>> carry several device addresses with the net device. To be backward compatible,
>> dev_addr is made to point to the first member of the list so original drivers
>> sees no difference.
>> 
>> Signed-off-by: Jiri Pirko <jpirko@redhat.com>
>
>I am still unsure why this added complexity to the network device model is needed.

I've found no other way how to support devices with multiple macs i.e. as a port
in the bridge (without horrible hooks).
>
>How does this interact with neighbor table (ARP)?

It doesn't interact ARP. ARP uses only the first device (dev_addr ptr). I'm not
sure this is the right behaviour, but I think that this is not crucial now.

>Isn't this what macvlan already does.

Hmm I'm looking at this and I'm not sure it would help (I've found no
documentation). Can you please show an example how this solves "bonding
interface in atb mode as a port in the bridge" problem?

Thanks
>
>
>
