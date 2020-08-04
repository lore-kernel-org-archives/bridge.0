Return-Path: <komachi.yoshiki@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=XtwssimjTTniuQl7LijmcNMg2apAbM55NqsMay8jLHo=;
 b=A9fr5HFU3lf8zSg+CMCJqO5u+Rhus37sWFZBf/pso+4kMD9Fv+1sdUpvwYClICy0zM
 /rfOHlQ7Y+7inApqU6w6O+j3zte0QSP7uQIdg6ZHeooAVfgStadr/Ntiza7mYYTmKCWo
 S4MwxfjfeD9U5bmSvg51VEw+aIKInU9YwTNnK8VrKbKCBF2xrqiJFvaviOoSPorKtxr3
 IcKc/BRbvVxzdS8u7KPEEBDS23ecJKXSG9/nlpw0uTU5iK0spuTOn2Y0HL+tx4j2hmqB
 4a1XHahqhwx9a2DXP4/u6RS1d9rkOrdIixjgYntLANqgwWWHFSq0T+ZpYhTW/ppGp5GW
 6IUw==
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.15\))
From: Yoshiki Komachi <komachi.yoshiki@gmail.com>
In-Reply-To: <5970d82b-3bb9-c78f-c53a-8a1c95a1fad7@gmail.com>
Date: Tue, 4 Aug 2020 20:27:47 +0900
Content-Transfer-Encoding: quoted-printable
Message-Id: <F99B20F3-4F88-4AFC-9DF8-B32EFD417785@gmail.com>
References: <1596170660-5582-1-git-send-email-komachi.yoshiki@gmail.com>
 <1596170660-5582-3-git-send-email-komachi.yoshiki@gmail.com>
 <5970d82b-3bb9-c78f-c53a-8a1c95a1fad7@gmail.com>
Subject: Re: [Bridge] [RFC PATCH bpf-next 2/3] bpf: Add helper to do
 forwarding lookups in kernel FDB table
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Ahern <dsahern@gmail.com>
Cc: Song Liu <songliubraving@fb.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <kafai@fb.com>, David Ahern <dsahern@kernel.org>, Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@chromium.org>, Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org, Andrii Nakryiko <andriin@fb.com>, "David S. Miller" <davem@davemloft.net>


> 2020/08/01 2:15=E3=80=81David Ahern <dsahern@gmail.com>=E3=81=AE=E3=83=A1=
=E3=83=BC=E3=83=AB:
>=20
> On 7/30/20 10:44 PM, Yoshiki Komachi wrote:
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 654c346b7d91..68800d1b8cd5 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -5084,6 +5085,46 @@ static const struct bpf_func_proto =
bpf_skb_fib_lookup_proto =3D {
>> 	.arg4_type	=3D ARG_ANYTHING,
>> };
>>=20
>> +#if IS_ENABLED(CONFIG_BRIDGE)
>> +BPF_CALL_4(bpf_xdp_fdb_lookup, struct xdp_buff *, ctx,
>> +	   struct bpf_fdb_lookup *, params, int, plen, u32, flags)
>> +{
>> +	struct net_device *src, *dst;
>> +	struct net *net;
>> +
>> +	if (plen < sizeof(*params))
>> +		return -EINVAL;
>=20
> I need to look at the details more closely, but on first reading 2
> things caught me eye:
> 1. you need to make sure flags is 0 since there are no supported flags
> at the moment, and

Thanks for your initial comments!

I will make sure whether this flag is required or not.

>> +
>> +	net =3D dev_net(ctx->rxq->dev);
>> +
>> +	if (is_multicast_ether_addr(params->addr) ||
>> +	    is_broadcast_ether_addr(params->addr))
>> +		return BPF_FDB_LKUP_RET_NOENT;
>> +
>> +	src =3D dev_get_by_index_rcu(net, params->ifindex);
>> +	if (unlikely(!src))
>> +		return -ENODEV;
>> +
>> +	dst =3D br_fdb_find_port_xdp(src, params->addr, =
params->vlan_id);
>=20
> 2. this needs to be done via netdev ops to avoid referencing bridge =
code
> which can be compiled as a module. I suspect the build robots will id
> this part soon.

I guess that no build errors will occur because the API is allowed when
CONFIG_BRIDGE is enabled.

I successfully build my kernel applying this patch, and I don=E2=80=99t =
receive any
messages from build robots for now.

Thanks & Best regards,


=E2=80=94
Yoshiki Komachi
komachi.yoshiki@gmail.com

