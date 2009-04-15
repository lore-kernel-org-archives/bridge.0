Message-ID: <49E5D2F5.8060108@cosmosbay.com>
Date: Wed, 15 Apr 2009 14:28:37 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
MIME-Version: 1.0
References: <20090313183303.GF3436@psychotron.englab.brq.redhat.com>
	<20090415081720.GA21342@psychotron.englab.brq.redhat.com>
	<20090415081819.GB21342@psychotron.englab.brq.redhat.com>
	<49E59A1C.9030108@cn.fujitsu.com>
	<20090415083223.GF21342@psychotron.englab.brq.redhat.com>
	<49E5A896.90408@cosmosbay.com>
	<20090415111724.GG21342@psychotron.englab.brq.redhat.com>
In-Reply-To: <20090415111724.GG21342@psychotron.englab.brq.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH 1/3] net: introduce a list of device
	addresses	dev_addr_list
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jiri Pirko <jpirko@redhat.com>
Cc: ivecera@redhat.com, fubar@us.ibm.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Li Zefan <lizf@cn.fujitsu.com>, linux-kernel@vger.kernel.org, mschmidt@redhat.com, bonding-devel@lists.sourceforge.net, jgarzik@pobox.com, davem@davemloft.net

Jiri Pirko a =E9crit :
> Wed, Apr 15, 2009 at 11:27:50AM CEST, dada1@cosmosbay.com wrote:

>> kzalloc(max(sizeof(*ha), L1_CACHE_SIZE)) is thus higly recommended her=
e.
> You mean PAGE_CACHE_SIZE? I think that would be little wasting... But I=
 see your
> point...

No, I meant L1_CACHE_BYTES    (usually 64 bytes on x86), I always confuse=
 BYTES and SIZE on this one...


>>> +	list_for_each_entry(ha, list, list) {
>>> +		if (i++ !=3D ignore_index &&
>>> +		    !memcmp(ha->addr, addr, addr_len)) {
>>> +			if (--ha->refcount)
>>> +				return 0;
>>> +			list_del_rcu(&ha->list);
>>> +			synchronize_rcu();
>> Oh well... I'm pretty sure this synchronize_rcu() call can be avoided,=

>> dont you think ? Check kfree_rcu() or equivalent, as it seems not yet
>> included in current kernels...
>>
> Well once kfree_rcu() will be in the tree I will be happy to replace th=
is.

If kfree_rcu() not yet available, please use a regular call_rcu() constru=
ct
(thus adding a struct rcu_head rcu; in struct netdev_hw_addr)

If you delete say 10 addresses on a device, while RTNL (or other lock) lo=
cked,
that means a lot of calls to synchronize_rcu() and a long lock hold time.=


>=20
>>> +			kfree(ha);
>>> +			return 0;
>>> +		}
>>> +	}
>>> +	return -ENOENT;
>=20
> <snip>
>=20
>>> +	err =3D __hw_addr_add(&dev->dev_addr_list, addr, sizeof(*addr));
>>> +	if (!err) {
>>> +		/*
>>> +		 * Get the first (previously created) address from the list
>>> +		 * and set dev_addr pointer to this location.
>>> +		 */
>>> +		rcu_read_lock();
>> locking is not correct or unnecessary
>=20
> Agree that here locking is not necessary, but I wanted to stay consiste=
nt to the
> rest of the code. Do you think I should remove locking here entirely?

Yes, it is very confusing for reviewers because we feel patch submiter
is not comfortable with locking rules.

Check for example dev_add_pack() in net/core/dev.c : It uses list_add_rcu=
()
but as it also uses a regular spinlock, there is no point using rcu_read_=
lock().

void dev_add_pack(struct packet_type *pt)
{
        int hash;

        spin_lock_bh(&ptype_lock);
        if (pt->type =3D=3D htons(ETH_P_ALL))
                list_add_rcu(&pt->list, &ptype_all);
        else {
                hash =3D ntohs(pt->type) & PTYPE_HASH_MASK;
                list_add_rcu(&pt->list, &ptype_base[hash]);
        }
        spin_unlock_bh(&ptype_lock);
}



Please note list_add_rcu() (and/or rcu_assign_pointer()) are still needed=
 to protect
readers that dont use the spinlock at all.

If you use fact that RTNL is locked when calling your code, you could add=

ASSERT_RTNL();
at strategic points so that this assertion can be checked at runtime.

(but Patrick & David wrote that you should not assume RTNL, so you probab=
ly need another lock...)

Thank you

