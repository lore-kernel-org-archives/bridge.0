Return-Path: <lorenzo@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643195361;
 bh=/zWncPmKwzXMZGHZvCSwS6Snn34KR1tN9vb7JKiM7T0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Q267gzkyR7eaQ8SFeGSWEWz71T7iffwrNfqZFfL+jbp7N7cS3VYfxm3RnUTTo5YXz
 Tuw99yUEAPLsiMXQS+V4ynhQBOsGMMZdzBbzzWIH0uf6HK83D0m1ihmKq6RxNLOj/E
 BTzUKgFDd5IL/CeVF8wRiwNIqFZr/o+Cb1GmfiQRCSvpX2er5mzAhrteXdM4CvNo4Z
 nJP7a9C74K2lpgLClUR5cUVKMsmIoNPJWsPAVrV2ojP7RMQ5J3HwyI3iHaQ0PHMdFK
 tw+tP6M1pst1kUucafw+F+MVsF4YfTtldl3yAreuDveGsj5+GczDqo+5AGkqcK/h7l
 a0V+HtYRrIfTA==
Date: Wed, 26 Jan 2022 12:09:17 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
Message-ID: <YfEr3Soy8YuJczHk@lore-desk>
References: <cover.1643044381.git.lorenzo@kernel.org>
 <720907692575488526f06edc2cf5c8f783777d4f.1643044381.git.lorenzo@kernel.org>
 <61553c87-a3d3-07ae-8c2f-93cf0cb52263@nvidia.com>
 <CAADnVQLv=45+Symc-8Y9QuzOAG40e3XkvVxQ-ibO-HOCyJhETw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kFCkJi5WGm1W4ka3"
Content-Disposition: inline
In-Reply-To: <CAADnVQLv=45+Symc-8Y9QuzOAG40e3XkvVxQ-ibO-HOCyJhETw@mail.gmail.com>
Subject: Re: [Bridge] [RFC bpf-next 1/2] net: bridge: add unstable
 br_fdb_find_port_from_ifindex helper
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Daniel Borkmann <daniel@iogearbox.net>, Roopa Prabhu <roopa@nvidia.com>, Network Development <netdev@vger.kernel.org>, David Ahern <dsahern@kernel.org>, Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>, Yoshiki Komachi <komachi.yoshiki@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, Ido Schimmel <idosch@idosch.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Jesper Dangaard Brouer <brouer@redhat.com>, Jakub Kicinski <kuba@kernel.org>, bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, "David S. Miller" <davem@davemloft.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>


--kFCkJi5WGm1W4ka3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, Jan 24, 2022 at 10:32 AM Nikolay Aleksandrov <nikolay@nvidia.com>=
 wrote:
> > >
> > > +int br_fdb_find_port_from_ifindex(struct xdp_md *xdp_ctx,
> > > +                               struct bpf_fdb_lookup *opt,
> > > +                               u32 opt__sz)
> > > +{
> > > +     struct xdp_buff *ctx =3D (struct xdp_buff *)xdp_ctx;
> > > +     struct net_bridge_port *port;
> > > +     struct net_device *dev;
> > > +     int ret =3D -ENODEV;
> > > +
> > > +     BUILD_BUG_ON(sizeof(struct bpf_fdb_lookup) !=3D NF_BPF_FDB_OPTS=
_SZ);
> > > +     if (!opt || opt__sz !=3D sizeof(struct bpf_fdb_lookup))
> > > +             return -ENODEV;
> > > +
> > > +     rcu_read_lock();
> > > +
> > > +     dev =3D dev_get_by_index_rcu(dev_net(ctx->rxq->dev), opt->ifind=
ex);
> > > +     if (!dev)
> > > +             goto out;
>=20
> imo that is way too much wrapping for an unstable helper.
> The dev lookup is not cheap.
>=20
> With all the extra checks the XDP acceleration gets reduced.
> I think it would be better to use kprobe/fentry on bridge
> functions that operate on fdb and replicate necessary
> data into bpf map.
> Then xdp prog would do a single cheap lookup from that map
> to figure out 'port'.

ack, right. This is a very interesting approach. I will investigate it. Tha=
nks.

Regards,
Lorenzo

--kFCkJi5WGm1W4ka3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYfEr3QAKCRA6cBh0uS2t
rI/BAQC9L141LtGoDrESrDY1ii4/RP/UGl82ndKb1Ap3thTqwQD/X6/s02kMpW3J
LqMH3nrhFBuZEt8OpC7T95rtRIf85Qc=
=PuxP
-----END PGP SIGNATURE-----

--kFCkJi5WGm1W4ka3--
