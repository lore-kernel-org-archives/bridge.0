Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23603CC7D3
	for <bridge@lists.linux.dev>; Wed,  8 Jul 2026 19:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783538057; cv=none; b=HwMA5Cq4rxynKuKGkN12bDlqSQMTZPi8qMbj+tUYtUJ32IS6t7/t8dzmLWig4Vdg//XSFMif8C+P4C9Lc+ZBU+RhnklPf3prmEk/txsAsjMWY/VpOvVe0eBcXxkYMqOu+FlIG6yZej3OBG4jfv3/0UbvlnDKHS3E7DaYsC+Lyv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783538057; c=relaxed/simple;
	bh=ZlefMp0qwwBvdrQmCZdmTlurpVHr17eYlPh5Ql4Sbys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lev0Fg63tID1Z2NHM1hn5fMTFyLmdbZq4BTueGKaMpmOEcfbrFfBZPv6z713zAzQUn/tRZ0hRyicRtjrF7dNFSzY4srpJmpGl2wRgoFSolHIf3gAgzTf0cV4z95nDl+/VhNMOPcvCIahr+MRu78G/7piP/kmn6F3HtJR8KHF22s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+1q/EAr; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+1q/EAr"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-69531108f25so1871436a12.2
        for <bridge@lists.linux.dev>; Wed, 08 Jul 2026 12:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783538054; x=1784142854; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BKdeyh5qDiS0BQge1087oDJUBrqtE39YPXs8iI8Zre0=;
        b=k+1q/EArmQ1WUi2rESKsG/QHOI2eAmcVhXcxvBLae8daXPpUS/wGcnMBFHXFYuAsIP
         0b+cHR73zCsYKzNqaJne+qyFJ6ZiGkh3o1NFty/ffNM0NNzI6Akqz13/et9sEwvhkhlc
         m9Gj9MudZARaLt0GEyJDm8qFFou873x9uvPpUUnPI2bfJgtPsqkrrMJLEvAiOZZH4Iq4
         rFMeoZip8kaAA7Urj8Nogbv1x84veGnq4uK7YHjciNZ0bEG4q8E6x/1n8voBDvtCv/yp
         zXMTuFq9W47dhr8Bcu5Z50txA1K23MK9el8aAtkWJmUyln1v9TiQD0KFe0GZ7nPqgof4
         0YZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783538054; x=1784142854;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BKdeyh5qDiS0BQge1087oDJUBrqtE39YPXs8iI8Zre0=;
        b=LeGsAPkrSx7T4NnC8Hu6EXLnEKqFFf0vJu3euJERCN2m0J7eY8SGC1qr8I9vFnESg2
         UBPuksoDjSEcnZ21ZI9/y9ZuS2jDGEFBQNQDS3nGca/KJxuFht89JHZcIuL5Bi8uQMBK
         sVimQEmhRJdFbWBgOJLsJHjPl53Ld+7zwqcLClkcBeRWpCiR37NfBDMmpug6R9ZdmsoY
         ERTMgLJTeRXG67ZojHMZ4OwMTZQseGsJiS/QQKJtzmAjtzNVLv534lSv22TVZFRaJxAG
         iJ55hoDNcObmRukA7XhbD9u5lzHRCCVEVB268q6rRuc/0HR6Uz1h/ik3/spoLoYhQjuM
         rgVA==
X-Forwarded-Encrypted: i=1; AHgh+RpbnEu9yQkFCRHSes2fwHvM5xUuoNycbMGhDcaYe5VN0U2pqjtdKEr0Bnbe7Ze8odrhPxzffeA=@lists.linux.dev
X-Gm-Message-State: AOJu0YypZLjF5l9dnxABjlS6GFL9bb6F0Z7NJISDxRMR71xHgeKsWJUJ
	bDehfI6ejxaelPvHkrvlZTrLNv1l2jSMYsLHpSSOQf4ts0QR/ZRkeBcp
X-Gm-Gg: AfdE7cn+OfKXq0kKIARRHMM8eNDHqkJ1zuAAd30lnrlgBsRxnXuwouGvRLp6v3qIDP7
	A8H173g503tEkud74aJsL478q+5aevzCkN8+Y2UYmfDYiJ3HcWkWM6FSCMDbsN12z4rljO8yBYg
	obnu47QRBtM7hNfUDCP7QDfbpYVygAgkIKDOtBXkf15bOZU0RN2krL7AI+lGCvtDMwDTSx/etbR
	b1H3bQnZtSK4JIRXN3tFjyQ0sDkK2dIQrUF+3vRP6QoEm4ICqrTwVF84L6SierLEcSHBpMaG3a3
	fgNJfw8oFa0psQZFmrwPbd9dyze9sXRdWEA4Zo/9pIsCnkzA0ddoAMEUc/YQTHtdcXkQkFQiPA6
	IUBA658W977OW+I0LG1n+kWmhWWJERt0bObHO2Mepn6GK5P6+qw1O9UVfmaLhkW1cF07Frtsw3H
	vVbCEowoWMOj5n4ubjYZ4rfW11QE6AudTO9gXBAYey17qL9C+y6KSLU1o7YEopuqZoBp+JQfifT
	hhOvmWXngTXI/er1jzGVOcjTbko3gRym1b6PGXN5HCoCQCd0udCCaZzS5kOnePVzwGwSHmIHJZm
	btB4JItrayQ/RfJwDDWREh0=
