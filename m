Date: Sat, 18 Apr 2009 09:01:52 +0200
From: Jiri Pirko <jpirko@redhat.com>
Message-ID: <20090418070151.GA3370@psychotron.englab.brq.redhat.com>
References: <20090313183303.GF3436@psychotron.englab.brq.redhat.com>
	<20090415081720.GA21342@psychotron.englab.brq.redhat.com>
	<20090415081819.GB21342@psychotron.englab.brq.redhat.com>
	<20090415180215.GA22540@psychotron.englab.brq.redhat.com>
	<20090417115723.GE9556@psychotron.englab.brq.redhat.com>
	<20090417083315.2f089755@nehalam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090417083315.2f089755@nehalam>
Subject: Re: [Bridge] [PATCH 1/3] net: introduce a list of device
	addresses	dev_addr_list (v3)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: ivecera@redhat.com, fubar@us.ibm.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mschmidt@redhat.com, bonding-devel@lists.sourceforge.net, dada1@cosmosbay.com, jgarzik@pobox.com, davem@davemloft.net

Fri, Apr 17, 2009 at 05:33:15PM CEST, shemminger@vyatta.com wrote:

<snip>

>> +struct netdev_hw_addr {
>> +	struct list_head	list;
>> +	unsigned char		addr[MAX_ADDR_LEN];
>> +	int			refcount;
>> +	struct rcu_head		rcu_head;
>> +};
>
>Minor nit, the ordering of elements cause holes that might not be
>needed.

Agree that ordering might be done better. Will do.
>
>Space saving? is rcu_head needed or would using synchronize_net
>make code cleaner and save space. 
>

Well I originaly had this done by synchronize_rcu(). Eric argued that it might
cause especially __hw_addr_del_multiple_ii() to run long and suggested to use
call_rcu() instead. I plan to switch this to kfree_rcu() (or whatever it's
called) once it hits the tree.

<snip>

>> +	ha = kzalloc(max(sizeof(*ha), L1_CACHE_BYTES), GFP_ATOMIC);
>> +	if (!ha)
>> +		return -ENOMEM;
>Since you are initializing all fields, kzalloc isn't really needed

Noted.
>
>> +	memcpy(ha->addr, addr, addr_len);
>> +	ha->refcount = 1;
>> +	list_add_tail_rcu(&ha->list, list);
>> +	return 0;
>> +}

<snip>

>> +static void dev_addr_flush(struct net_device *dev)
>> +{
>> +	ASSERT_RTNL();
>> +
>Since this is local you should be able to audit all
>the callers and remove this ASSERT.

Okay. I will at least put a comment instead of this.
>
>> +	__hw_addr_flush(&dev->dev_addr_list);
>> +	dev->dev_addr = NULL;
>> +}
>> +
>> +static int dev_addr_init(struct net_device *dev)
>> +{
>> +	unsigned char addr[MAX_ADDR_LEN];
>> +	struct netdev_hw_addr *ha;
>> +	int err;
>> +
>> +	ASSERT_RTNL();
>Ditto, ASSERT_RTNL makes sense for exposed kernel API and
>initial testing.
>
>> +	INIT_LIST_HEAD(&dev->dev_addr_list);
>> +	memset(addr, 0, sizeof(*addr));
>> +	err = __hw_addr_add(&dev->dev_addr_list, addr, sizeof(*addr));
>> +	if (!err) {
>> +		/*
>> +		 * Get the first (previously created) address from the list
>> +		 * and set dev_addr pointer to this location.
>> +		 */
>> +		ha = list_first_entry(&dev->dev_addr_list,
>> +				      struct netdev_hw_addr, list);
>> +		dev->dev_addr = ha->addr;
>> +	}
>> +	return err;
>> +}

<snip>

