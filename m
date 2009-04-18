Message-ID: <49E98A12.9020302@cosmosbay.com>
Date: Sat, 18 Apr 2009 10:06:42 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
MIME-Version: 1.0
References: <20090313183303.GF3436@psychotron.englab.brq.redhat.com>
	<20090415081720.GA21342@psychotron.englab.brq.redhat.com>
	<20090415081819.GB21342@psychotron.englab.brq.redhat.com>
	<20090415180215.GA22540@psychotron.englab.brq.redhat.com>
	<20090417115723.GE9556@psychotron.englab.brq.redhat.com>
	<20090417083315.2f089755@nehalam>
	<20090418070151.GA3370@psychotron.englab.brq.redhat.com>
	<49E982C4.8020407@cosmosbay.com>
	<20090418074427.GB3370@psychotron.englab.brq.redhat.com>
In-Reply-To: <20090418074427.GB3370@psychotron.englab.brq.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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
To: Jiri Pirko <jpirko@redhat.com>
Cc: ivecera@redhat.com, fubar@us.ibm.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mschmidt@redhat.com, bonding-devel@lists.sourceforge.net, Stephen Hemminger <shemminger@vyatta.com>, jgarzik@pobox.com, davem@davemloft.net

Jiri Pirko a =E9crit :
> Sat, Apr 18, 2009 at 09:35:32AM CEST, dada1@cosmosbay.com wrote:
>> Jiri Pirko a =E9crit :
>>> Fri, Apr 17, 2009 at 05:33:15PM CEST, shemminger@vyatta.com wrote:
>>>
>>> <snip>
>>>
>>>>> +struct netdev_hw_addr {
>>>>> +	struct list_head	list;
>>>>> +	unsigned char		addr[MAX_ADDR_LEN];
>>>>> +	int			refcount;
>>>>> +	struct rcu_head		rcu_head;
>>>>> +};
>>>> Minor nit, the ordering of elements cause holes that might not be
>>>> needed.
>>> Agree that ordering might be done better. Will do.
>>>> Space saving? is rcu_head needed or would using synchronize_net
>>>> make code cleaner and save space.=20
>>>>
>>> Well I originaly had this done by synchronize_rcu(). Eric argued that=
 it might
>>> cause especially __hw_addr_del_multiple_ii() to run long and suggeste=
d to use
>>> call_rcu() instead. I plan to switch this to kfree_rcu() (or whatever=
 it's
>>> called) once it hits the tree.
>>>
>> Yes, and dont forget we wont save space, as we allocate a full
>> cache line to hold a 'struct netdev_hw_addr', since we dont want this
>> critical and read_mostly object polluted by a hot spot elsewhere in ke=
rnel...
>>
>> Considering this, letting 'rcu_head' at the end of structure, even if =
we
>> have an eventual hole on 64 bit arches is not really a problem, and IM=
HO
>> the best thing to do, as rcu_head is only used at dismantle time.
>=20
> I will order the struct better, there are archs with small cache line s=
ize where
> it makes sense.

How exactly ?

If you consider a 32bit arch with 16 or 32 bytes cache line,
sizeof(struct_list_dead) is 8
sizeof(addr) =3D 32     (but we really use 6 bytes for ethernet)

struct netdev_hw_addr {
	unsigned char		addr[MAX_ADDR_LEN];
	struct list_head	list;
	int			refcount;
	struct rcu_head		rcu_head;
};

would cost more at lookup time, since we would use two cache lines

struct netdev_hw_addr {
	struct list_head	list;
	unsigned char		addr[MAX_ADDR_LEN];
	int			refcount;
	struct rcu_head		rcu_head;
};

Is nicer, because at least 8 bytes of addr share the same cache line
than list. So direct dev->dev_addr would be fast (for devices with one
address), and is_etherdev_addr() would still use one cache line per
item.


