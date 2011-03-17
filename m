Message-Id: <4D81CBF80200007800036FEA@vpn.id2.novell.com>
Date: Thu, 17 Mar 2011 07:53:12 +0000
From: "Jan Beulich" <JBeulich@novell.com>
References: <4D80BC5B0200007800036D85@vpn.id2.novell.com>
	<20110316082441.45db3018@nehalam>
	<20110316.104937.189702706.davem@davemloft.net>
In-Reply-To: <20110316.104937.189702706.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [Bridge] build breakage due to br_multicast.c referencing	
	ipv6_dev_get_saddr()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>, shemminger@linux-foundation.org
Cc: linus.luessing@web.de, netdev@vger.kernel.org, bridge@lists.linux-foundation.org

>>> On 16.03.11 at 18:49, David Miller <davem@davemloft.net> wrote:
> From: Stephen Hemminger <shemminger@linux-foundation.org>
> Date: Wed, 16 Mar 2011 08:24:41 -0700
>=20
>> On Wed, 16 Mar 2011 12:34:19 +0000
>> "Jan Beulich" <JBeulich@novell.com> wrote:
>>=20
>>> With BRIDGE=3Dy and IPV6=3Dm commit
>>> fe29ec41aaa51902aebd63658dfb04fe6fea8be5 ("bridge: Use IPv6
>>> link-local address for multicast listener queries") causes the build =
to
>>> break.
>>=20
>> Rather than continue with the config games, lets just make the =
necessary
>> ipv6 pieces accessible.
>=20
> You can't Stephen, ipv6_dev_get_saddr() requires access to the actual =
ipv6
> device state, that means you have to pull in the entire ipv6 stack in=20
> because
> there are dependencies all the way down into the routing code.
>=20
> We added a Kconfig fix to cure this specific problem, which made it
> into 2.6.38-final, so I don't understand why Jan is even seeing this,
> it's supposed to force BRIDGE modular if IPV6 is modular:

Oh, sorry, I was still on -rc7.

Nevertheless, I don't think this is the right way to fix it (nor
in infiniband and possibly ip_vs as pointed out).

Jan

> commit dcbcdf22f500ac6e4ec06485341024739b9dc241
> Author: Randy Dunlap <randy.dunlap@oracle.com>
> Date:   Thu Mar 10 13:45:57 2011 -0800
>=20
>     net: bridge builtin vs. ipv6 modular
>    =20
>     When configs BRIDGE=3Dy and IPV6=3Dm, this build error occurs:
>    =20
>     br_multicast.c:(.text+0xa3341): undefined reference to=20
> `ipv6_dev_get_saddr'
>    =20
>     BRIDGE_IGMP_SNOOPING is boolean; if it were tristate, then adding
>     	depends on IPV6 || IPV6=3Dn
>     to BRIDGE_IGMP_SNOOPING would be a good fix.  As it is currently,
>     making BRIDGE depend on the IPV6 config works.
>    =20
>     Reported-by: Patrick Schaaf <netdev@bof.de>
>     Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
>     Signed-off-by: David S. Miller <davem@davemloft.net>
>=20
> diff --git a/net/bridge/Kconfig b/net/bridge/Kconfig
> index 9190ae4..6dee7bf 100644
> --- a/net/bridge/Kconfig
> +++ b/net/bridge/Kconfig
> @@ -6,6 +6,7 @@ config BRIDGE
>  	tristate "802.1d Ethernet Bridging"
>  	select LLC
>  	select STP
> +	depends on IPV6 || IPV6=3Dn
>  	---help---
>  	  If you say Y here, then your Linux box will be able to act as an
>  	  Ethernet bridge, which means that the different Ethernet =
segments it



