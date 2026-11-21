Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.190.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795295422;
	b=cQTCQmkie6a9VgkuSnKCASzu8QdkjnzozZldYhekfib79+Gh1qq0o32FE6gp361rHyVB
	 xofvLdGhbDYq6+UFquwmfVksc7kUmq3Qv/DX7X9WJFarBdWAVCBDWwbdR13j86G4YSefF
	 bihkZVuHqF8N6CngIXcTWvMsrrebMywsBmmV0bVkBdnPyxKxtNjgd4cXZ59lLUCKDqxIR
	 A6Ss82FH1nKyVhSO5+VgszS/sp+3yaZgmhq9xh2XXvm6APbGxoKz6LLGgTQbhhcGSRVGV
	 EyKyESkB1x1S2tIGRr1i8xR5xSd/aMNBewwEfcMCE+RQLY+zVtf2Nyxyd++rC9SuSiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795295422;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Status:X-Spam-Checker-Version;
	bh=a2NKQrpvPoSFGsmTW495uzvdLwTr591GoJMHlrOmQEQ=;
	b=CS6Ed7CsnkWXYj80iJGeD0TO48djNhPYcLq9B3YaQmJoNkHw49suE7VBqVHQdaYqXJhO
	 +RnSfcVh6fRh8tf+UvuGt0MoEpOUVnTCE7BeFIctBLrRR+l0lOM7Y4jIRI0HIUOvBuFNh
	 GBmeKec4ZeY9DkMlZxtxPfChaRlghAl3mr2MF4vT+366FWX90GBGnqJ8HX92m0WkAn65C
	 XxrD994YDdiObWyRxnBzmnmlrs/NMIK8+zLCiKAqWdZj8Cn24hUIHRYMiwLUoBg+zOYFN
	 qanQw5QapT5mQrAuaGmnIAmOBP9f9ZNHJkZeZfdbYpGWrA6rB+z+v65R1FMet6JI9Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=netfilter.org;
	spf=pass smtp.mailfrom=netfilter.org;
	dkim=pass header.d=netfilter.org header.i=@netfilter.org header.a=rsa-sha256 header.s=2025 header.b=DY2yRP4Y;
	arc=none smtp.remote-ip=217.70.190.124
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id BBC1E606A32A
	for <bridge@lists.linux.dev>; Sat, 21 Nov 2026 21:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBC1E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.a=rsa-sha256 header.s=2025 header.b=DY2yRP4Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1795295417;
	bh=a2NKQrpvPoSFGsmTW495uzvdLwTr591GoJMHlrOmQEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DY2yRP4YffYyDEplaRFW/pR+w5WYQMzSAnb7Fk36iVoR6lArAINIhH4yZGJHAb0dY
	 GyqdqR/PUsnmw/U/RiLkqioEnxytnFN3p4BAJKxfG1o9m6nPczFRm7LWhFIqUg6x3B
	 1mAksXdhS4orAdS0EL0alcm8J07vtIwGf3OWUnLlbgks4fgPAdnLHquPZdTaTPA+gX
	 1PQ4FmfxJRMnspWQtYKL0k+XLyUx8zPlGai6pNszjHpeyAv+uhEzTEj7+jKQtmj003
	 4MebVVYykpa5sqbya9UPizyv/31eNY600yCp/P5vtvSvPuZ2T1u2Amngi0/Wr5c4z8
	 aITV1Y64PIJ+A==
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 7E49D6005A;
	Sat, 21 Nov 2026 22:10:17 +0100 (CET)
Date: Sat, 21 Nov 2026 22:10:15 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Julius Bairaktaris <julius@bairaktaris.de>
Cc: netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Eric Woudstra <ericwouds@gmail.com>, netdev@vger.kernel.org,
	bridge@lists.linux.dev, coreteam@netfilter.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH nf-next v11 2/3] netfilter: flowtable: tear down direct
 xmit flows when the fdb entry moves
Message-ID: <awIItwlvNhrdOdjn@chamomile>
References: <20261121205535.1888592-1-julius@bairaktaris.de>
 <20261121205535.1888592-3-julius@bairaktaris.de>
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261121205535.1888592-3-julius@bairaktaris.de>

