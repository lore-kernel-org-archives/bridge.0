Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383982D94BC
	for <bridge@lists.linux-foundation.org>; Wed, 20 Aug 2025 13:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755696375; cv=none; b=Ua3wD/oeGnnHebRYbq1GLv4vcZkCNQBRGuaQuogf32W8f7vZoIudUIi5iviup94uED/dmkhxxL4+zWlTNNzhiZwAgnE7vxZojCRDmHiyB+Sp3jPBp4bokgTVVt5FhG53FbpL6NOAOLr4Z9DY5I9uiU7r/MObyIPV1kE1ZtoHbLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755696375; c=relaxed/simple;
	bh=DOeocE2TSMK2zhBIMAISf0bA1p+4iSO7xk5SPu2tIfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MeQ0Auzu0cHgkA1xlkey1SaMRVksGJNSfk6M6gvTsPRVn/8xVHtDwA6XPROQuXkCS+q/ego59DfpB+L/YnmYMcqU+jfS+FnCxdl18kfWZVwvQ3dzcJa+ccTFpBGYY8F4VRE1Xy0fMe3qBAe00Z76KZYBLnca9bJ1zHZCt6yIEz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ENwthEb+; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ENwthEb+"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D278D836F6
	for <bridge@lists.linux-foundation.org>; Wed, 20 Aug 2025 13:26:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -6.291
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BBF5ay9z4_Vg for <bridge@lists.linux-foundation.org>;
 Wed, 20 Aug 2025 13:26:13 +0000 (UTC)
X-Greylist: delayed 478 seconds by postgrey-1.37 at util1.osuosl.org; Wed, 20 Aug 2025 13:26:12 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D733C81E55
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=idosch.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D733C81E55
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ENwthEb+
Received-SPF: Pass (sender SPF authorized) identity=helo; client-ip=103.168.172.158; helo=fhigh-a7-smtp.messagingengine.com; envelope-from=idosch@idosch.org; receiver=<UNKNOWN> 
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D733C81E55
	for <bridge@lists.linux-foundation.org>; Wed, 20 Aug 2025 13:26:12 +0000 (UTC)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8EE3714003B9;
	Wed, 20 Aug 2025 09:18:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 20 Aug 2025 09:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755695893; x=1755782293; bh=dzEYBhueTWc89/MISWU3UFuCYVd1T4k9Kq6
	zJAOupw0=; b=ENwthEb+Ky21vZLrX+qnv+f6AyHsIx3sG86siSeLtTHUVMBax0t
	F8LjXTrl6bDCwwkpazNZ1JKKI8SUZfUdNRJQTYAB6zwsMzCxcsyjC2rfilufvjJm
	fHeFGSgxSoLbr4Hv4hvFxdxN9my4gqkHxG8mHZLLoiXw+Yo7Lg0dyOTqSIXZ/apW
	5lOzUhGnEstpFRCgGnhwNFkxOEQ7f4wue0v29runO6+kn2HMc6y8BUxk/rqwgkXJ
	616kKKbNb+2n8TMJ7Cl52mtSsn1K2cWoPbv971dmy+sHg6cv3Wq9+ezIROl1ukYW
	150wojWK9rXge+VNLyR5fzzopoHYCqV7npg==
X-ME-Sender: <xms:FculaCYGrrWPF0axijoXPinf3zDEc23SrYUvRpMwO2-YuvP5dgLb4w>
    <xme:FculaNAdgcf33lpjBApqpzPojukmSZwNBvB8-ClHh9iWZgawiGXRqjlknLbOU6PhI
    2eZLay7Xo5c95g>
X-ME-Received: <xmr:FculaKmM61xFbleSxj4UZnpMkvqtc-1v_Vd-iHYpfmWnjhGXUPLIvTr6zhBR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheekgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcuufgt
    hhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrthhtvg
    hrnhephefhtdejvdeiffefudduvdffgeetieeigeeugfduffdvffdtfeehieejtdfhjeek
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhn
    sggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrhhghh
    hoshhhsegtihhstghordgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrihgughgvsehlihhsthhsrdhlihhnuhig
    qdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehmrhhinhhmohihpghgsehhoh
    htmhgrihhlrdgtohhmpdhrtghpthhtohepphgsrhhishhsvghtsegtihhstghordgtohhm
    pdhrtghpthhtoheprhgriihorhessghlrggtkhifrghllhdrohhrgh
