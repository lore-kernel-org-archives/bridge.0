Return-Path: <david.laight@aculab.com>
From: David Laight <David.Laight@ACULAB.COM>
Date: Sat, 20 Nov 2021 21:57:42 +0000
Message-ID: <a98476cd4414476980a227c0f053bea7@AcuMS.aculab.com>
References: <20211119020642.108397-1-bernard@vivo.com>
In-Reply-To: <20211119020642.108397-1-bernard@vivo.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH] net/bridge: replace simple_strtoul to kstrtol
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: 'Bernard Zhao' <bernard@vivo.com>, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

From: Bernard Zhao
> Sent: 19 November 2021 02:07
>=20
> simple_strtoull is obsolete, use kstrtol instead.

I think the death announcement of simple_strtoull() has already
been deemed premature.
kstrtol() isn't a replacment in many cases.

> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  net/bridge/br_sysfs_br.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
> index d9a89ddd0331..11c490694296 100644
> --- a/net/bridge/br_sysfs_br.c
> +++ b/net/bridge/br_sysfs_br.c
> @@ -36,15 +36,14 @@ static ssize_t store_bridge_parm(struct device *d,
>  =09struct net_bridge *br =3D to_bridge(d);
>  =09struct netlink_ext_ack extack =3D {0};
>  =09unsigned long val;
> -=09char *endp;
>  =09int err;
>=20
>  =09if (!ns_capable(dev_net(br->dev)->user_ns, CAP_NET_ADMIN))
>  =09=09return -EPERM;
>=20
> -=09val =3D simple_strtoul(buf, &endp, 0);
> -=09if (endp =3D=3D buf)
> -=09=09return -EINVAL;
> +=09err =3D kstrtoul(buf, 10, &val);
> +=09if (err !=3D 0)
> +=09=09return err;

That changes the valid input strings.
So is a UAPI change.
Now it might be that no one passes in strings that now fail,
but you can't tell.

Rightfully or not it used to ignore any trailing characters.
So "10flobbs" would be treated as "10".

Did you also check what happens to 0x1234 and 012 ?

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

