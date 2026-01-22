Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E5A3C1971
	for <bridge@lists.linux.dev>; Thu, 22 Jan 2026 11:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769079759; cv=none; b=VGv9fZgBxziJvjvA9u10Lye+IAacQBR8Basji7GxTVcQTlGZ7bJPpeAQDT5yWGLzc21rW/Qt2J+4ktCZByJhAAJz3E+g0h6/jLaWpez5eyshWubDQJn8si6knlh8h/RZ/YXDTyaBSLEfU0rBAxsHJTKoLsLqDhmmwoPPmdOvVtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769079759; c=relaxed/simple;
	bh=TryKnrp6JlC6lzVwNZ8LDFK6HEJFFCQy6yNZAQDMENk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHkVJTFlkRqQz067ZU6mrNyckE64qcMWrBPtnJLAzBUkxprOh4GW61WmD+tAqeQyXlHraxlM+QD9+UHSoOAlhd7xo2gwbSa/6hmmIKgq+24NXZlci8Nb5jdPUf8U9UwvrrIlSMNDsRGpM510aHSIix/3hzpIwv+Oxg9WpobZCkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=dhZwNhSz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tiqRWGNJ; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="dhZwNhSz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tiqRWGNJ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3273D1400098;
	Thu, 22 Jan 2026 06:02:36 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 22 Jan 2026 06:02:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1769079756; x=
	1769166156; bh=ZbD2rWWeTt//Jps7+a9Rlp2pXH+b3w9K6OMG55473EY=; b=d
	hZwNhSzMViYZXFXpxRT8f04yLaICAEFFKRoOhmoT4r7vWnLD6lkeXhLF8ADTiG3l
	Ats7XYhxlQ37eNn3Ipri7OX/cIkARw1qgP9tdDqBC6xMayNRH6qtWbc8r1KbOvu8
	+cQWytCe7JDR1k0Za+27CWnUMGFCaiQg0+nNsRN5/krQzgR3MGkjIkWwEUu3Cd6r
	YeSQAsjOT0GJ33Z0bvWIR/pDLNSou4yfal3sEjG2iMF++T2YPqjbh/PYeT18PEl1
	QTI+vTR6si1NM571AAxwukVPPCaz63CV+L9pQ7gmHUU/XyQ0hsir5bQm8pQjx8Ly
	qH6cuhcD+meZjLBUjp96g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769079756; x=1769166156; bh=ZbD2rWWeTt//Jps7+a9Rlp2pXH+b3w9K6OM
	G55473EY=; b=tiqRWGNJlnoQPrvEU/CRCR2KaWOvx4YaV1cFc19I+cPhJfmBQCS
	SN1fDefiI0eQTWPK+hn/ceDgpBAdjJ8ewAbVglDVlXfAmRBvFKso7IuS4PrU3mvG
	ud9LSMWPvaTgDP4l98oHVsNNpY176i8Bo6nEzTLzavA77EhIQZ+RvYwPRfRk/N5i
	Pe78rwRzvYYu0bTnjyzm2WBag8tW6ZpNMaGH9ZwVamhQy+BANUKZFtKLSjUHHvVY
	IicRtERNN4pT3iZHpdmEvgfFIqo6GhbPQZ30xXWOG4HEfW3m3d3+bK3suRIgtosh
	VLJqgUVyrR1nwtrje98t8x2se60KMfZEquQ==
X-ME-Sender: <xms:ywNyaYRpaJSMBl1gk-OpVF-ykpEvkbHLlPfzSj-HlflQ-pkujCa0Xg>
    <xme:ywNyaQdel99wgSYDChsqoWQ3HlDinhEs3VPYFtq70p6Shhp4jGRABIbLYDYjjS5_x
    jYPu250XClYvG7YdAfraX0Xa4JQZMiuDfn74Hld80dCk54nCBQOQVeh>
X-ME-Received: <xmr:ywNyaccFIf9ICgjiOHur0C6mfHs8JJ7nKifyLNsrLdnxLugNYOPk_WZm1V3Z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeehleelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:ywNyaW_b3M7CGP5YJV-lA1nY7Mhd1VhbXWtcZ2JT0hjvrWel2BCm_A>
    <xmx:ywNyacNHIliccWhdSwZOUOUO2mOM7AnVyHfK_ZQlwtjqwrHzOF-F7Q>
    <xmx:ywNyaUVX8PYwONznTnStfm50WoRFexvhTqUjvAkZOFGLbCZHCAtAFA>
    <xmx:ywNyacjlD_i-QMmxxAUgq4SyU0Dk5qtz73JF4RSmdHESCvrQWJz08w>
    <xmx:zANyaYpDVGh-vzeP8MtJh1cL389z8hYvqH2eYS_TlEfpJoey1xxQNJoM>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jan 2026 06:02:34 -0500 (EST)
Date: Thu, 22 Jan 2026 12:02:32 +0100
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
Message-ID: <aXIDyPMOvU1fEYDs@krikkit>
References: <20260120092137.2161162-1-mmyangfl@gmail.com>
 <20260121111635.GA447040@shredder>
 <aXELAazPe7G5M6am@krikkit>
 <20260122080043.GA547381@shredder>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260122080043.GA547381@shredder>

2026-01-22, 10:00:43 +0200, Ido Schimmel wrote:
> On Wed, Jan 21, 2026 at 06:21:05PM +0100, Sabrina Dubroca wrote:
> > No direct instances using memcpy, but do we need to also full structs
> > copied within a u64_stats_fetch_begin/u64_stats_fetch_retry loop?
> 
> My understanding is that we cannot rely on the compiler to perform the
> copy in any particular way. With the suggested helper it is at least
> clear how the copy is done.

Ok, thanks. So those (and a few more similar things in drivers/net)
should also be switched to this new helper.

-- 
Sabrina
