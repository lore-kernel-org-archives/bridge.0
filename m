Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793032458;
	b=FOvlN49+TibJbq52SavdwD8ywAR3Pb0QH2ba8frlJcTxSS2e4NDdnslMu4O5lNqBUuXc
	 ZfN/iLgmL1pDLjEOEkFw1XNVUO3EAIfC9ccwKc7Kgxe/UUal4TFEtXFzc9WtsG0x7/Sbv
	 L4AqIn18/9Uj8nHBZXh5oxSA0MJjoilCcbNzYbRaUS08IN2roIWgvZVbIv1ro9oRz+YDq
	 /x1eDU2xrdWLJjtev7ZHIu7hBxI7pcAXwisk9aB8RJHgbPFJx7v7jfMG8FEFroGHycPME
	 pfT3YG/YzAAxVpGo+e5nciXTNecRjuDc8kXfHXwZ91ELDoigjDtHopCpWLUiflrBgCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793032458;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=1pw5Y2kdhl00k3SU/S/VeRlGVRN9vDxsTMvxZUbr8bQ=;
	b=yyfQvMYDb/eUCUmEyy7rV9BEe1XS95lkDu5z0Dnulv9rP7JTK0XddCryk1xdtGAMYbFC
	 X3kWgjnQsbvc0jvY6ibwsa7KkUb59nJQl3d350Y4Fu2h4pp0TECMviTYPE0dt6VMJrjly
	 rpf9cwUCpoR9do9ZAnufO2QoM5267BGZFFxPkTTG9uEMV0wywXpuNKs+CIivE/QAniTcC
	 CRLb5IkeTdUglo0o27XzOgYqBNemylRunsYJ+72F7FIBFiFvgZBLRBOFl1pehiNxOgepG
	 4eHGnOA8rDR0nKmw/TigVfwu+JnJFhjp6TiyemfmXHr3YOl0Q1SDbNbk+4a1hu5ipvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OHkmh3Zk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C269606A31F;
	Mon, 26 Oct 2026 16:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OHkmh3Zk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B35C1F01825;
	Mon, 26 Oct 2026 16:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793032457;
	bh=1pw5Y2kdhl00k3SU/S/VeRlGVRN9vDxsTMvxZUbr8bQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OHkmh3ZkWaqiY0jDyhdkQR+428Cgt7Zr9rUn+iczuAAWr66kZKYc9EcNYqBJl8ayL
	 c52SBDaSrFV9/WeM4qPS3SySJO5YZlYhJAQxPF0FK9CK0bAvmulqKZi2qua5nhizqa
	 2FfY3An+/dOouKpS5yv2gPfIi3yjsE2s1t6XWUg2GbaximXQSoUeaMQladnQDsHgKJ
	 COP+C37Pv5IuHuPAsKh7+mCVLKlLjjf2m9g93fGfbkzo8FvuOTDV0AUjYyKz3re/lt
	 qCpCSMlwdhMQyPOYUbK9ESNF9QNeojvwqbEbVpdLxl3vXBpX0GO8jjefasiWL4lLln
	 wa4nmwfqH7MsA==
Subject:
 Re: [PATCH net] bridge: cfm: keep RX work disabled while CC is disabled
From: netdev-bot+sashiko@kernel.org
To: pocj8ur4in@gmail.com
Cc: razor@blackwall.org, idosch@nvidia.com, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Mon, 26 Oct 2026 16:34:16 +0000
Message-ID: <179303245691.3134.18367923447939876610@kernel.org>
In-Reply-To: <20261025163215.62509-1-pocj8ur4in@gmail.com>
References: <20261025163215.62509-1-pocj8ur4in@gmail.com>
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

- [Medium] The patch only partly closes the post-disable behaviour its
  own commit message describes.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but it sits on
  the cc_peer_enable() path the patch modifies.

--

bridge: cfm: keep RX work disabled while CC is disabled

This patch initializes each peer MEP's ccm_rx_dwork in the disabled
state. It enables the work in cc_peer_enable() and switches
cc_peer_disable() to disable_delayed_work_sync(). The goal is to stop
br_cfm_frame_rx() from requeueing the RX work, and reporting a new loss
defect, after CC has been turned off.