X-Received: by 2002:a05:6402:3207:b0:698:76b8:e552 with SMTP id 4fb4d7f45d1cf-69ab446345cmr1638678a12.2.1783538054086;
        Wed, 08 Jul 2026 12:14:14 -0700 (PDT)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69aa6dba523sm2645976a12.0.2026.07.08.12.14.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 12:14:13 -0700 (PDT)
Message-ID: <edfca509-860d-4f10-b84d-3f7249bc1488@gmail.com>
Date: Wed, 8 Jul 2026 21:14:11 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 nf-next 7/7] netfilter: nft_flow_offload: Add
 bridgeflow to nft_flow_offload_eval()
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>,
 Phil Sutter <phil@nwl.cc>, Nikolay Aleksandrov <razor@blackwall.org>,
 Ido Schimmel <idosch@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Stanislav Fomichev <sdf.kernel@gmail.com>,
 Samiullah Khawaja <skhawaja@google.com>, Hangbin Liu <liuhangbin@gmail.com>,
 Krishna Kumar <krikku@gmail.com>, Martin Karsten <mkarsten@uwaterloo.ca>,
 netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
 bridge@lists.linux.dev
References: <20260707091045.967678-1-ericwouds@gmail.com>
 <20260707091045.967678-8-ericwouds@gmail.com> <ak4d89hkh0Jvcp2W@chamomile>
