Return-Path: <kuba@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9417E400EF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A4A4C4007A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1663764179;
 bh=9SIsgEZDXH7+JI+d9iRn2G0EfLXDT4/JWJpJozreBdw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=MTPc36+TcxZoaVX6OfmzqolFrEa4eQjyXWca93IU01neVV8qA4SlqSUsUFqf7bgtr
 /sLQIwvfg5W/0O1kmdCEWlda9w/4/8e3nhS3lpFI8Bb6kXauCXYQaJVCjX69SaHYZO
 xpjrhFg8lbVMCtWoM/DOJ8awGrUfqYqtFCrA2GJ5ORSNLs4kptlA8nLbcYSlU8myip
 m6omQYK//fzm/M4HLAkJs1vN3dWamRnCWkaa+QLK1Dub24JK2iXwagLqXBDb79wZ2Q
 sH6yXl7xLKveMEOf4Ftr/TJuSIiOLRqxlSVsK80lRxxJ5qEWFkDTfiZIUGIXyq4v+0
 GxPIL5s6pKs1Q==
Date: Wed, 21 Sep 2022 05:42:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20220921054258.41e06387@kernel.org>
In-Reply-To: <3f2d6682-7c5c-5a6d-110b-568331650949@blackwall.org>
References: <cover.1663445339.git.sevinj.aghayeva@gmail.com>
 <78bd0e54-4ee3-bd3c-2154-9eb8b9a70497@blackwall.org>
 <20220920162954.1f4aaf7b@kernel.org>
 <3f2d6682-7c5c-5a6d-110b-568331650949@blackwall.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH RFC net-next 0/5] net: vlan: fix bridge binding
 behavior and add selftests
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: aroulin@nvidia.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, sbrivio@redhat.com, Eric Dumazet <edumazet@google.com>, Sevinj Aghayeva <sevinj.aghayeva@gmail.com>, roopa@nvidia.com, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On Wed, 21 Sep 2022 07:45:07 +0300 Nikolay Aleksandrov wrote:
> > IDK, vlan knows it's calling the bridge:
> >=20
> > +	if ((vlan->flags ^ old_flags) & VLAN_FLAG_BRIDGE_BINDING &&
> > +	    netif_is_bridge_master(vlan->real_dev)) {
>=20
> This one is more of an optimization so notifications are sent only when t=
he bridge
> is involved, it can be removed if other interested parties show up.
>=20
> > bridge knows it's vlan calling:
> >=20
> > +	if (is_vlan_dev(dev)) {
> > +		br_vlan_device_event(dev, event, ptr);
> >=20
> > going thru the generic NETDEV notifier seems odd.
> >=20
> > If this is just to avoid the dependency we can perhaps add a stub=20
> > like net/ipv4/udp_tunnel_stub.c ?
>=20
> I suggested the notifier to be more generic and be able to re-use it for =
other link types although
> I don't have other use cases in mind right now. Stubs are an alternative =
as long as they and
> their lifetime are properly managed. I don't have a strong preference her=
e so if you prefer
> stubs I'm good.

Yup, stub seems simpler and more efficient to me. Only time will
tell if indeed this ntf type would have been reused further.. =F0=9F=A4=B7
