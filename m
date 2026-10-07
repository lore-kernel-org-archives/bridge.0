Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2034E66B8;
	Wed,  7 Oct 2026 19:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791401908; cv=none; b=he6naVnuphgXePcj/ehab7TZqam31/JjtBVAuWz7dHX2KyrGPJ9fnvaIGTbsWiXcIjydykHH2TjXykt2x3Lx5mgvuGw2w7A9jqvHaS3e1U0lDiE/7pavEDUJjpNnzWzxhTipwGlWxrlf84ZGoasCOJZvSaSuknXL22CklyAbrK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791401908; c=relaxed/simple;
	bh=jj8V+01tIfSXZ2Y/5lOxJoixmNn+btG5nqtGm9keQX4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sAZnG82Xs/lTZoGlexWoLssTk2ESFBDR1ufNsvMmMBeHLvbScfmKlqCuFQp34EUyfoJLVSxovJSKbzhgGuEpkWT15sFmiqtbjLF2ragnVngp+dKwGkV4xQMBPT8/tbceEUZHYetTLzQA+Aeb+arx/2TRUqBEiSJTYXu5l3umKek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFbySH1a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFbySH1a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07BAC1F000FF;
	Wed,  7 Oct 2026 19:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791401907;
	bh=VIK9SuCUCf/o2M6lPH86LKXaX5NtHRetOZ4pKF9pDQM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lFbySH1aUUWe7HbIBoOEE5yz85o2JdlzVmu4dFm44IpmLpPwAn90SBWBJxMPl3bpA
	 h4ngG+YiyRMqWdZDG0+d1Lb2Mkr8/VGTJ/XS8b0ZbeVEaoqls4hu1Q834qvuutDYdv
	 WMonm9TY5S/XjoHcMKEMCe6kGPJNAudcNNL+5z0bdbHA4rDIaSFmoyEzCO8OQt5zyu
	 AisnVbwOMksjbrnxnd7Svd5b+KSwcU1AwGo9G75J5hgJJXWYpaenD/HaO5HDlzbWm7
	 zy6hE3ktrrGtpXXrY0NKu5GhnMGLlaDxZ14Qz9c8HfSTfBevx8STTuhQ78ErDN1EgA
	 gvBmpZSCNashA==
Subject: Re: [PATCH net-next v2 3/3] net: bridge: cfm: notify userspace on CFM
 config changes
From: netdev-bot+sashiko@kernel.org
To: w453y.me@gmail.com
Cc: netdev@vger.kernel.org, razor@blackwall.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, horatiu.vultur@microchip.com, bridge@lists.linux.dev,
 linux-kernel@vger.kernel.org
Date: Wed, 07 Oct 2026 19:38:26 +0000
Message-ID: <179140190656.434549.16339845926256165183@kernel.org>
In-Reply-To: <20261005043822.3106580-4-w453y.me@gmail.com>
References: <20261005043822.3106580-4-w453y.me@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Config-change notifications are only sent for changes made
  through br_cfm_parse().

--

net: bridge: cfm: notify userspace on CFM config changes

This patch makes br_cfm_parse() send an RTM_NEWLINK with
RTEXT_FILTER_CFM_CONFIG once any CFM config group in the request has
been applied. The notification is sent even if a later group in the
same request fails. It uses br_info_notify() the same way
br_cfm_notify() already does for status.

> diff --git a/net/bridge/br_cfm_netlink.c b/net/bridge/br_cfm_netlink.c
> index 91b9922dc3f25..56309e6f4b1be 100644
> --- a/net/bridge/br_cfm_netlink.c
> +++ b/net/bridge/br_cfm_netlink.c

[ ... ]

> @@ -399,59 +400,72 @@ int br_cfm_parse(struct net_bridge *br, struct net_bridge_port *p,

[ ... ]

>  	if (tb[IFLA_BRIDGE_CFM_CC_CCM_TX]) {
>  		err = br_cc_ccm_tx_parse(br, tb[IFLA_BRIDGE_CFM_CC_CCM_TX],
>  					 extack);
>  		if (err)
> -			return err;
> +			goto out;
> +		changed = true;
>  	}
>  
> -	return 0;
> +out:
> +	/* Earlier groups may have been applied even if a later one failed */
> +	if (changed)
> +		br_info_notify(RTM_NEWLINK, br, NULL, RTEXT_FILTER_CFM_CONFIG);
> +
> +	return err;
>  }

[Severity: High]

This sends a CFM config notification for changes that come in through
br_cfm_parse(). The kernel also changes the reported CFM config in a
couple of other places. Do those still go unreported?

The commit message says:

  Today the only way to see these changes is
  to poll RTM_GETLINK with RTEXT_FILTER_CFM_CONFIG.

One such place is ccm_tx_work_expired() in net/bridge/br_cfm.c, when the
transmission period ends:

	if (time_before_eq(mep->ccm_tx_end, jiffies)) {
		/* Transmission period has ended */
		mep->cc_ccm_tx_info.period = 0;
		return;
	}

br_cfm_config_fill_info() reports this field as
IFLA_BRIDGE_CFM_CC_CCM_TX_PERIOD. With this patch a listener sees
period=N when CCM transmission starts. Does it ever see the period drop
to 0 when transmission stops on its own?

The other place is port removal. del_nbp()->br_cfm_port_del() deletes
every MEP whose ifindex matches the port being removed:

	hlist_for_each_entry_safe(mep, n_store, &br->mep_list, head)
		if (mep->create.ifindex == port->dev->ifindex)
			mep_delete_implementation(br, mep);

After that, the only notification in del_nbp() is:

	br_ifinfo_notify(RTM_DELLINK, NULL, p);

That is a port message using RTEXT_FILTER_BRVLAN_COMPRESSED. Also,
br_fill_ifinfo() never puts IFLA_BRIDGE_CFM in port messages.

The previous patch in this series ("net: bridge: cfm: send an empty CFM
nest when a bridge has no MEPs") adds the empty nest so a listener can
tell that the last MEP is gone. If that last MEP is removed because its
port leaves the bridge (ip link del, or ip link set ... nomaster), no
bridge CFM config message is sent at all.

In these two cases, would a listener that relies only on the new
notifications keep deleted MEPs and non-zero CCM_TX periods in its view,
so it still has to poll?

Should ccm_tx_work_expired() and br_cfm_port_del() also send an
RTEXT_FILTER_CFM_CONFIG notification?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261005043822.3106580-1-w453y.me%40gmail.com
