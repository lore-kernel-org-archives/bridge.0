MIME-Version: 1.0
In-Reply-To: <20110326140115.GA2882@psychotron.redhat.com>
References: <1300302933.1462.5.camel@bordalnx> <4D8121EF.3030200@free.fr>
	<1300914794.32252.68.camel@bordalnx> <4D8DDA06.4040704@gmail.com>
	<20110326140115.GA2882@psychotron.redhat.com>
From: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Date: Sat, 26 Mar 2011 16:42:54 +0100
Message-ID: <AANLkTimkVqHaU=Ye96xK4Zs7XyzcL3Xgh5ouz5m2KXur@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [Bonding-devel] bonding inside a bridge does not work
 when using arp monitoring
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jiri Pirko <jpirko@redhat.com>
Cc: =?ISO-8859-1?Q?Nicolas_de_Peslo=FCan?= <nicolas.2p.debian@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Bridge <bridge@lists.linux-foundation.org>, bonding-devel@lists.sourceforge.net

2011/3/26 Jiri Pirko <jpirko@redhat.com>:
> Sat, Mar 26, 2011 at 01:20:22PM CET, nicolas.2p.debian@gmail.com wrote:
>>Le 23/03/2011 22:13, Leonardo Borda a =E9crit :
>>>Thank you for answering my question.
>>>Actually this is what I want to achieve:
>>>
>>>eth0----+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 +----bond0.100----br0-100---{+virt=
ual machines
>>> =A0 =A0 =A0 =A0 =A0 | =A0 =A0 =A0 =A0 =A0 =A0 |
>>> =A0 =A0 =A0 =A0 =A0 +----bond0----+----br0---(LAN)
>>> =A0 =A0 =A0 =A0 =A0 | =A0 =A0 =A0 =A0 =A0 =A0 |
>>>eth1----+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 +----bond0.200----br0-200---{+virt=
ual machines
>>
>>Hi Leonardo,
>>
>>I'm not sure recent kernels allow for a given interface to be a port
>>for a bridge and the base interface for vlan interfaces at the same
>>time. This might be particularly true for 2.6.38 or 2.6.38+, because
>>of the new rx_handler usage.
>
> This topology is not legit and should/will be prohibited.
>
> Only consider that you have + br0.100 device on top of br0. Where should
> the packet go?
>
> I suggest to consider topology change.

It should be possible to have bridge for untagged (or 802.1p only)
packets independent of 802.1q tagged packets. I wonder if tag 0
devices should be expanded to have a flag that will enable handling
untagged packets by it.

Best Regards,
Micha=B3 Miros=B3aw
