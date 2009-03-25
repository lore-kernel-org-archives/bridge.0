Date: Wed, 25 Mar 2009 15:39:24 +0100
From: Jiri Pirko <jpirko@redhat.com>
Message-ID: <20090325143923.GH3437@psychotron.englab.brq.redhat.com>
References: <20090313183303.GF3436@psychotron.englab.brq.redhat.com>
	<20090325130443.GG3437@psychotron.englab.brq.redhat.com>
	<49CA345B.3070103@cosmosbay.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <49CA345B.3070103@cosmosbay.com>
Subject: Re: [Bridge] [PATCH] bonding: allow bond in mode balance-alb to
	work	properly in bridge -try2
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: fubar@us.ibm.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mschmidt@redhat.com, bonding-devel@lists.sourceforge.net, jgarzik@pobox.com, davem@davemloft.net

Wed, Mar 25, 2009 at 02:40:43PM CET, dada1@cosmosbay.com wrote:
>Jiri Pirko a =E9crit :
>> (resend)
>>=20
>> Hi all.
>>=20
>> The problem is described in following bugzilla:
>> https://bugzilla.redhat.com/show_bug.cgi?id=3D487763
>>=20
>> Basically here's what's going on. In every mode, bonding interface uses =
the same
>> mac address for all enslaved devices. Except for mode balance-alb. When =
you put
>> this kind of bond device into a bridge it will only add one of mac adres=
ses into
>> a hash list of mac addresses, say X. This mac address is marked as local=
. But
>> this bonding interface also has mac address Y. Now then packet arrives w=
ith
>> destination address Y, this address is not marked as local and the packe=
d looks
>> like it needs to be forwarded. This packet is then lost which is wrong.
>>=20
>> Notice that interfaces can be added and removed from bond while it is in=
 bridge.
>>=20
>> This patch solves the situation in the bonding without touching bridge c=
ode,
>> as Patrick suggested. For every incoming frame to bonding it searches the
>> destination address in slaves list and if any of slave addresses matches=
, it
>> rewrites the address in frame by the adress of bonding master. This ensu=
res that
>> all frames comming thru the bonding in alb mode have the same address.
>>=20
>> Jirka
>>=20
>>=20
>> Signed-off-by: Jiri Pirko <jpirko@redhat.com>
>>=20
>> diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_a=
lb.c
>> index 27fb7f5..2838be0 100644
>> --- a/drivers/net/bonding/bond_alb.c
>> +++ b/drivers/net/bonding/bond_alb.c
>> @@ -1762,6 +1762,26 @@ int bond_alb_set_mac_address(struct net_device *b=
ond_dev, void *addr)
>>  	return 0;
>>  }
>> =20
>> +void bond_alb_change_dest(struct sk_buff *skb)
>> +{
>> +	struct net_device *bond_dev =3D skb->dev;
>> +	struct bonding *bond =3D netdev_priv(bond_dev);
>> +	unsigned char *dest =3D eth_hdr(skb)->h_dest;
>> +	struct slave *slave;
>> +	int i;
>> +
>> +	if (!memcmp(dest, bond_dev->dev_addr, ETH_ALEN))
>> +		return;
>> +	read_lock(&bond->lock);
>
>
>Its a pity bonding doesnt use RCU and needs this read_lock(&bond->lock)

Sure it is...
>
>
>> +	bond_for_each_slave(bond, slave, i) {
>> +		if (!memcmp(slave->dev->dev_addr, dest, ETH_ALEN)) {
>
>compare_ether_addr() (or even better compare_ether_addr_64bits()) instead =
of memcmp() ?

Okay, I'll use compare_ether_addr_64bits and do the repost later on...
>
>> +			memcpy(dest, bond_dev->dev_addr, ETH_ALEN);
>> +			break;
>> +		}
>> +	}
>> +	read_unlock(&bond->lock);
>> +}
>> +
>
