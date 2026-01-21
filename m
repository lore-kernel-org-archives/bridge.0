Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CE8495515
	for <bridge@lists.linux.dev>; Wed, 21 Jan 2026 17:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769016073; cv=none; b=oOjn9ufU1ZMpfBXtvmUhMUhgrdLeGt2dKnl97x3ijc2Tg7oEa/JSaaVs/EOJY1rtwAiP/L/aWeZgrPT3EOaJQK7xIXRtMxFzxaH3kGr9BvNBU9QuZQ0Jvp+zx4rW6RlQxTkLICSHc1F5qxTT3NrDFvknzYPLqY6BDsDd09AoaxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769016073; c=relaxed/simple;
	bh=hVozr/UAze3F0ZukkBIDoKX7V9cDW4MB3uwxpn0t5cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bX56bk8LoyuOxiRzvlrOr/nDcTTQCTg+JFNt5yqbSdqUpbYBnaE0f2pAvZY4dWIe7XXDxTB9VMTAkBhlXVyoWFdCbGiLk9Kqb8cam519T7JpQe2vQCHSNM/QukPw37I/I/ike0rnDoOTSnJxz9r6hNHMvvW3ebmynn8VzuRzyVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=EA221Aak; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g/6xA37V; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="EA221Aak";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g/6xA37V"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 9D7B41D003A3;
	Wed, 21 Jan 2026 12:21:09 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 21 Jan 2026 12:21:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1769016069; x=
	1769102469; bh=9T5Cog/dLzaoPDeo3aK2X6a5C6BvZXYMr7KZk1YmWjk=; b=E
	A221AakZhh8hkGn3DxeDhJHm3K5KtJ5mhTx940AdHbFc81KZON2mUhPtUsMphPWj
	pRpg3MLk09i7T01wwmqVKtwgUCPpXX5Ud7SJvplaPnQEauvoJmS/Me/c7x7ZdfyA
	dVYlOSpjuWErVysjBSPN5lj9YuWx/9pTDxU+8km8ZQSFyiHIZE/lMp+qEvHzO6sh
	F1iZWiJWfHAiq7apzV27R1IaFEt8k0FE1Jt6qkM2HGiz9lN03EFfXuB2TWff63AL
	PUeiSaAVhnRlGHz0Q/eTPZNPQVjYRpaFuHvAQVGFZY6fjYsbdY7tErHWM5cwuL2c
	ZBiTxt9wp0zVQoqGJMc7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769016069; x=1769102469; bh=9T5Cog/dLzaoPDeo3aK2X6a5C6BvZXYMr7K
	Zk1YmWjk=; b=g/6xA37V8999oqJwIZaSxJQs0TqMR1sXFe7N0ba/mBVFHngJ1mV
	IAyx0WOR1hsRAKTaXFXMCMsgC9H46tYAEWUFh/UmmA9AY6vTN/IIx4Kf4JY3Bw6q
	EbmaPdKwhMequs4UxmV98gqZys/UlmNeBmTRX7l53eAnTcTBDhmeR7krHo+XG1yF
	f0EBaaRRYw3H6AU9CryaSmRsiBzSMTLCQDOxpxMQBlQaNHNx81mTXccT+MQzs/bx
	EJYOMeyW9n0Zcli/Lhq2LTc+Yl586eYmSLMuu3NwctQNhX6k9eWCoDTkzfeNUI5u
	uTy7fnkva44IaTI01jZvuMaPXGsnC00GVng==
X-ME-Sender: <xms:BAtxaSSKchQxO5lcRmk5vFOM5cosymiqQV1672daPqJWQRr0KTyLgg>
    <xme:BAtxaScCt1B2cXVeQ-bLubRKlVMISGeR1LgSw85YlFHw4Bq2SzhkzHZZeMwtURhKB
    jvz5FHIHNAZT0AL-jk1sB_ez4WNUdYdWpI-Mq0sdSJbGRP4B-53snoo>