On Sat, Nov 21, 2026 at 09:55:34PM +0100, Julius Bairaktaris wrote:
> From: Pablo Neira Ayuso <pablo@netfilter.org>
> 
> A direct xmit flow that reaches a bridge port keeps sending to that port
> when the host moves to another port of the bridge, and packets from the
> other side keep the flow from timing out.
> 
> The gc now checks the fdb entry after nf_flow_dst_check_gc(), through
> nf_br_utils_hook, and tears the flow down when the entry points to
> another port. An entry that aged out does not tear it down, because
> offloaded packets do not refresh it.
> 
> One possibility to address this issue is to subscribe to
> SWITCHDEV_FDB_DEL_TO_DEVICE event notifications, however, this requires
> iterating over the whole flowtable whenever a fdb entry is removed.
> 
> The bridge port is found from out.ifidx through the vlan devices that
> the forward path has below the port. The flow keeps the vid the forward
> path looked the fdb entry up in: a vlan that leaves the port untagged
> is in neither encap stack. struct flow_offload grows from 296 to 312
> bytes on x86_64; its slab cache is cacheline aligned, so an object takes
> 320 bytes either way.
> 
> The flow is also torn down when the port no longer forwards in that
> vid, where the bridge would no longer deliver either: the port left the
> forwarding state, the vlan left the port, or vlan filtering was turned
> on or off. With two bridges on the path, at most two fit in a forward
> path, the gc goes up from the inner bridge through the vlan devices
> between them to the port of the outer one and checks its entry as well.
> 
> Neigh xmit flows need no fdb check: a forward path that crosses a bridge
> always makes the flow direct xmit, and a failed walk is not offloaded.
> 
> Reported-by: Eric Woudstra <ericwouds@gmail.com>
> Link: https://lore.kernel.org/netfilter-devel/20250925182623.114045-1-ericwouds@gmail.com/
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> [julius@bairaktaris.de: find the bridge port below the vlan devices of the
>  path, keep the vid of the fdb lookup, keep a flow whose entry aged out,
>  check that the port forwards the vid, check both bridges of a stacked
>  path, follow struct net_bridge_dst, build br_nf_utils.o only with the
>  flowtable]
> Link: https://lore.kernel.org/netfilter-devel/20261014210256.1573072-1-pablo@netfilter.org/
> Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
> ---
> v11: rebased onto Pablo's xmit series: the gc checks the fdb entry
> after his nf_flow_dst_check_gc(), which replaces nf_flow_dst_check()
> there, and his patch now sets out.h_dest for every xmit type
> v10: https://lore.kernel.org/netfilter-devel/20261115005555.645727-3-julius@bairaktaris.de/
> 
>  include/linux/netfilter.h             |  7 +++
>  include/net/netfilter/nf_flow_table.h | 22 ++++++++-
>  net/bridge/Makefile                   |  2 +
>  net/bridge/br.c                       |  2 +
>  net/bridge/br_nf_utils.c              | 35 ++++++++++++++
>  net/bridge/br_private.h               | 13 +++++
>  net/netfilter/core.c                  |  3 ++
>  net/netfilter/nf_flow_table_core.c    | 68 ++++++++++++++++++++++++++-
>  net/netfilter/nf_flow_table_path.c    | 29 +++++++++++-
>  9 files changed, 176 insertions(+), 5 deletions(-)
>  create mode 100644 net/bridge/br_nf_utils.c
> 
> diff --git a/include/linux/netfilter.h b/include/linux/netfilter.h
> index e99afc1414cd..be85d8f68b45 100644
> --- a/include/linux/netfilter.h
> +++ b/include/linux/netfilter.h
> @@ -67,6 +67,13 @@ static inline void nf_inet_addr_mask(const union nf_inet_addr *a1,
>  #endif
>  }
>  
> +struct nf_br_utils {
> +	bool (*fdb_valid_dst)(const struct net_device *dev,
> +			      const unsigned char *addr, u16 vid);
> +};
> +
> +extern const struct nf_br_utils __rcu *nf_br_utils_hook;
> +
>  int netfilter_init(void);
>  
>  struct sk_buff;
> diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
> index 143bcfce3678..206296483fe1 100644
> --- a/include/net/netfilter/nf_flow_table.h
> +++ b/include/net/netfilter/nf_flow_table.h
> @@ -121,6 +121,18 @@ struct flow_offload_tunnel {
>  	u8	encap_proto;
>  };
>  
> +/* The outer of two bridges on the path: its vid, and how to reach its port
> + * from the inner bridge.
> + */
> +struct flow_offload_br_outer {
> +	u16				vid;
> +	u8				present:1,
> +					link_vlans:2,
> +					link_untag:1,
> +					link_8021ad:1,
> +					inner_tag:1;
> +};

What scenario are you trying to support with this?
