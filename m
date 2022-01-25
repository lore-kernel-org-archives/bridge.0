Return-Path: <alexei.starovoitov@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oeTEp2rB9dc4PJgyacmkSyq1DnjRfsybkwCycdXUsGs=;
 b=Hr9ia0X3q2nSdh1Yg8YMr9AAWSS8SVvWVgNhE6UYrGE5ZCVqKWYNluuId3WuC4LaTV
 Ivt1YKz1q/2uukeTwh49RYp/3015L8kuwEUB4lv9WsSvJ25loEEORzt7fxx42V0sOK9q
 jXv9jIZiekuycv+NoZOg/f7WSg0Psbr0EfFC+O9aQyNcJ54yfGKg/BH6+NF70INvBmlZ
 edwm83UJRLH1BO2A93v+xSSwEeuN8rv4/w2GbD+BHeNxC50K2xkcENur4jD3vzg0rH4k
 lOZpzSBv6T9BLSjARPFOY8lJiKM8Fi/ajHDRx0b/ZQ0hW562VK6jDlocp8xl0u6vEszg
 +S7w==
MIME-Version: 1.0
References: <cover.1643044381.git.lorenzo@kernel.org>
 <720907692575488526f06edc2cf5c8f783777d4f.1643044381.git.lorenzo@kernel.org>
 <61553c87-a3d3-07ae-8c2f-93cf0cb52263@nvidia.com>
In-Reply-To: <61553c87-a3d3-07ae-8c2f-93cf0cb52263@nvidia.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 24 Jan 2022 21:09:14 -0800
Message-ID: <CAADnVQLv=45+Symc-8Y9QuzOAG40e3XkvVxQ-ibO-HOCyJhETw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Nikolay Aleksandrov <nikolay@nvidia.com>
Cc: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Daniel Borkmann <daniel@iogearbox.net>, Roopa Prabhu <roopa@nvidia.com>, Network Development <netdev@vger.kernel.org>, David Ahern <dsahern@kernel.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, Yoshiki Komachi <komachi.yoshiki@gmail.com>, Alexei Starovoitov <ast@kernel.org>, "David S. Miller" <davem@davemloft.net>, Ido Schimmel <idosch@idosch.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Jesper Dangaard Brouer <brouer@redhat.com>, Jakub Kicinski <kuba@kernel.org>, bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Lorenzo Bianconi <lorenzo.bianconi@redhat.com>

On Mon, Jan 24, 2022 at 10:32 AM Nikolay Aleksandrov <nikolay@nvidia.com> wrote:
> >
> > +int br_fdb_find_port_from_ifindex(struct xdp_md *xdp_ctx,
> > +                               struct bpf_fdb_lookup *opt,
> > +                               u32 opt__sz)
> > +{
> > +     struct xdp_buff *ctx = (struct xdp_buff *)xdp_ctx;
> > +     struct net_bridge_port *port;
> > +     struct net_device *dev;
> > +     int ret = -ENODEV;
> > +
> > +     BUILD_BUG_ON(sizeof(struct bpf_fdb_lookup) != NF_BPF_FDB_OPTS_SZ);
> > +     if (!opt || opt__sz != sizeof(struct bpf_fdb_lookup))
> > +             return -ENODEV;
> > +
> > +     rcu_read_lock();
> > +
> > +     dev = dev_get_by_index_rcu(dev_net(ctx->rxq->dev), opt->ifindex);
> > +     if (!dev)
> > +             goto out;

imo that is way too much wrapping for an unstable helper.
The dev lookup is not cheap.

With all the extra checks the XDP acceleration gets reduced.
I think it would be better to use kprobe/fentry on bridge
functions that operate on fdb and replicate necessary
data into bpf map.
Then xdp prog would do a single cheap lookup from that map
to figure out 'port'.