X-ME-Proxy: <xmx:FculaOx3A_6SA5pGhBWbRiMK4Rv60ltL88f9wjl8fyvvfTSvU-KhVw>
    <xmx:FculaEQ1se9V8cAT_kw_d2MzpUhDW8u0-7FP4MopGEVwFX1JJczLRQ>
    <xmx:FculaG9UPX8vb_kM0Zr0onUtfO7JIAFIGY4uZPGw6PHKxS2dNiAjPw>
    <xmx:FculaCurBEBKqQ2g7j75PTVVDoj8tlOEatuaO6tpPTfNfJRH0kBslA>
    <xmx:FculaMqjobtMGghfqMasYWhjjWBzFWAVbdBa_9J9KjRWlAEW__FgvqKB>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Aug 2025 09:18:12 -0400 (EDT)
Date: Wed, 20 Aug 2025 16:18:10 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Mrinmoy Ghosh <mrghosh@cisco.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	bridge@lists.linux-foundation.org,
	Mrinmoy Ghosh <mrinmoy_g@hotmail.com>,
	Patrice Brissette <pbrisset@cisco.com>, razor@blackwall.org
Subject: Re: [PATCH] net: bridge: vxlan: Protocol field in bridge fdb
Message-ID: <aKXLEiY8gd0sNGrW@shredder>
References: <20250818175258.275997-1-mrghosh@cisco.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818175258.275997-1-mrghosh@cisco.com>

+ Nik

Please use scripts/get_maintainer.pl when submitting a patch.

On Mon, Aug 18, 2025 at 05:52:58PM +0000, Mrinmoy Ghosh wrote:
> This is to add optional "protocol" field for bridge fdb entries.
> The introduction of the 'protocol' field in the bridge FDB for EVPN Multihome, addresses the need to distinguish between MAC addresses learned via the control plane and those learned via the data plane with data plane aging. Specifically:
> * A MAC address in an EVPN Multihome environment can be learned either through the control plane (static MAC) or the data plane (dynamic MAC with aging).
> * The 'protocol' field uses values such as 'HW' for data plane dynamic MACs and 'ZEBRA' for control plane static MACs.
> * This distinction allows the application to manage the MAC address state machine effectively during transitions, which can occur due to traffic hashing between EVPN Multihome peers or mobility of MAC addresses across EVPN peers.
> * By identifying the source of the MAC learning (control plane vs. data plane), the system can handle MAC aging and mobility more accurately, ensuring synchronization between control and data planes and improving stability and reliability in MAC route handling.
> 
> This mechanism supports the complex state transitions and synchronization required in EVPN Multihome scenarios, where MAC addresses may move or be learned differently depending on network events and traffic patterns.

[...]

> Signed-off-by: Mrinmoy Ghosh <mrghosh@cisco.com>
> Co-authored-by: Mrinmoy Ghosh <mrinmoy_g@hotmail.com>
> Co-authored-by: Patrice Brissette <pbrisset@cisco.com>
> ---
>  drivers/net/vxlan/vxlan_core.c      | 132 ++++++++++++++--------------
>  drivers/net/vxlan/vxlan_private.h   |  21 +++--
>  drivers/net/vxlan/vxlan_vnifilter.c |  11 +--
>  net/bridge/br.c                     |   4 +-
>  net/bridge/br_fdb.c                 |  52 ++++++++---
>  net/bridge/br_private.h             |   5 +-
>  6 files changed, 127 insertions(+), 98 deletions(-)

Please read these two documents and make changes accordingly before
submitting a new version:

https://docs.kernel.org/process/submitting-patches.html
https://docs.kernel.org/process/maintainer-netdev.html

At the very least the patch should be split to a bridge patch and a
VXLAN patch. I will provide more comments later this week.

Thanks
