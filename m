Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793552517;
	b=c69zGNTM3e+HJnWbEjf/7UVrgjZBKDVgBEnrqCPzzJlCCbMy6JMw2ICxVytud64/ttmz
	 KED12fSBwQkbeTq0ctpAY+z9CGH7KjqL4kwYXpz7E4Cl+Qfsj4Q4uzfJlBL6A6Ee+LM/m
	 0DwgPFxKINFnlQZBHTcXSa5dWlNZ/dEMlCJ/Ko4bMCFBLbebiGFBqoODt8aW+c3fxTGL+
	 cpp/qK0fl5PH79pS0eNyYJhQ++zTZSGtYS0X6SzGXUl1F1gPVsz0P58knu8zKyF/IIkvL
	 drgSsS/CfSvrSrXChbEXVN9y6lKD+3ngCwQsXWUcOiCOt8Gh2/7mbxbA3+c36OnkFhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793552517;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=C3LoBN5t64bHrUu7cG47Kku/wEVXrt6OuNyUMHATThI=;
	b=oVaMY7xleYkXyiGzREMTmOhht8w6X03/8COCF/R0Hk1w3LV2tCruPWQkA0yEfq95DbZ8
	 fe6/kpcNmgCD7cCbsFsYb3jceJIL28zRZxgqqx6btSDIZa3sB92f0qjVUNS1XG7rnXPpf
	 8K/uxzoMYsjZpsfTRMFrPLUlNUOD7zmdl1tu7hy7FY5r56oGDEi0zwpenP1RdTkj+EAgZ
	 H/IDC+OMggOFBIXvINfGiLFR0FRjfufJRrQv63vqAWnWptPc5qJBiZjCICe41FMK2tiCE
	 5Qf+giuHiP8iwTotdo5ainvGvWMqz37pLgvGVkoj4JhL50jua6d3ica+UZDME/8wrHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jQQQk8s/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA018606A32E;
	Sun,  1 Nov 2026 17:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jQQQk8s/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78F81F00919;
	Sun,  1 Nov 2026 17:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793552516;
	bh=C3LoBN5t64bHrUu7cG47Kku/wEVXrt6OuNyUMHATThI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jQQQk8s/ycZfIU1impLbY4+koomODpq+frVnPk56b5tkm2EbR4lCbD2MYCHSkHZRy
	 UmdTFkAy5b7Uu1cPDM8Q1i3M8tfdd9Unbb1Lqib9j+fSzogq4EaywaQGs1T5izP1Fx
	 paYxu2JhhYQytvoY556jNcOz6ySVIFr7MXDo1LTqg71GzQkUpP7/Fr+rMzPUE7mOAM
	 7U65FzjzP1T2w6mn1mxZqFtOCnxQBprdjGeYR1e4ef8hCEFYhsGKaQ9NFGJU+o34OG
	 mxamgoYGtEe/x2lKHqHy5gM/HOH9cKzs8B26mJ/aqpAKTt+LeNsWOpjbtHc5ngGpuG
	 LyB6vdBt4su4A==
Subject: Re: [PATCH net v2 2/2] bridge: cfm: ignore CCM while CC is disabled
From: netdev-bot+sashiko@kernel.org
To: pocj8ur4in@gmail.com
Cc: razor@blackwall.org, idosch@nvidia.com, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Sun, 01 Nov 2026 17:01:55 +0000
Message-ID: <179355251548.3131.13821521898777428651@kernel.org>
In-Reply-To: <20261028164730.253238-3-pocj8ur4in@gmail.com>
References: <20261028164730.253238-3-pocj8ur4in@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The CC-disable path in br_cfm_cc_config_set()
  (net/bridge/br_cfm.c) does things in the wrong order and does not wait…
- [Low] The patch adds a lockless reader,
  READ_ONCE(mep->cc_config.enable) in br_cfm_frame_rx()…

--

bridge: cfm: ignore CCM while CC is disabled

This patch keeps the per-peer CCM RX delayed work disabled from creation
until CC is enabled. It switches cc_peer_disable() to
disable_delayed_work_sync(), and br_cfm_frame_rx() now drops CCM PDUs
while mep->cc_config.enable is false.

