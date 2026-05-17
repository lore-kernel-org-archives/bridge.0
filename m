Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846BA361662
	for <bridge@lists.linux.dev>; Sun, 17 May 2026 13:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779025400; cv=none; b=jxnyIsQ5jU0rMUSSLexKWKuaPgbsT04B7k57q3cEk1b2F3JVSAbuxnzUHHqVxEIYSr5vtF6bHOtnjLq/5ppBfoc4qrybP/9OVphJ4WEuP5lmJ9O0FGTg19xFV35kSX6bvq26rFIUBYqn6NL+sqjKv/o0GqjXmewwIAHWCtCekvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779025400; c=relaxed/simple;
	bh=sMLXXNEtNM9byc9cxRPZeXDbmGRBMfUm3b7miLj3Ocs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwNXxgbaWz9QPaxPIQSkmygsHUbHfTIrNynY/Ytf4aK14fnXD82v80FbgY2DmWrAXYTwzahr7KAa6yq2yFtjj0LEqtlagABvPucVm+GuvRxk4BlGuCuwbQOokmdSYw2VxLiavtL7FGdmHzIYfJmA1by8WBjp9nrMdmCkZry6HoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=QU6go+Dl; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="QU6go+Dl"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso6765485e9.3
        for <bridge@lists.linux.dev>; Sun, 17 May 2026 06:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1779025396; x=1779630196; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+HArGPzJ3JrxUqYbJRCQTeZdStWSHyJjxqFBR8YJCaA=;
        b=QU6go+DlOfCJqBtrT1Ph6SBfSHSYPWwtA7vlkjiGlPvs6WRevulwYW8RF/xlAHdTns
         FOgkI27dXGo28eVZglgDJuLvcAv0kIwCw3jkKck1P1bA3McDDcDZZ7GtPwGwP9cQ6Lxg
         7La0b5yP+7N1KLQGAjfT0+1S4Cx/GqmRKNA23OyYsIz/Hui24xr72ke2QhAMCXBaQVLC
         ezFnTpm6Bmu+1g0nqOQHCJex9XVnaWtPbL9qmynTRBU8MByWfn4KuJF3AZ7NRFVsBmZj
         dso5DYVc8Wq7aKiXIvYrHJDFKJzZ1Yvu5XljOTRn1GQXu5UjVWYR4BQjPdjFMpZAm8ko
         zYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779025396; x=1779630196;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+HArGPzJ3JrxUqYbJRCQTeZdStWSHyJjxqFBR8YJCaA=;
        b=Uy6erFwt9xhRJoQ1N2bMj0Fx18OvENICXeKmaPQYhdbBFB4sTBnjCqfS/wEdUd1Jap
         wpmwl9v8gXrzzT8RUY/wgBhcL0z1UupaV8HGTd+VPe0ToFLXIxyZlFbbJqKGmLaKKbkv
         CzLboNM2yfIKVMLXm1ax4NjQrDGyW7nYValkol19I1vu/+E0yrJgUjw7uWKneQ1WDvGu
         NQdGMif42c59XYu0ecW44SxGXvijk08GKE59f5n834zdLCrG+vZwd4k/AjtGCA/Eh97L
         BDCIMAK1Oc1AEBvid4LwF8PFPTRg1G/DejHV7HlWf4cGGU3piY6qn9MHvMX0Pwo0+CnO
         YsKg==
X-Forwarded-Encrypted: i=1; AFNElJ+LhfG+C/OOuaLwc19t75WW+EtjgAPsvtuEDfmrcahOztnDu69cE5h/osjhskoSvEzLJ/IX0v0=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw66eveGKuhAIvqkILQhLvIterM7Bc6jPJznKPbS8vIes14QVn6
	QEhdPb5N9Vj/GUclEkuL/VhsFXgm8pwoXtHp2Xy/5b1g6mZqiUDeAWcWXI9ZUYGry80=
X-Gm-Gg: Acq92OGN0fUfXcRm8xmPuLLiKFXc5OkMwvCnrNHNjJK+HPoeE+TLNk74el6Qex3ZF65
	RsvX/haCQZDS+DwVpUX6Vp3wkid+ikL7wlv3KU1WqcqSdy3Kz7YIYSko9aNnSMinWEkccSct99j
	Vbl/vI6+2L0+jNK2HJ13Ut1DiL+f2MmM6VMXBvQP7Z9/0CUEERF6acE9pYd1RljpH0Zs5Zg7B5f
	WnklXVXfmF99II21s1XErW+JSXSmUGzlLYFt1x2mOgN3q9EZ65ZP0AMxC/pHchjNcc6Gn5KhfSq
	NRV1LL/7uVaAOWGgjf5ZuXx4rJ8bJLuRIktrZS9OYRKXE2aBOSpr9RnvB+6i4Hyxk27iB7DBbRj
	t863C0jW+L22WMhcED8om3SzhsIq30MWqCmiUE8TpKO0GMmsfRMtgGyNfuJOE3L3jUmiiR+tnT5
	4WsQYg7A7hkzSyjxFYmE/yGIgQL6bFxRAIH7xGxmSJMdJxrQfuxHrXXrkpwQ==
