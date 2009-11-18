Message-ID: <4B0398D4.8030904@gmail.com>
Date: Wed, 18 Nov 2009 07:48:52 +0100
From: Eric Dumazet <eric.dumazet@gmail.com>
MIME-Version: 1.0
References: <1258497551-25959-1-git-send-email-arnd@arndb.de>
	<1258497551-25959-4-git-send-email-arnd@arndb.de>
In-Reply-To: <1258497551-25959-4-git-send-email-arnd@arndb.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH 3/3] macvlan: export macvlan mode through
	netlink
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Anna Fischer <anna.fischer@hp.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Gerhard Stenzel <gerhard.stenzel@de.ibm.com>, virtualization@lists.linux-foundation.com, "Eric W. Biederman" <ebiederm@xmission.com>, Jens Osterkamp <jens@linux.vnet.ibm.com>, Patrick Mullaney <pmullaney@novell.com>, Stephen Hemminger <shemminger@vyatta.com>, Edge Virtual Bridging <evb@yahoogroups.com>

Arnd Bergmann a =E9crit :
> In order to support all three modes of macvlan at
> runtime, extend the existing netlink protocol
> to allow choosing the mode per macvlan slave
> interface.
>=20
> This depends on a matching patch to iproute2
> in order to become accessible in user land.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/macvlan.c   |   67 +++++++++++++++++++++++++++++++++++++++++=
-----
>  include/linux/if_link.h |   15 ++++++++++
>  2 files changed, 74 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
> index fa8b568..731017e 100644
> --- a/drivers/net/macvlan.c
> +++ b/drivers/net/macvlan.c
> @@ -33,12 +33,6 @@
> =20
>  #define MACVLAN_HASH_SIZE	(1 << BITS_PER_BYTE)
> =20
> -enum macvlan_type {
> -	MACVLAN_PRIVATE		=3D 1,
> -	MACVLAN_VEPA		=3D 2,
> -	MACVLAN_BRIDGE		=3D 4,
> -};

I realize you defined MACVLAN_PRIVATE in patch 2, but used MACVLAN_MODE_PRI=
VATE,
so patch 2 is not compilable and breaks bisection ?


> +
> +enum ifla_macvlan_mode {
> +	MACVLAN_MODE_PRIVATE =3D 1, /* don't talk to other macvlans */
> +	MACVLAN_MODE_VEPA    =3D 2, /* talk to other ports through ext bridge */
> +	MACVLAN_MODE_BRIDGE  =3D 4, /* talk to bridge ports directly */
> +};