From: Eric Woudstra <ericwouds@gmail.com>
Content-Language: en-US
In-Reply-To: <ak4d89hkh0Jvcp2W@chamomile>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/8/26 11:52 AM, Pablo Neira Ayuso wrote:
> Hi,
> 
> On Tue, Jul 07, 2026 at 11:10:45AM +0200, Eric Woudstra wrote:
>> Edit nft_flow_offload_eval() to make it possible to handle a flowtable of
>> the nft bridge family.
>>
>> Use nft_flow_offload_bridge_init() to fill the flow tuples. It uses
>> nft_dev_fill_bridge_path() in each direction.
> 
> I decided to add a bit more boiler plate in my proposal to detach the
> inet and bridge flowtable dataplanes.
> 
> More comments below.
> 
>> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
>> ---
>>  include/net/netfilter/nf_flow_table.h |   5 +
>>  net/netfilter/nf_flow_table_path.c    | 126 ++++++++++++++++++++++++++
>>  net/netfilter/nft_flow_offload.c      |  20 +++-
>>  3 files changed, 146 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
>> index 5c6e3b65ae85b..a109eda5250c7 100644
>> --- a/include/net/netfilter/nf_flow_table.h
>> +++ b/include/net/netfilter/nf_flow_table.h
>> @@ -305,6 +305,11 @@ nf_flow_table_offload_del_cb(struct nf_flowtable *flow_table,
>>  void flow_offload_route_init(struct flow_offload *flow,
>>  			     struct nf_flow_route *route);
>>  
>> +int flow_offload_bridge_init(struct flow_offload *flow,
>> +			     const struct nft_pktinfo *pkt,
>> +			     enum ip_conntrack_dir dir,
>> +			     struct nft_flowtable *ft);
>> +
>>  int flow_offload_add(struct nf_flowtable *flow_table, struct flow_offload *flow);
>>  void flow_offload_refresh(struct nf_flowtable *flow_table,
>>  			  struct flow_offload *flow, bool force);
>> diff --git a/net/netfilter/nf_flow_table_path.c b/net/netfilter/nf_flow_table_path.c
>> index 2b6ebb594a9ee..cdd6a822cb811 100644
>> --- a/net/netfilter/nf_flow_table_path.c
>> +++ b/net/netfilter/nf_flow_table_path.c
>> @@ -1,6 +1,7 @@
>>  // SPDX-License-Identifier: GPL-2.0-only
>>  #include <linux/kernel.h>
>>  #include <linux/module.h>
>> +#include <linux/if_vlan.h>
>>  #include <linux/init.h>
>>  #include <linux/etherdevice.h>
>>  #include <linux/netlink.h>
>> @@ -365,3 +366,128 @@ int nft_flow_route(const struct nft_pktinfo *pkt, const struct nf_conn *ct,
>>  	return -ENOENT;
>>  }
>>  EXPORT_SYMBOL_GPL(nft_flow_route);
>> +
>> +static int nft_dev_fill_bridge_path(struct flow_offload *flow,
>> +				    struct nft_flowtable *ft,
>> +				    enum ip_conntrack_dir dir,
>> +				    const struct net_device *src_dev,
>> +				    const struct net_device *dst_dev,
>> +				    unsigned char *src_ha,
>> +				    unsigned char *dst_ha)
>> +{
>> +	struct flow_offload_tuple_rhash *th = flow->tuplehash;
>> +	struct net_device_path_ctx ctx = {};
>> +	struct net_device_path_stack stack;
>> +	struct nft_forward_info info = {};
>> +	int i, j = 0;
>> +
>> +	for (i = th[dir].tuple.encap_num - 1; i >= 0 ; i--) {
>> +		if (info.num_encaps >= NF_FLOW_TABLE_ENCAP_MAX)
>> +			return -1;
>> +
>> +		if (th[dir].tuple.in_vlan_ingress & BIT(i))
>> +			continue;
>> +
>> +		info.encap[info.num_encaps].id = th[dir].tuple.encap[i].id;
>> +		info.encap[info.num_encaps].proto = th[dir].tuple.encap[i].proto;
>> +		info.num_encaps++;
>> +
>> +		if (th[dir].tuple.encap[i].proto == htons(ETH_P_PPP_SES))
>> +			continue;
>> +
>> +		if (ctx.num_vlans >= NET_DEVICE_PATH_VLAN_MAX)
>> +			return -1;
>> +		ctx.vlan[ctx.num_vlans].id = th[dir].tuple.encap[i].id;
>> +		ctx.vlan[ctx.num_vlans].proto = th[dir].tuple.encap[i].proto;
>> +		ctx.num_vlans++;
>> +	}
> 
> I am not sure why this is needed, in my approach I simplified this,
> but maybe I broke bridge vlan filtering. I am not sure what test
> coverage you made.
> 

This part is used for handling packets that are incoming with encaps.
Previously I got the encaps from the skb and stored them in
th[dir].tuple.encap. I understand you want to do this differently.
It is also why I'm starting in the opposite direction as in you patch-set.

The code above then reads th[dir].tuple.encap and starts filling info
and ctx with encaps. It also handles encaps marked with a
in_vlan_ingress bit. Once info and ctx are filled with the encaps from
the skb, it can continue with dev_fill_bridge_path().

My selftest script bridge_fastpath.sh tests this code thoroughly in many
different scenarios. Incoming vlan, q-in-q, ad, pppoe, pppoe-in-q. Also
on a dsa-port with the in_vlan_ingress bit set.

>> +	ctx.dev = src_dev;
>> +	ether_addr_copy(ctx.daddr, dst_ha);
>> +
>> +	if (dev_fill_bridge_path(&ctx, &stack) < 0)
>> +		return -1;
>> +
>> +	nft_dev_path_info(&stack, &info, dst_ha, &ft->data);
>> +
>> +	if (!info.indev || info.indev != dst_dev)
>> +		return -1;
>> +
>> +	th[!dir].tuple.iifidx = info.indev->ifindex;
>> +	for (i = info.num_encaps - 1; i >= 0; i--) {
>> +		th[!dir].tuple.encap[j].id = info.encap[i].id;
>> +		th[!dir].tuple.encap[j].proto = info.encap[i].proto;
>> +		if (info.ingress_vlans & BIT(i))
>> +			th[!dir].tuple.in_vlan_ingress |= BIT(j);
>> +		j++;
>> +	}
>> +	th[!dir].tuple.encap_num = info.num_encaps;
>> +
>> +	th[dir].tuple.mtu = dst_dev->mtu;
>> +	ether_addr_copy(th[dir].tuple.out.h_source, src_ha);
>> +	ether_addr_copy(th[dir].tuple.out.h_dest, dst_ha);
>> +	th[dir].tuple.out.ifidx = info.outdev->ifindex;
>> +	th[dir].tuple.xmit_type = FLOW_OFFLOAD_XMIT_DIRECT;
>> +
>> +	return 0;
>> +}
>> +
>> +int flow_offload_bridge_init(struct flow_offload *flow,
>> +			     const struct nft_pktinfo *pkt,
>> +			     enum ip_conntrack_dir dir,
>> +			     struct nft_flowtable *ft)
>> +{
>> +	const struct net_device *in_dev, *out_dev;
>> +	struct ethhdr *eth = eth_hdr(pkt->skb);
>> +	struct flow_offload_tuple *tuple;
>> +	int err, i = 0;
>> +
>> +	in_dev = nft_in(pkt);
>> +	if (!in_dev || !nft_flowtable_find_dev(in_dev, ft))
>> +		return -1;
>> +
>> +	out_dev = nft_out(pkt);
>> +	if (!out_dev || !nft_flowtable_find_dev(out_dev, ft))
>> +		return -1;
>> +
>> +	tuple =  &flow->tuplehash[!dir].tuple;
>> +
>> +	if (skb_vlan_tag_present(pkt->skb)) {
>> +		tuple->encap[i].id = skb_vlan_tag_get(pkt->skb);
>> +		tuple->encap[i].proto = pkt->skb->vlan_proto;
>> +		i++;
>> +	}
>> +
>> +	switch (eth_hdr(pkt->skb)->h_proto) {
>> +	case htons(ETH_P_8021Q): {
>> +		struct vlan_hdr *vhdr = (struct vlan_hdr *)(skb_mac_header(pkt->skb)
>> +					 + sizeof(struct ethhdr));
>> +		tuple->encap[i].id = ntohs(vhdr->h_vlan_TCI);
>> +		tuple->encap[i].proto = htons(ETH_P_8021Q);
>> +		i++;
>> +		break;
>> +	}
>> +	case htons(ETH_P_PPP_SES): {
>> +		struct pppoe_hdr *phdr = (struct pppoe_hdr *)(skb_mac_header(pkt->skb)
>> +					  + sizeof(struct ethhdr));
>> +
>> +		tuple->encap[i].id = ntohs(phdr->sid);
>> +		tuple->encap[i].proto = htons(ETH_P_PPP_SES);
>> +		i++;
>> +		break;
>> +	}
>> +	}
>> +	tuple->encap_num = i;
> 
> I am not sure these lines above can work. The VLAN tag might be
> already gone by when the packet is observed from the bridge/forward
> hook. I think populating the encap fields of the tuple by using the
> observed packet is not good to go.
> 

I have not experienced this, but I understand that this is no guarantee
that it does not happen at all.

>> +	err = nft_dev_fill_bridge_path(flow, ft, !dir, out_dev, in_dev,
>> +				       eth->h_dest, eth->h_source);
>> +	if (err < 0)
>> +		return err;
>> +
>> +	err = nft_dev_fill_bridge_path(flow, ft, dir, in_dev, out_dev,
>> +				       eth->h_source, eth->h_dest);
>> +	if (err < 0)
>> +		return err;
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(flow_offload_bridge_init);
>> diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
>> index 0be62841155b6..d0d63ef7cecd5 100644
>> --- a/net/netfilter/nft_flow_offload.c
>> +++ b/net/netfilter/nft_flow_offload.c
>> @@ -53,6 +53,7 @@ static void nft_flow_offload_eval(const struct nft_expr *expr,
>>  {
>>  	struct nft_flow_offload *priv = nft_expr_priv(expr);
>>  	struct nf_flowtable *flowtable = &priv->flowtable->data;
>> +	bool routing = flowtable->type->family != NFPROTO_BRIDGE;
>>  	struct tcphdr _tcph, *tcph = NULL;
>>  	struct nf_flow_route route = {};
>>  	enum ip_conntrack_info ctinfo;
>> @@ -109,14 +110,21 @@ static void nft_flow_offload_eval(const struct nft_expr *expr,
>>  		goto out;
>>  
>>  	dir = CTINFO2DIR(ctinfo);
>> -	if (nft_flow_route(pkt, ct, &route, dir, priv->flowtable) < 0)
>> -		goto err_flow_route;
>> +	if (routing) {
>> +		if (nft_flow_route(pkt, ct, &route, dir, priv->flowtable) < 0)
>> +			goto err_flow_route;
>> +	}
> 
> As said, I am leaning towards adding a bit more boilerplate code to
> separate the bridge and inet flowtable datapaths.
> 
>>  	flow = flow_offload_alloc(ct);
>>  	if (!flow)
>>  		goto err_flow_alloc;
>>  
>> -	flow_offload_route_init(flow, &route);
>> +	if (routing)
>> +		flow_offload_route_init(flow, &route);
>> +	else
>> +		if (flow_offload_bridge_init(flow, pkt, dir, priv->flowtable) < 0)
>> +			goto err_flow_add;
>> +
>>  	if (tcph)
>>  		flow_offload_ct_tcp(ct);
>>  
>> @@ -164,8 +172,10 @@ static void nft_flow_offload_eval(const struct nft_expr *expr,
>>  err_flow_add:
>>  	flow_offload_free(flow);
>>  err_flow_alloc:
>> -	dst_release(route.tuple[dir].dst);
>> -	dst_release(route.tuple[!dir].dst);
>> +	if (routing) {
>> +		dst_release(route.tuple[dir].dst);
>> +		dst_release(route.tuple[!dir].dst);
>> +	}
>>  err_flow_route:
>>  	clear_bit(IPS_OFFLOAD_BIT, &ct->status);
>>  out:
>> -- 
>> 2.53.0
>>

