Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793552516;
	b=pGnrYMRD2T02p0jZN2KWodgsc7FUBLdoUaptJLw/axA59pmbRlbw79vXQYKv/h+Sz2XI
	 TmHNHFvNqbeHK62ayd42WC+eAtQNLx17J5rbI5Teim/69ufoRIKYXCf4aImk5WOn3cx/l
	 3W71lW8bEjj1RHbYvyMBmXg+7eroiTgE7zcb0HGdvYNHPOEw2wIJjlfcPuMSoRI2y1mdK
	 DjE8c1m30HZdFgBd4GRXnnxRuPA+lgWlRdMg6vjIRokpmxcvKe6lMNTGipdLnPxCXwpmr
	 jnRYmqPj9yT51Lnb6CDV8JnRM5DX6RiNgfg9UmalSKtdWQcOM/Kf7UarlLJ6EnYlIZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793552516;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=CC5+I0kQeM4PqmSxLmQU8DWQGU1yHX24IvORForBsa0=;
	b=IaHb3QAyKoU9vPpJntjkuEIfY00azq9Ev9hJCGB53eIkJLR5n2/VSiPJhTVut5tG36l7
	 k5hIvlmHzEyTxIgqcOn3057f85wFjvqLBN/D0GwtZjaze9Js72cD6K71ylND5sB8zpCTH
	 ROfI7v7UwKfPadFd7nH235+xfyF3ohWMhFZ0gBtztDZQAhAlsDFa5VLUOJcl0VRTJjTBz
	 wlBkq9l/fmOzX2SJiVjhUjC9GVYdbG4ZeFRxZEh0XLZT28LcuGxYLGbl/ofqZuwRM8nke
	 4n+5uulGuJS7LTqZkTjcfy//D9KRHUUyVEEvvlP4CaxbV+5JR9dJbtCCNLOQabsuNNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nh9ujrWV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A45606A324;
	Sun,  1 Nov 2026 17:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nh9ujrWV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58581F000C1;
	Sun,  1 Nov 2026 17:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793552515;
	bh=CC5+I0kQeM4PqmSxLmQU8DWQGU1yHX24IvORForBsa0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Nh9ujrWVh+wqKKdbbtZNThKXD/d1Ks0iTADQbtxYmpslIhD0oMJcPgPmjb84Gp9V6
	 MxMXC8MpfRB0Le7F3hkIJty+tYOpRKeYiZlJQCVlp3QTyfBa5atrdFbFT28ZJHAEGk
	 sc/pw7S3aPzttEZdUnnWMJMZ7MyFR/5kZdHJIaliU1RHRlWXoKP5EJq01yB3BQ5RDk
	 aD8D9tPDjADPfINgjpOjb/nPbs56AI5KjllVtYnEy8wmfE3j+z3rbTHlImkni4Cq1n
	 NCWvA9lNWzY8vBHfRsEA/29dpMMrUQ7D4OohaYQ39hRaE0fsRC0tLZft8IMI30qxZX
	 QTRzfxZlpYE9w==
Subject: Re: [PATCH net v2 1/2] bridge: cfm: Store the new CC configuration
 before enabling peers
From: netdev-bot+sashiko@kernel.org
To: pocj8ur4in@gmail.com
Cc: razor@blackwall.org, idosch@nvidia.com, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Sun, 01 Nov 2026 17:01:54 +0000
Message-ID: <179355251442.3131.5735013472111110097@kernel.org>
In-Reply-To: <20261028164730.253238-2-pocj8ur4in@gmail.com>
References: <20261028164730.253238-2-pocj8ur4in@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] At this commit, cc_peer_disable()
  (net/bridge/br_cfm.c:156-159) only calls cancel_delayed_work_sync().

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the code
  still mishandles it.

--

bridge: cfm: Store the new CC configuration before enabling peers

This patch reorders br_cfm_cc_config_set() so that mep->cc_config holds
the new CC configuration before cc_peer_enable() is called on the
disabled-to-enabled transition. The goal is for the first RX timer to use
the new exp_interval instead of the previous one.

