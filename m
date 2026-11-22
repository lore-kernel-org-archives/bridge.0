Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795345087;
	b=TMkdeYwbgSd8/Avr7OiXALOemokJhhtQ70hHH3nE0jXeUEltwLz4Of/z09sN+y7gk088
	 rKp/ZVR5Ck0w74qQJCykxrCF/6yr85UPZypBipT2n9etaAj/qLa26JqWptd5lxTQHEkUk
	 T9bGxAjM6l/YWBjn/ocmudRSjDReM+EeaebsTiTCxJ9Uk6Kn/iZI+RvDDTLiJ2xEwX2nV
	 Ghcxy7YKWOJ3Xut5bXEfFXYFL0RZzz3XL0m/RwqC8C5XU0DxQ926Ee9ZPHVy9dq69WSBZ
	 33SS2rom67AGVfRiBnoKfJ/ScjItrViBorqbR1jntv28wPhe0R1HUIcT8EECFWlKEFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795345087;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=1BgKHSd3CQAdu9W4c7Bsjn/CT1XjSRVEIx6RizkYoTw=;
	b=O/8pHlr4PwHhA9pvRm0oGAjtfseeZ8Ccc0pIdJLLdA4QoPUvoUBoZ3fXQRnAac2HdvNx
	 xtZWz8dCVgDkjGHCwaFSu80bdQ9DkIk2+KHl497+KIsu/78qx2eEwHQxcZqPGwnAnfdXe
	 npbAFW7bomsBnHEfPlBOnQ/sHRApRMEnTeo/OGK9UqdqWjfluuo3pLaFotyQGTN9kxEBy
	 +jrVlzQfTEkUTxyjNaHLvDq13T5+E7hJG1rptI5tOFpUUBtRleDO/9qLnmprAXs3HdClI
	 L+oe8wc9o192vj7xTBA6wRUltzJzzayW2ROy4aWDERNNGKfePmKlMwlwthQUtLXaSow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=YZ5bDllE;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95739606A338
	for <bridge@lists.linux.dev>; Sun, 22 Nov 2026 10:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95739606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=YZ5bDllE
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bb5b8ef642so18674245e9.1
        for <bridge@lists.linux.dev>; Sun, 22 Nov 2026 02:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1795345086; x=1795949886; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1BgKHSd3CQAdu9W4c7Bsjn/CT1XjSRVEIx6RizkYoTw=;
        b=YZ5bDllE7BUWMDYFieiobEjZVxN5TdkQWHrvZ12txftnZYNc4vr0mBnHowrNuP/nfo
         YZ+ib2Tgww3kVOtaO1KzHF7XJQCMYpKZKhghQq8HONhBPfPRmy+bAOvi9SC5v84eVksI
         Czh1MECKBW5s0knQXcoTK0Vch2pKd1MA7fcT9QBJRngVJ9KGHBcA62UISdNR6zdufUJb
         lpNuzI82NWY30P0jUO18KaOhear+bUuKHOJmRDPC5gUjEc1UvRe3F9xo7A9BARSFYkla
         2zcpq5INRKCWsix7i1ufuRedhP0TVGlqMGvTP1Op/33TDoMwgoc2ZzWiaFQ8YAdIraGs
         /cWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795345086; x=1795949886;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1BgKHSd3CQAdu9W4c7Bsjn/CT1XjSRVEIx6RizkYoTw=;
        b=2xSMH1VN4822HS7hreHDw69O0phQywa3tlNeoUnuPQUqxYSpgPHN4nTzK4lqhbtTEg
         UAjbFlynyluN7AhWg5FHKpxJqZcUDvxArSG5nfHR9x+fzNlmOe0TBEWlAbTg9fhIGdCK
         /YO62hUV47uvZAV1bSL/Lb/DJHbRtL9HfDQc2RIS1DFY6RBsRCk5BpPazhhIuwGVwwok
         NQBRXXUpIQOm7YRLmGadm57bOHu0Gt32gf7yM8f35M4dWZapGoq3Roq9v+OonIS4dw00
         JTouAam8VCCahIGheJfocnvAPodFj0NSZX9cCnO72Q851KycJluR/Zu3NNyrmAeghYJt
         1hnA==