X-ME-Received: <xmr:BAtxaWenjqTibrpHBWbTMaE9pZrXPIj0pjcqC6lvUD6ehi24MUoyPqySC4Jp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeefkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedukedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepihguohhstghhsehnvhhiughirgdrtghomh
    dprhgtphhtthhopehmmhihrghnghhflhesghhmrghilhdrtghomhdprhgtphhtthhopehn
    vghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhgvfi
    donhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhl
    ohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghn
    ihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprhgriihorhessghlrggtkhifrghllh
    drohhrgh
X-ME-Proxy: <xmx:BAtxaY9sQH0auz3CYOgcnXubjtxhaaA_4W1Ve7leOIr3aTeiEo5cMA>
    <xmx:BAtxaWPSaZbvxd9azNi5f8SOyVWJ2Lfoby9SVEu8NwE9mTjeXxSEAA>
    <xmx:BAtxaWUdck1Uqr_ZWBtNpPhZo3xm01BMoMUSE0kk-AO7HytKXAYg1Q>
    <xmx:BAtxaWgB0so-k0p_LjrX4jS3rTFNfv4yOICIZGlHLwqHjoxAwOJf1g>
    <xmx:BQtxaasD_IhRgwcxmbMQYxDD7YYFGQKZ1cWpIB3WBxYhZjtx56-EawUw>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 12:21:07 -0500 (EST)
Date: Wed, 21 Jan 2026 18:21:05 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Ido Schimmel <idosch@nvidia.com>
Cc: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Carolina Jubran <cjubran@nvidia.com>,
	Breno Leitao <leitao@debian.org>,
	Shigeru Yoshida <syoshida@redhat.com>, linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev
Subject: Re: [PATCH net-next 0/4] u64_stats: Introduce u64_stats_copy()
Message-ID: <aXELAazPe7G5M6am@krikkit>
References: <20260120092137.2161162-1-mmyangfl@gmail.com>
 <20260121111635.GA447040@shredder>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260121111635.GA447040@shredder>

2026-01-21, 13:16:35 +0200, Ido Schimmel wrote:
> On Tue, Jan 20, 2026 at 05:21:28PM +0800, David Yang wrote:
> > On 64bit arches, struct u64_stats_sync is empty and provides no help
> > against load/store tearing. memcpy() should not be considered atomic
> > against u64 values. Use u64_stats_copy() instead.
> 
> The existing memcpy() does seem problematic (even if in practice it's
> not) and the proposed solution in patch #1 seems OK to me given that all
> the callers only pass structures containing 64 bit counters. Couldn't
> find any more instances of this pattern.

No direct instances using memcpy, but do we need to also full structs
copied within a u64_stats_fetch_begin/u64_stats_fetch_retry loop?


// net/mpls/af_mpls.c
static void mpls_get_stats(struct mpls_dev *mdev,
			   struct mpls_link_stats *stats)
{
[...]
	for_each_possible_cpu(i) {
		struct mpls_link_stats local;
		unsigned int start;

		p = per_cpu_ptr(mdev->stats, i);
		do {
			start = u64_stats_fetch_begin(&p->syncp);
			local = p->stats;
		} while (u64_stats_fetch_retry(&p->syncp, start));
[...]

// net/openvswitch/datapath.c
static void get_dp_stats(const struct datapath *dp, struct ovs_dp_stats *stats,
			 struct ovs_dp_megaflow_stats *mega_stats)
{
[...]
	for_each_possible_cpu(i) {
		const struct dp_stats_percpu *percpu_stats;
		struct dp_stats_percpu local_stats;
		unsigned int start;

		percpu_stats = per_cpu_ptr(dp->stats_percpu, i);

		do {
			start = u64_stats_fetch_begin(&percpu_stats->syncp);
			local_stats = *percpu_stats;
		} while (u64_stats_fetch_retry(&percpu_stats->syncp, start));
[...]


And if not: can't we just use the same pattern for those other cases
that this series is touching?

-- 
Sabrina
