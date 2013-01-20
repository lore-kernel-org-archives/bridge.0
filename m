Return-Path: <vyasevic@redhat.com>
Message-ID: <50FC307A.5090003@redhat.com>
From: Vlad Yasevich <vyasevic@redhat.com>
MIME-Version: 1.0
References: <1358360289-23249-1-git-send-email-vyasevic@redhat.com>
	<1358360289-23249-3-git-send-email-vyasevic@redhat.com>
	<CAHXqBFKg6Vp5=dprDYKON2LmshhX+nSPF7KRHiQmOS68PrQq-A@mail.gmail.com>
In-Reply-To: <CAHXqBFKg6Vp5=dprDYKON2LmshhX+nSPF7KRHiQmOS68PrQq-A@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-2"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH net-next V6 02/14] bridge: Add vlan filtering
	infrastructure
Reply-To: vyasevic@redhat.com
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Sun, 20 Jan 2013 17:59:30 -0000
To: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Cc: mst@redhat.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, shmulik.ladkani@gmail.com, shemminger@vyatta.com, davem@davemloft.net

On 01/17/2013 08:57 PM, Micha=B3 Miros=B3aw wrote:
> 2013/1/16 Vlad Yasevich <vyasevic@redhat.com>:
> [...]
>> --- /dev/null
>> +++ b/net/bridge/br_vlan.c
> [...]
>> +struct net_port_vlan *nbp_vlan_find(const struct net_port_vlans *v, u16=
 vid)
>> +{
>> +       struct net_port_vlan *pve;
>> +
>> +       /* Must be done either in rcu critical section or with RTNL held=
 */
>> +       WARN_ON_ONCE(!rcu_read_lock_held() && !rtnl_is_locked());
>> +
>> +       list_for_each_entry_rcu(pve, &v->vlan_list, list) {
>> +               if (pve->vid =3D=3D vid)
>> +                       return pve;
>> +       }
>> +
>> +       return NULL;
>> +}
>
> This looks expensive - it's O(n) with n =3D number of configured VLANs on=
 a port.
> And this is called for every packet. The bridge already has a hash of VLAN
> structures found by br_vlan_find(). You could add a second bitmap there
> (eg. ingres_ports[]) and check port's bit instead of walking the list.
> You would use a bit more memory (64 bytes minus the removed list-head)
> per configured VLAN but save some cycles in hot path.
>

Technically wouldn't even need another bitmap as an existing membership=20
bitmap would cover this case.  I did some profiling and the list is=20
faster for 3 vlans per port.  Hash is faster for more then 3 vlans.

I can easily switch to hash if that is what others think.

-vlad
> Best Regards,
> Micha=B3 Miros=B3aw
>