X-Forwarded-Encrypted: i=1; AL+hErFJ6YQB3GJDEyj/C/Dj9NdeybXIJnEMPDFUCiWh1g6FhHy0AKwxeUvNNLgjsQP2unoEOCBDbOE=@lists.linux.dev
X-Gm-Message-State: APuU4Z8xuwT4J9ZY6OKvu3wLMFX3C1xSobEuH08MHS3iSFyXX5oZAvIy
	hj1DWZXl6LDHOQbweAP+Ne9hrLTDcHiZBimwrcPJXr8dYChHZp0Uw6MFmv26qJH5BTw=
X-Gm-Gg: AZFdTZdoYgSgvk42E4gO9tn0PHO6rBAVpAY4L0bgpD63HjVMHjbpcHrvrmqrTm0Pty4
	HmzFovMJgd/29QJVbvAlmN/3KY2KhmyJh2faBSDqb6UsiB3Y8Af0SwuSjfXv7DU0+pZdDD39sTW
	b1I4j0dUzNmLr0U8mbSvqBxviTkSaXKtxkk//29UZYJUOsNfoqBnBgp/dvbz4U/ZIGBExHDBq1r
	+VcaRJ5kGUoUzZXzlOoYmGjhbg+KLrXPhswGxnpBPXcCVXbXuLQsc+/zQxP8rMhWgpZWh193SEr
	KdN8tjipYyUPLPn6JDs2Y2F1lqnwkZzmXPLsTTYdOedQOuprqQXEqmv7OWBZoIKoEFnUMIz0S40
	8aUzSvjsAQUrT64dgTZ+rPixSF9yDe9hb5cyja22K1GpS8EJafepQ0BJwxyTdGjhDOwiFrKPsx1
	0wPuDhNdFAtOopOKv+O0ekyGwDehHrFd7rP4RL8UXrjF7sAHqDL3sbrpgSeNcWf7Xgi/CaiufKy
	17y0ny+G2nDcZBl5vK7KuoS9ZQzgA5lJcpO5pwCL7CEeDFQmDZRvIIhyMfsUbQqIvHy1izyY7Wi
	nk5cXT+3nEyK3U8sbCAEGAaRS7i7Q9lX3GVQLZ+2EbL95lL77bfn1O6ai0aG
X-Received: by 2002:a05:600c:820d:b0:4a1:dfaf:f465 with SMTP id 5b1f17b1804b1-4bb887c2ca3mr186411065e9.4.1795345085983;
        Sun, 22 Nov 2026 02:58:05 -0800 (PST)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906e4ce6sm105568865e9.4.2026.11.22.02.58.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 02:58:05 -0800 (PST)
Message-ID: <4937f07a-6238-4136-94ca-a98b2f4b8db5@blackwall.org>
Date: Sun, 22 Nov 2026 12:58:04 +0200
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: withdraw the switchdev entry of an fdb
 entry made dynamic
Content-Language: en-US, bg
To: Julius Bairaktaris <julius@bairaktaris.de>,
 Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 Simon Horman <horms@kernel.org>, Vladimir Oltean <olteanv@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Jesse Brandeburg <jbrandeb@kernel.org>
References: <20261121191638.1724620-1-julius@bairaktaris.de>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20261121191638.1724620-1-julius@bairaktaris.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/11/2026 21:16, Julius Bairaktaris wrote:
> Since commit 927cdea5d209 ("net: bridge: switchdev: don't notify FDB
> entries with "master dynamic""), br_switchdev_fdb_notify() reports
> neither the addition nor the deletion of an entry that the user added
> without NUD_PERMANENT or NUD_NOARP. The user can turn an entry that
> switchdev was told about, a learned one or a static one, into such an
> entry: fdb_add_entry() does it for "bridge fdb replace ... master
> dynamic", and __fdb_update() for "bridge fdb replace ... master use"
> (NTF_USE), which marks a learned entry as added by the user. The
> drivers then keep the entry they were given, and since its later
> deletion is not reported either, they keep it after the bridge has
> dropped it.
> 
> Report the deletion of the old entry to switchdev before either path
> makes it one that is no longer reported, as br_fdb_update() does before
> an entry moves to another port; br_switchdev_fdb_notify() tests the old
> flags, so only an entry that was reported is withdrawn. Entries with
> the extern_learn flag stay reported and are left alone. The NTF_USE
> branch is only reached from netlink: the packet path passes no
> BR_FDB_ADDED_BY_USER to br_fdb_update(). The offloaded flag of the
> entry stays as the drivers report it.
> 
> Found while reviewing how DSA tracks host addresses for bridge FDB
> entries. In QEMU with KASAN and dsa_loop given FDB operations and
> assisted learning, an address learned on a veth port of the bridge is a
> host address on the CPU port. After "bridge fdb replace <addr> dev vA
> master dynamic", or "... master use", and the deletion of the entry,
> net keeps the address on the CPU port in 3 of 3 boots for each command;
> with this change it is deleted at the replace in 3 of 3 boots for each.
> 
> Fixes: 927cdea5d209 ("net: bridge: switchdev: don't notify FDB entries with "master dynamic"")
> Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
> ---
> I used Claude (Anthropic) to help write these patches.
> 
>   net/bridge/br_fdb.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 

I think this has never worked, so this patch can go to net-next.
A few nits below.

> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index b601245ad923..377ca8341029 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -996,6 +996,16 @@ static bool __fdb_mark_active(struct net_bridge_fdb_entry *fdb)
>   		  test_and_clear_bit(BR_FDB_NOTIFY_INACTIVE, &fdb->flags));
>   }
>   
> +/* Called before @fdb becomes an entry that the user added as dynamic, which
> + * br_switchdev_fdb_notify() does not report: report the deletion of the entry
> + * switchdev was told about, if it was
> + */
> +static void fdb_switchdev_hide(struct net_bridge *br,
> +			       const struct net_bridge_fdb_entry *fdb)
> +{
> +	br_switchdev_fdb_notify(br, fdb, RTM_DELNEIGH);
> +}