> diff --git a/net/bridge/br_cfm.c b/net/bridge/br_cfm.c
> index 9dcc97d63a6fc..8576f387d037e 100644
> --- a/net/bridge/br_cfm.c
> +++ b/net/bridge/br_cfm.c
> @@ -150,12 +150,13 @@ static void cc_peer_enable(struct br_cfm_peer_mep *peer_mep)
>  	memset(&peer_mep->cc_status, 0, sizeof(peer_mep->cc_status));
>  	peer_mep->ccm_rx_count_miss = 0;
>  
> +	enable_delayed_work(&peer_mep->ccm_rx_dwork);
>  	ccm_rx_timer_start(peer_mep);
>  }

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch, but it
is on the cc_peer_enable() path changed here. When br_cfm_cc_config_set()
calls ccm_rx_timer_start(), which exp_interval does it see?

br_cfm_cc_config_set() enables the peers before it stores the new config:

    if (config->enable && !mep->cc_config.enable)
        /* CC is enabled */
        hlist_for_each_entry(peer_mep, &mep->peer_mep_list, head)
            cc_peer_enable(peer_mep);
    ...
    mep->cc_config = *config;

ccm_rx_timer_start() then reads the old value:

    interval_us = interval_to_us(peer_mep->mep->cc_config.exp_interval);

On the first enable of a newly created MEP, cc_config is all zeroes. That
makes exp_interval BR_CFM_CCM_INTERVAL_NONE, so interval_to_us() returns 0
and the RX work is queued with a 0 jiffy delay.

If the kworker runs before mep->cc_config is updated, can
ccm_rx_work_expired() keep requeueing itself with a 0 delay? If so, it
could reach the miss limit and latch a spurious ccm_defect, with a
notification.

The same ordering matters when enable and an interval change arrive in
one request. For example, CC was disabled with a 10 min interval and is
now enabled with 3.3 ms. The first tick would then fire after a quarter
of the old interval, which delays loss detection by up to about 2.5
minutes.

Could the new config be stored before the peers are enabled?

>  
>  static void cc_peer_disable(struct br_cfm_peer_mep *peer_mep)
>  {
> -	cancel_delayed_work_sync(&peer_mep->ccm_rx_dwork);
> +	disable_delayed_work_sync(&peer_mep->ccm_rx_dwork);
>  }

[Severity: Medium]
Does this cover everything the commit message describes? The commit
message says:

    After CC is turned off, a valid CCM can still reach br_cfm_frame_rx(),
    clear the peer defect and restart its RX timer.

This change only prevents the timer restart. The CCM branch of
br_cfm_frame_rx() still does not check mep->cc_config.enable:

    /* A valid CCM frame is received */
    if (peer_mep->cc_status.ccm_defect) {
        peer_mep->cc_status.ccm_defect = false;

        /* Change in CCM defect status - notify */
        br_cfm_notify(RTM_NEWLINK, port);

        /* Start CCM RX timer */
        ccm_rx_timer_start(peer_mep);
    }

    peer_mep->cc_status.seen = true;
    peer_mep->ccm_rx_count_miss = 0;

cc_peer_disable() does not touch cc_status, so a ccm_defect latched
before CC was disabled stays set.

When a valid CCM arrives after that, won't br_cfm_frame_rx() still clear
the defect and send an RTM_NEWLINK notification for a MEP whose CC is
disabled? The only difference is that ccm_rx_timer_start() now does
nothing, because queue_delayed_work() refuses the disabled work.

A receive that is already in flight when br_cfm_cc_config_set() disables
CC seems to behave the same way. disable_delayed_work_sync() returns and
the request is acked, but the in-flight br_cfm_frame_rx() can still clear
the defect and notify.

The same path also keeps updating seen, ccm_rx_count_miss, rdi,
seq_unexp_seen, the TLV status and mep->ccm_rx_snumber.

Would it close the remaining gap to also gate the CCM processing branch
of br_cfm_frame_rx() on mep->cc_config.enable? Disabling the work would
still be needed for the in-flight requeue race.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261025163215.62509-1-pocj8ur4in%40gmail.com
