Message-ID: <4C75724F.2000400@free.fr>
Date: Wed, 25 Aug 2010 21:43:11 +0200
From: =?ISO-8859-1?Q?Nicolas_de_Peslo=FCan?= <nicolas.2p.debian@free.fr>
MIME-Version: 1.0
References: <4C752DD9.7040302@tiolive.com>
In-Reply-To: <4C752DD9.7040302@tiolive.com>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Number of addresses limitation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Le 25/08/2010 16:51, Fran=E7ois Schmidts a =E9crit :
>    Hi,
>
> I'm using bridge-utils to add a bunch of tap interfaces to my computer
> so I can run different qemu vm at the same time without using nat to
> give them network access. It works fine.
>
> But at the same time I would like to add a lot of IPv6s addresses to the
> bridge interface (br0). I find myself limitated to more or less 56
> addresses. If I add one more, one of the addresses already existing just
> disappear from the br0 interface.
>
> Is there something I could do to remove or extent this limitation ?

Did you try the same IPv6 configuration on a normal ethernet NIC ? Do you t=
hink this is a bridge=20
only related problem ?

	Nicolas.

>
> Best regards,
> Fran=E7ois Schmidts.
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>