This helper isn't helpful. Just call br_switchdev_fdb_notify directly.

> +
>   static void __fdb_update(struct net_bridge *br,
>   			 struct net_bridge_fdb_entry *fdb,
>   			 struct net_bridge_port *source,
> @@ -1005,6 +1015,7 @@ static void __fdb_update(struct net_bridge *br,
>   	struct net_bridge_port *old_port;
>   	struct net_bridge_dst old_dst;
>   	bool fdb_modified = false;
> +	bool roamed = false;
>   	unsigned long now;
>   
>   	/* attempt to update an entry for a local interface */
> @@ -1032,6 +1043,7 @@ static void __fdb_update(struct net_bridge *br,
>   			br_switchdev_fdb_notify(br, fdb, RTM_DELNEIGH);
>   			br_fdb_dst_write(fdb, dst);
>   			fdb_modified = true;
> +			roamed = true;
>   			/* take over HW learned entry */
>   			if (unlikely(test_bit(BR_FDB_ADDED_BY_EXT_LEARN,
>   					      &fdb->flags)))
> @@ -1048,7 +1060,12 @@ static void __fdb_update(struct net_bridge *br,
>   		}
>   	}
>   
> +	/* Only from netlink (NTF_USE), with the user's flag in @flags */

This comment is useless.

>   	if (unlikely(test_bit(BR_FDB_ADDED_BY_USER, &flags))) {
> +		/* After a roam the deletion was reported above */
> +		if (!roamed && !test_bit(BR_FDB_STATIC, &fdb->flags) &&
> +		    !test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags))
> +			fdb_switchdev_hide(br, fdb);
>   		set_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
>   		if (test_and_clear_bit(BR_FDB_DYNAMIC_LEARNED, &fdb->flags))
>   			atomic_dec(&br->fdb_n_learned);
> @@ -1262,6 +1279,10 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_dst dst,
>   		if (flags & NLM_F_EXCL)
>   			return -EEXIST;
>   
> +		if (!(state & (NUD_PERMANENT | NUD_NOARP)) &&
> +		    !test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags))
> +			fdb_switchdev_hide(br, fdb);
> +

I played around with the possible bits that can result from this change and I think
I got 1 bad case:
What if a user adds a master static entry (created with BR_FDB_ADDED_BY_USER but without
ext_learn) which is later programmed and gets BR_FDB_OFFLOADED set, then a replace with
"master dynamic"?
That is,
bridge fdb add master static, bridge -> swdev driver issues add (entry is now ADDED_BY_USER | STATIC),
swdev -> bridge (entry is now with | OFFLOADED), bridge fdb replace master dynamic (ADDED_BY_USER | OFFLOADED)
but the entry has been deleted in dsa / mlxsw due to the new swdev del that is sent

>   		old_dst = br_fdb_dst_read(fdb);
>   		modified = fdb_update_dst(fdb, old_dst, dst);
>   
> 
> base-commit: d5b89d55a322b632e2b465b392a4c1d9d338db9c

