Return-Path: <toke@redhat.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643198548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JffvNSe2BvAV1CIblV/we+uBV7wt/SYCRMsaGQKbhCY=;
 b=bVM0tDtUtVXr0Mj6dbicCiqUP4CYbhp5hp7AZ2blCjRm3ikx6G589XY0qveoKVssd6Gwz1
 WfXcbVd+JfIsbG9q/+uEmCnc/oMeytqGidHDNqHM72wcVIYMfhBbTpGEEZJc5RVpDcZ+eS
 wdEb+AdyosdBzukZWqptWBlC+8yKAI4=
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
In-Reply-To: <YfEr3Soy8YuJczHk@lore-desk>
References: <cover.1643044381.git.lorenzo@kernel.org>
 <720907692575488526f06edc2cf5c8f783777d4f.1643044381.git.lorenzo@kernel.org>
 <61553c87-a3d3-07ae-8c2f-93cf0cb52263@nvidia.com>
 <CAADnVQLv=45+Symc-8Y9QuzOAG40e3XkvVxQ-ibO-HOCyJhETw@mail.gmail.com>
 <YfEr3Soy8YuJczHk@lore-desk>
Date: Wed, 26 Jan 2022 13:02:24 +0100
Message-ID: <87ee4u3dtb.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Lorenzo Bianconi <lorenzo@kernel.org>, Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Daniel Borkmann <daniel@iogearbox.net>, Network Development <netdev@vger.kernel.org>, David Ahern <dsahern@kernel.org>, Roopa Prabhu <roopa@nvidia.com>, Yoshiki Komachi <komachi.yoshiki@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, Ido Schimmel <idosch@idosch.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Jesper Dangaard Brouer <brouer@redhat.com>, Jakub Kicinski <kuba@kernel.org>, bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, "David S. Miller" <davem@davemloft.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>

Lorenzo Bianconi <lorenzo@kernel.org> writes:

>> On Mon, Jan 24, 2022 at 10:32 AM Nikolay Aleksandrov <nikolay@nvidia.com> wrote:
>> > >
>> > > +int br_fdb_find_port_from_ifindex(struct xdp_md *xdp_ctx,
>> > > +                               struct bpf_fdb_lookup *opt,
>> > > +                               u32 opt__sz)
>> > > +{
>> > > +     struct xdp_buff *ctx = (struct xdp_buff *)xdp_ctx;
>> > > +     struct net_bridge_port *port;
>> > > +     struct net_device *dev;
>> > > +     int ret = -ENODEV;
>> > > +
>> > > +     BUILD_BUG_ON(sizeof(struct bpf_fdb_lookup) != NF_BPF_FDB_OPTS_SZ);
>> > > +     if (!opt || opt__sz != sizeof(struct bpf_fdb_lookup))
>> > > +             return -ENODEV;
>> > > +
>> > > +     rcu_read_lock();
>> > > +
>> > > +     dev = dev_get_by_index_rcu(dev_net(ctx->rxq->dev), opt->ifindex);
>> > > +     if (!dev)
>> > > +             goto out;
>> 
>> imo that is way too much wrapping for an unstable helper.
>> The dev lookup is not cheap.
>> 
>> With all the extra checks the XDP acceleration gets reduced.
>> I think it would be better to use kprobe/fentry on bridge
>> functions that operate on fdb and replicate necessary
>> data into bpf map.
>> Then xdp prog would do a single cheap lookup from that map
>> to figure out 'port'.
>
> ack, right. This is a very interesting approach. I will investigate
> it. Thanks.

I think it would be interesting to try both, and compare their
performance. I'm a bit sceptical about Alexei's assertion that
dev_get_by_index_rcu() is that expensive: we do such a lookup in the XDP
redirect code when using the non-map bpf_redirect() helper, and I have
not been able to measure a significant performance difference between
the map and non-map variants (after we added bulking to the latter).

If looking up devices by ifindex does turn out to be too expensive,
maybe what we really need is a way to pass around 'struct net_device'
pointers to BPF helpers, so a given BPF program only has to do the
lookup once if it's calling multiple dev-based helpers? I think this
should be doable with BTF, no?

-Toke

