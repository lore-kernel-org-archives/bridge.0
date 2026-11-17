Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794900046;
	b=ULL6LhCDjuOeI2Z6+s1pYuzRVd01KimDnj4buKdwlCn/z6cKGsHaB6KkWFXGXADAL637
	 pUtAM7eyUwpSZioBnCtlmZuww7SEnD+R1NZKz8ww6lnqvonJGefhbkLNydo9WMuQb7fAA
	 J5h8GCf18gGaVPucGeNsjwreJZfUPx5V0FSpnnGNPka3o3M3/1mN/cNrrTeZNyrbhJ7mF
	 WPkPFewU/PKke8fmoXoeunX4b/ibAslgxUplJbNc8vErzvl3iczEZlNV6uC14YghlHff/
	 S542rGR9IMjnNnB6NzSOnxZlBIpZO7+ZI0IRpxlKP3Maz1pylLJrAq8feQZtTPD3Pdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794900046;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=wGSN+nm4nJXlMtGvr0vz0Ecn/IBKbBibwHoRey+2Wug=;
	b=oC6gfEc5AosH+S+/2Kd25HjckcGC6YpyUBAvnoTSx/E8brXW4IIH+TTF1baw5HNoDoyU
	 UaO3hSps/EWIFjUFDLMmjY8mlsct/sUU5+ZjlFY4ibSKdFWA7XibpyTH0KjrKK+FidEX/
	 fdjky3x12cyVpy7HwGRAv3HSC/JM3prN4Ax60/KwaS75lPqcPVHYfgGIhZm9Z1ybV4fwV
	 Jbkm014a5xN/rBpiMfF111f2nIi1Huv7jQEcaroQikxX5Scj/Rcgw0IELffuYmYpUgah2
	 YAQm4IM9EfF/fD9MHYcakI5NjQMeEh/IuRFkLDOpUIzjVmE+mKGUy2ePTKvnrklCOuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=ifCqWEeT;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B39606A323
	for <bridge@lists.linux.dev>; Tue, 17 Nov 2026 07:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0B39606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=ifCqWEeT
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso35609005e9.1
        for <bridge@lists.linux.dev>; Mon, 16 Nov 2026 23:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1794900044; x=1795504844; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wGSN+nm4nJXlMtGvr0vz0Ecn/IBKbBibwHoRey+2Wug=;
        b=ifCqWEeThT5gr7H4+En9NZgPSjew//2jxhazIGLARxd0WMWRgnQ+/cEQSRQy353bFd
         sp6q5xMyCFKFtN39lP83d0TLE/7nmEtIUp6IU83rdUAG5B3D1y47xsCV7EYjhqICT12X
         N5MH9a/qn/rOHu2v5Swp3nmzmkeiUJxPKiCUPAUsqQM4QOXKRiT6pQtewCnBsr6/iWNx
         iLGZMkoDujjd8gm0E0Si3n+sPIVuIcsH1sWtxQp5W5pwdx9T5VMIyyQfQynz9r13KSS0
         axAPSydpusLmCqSGQrBD1SeXmchkCIIkHQ3/CZTESUzgb9iAJFK17KDx4ObPXrjKQlqC
         +3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794900044; x=1795504844;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wGSN+nm4nJXlMtGvr0vz0Ecn/IBKbBibwHoRey+2Wug=;
        b=0Ua1j7T2YBSR7iaJ5xICXT+Vc5GXsa1ZOoDBT9Y3Hox4xwznXjPVXmYDgOGTevFqm/
         oBTy/KaAYjb7eeEmdjDV79QZJxV5l0XblmR8OWiPWKYzn2mz2LLMLHBfwCe+Fxx8Znyj
         aoo/q4xlw+Rdm1ldVvmOZfGViCpXKKIvQBUJSb0QvdT5UZqIsLG9GmSHVqP6Eq4QyFB3
         P2wG58xjbqPOLbAUR4PuBDPkX5+6AyhrWgCNlO8AnYmFNuX9yLn2v4ChTaBgMW1jWS6E
         EEVlRHBIra94G4pWmjLYQXDFfjn3gNctRKirkyScal9IMVRHJaL4btQbGhBzPPy5/953
         0gbw==