> diff --git a/net/bridge/br_cfm.c b/net/bridge/br_cfm.c
> index 9dcc97d63a6fc..28b40dbf40734 100644
> --- a/net/bridge/br_cfm.c
> +++ b/net/bridge/br_cfm.c

[ ... ]

> @@ -648,17 +649,20 @@ int br_cfm_cc_config_set(struct net_bridge *br,
>  	if (memcmp(config, &mep->cc_config, sizeof(*config)) == 0)
>  		return 0;
>  
> -	if (config->enable && !mep->cc_config.enable)
> -		/* CC is enabled */
> -		hlist_for_each_entry(peer_mep, &mep->peer_mep_list, head)
> -			cc_peer_enable(peer_mep);
> -
>  	if (!config->enable && mep->cc_config.enable)
>  		/* CC is disabled */
>  		hlist_for_each_entry(peer_mep, &mep->peer_mep_list, head)
>  			cc_peer_disable(peer_mep);
>  
> +	enable = config->enable && !mep->cc_config.enable;
> +
>  	mep->cc_config = *config;

[Severity: Medium]
This isn't a bug introduced by this patch, but what happens when
exp_interval changes while CC stays enabled?

In that case the disable branch and the new enable branch are both false,
so only the config store runs. No peer is re-armed, and ccm_rx_count_miss
is not reset.

ccm_rx_timer_start() reads exp_interval only at the moment it queues the
work:

ccm_rx_timer_start() {
	interval_us = interval_to_us(peer_mep->mep->cc_config.exp_interval);
	...
	queue_delayed_work(system_percpu_wq, &peer_mep->ccm_rx_dwork,
			   usecs_to_jiffies(interval_us / 4));
}

So a ccm_rx_dwork that is already pending still fires after the delay
computed from the old interval. For example, changing from 10 min to
3.3 ms without disabling CC could leave the next RX check up to 150 s
away instead of about 825 us.

The 13-tick threshold in ccm_rx_work_expired() would then be counted with
a mix of old and new intervals.

Should the peer RX timers also be restarted when exp_interval changes on
an enabled MEP? The follow-up commit "bridge: cfm: ignore CCM while CC is
disabled" doesn't seem to touch this path either.

> +
> +	if (enable)
> +		/* CC is enabled */
> +		hlist_for_each_entry(peer_mep, &mep->peer_mep_list, head)
> +			cc_peer_enable(peer_mep);

[Severity: Medium]
Can ccm_rx_dwork already be pending when this loop runs?

At this commit cc_peer_disable() only calls cancel_delayed_work_sync().
br_cfm_frame_rx() runs in softirq and does not check
mep->cc_config.enable. If ccm_defect was still set when CC was disabled,
a valid CCM that arrives later queues the work again, using the disabled
config's interval:

br_cfm_frame_rx() {
	...
		if (peer_mep->cc_status.ccm_defect) {
			peer_mep->cc_status.ccm_defect = false;
			...
			ccm_rx_timer_start(peer_mep);
		}
	...
}

After that, ccm_rx_work_expired() keeps re-arming the work.

On re-enable, cc_peer_enable()->ccm_rx_timer_start()->queue_delayed_work()
returns false because the work is already pending. The new, shorter delay
is never programmed.

Take the example from the commit message (disable at 1s, re-enable at
100ms). The first check could still fire after about 250ms instead of
25ms, which is the symptom this patch sets out to fix.

The next commit in the series, "bridge: cfm: ignore CCM while CC is
disabled", appears to close this path. It uses disable_delayed_work_sync()
in cc_peer_disable(), disables the work at peer add, calls
enable_delayed_work() in cc_peer_enable(), and checks
READ_ONCE(mep->cc_config.enable) in br_cfm_frame_rx(). With that commit
applied, the remaining window looks only theoretical.

Could the two patches be reordered or squashed, so that this commit fixes
the re-enable case by itself?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261028164730.253238-1-pocj8ur4in%40gmail.com