> diff --git a/net/bridge/br_cfm.c b/net/bridge/br_cfm.c
> index 28b40dbf40734..115cccf1d327d 100644
> --- a/net/bridge/br_cfm.c
> +++ b/net/bridge/br_cfm.c
> @@ -150,12 +150,13 @@ static void cc_peer_enable(struct br_cfm_peer_mep *peer_mep)
>  	memset(&peer_mep->cc_status, 0, sizeof(peer_mep->cc_status));
>  	peer_mep->ccm_rx_count_miss = 0;
>  
> +	enable_delayed_work(&peer_mep->ccm_rx_dwork);
>  	ccm_rx_timer_start(peer_mep);
>  }
>  
>  static void cc_peer_disable(struct br_cfm_peer_mep *peer_mep)
>  {
> -	cancel_delayed_work_sync(&peer_mep->ccm_rx_dwork);
> +	disable_delayed_work_sync(&peer_mep->ccm_rx_dwork);
>  }

[Severity: Medium]
Can a CCM still change peer status after the RX work has been disabled?

br_cfm_cc_config_set() disables the RX work for every peer first and
clears the enable flag only after that:

net/bridge/br_cfm.c:br_cfm_cc_config_set() {
    ...
	if (!config->enable && mep->cc_config.enable)
		/* CC is disabled */
		hlist_for_each_entry(peer_mep, &mep->peer_mep_list, head)
			cc_peer_disable(peer_mep);

	enable = config->enable && !mep->cc_config.enable;

	mep->cc_config = *config;
    ...
}

disable_delayed_work_sync() can sleep while a running
ccm_rx_work_expired() finishes. For that whole loop,
mep->cc_config.enable is still true.

br_cfm_frame_rx() runs in softirq under RCU without RTNL, and it checks
the flag only once. A CCM handled on another CPU during the loop, or one
that read enable just before the store, passes the new check and then
does this:

	if (peer_mep->cc_status.ccm_defect) {
		peer_mep->cc_status.ccm_defect = false;
		br_cfm_notify(RTM_NEWLINK, port);
		ccm_rx_timer_start(peer_mep);
	}

It also updates seen, rdi, seq_unexp_seen and mep->ccm_rx_snumber.

The RX work is already disabled at that point, so ccm_rx_timer_start()
does nothing and the defect stays cleared while CC is off. Nothing like
synchronize_net() follows the store, so such a receiver can also finish
after the netlink request has returned.

This seems to be the case the commit message says it prevents:

    This prevents a later CCM from changing
    peer status or restarting RX monitoring.

Would it work to clear the flag first with
WRITE_ONCE(mep->cc_config.enable, false), then call synchronize_net() so
in-flight RX handlers drain, and only then disable the per-peer RX work?

[ ... ]

> @@ -414,6 +415,9 @@ int br_cfm_frame_rx(struct net_bridge_port *port, struct sk_buff *skb)
>  
>  	if (hdr->opcode == BR_CFM_OPCODE_CCM) {
>  		/* CCM PDU received. */
> +		if (!READ_ONCE(mep->cc_config.enable))
> +			return 1;
> +

[Severity: Low]
Should the writer side of this flag be annotated too?

This READ_ONCE() is a new lockless reader. The only writer is still the
plain struct copy in br_cfm_cc_config_set():

	mep->cc_config = *config;

The writer runs under RTNL and the reader runs in softirq under RCU, so
no common lock serializes them. The copy covers exp_interval, the 48 byte
exp_maid and enable, and the compiler may emit it as a memcpy. KCSAN can
then report a data race against this marked read.

Would a separate WRITE_ONCE(mep->cc_config.enable, ...) work here, placed
at the right point in the disable and enable sequences?

The same RX path also reads exp_maid and exp_interval without annotation
while they are being rewritten. Those reads were there before this patch.

>  		/* MA ID is after common header + sequence number + MEP ID */
>  		maid = skb_header_pointer(skb,
>  					  CFM_CCM_PDU_MAID_OFFSET,

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261028164730.253238-1-pocj8ur4in%40gmail.com
