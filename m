Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABAC217F32
	for <bridge@lists.linux-foundation.org>; Mon,  7 Apr 2025 08:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744014974; cv=none; b=LBnBCXoSuISoXdMf6d7kQu/fN23ri3caT4h14/ODbwRSqo3f2HA+w84JQyNx15oOZRbvXyJp9IEQN+u92WoDfPzgM/4AfSlhpAF/T8NfE4VEFIfAfs57VyBI7xa9ZJnTXF09YWuG/udRxu7GD5cjkHKiF3N1JXbHmgPLEyMLkjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744014974; c=relaxed/simple;
	bh=NdxrZpkoAS5JiWYgZz3H6UVBi+3AhclDMA55q0fjY8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wteo+FAGMFv7Vn97CbIKmN9ic1yNrokBCkbSXDZJKq41mfhgmeqOtmlZ9GW97mwAyk2oe+4tJck1/dM9DzIluBQbcyqhee31RRIDSYqlUjfFCXRPN61UOHeUqG9XVhl30z1vq0a079INYc/Sl6TeRYuL9HF4SAhaQu94dMx0kOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RPbgpXco; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RPbgpXco"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A138C4062B
	for <bridge@lists.linux-foundation.org>; Mon,  7 Apr 2025 08:36:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -6.291
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B4EnGsyAAmSt for <bridge@lists.linux-foundation.org>;
 Mon,  7 Apr 2025 08:36:11 +0000 (UTC)
X-Greylist: delayed 357 seconds by postgrey-1.37 at util1.osuosl.org; Mon, 07 Apr 2025 08:36:11 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 65AB1403C2
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=idosch.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 65AB1403C2
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=RPbgpXco
Received-SPF: Pass (sender SPF authorized) identity=helo; client-ip=103.168.172.149; helo=fout-a6-smtp.messagingengine.com; envelope-from=idosch@idosch.org; receiver=<UNKNOWN> 
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 65AB1403C2
	for <bridge@lists.linux-foundation.org>; Mon,  7 Apr 2025 08:36:11 +0000 (UTC)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 342A91380228;
	Mon,  7 Apr 2025 04:30:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 07 Apr 2025 04:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744014613; x=1744101013; bh=SyWehjHb8zpXeJ45viskigR9BtioaZba5Zg
	A+Lsdhxg=; b=RPbgpXcoQMgTtWqOiV//r6KxMBrhuOw3Cslw11T89Cicmfsl5m+
	l723C5GdJlMN3CMAXQQAml/xR2wWtigHeoGCoAgSkCfB/nrkR/gRpv7DkVM1007i
	CDS8criM0ojxh7rQJAFX9oaJA6+uCv7oKdT5YbH+GenTbfRForm0Hkbkx8OA7t9g
	a/TKOEGNYDDNOrlIOoUljOLzdcY1x1sPWJj5GnexixoRGsOPuCM5lJOvLa4kK+Dh
	7XjajbyUIn6AJt1PJ4E63BSCj6DtKKeG/FAkKPRHyKJBmSE23LE1gktq23/AF/hT
	vXdgOWVSy1n0Q1GoE/Qe8E3zPMntJWSJv0w==
X-ME-Sender: <xms:FI3zZ18U1Ke5vixfd1ZgttVZ_6Z7IPbeKc6lPoVA54VS7JVjAyc3rg>
    <xme:FI3zZ5siJHF_bZ0tqdPsJz9FyegM4afHnvlYWYwNcbbhfl_G3OZG-NtHpE9sSjCNI
    Ntoosjf1ehGOVg>
X-ME-Received: <xmr:FI3zZzBWvuuIkiM_IcbYzmS2jkI_R9yG5kPOoLuozCiljOhclP2p-z-6YUya>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduleeljeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgthh
    drohhrgheqnecuggftrfgrthhtvghrnhephefhtdejvdeiffefudduvdffgeetieeigeeu
    gfduffdvffdtfeehieejtdfhjeeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgt
    hhesihguohhstghhrdhorhhgpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhgpdhrtghpthht
    ohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrih
    gughgvsehlihhsthhsrdhlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphht
    thhopehrohhophgrsehnvhhiughirgdrtghomhdprhgtphhtthhopehiughoshgthhesnh
    hvihguihgrrdgtohhmpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplhhu
    mhgsvghrrdhorhhgpdhrtghpthhtohepughsrghhvghrnheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:FI3zZ5c-nbqP8GJ2V7xC96KeEyKj0nBYfONH3D0AB_jQWiesWLci0w>
    <xmx:FI3zZ6MUp5yPeUR2hzj2S_ignBk8rwR_JLkMMouNp2c-L7rgpQ4Emg>
    <xmx:FI3zZ7nX2LCavDzzcUTh4F94_T8lDd0H_CKVQpdjm6KRw0rSgYWMiA>
    <xmx:FI3zZ0uhTd1Yqp-0zfCfyea35WUkQI1-MeJoP6vo6_hm4mZp-dewgw>
    <xmx:FY3zZ1O-3RE8nTU9Um103Lb92qmzGra_ZhwjtgOldYXjcQIAp45k_Cu2>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 04:30:11 -0400 (EDT)
Date: Mon, 7 Apr 2025 11:30:10 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org,
	Roopa Prabhu <roopa@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH iproute2] MAINTAINERS: update bridge entry
Message-ID: <Z_ONEvPRjiAgRRY9@shredder>
References: <20250405102504.219970-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250405102504.219970-1-razor@blackwall.org>

On Sat, Apr 05, 2025 at 01:25:04PM +0300, Nikolay Aleksandrov wrote:
> Sync with the kernel and update the bridge entry with the current bridge
> maintainers. Roopa decided to withdraw and Ido has agreed to step in.
> 
> Link: https://lore.kernel.org/netdev/20250314100631.40999-1-razor@blackwall.org/
> CC: Roopa Prabhu <roopa@nvidia.com>
> CC: Ido Schimmel <idosch@nvidia.com>
> CC: Stephen Hemminger <stephen@networkplumber.org>
> CC: David Ahern <dsahern@kernel.org>
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