X-Forwarded-Encrypted: i=1; AL+hErFh9QAg/1LHzySRyL2eP9G+ccNZATfCbU8M3Gr5S410+2nGwShSsmeedGVs2QfaE4C2qftfe2s=@lists.linux.dev
X-Gm-Message-State: APuU4Z8cALs51kOVvj801ST9f8a5niJBafbivtc1RxV6ev37V1VFoe0T
	wvXOA3K+KMsBkjTW2Wtb8g7S25BkCg6VG0QObhsB67ToNUHi0qZ6yYSIVg42IoKGySs=
X-Gm-Gg: AYBFou0UN69zomC2ulopRVafIln/10RSVjw92/wWdBjsFUwBWKr4gFSKYIy2xzm2ykQ
	dOyqIoSPj1QzPFFRQzagdH2RwrUkbQEYs4ZlXL0zt7VCngelGYQrbyVRVQqysJcxjZamhkp8ApN
	+kMJOkIQ4ZhzeQUyQ8rnfI+m4qc53oPL567eV+hGJr8WA/Bhli6N7/6JngMAotjLTfscXkjsCSR
	yhM+Q/cm7I9hodWl6EfXuG7yD7/2WDjLoIgJcc9lIS7NJjvvnlMDDH9JqCnLH0a0I3ZtXUFuPJg
	L4OlrsHerjFpys61O6Ud5FtrC7WOfLGS10p5y9zlUsXFmwnq1TFjUL5slK27sEGpXda5n2v0ctf
	N3N86cTdDxJKT57IPhcn/iZ8rLIMWTRXCcoFmge8hVcXAMWB+HegB4oGnzSGVAK5QWuntCOfD67
	80TDTYgTS3YOvhfSstElsoZhU+C42pAhIv7IjHw8yQOYqV1MmGzmvkSXnEnl0Bkk17Y7KKpMohX
	1TGxVnTAfu3VxH0zJzHaXSGwZvPQ+7L74XLPfzyIdIkKl6PHoKIWqPG2+c0kfjxrrQIFWarOI+q
	ISguFD6als+NPwNBiZGMzDvSmWWE9TWeFUfeFbCr9t2WIJm7vK56pGZkHrg=
X-Received: by 2002:a05:600c:3f0a:b0:4a4:3a2d:15da with SMTP id 5b1f17b1804b1-4bb55a702femr252699885e9.15.1794900043776;
        Mon, 16 Nov 2026 23:20:43 -0800 (PST)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb783853b5sm47198985e9.2.2026.11.16.23.20.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 23:20:43 -0800 (PST)
Message-ID: <5bf25689-5939-4c45-8155-48e1fa4c7032@blackwall.org>
Date: Tue, 17 Nov 2026 09:20:42 +0200
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
Subject: Re: [PATCH net] net: bridge: fix skb leak of reinjected link-local
 frames