X-Received: by 2002:a05:600c:3f0f:b0:48f:99a9:bbcc with SMTP id 5b1f17b1804b1-48fe60ecb9cmr152488335e9.10.1779025395675;
        Sun, 17 May 2026 06:43:15 -0700 (PDT)
Received: from localhost (176.111.181.159.kyiv.nat.volia.net. [176.111.181.159])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ed30110sm32700649f8f.13.2026.05.17.06.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 06:43:15 -0700 (PDT)
Date: Sun, 17 May 2026 16:43:12 +0300
From: Nikolay Aleksandrov <razor@blackwall.org>
To: David Carlier <devnexen@gmail.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev, andrew@lunn.ch,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	horms@kernel.org
Subject: Re: [PATCH net-next v1] net: tpmr: add Two-Port MAC Relay driver
Message-ID: <agnF8KScbKxtUite@penguin>
References: <20260517041306.24841-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260517041306.24841-1-devnexen@gmail.com>

On Sun, May 17, 2026 at 05:13:06AM +0100, David Carlier wrote:
> Add a driver implementing the Two-Port MAC Relay as defined by IEEE
> 802.1Q-2014 §6.7.1. A TPMR is a minimal L2 relay between exactly two
> member ports: no FDB, no MAC learning, no STP, and -- by
> specification -- it forwards most of the 01:80:C2:00:00:0X reserved
> group address range that a regular bridge would consume. This makes
> it suitable as a bump-in-the-wire element that is transparent to the
> control plane on both sides (LACP, LLDP, EAPOL, and so on continue
> to reach the far end as if the relay were not present).
> 
> The driver is created with "ip link add type tpmr" and slaves are
> attached through ndo_add_slave, with a hard cap of two members.
> Forwarding is implemented as an rx_handler: a frame arriving on one
> slave is sent out the other via dev_queue_xmit(), with no FDB
> lookup. The IEEE-permitted subset of reserved multicasts is relayed;
> the remainder is delivered to the host stack via RX_HANDLER_PASS,
> preserving today's behaviour for protocols that genuinely target the
> local machine. Only 01:80:C2:00:00:01 (IEEE 802.3x PAUSE) is
> terminated, as required by the MAC layer.
> 
> The master's carrier follows the logical AND of both slaves'
> carriers, propagated via a netdev notifier. Both slaves enter
> IFF_PROMISC on enslave (and the refcount is balanced on detach) so
> the relay sees all unicast on the wire. rx_handler_register()
> provides exclusivity for free: a netdevice that is already a member
> of a bridge, bond, team, or macvlan is rejected with -EBUSY at
> enslave time.
> 
> MTU consistency is enforced at enslave: a second slave whose MTU
> differs from the first is rejected. Subsequent member MTU changes
> are blocked via NETDEV_PRECHANGEMTU; to change a member's MTU,
> detach it first.
> 
> Inspired by OpenBSD's tpmr(4) (David Gwynne, 2019), reimplemented
> against Linux's rx_handler / rtnl_link_ops infrastructure.
> 
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
> 
> v1 (from RFC, addressing Andrew Lunn review):
>   - Inline reserved-address check; only PAUSE is passed up,
>     gated on is_multicast_ether_addr() + unlikely().
>   - Fix MTU check that assumed ports[0] is always the
>     surviving slot after a detach-then-add sequence;
>     iterate ports[] to find the populated entry instead.
>   - Reject member MTU changes via NETDEV_PRECHANGEMTU.
>   - Drop driver version string; let ethtool core fill it.
>   - Keep driver in drivers/net/ (precedent: veth, bonding,
>     macvlan).
> RFC: https://lore.kernel.org/netdev/20260516050858.23858-2-devnexen@gmail.com/
> 
 
Hi David,
Please give people more time to review the proposed RFCs before sending v1.
Also you specifically asked bridge maintainers to comment and did not
wait for us to do so.

Now to the point - I don't think this device is needed at all, this task can
be accomplished in multiple ways with what we currently have, there is no 
need to add another software device for something so simple.

First, I'd like to ask: could you please elaborate why bridge's group_fwd_mask
isn't working out for you? How exactly are you trying to use it?
It was added for this purpose, to forward link-local frames and should be
able to do the same as what you're describing. If there is a problem I'd
rather we fix it or extend the bridge if something's missing instead of
adding so much new code that we'll have to maintain forever.

Second, what else did you try and how exactly did you try it?

Examples of a few ways to solve this:
 - tc: why dismiss mirred so fast, it can do the same combined with some matching?
       Did you check mirred redirect?
       cls_bpf/ebpf - definitely can do it as well
 - nftables: should be able to solve it, too
 - XDP: I wouldn't dismiss it because network managers cannot control it,
        all modern network managers support custom scripts in some form
        where you can load your custom XDP program and solve the problem

Cheers,
 Nik
