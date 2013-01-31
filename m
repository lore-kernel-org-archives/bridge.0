Return-Path: <vyasevic@redhat.com>
Message-ID: <510AD169.8040206@redhat.com>
Date: Thu, 31 Jan 2013 15:17:45 -0500
From: Vlad Yasevich <vyasevic@redhat.com>
MIME-Version: 1.0
References: <1359601979-14942-1-git-send-email-vyasevic@redhat.com>
	<1359601979-14942-4-git-send-email-vyasevic@redhat.com>
	<CAHXqBFLQofoWPN9nfAKc6xumjzO3hu7ue3r=bHYerypAuRW0qw@mail.gmail.com>
In-Reply-To: <CAHXqBFLQofoWPN9nfAKc6xumjzO3hu7ue3r=bHYerypAuRW0qw@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-2"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH v7 net-next 03/12] bridge: Verify that a vlan
 is allowed to egress on give port
Reply-To: vyasevic@redhat.com
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Cc: netdev@vger.kernel.org, shemminger@vyatta.com, bridge@lists.linux-foundation.org, davem@davemloft.net, shmulik.ladkani@gmail.com

On 01/31/2013 03:03 PM, Micha=B3 Miros=B3aw wrote:
> 2013/1/31 Vlad Yasevich <vyasevic@redhat.com>:
>> When bridge forwards a frame, make sure that a frame is allowed
>> to egress on that port.
>
> For egress checks it might be better to have per-vlan bitmaps of ports
> instead. For unicast this doesn't really change anything, but for
> broadcast and multicast all ports are checked so reading all bits from
> one location is going to be cheaper.

But then one would have to locate that particular bitmap and now we are=20
back to a list/hash of vlans each containing port bitmap.  Considering=20
how strenuously Stephen wanted a bitmap of vlans, I'll leave it as is=20
for now.

>
> [...]
>> -static inline struct net_port_vlans *br_get_vlan_info(struct net_bridge=
 *br)
>> +static inline struct net_port_vlans *br_get_vlan_info(
>> +                                               const struct net_bridge =
*br)
>>   {
>>          return rcu_dereference(br->vlan_info);
>>   }
>>
>> -static inline struct net_port_vlans *nbp_get_vlan_info(struct net_bridg=
e_port *p)
>> +static inline struct net_port_vlans *nbp_get_vlan_info(
>> +                                               const struct net_bridge_=
port *p)
>>   {
>>          return rcu_dereference(p->vlan_info);
>>   }
>
> Shouldn't this be in patch 1?

Sure.  'const' wasn't needed until this patch though, but I guess its=20
good practice.

Thanks for taking a look
-vlad
>
> Best Regards,
> Micha=B3 Miros=B3aw
>