Content-Language: en-US, bg
To: Daniel Wade <danjwade95@gmail.com>, Ido Schimmel <idosch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261115130211.7724-1-danjwade95@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20261115130211.7724-1-danjwade95@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/11/2026 15:02, Daniel Wade wrote:
> br_handle_frame() passes the link-local frames it neither forwards nor
> delivers (01:80:c2:00:00:02 to 0d and 0f, unless set in the group
> forward mask) through NF_HOOK() at NF_BR_LOCAL_IN. Since commit
> 3b2e2904deb3 ("net: bridge: fix per-port af_packet sockets") the okfn
> only learns the source and returns 1, which becomes RX_HANDLER_PASS.
> 
> That commit sent the nf_queue case to RX_HANDLER_CONSUMED, which is
> right for the synchronous return, but the frame comes back: on
> reinjection nf_reinject() calls the okfn and ignores its return value,
> because every other okfn consumes the skb. This one no longer does, so
> nothing frees the frame. NFQA_CFG_F_FAIL_OPEN leaks it the same way
> with no verdict at all, when the queue or the listener's socket is full.
> 
> Each frame leaks an skb, and one sent from a local socket keeps that
> socket charged, so neither it nor the network namespace holding it is
> freed. Bridge, rule and queue need only CAP_NET_ADMIN in a netns, so
> with user namespaces an unprivileged user can exhaust kernel memory.
> 
> nf_reinject() cannot free the skb on a 1 from the okfn, because other> okfns return NET_RX_DROP, which is 1, after freeing it.
> 
> Call nf_hook() instead of NF_HOOK() and do the learning and the
> RX_HANDLER_PASS return in br_handle_frame() on 1, as the 0x00 and 0x0e
> cases already do and as vrf_rcv_nfhook() does. The okfn then runs only
> for a reinjected frame, which br_handle_frame() has already reported
> consumed and cannot pass on the port, so it learns from the frame and
> frees it. These frames were not delivered before this change either.
> 
> Also set *pskb before the new RX_HANDLER_PASS, as the other such
> returns do; skb_share_check() may have replaced the skb, and the commit
> above added that return without the assignment.
> 
> Discovered by an AI code review agent and reproduced on unmodified
> mainline under KASAN: an unprivileged user in a new user and network
> namespace bridged a veth, queued link-local frames to an NFQUEUE
> listener that accepted every one, and leaked an skb per frame. With
> this patch the reinjected frames are freed and nothing leaks.
> 
> Fixes: 3b2e2904deb3 ("net: bridge: fix per-port af_packet sockets")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Wade <danjwade95@gmail.com>
> ---
> Tested in a KVM guest on mainline b3dfbde62cf1 with KASAN and
> PROVE_LOCKING, running as nobody under "unshare -Urn". No kernel
> modification, debug patch or injected delay was needed to reproduce.
> Before: 192000 bytes charged on the sending socket, unchanged 2 s
> later. After: 0 bytes, no KASAN report or lockdep warning, and
> br_input.o builds clean at W=1.
> 
> Not tested: NF_STOP, NFQA_CFG_F_FAIL_OPEN, real EAPOL traffic, the
> netfilter and bridge selftests, CONFIG_NETFILTER=n.
> 
> Applies to v7.2-rc5, v6.12.117, next-20261109 and 7e1392a42ea2.
> 
> The Fixes commit was checked against torvalds/linux: it adds both the
> "return 1" okfn and the RX_HANDLER_PASS return without the *pskb
> assignment.
> 
>   net/bridge/br_input.c |   18 +++++++++++++-----
>   1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index fc2e381..b5bd9d6 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -257,13 +257,18 @@ static void __br_handle_local_finish(struct sk_buff *skb)
>   		br_fdb_update(p->br, p, vlan, eth_hdr(skb)->h_source, 0);
>   }
>   
> -/* note: already called with rcu_read_lock */
> +/* okfn of the link-local NF_BR_LOCAL_IN hook in br_handle_frame(). It is
> + * only called when a queued frame is reinjected, after br_handle_frame()
> + * returned RX_HANDLER_CONSUMED for it, so the frame can no longer be
> + * passed up on the port and has to be freed here.
> + * note: already called with rcu_read_lock
> + */
>   static int br_handle_local_finish(struct net *net, struct sock *sk, struct sk_buff *skb)
>   {
>   	__br_handle_local_finish(skb);
> +	kfree_skb(skb);
>   
> -	/* return 1 to signal the okfn() was called so it's ok to use the skb */
> -	return 1;
> +	return 0;
>   }
>   
>   static int nf_hook_bridge_pre(struct sk_buff *skb, struct sk_buff **pskb)
> @@ -424,11 +429,14 @@ static rx_handler_result_t br_handle_frame(struct sk_buff **pskb)
>   		/* The else clause should be hit when nf_hook():
>   		 *   - returns < 0 (drop/error)
>   		 *   - returns = 0 (stolen/nf_queue)
> -		 * Thus return 1 from the okfn() to signal the skb is ok to pass
> +		 * On 1 the frame is passed on here. The okfn() only runs if a
> +		 * queued frame is reinjected later, and must consume it then.
>   		 */
> -		if (NF_HOOK(NFPROTO_BRIDGE, NF_BR_LOCAL_IN,
> +		if (nf_hook(NFPROTO_BRIDGE, NF_BR_LOCAL_IN,
>   			    dev_net(skb->dev), NULL, skb, skb->dev, NULL,
>   			    br_handle_local_finish) == 1) {
> +			*pskb = skb;
> +			__br_handle_local_finish(skb);
>   			return RX_HANDLER_PASS;
>   		} else {
>   			return RX_HANDLER_CONSUMED;

The fix looks ok, the commit message though - next time trim the AI slop,
all of that could've been 3-4 sentences.

Actually I think there is a worse bug in there, by the time an skb was stolen and
reinjected, its port could've gone away (I'll have to verify it) but we deref it in
the helper without any checks, that could lead to a null ptr deref or wrong ptr.
I will take care of that.

Anyway let's not delay this patch,
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


