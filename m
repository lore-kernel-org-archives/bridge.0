Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A026EAF6
	for <bridge@lists.linux.dev>; Sun, 22 Dec 2024 08:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734855204; cv=none; b=SSiIfelwBBWetDQFSyE+cS+gx+NV+nC8U8ouhFi6wUqT89BCh5f7tAW3QIKHW0LnKPXpNJf3utX+VCBq1njU4ANPusXG64j7o4a9o7NyaTefNc9TR2XiY+ckNYjtgWDWlvynddaX0WUDSPVF83PNoGeUQSshHDcOKbLliQ03/FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734855204; c=relaxed/simple;
	bh=Vx0ax2oFojTi+CNBs+p80924fcBt4WJuRA2ihV+IpPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VIa8RxJ+ygSA+6Q4Ktc4f5uhnbWiQH+w+sSRFdQm7Pd2TrYCMJL+pEUjUTBPVWbzAA/5mIOGZymt4Xb+tU1ySlzUuhzX00nFAwBMiIZKHef0V+BB8fTa+S/AnfXWr2vfJwxl/z5tX/IxMA71VruXRi8gg/C8oPHPWS5yNTKVh6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fc4T1ojH; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fc4T1ojH"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 2157A1140185;
	Sun, 22 Dec 2024 03:13:21 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sun, 22 Dec 2024 03:13:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1734855200; x=1734941600; bh=P9RbmwcYCik4r1DP06JkXU3Lr41Zo8Kq402
	asrEahaY=; b=Fc4T1ojHUsJT48d8zP83PDxG5PyY4CtIMAojQEwLsWom31CF+D7
	Q5NPyLJiCM/oI6+Tb+R/2J5pvhsvwaoaKYE35Y3QpQzQ8OzXHZwYM/9zR68i3VsI
	4XI9XHZKSD347wxH0OBRtw73FLgu7YF4tBsZfvF8niFXeDKJCs1v8ABlAVHkgKfp
	m3BBChZh0nFt3eU77rC6ChMkJP/nY7qpjnDRjxwijiS+Ah0Fq6S8bkjJWA2YCWCE
	JQlHZv0nCmoc906Hw1mHoH+gVRhOdTUowQPat46hR3qytJVeJcpVfX9zml3YEr2k
	dgFvqMO0TabrziBxINGnLp5HxH7f2ID7YIQ==
X-ME-Sender: <xms:IMpnZ33CnYwmg2-j-bqYig_o2lcel1nzjXO9V0eZnA6tswcey6Mf5g>
    <xme:IMpnZ2E5GpX4tCUsllftaJ6BT6I_47nzKj90Mxf0CiuU5c03xdIx2pMsVOj3hz8XL
    CiEHKHpO-M1eao>
X-ME-Received: <xmr:IMpnZ37sgwbQ-08tZAY2tTsRze-Aa_yVxA9Nji_dVJedYPUaxW64oP-CaUyY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtjedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdroh
    hrgheqnecuggftrfgrthhtvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieef
    gfelkeehgeelgeejjeeggefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrghdpnhgspghrtghpthht
    ohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrrhgvnhguvggtsehrvg
    guhhgrthdrtghomhdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhg
    pdhrtghpthhtoheprhhoohhprgesnhhvihguihgrrdgtohhmpdhrtghpthhtohepsghrih
    gughgvsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepnhgvthguvghvsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthho
    pehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgoh
    hoghhlvgdrtghomh
X-ME-Proxy: <xmx:IMpnZ81RsNlptXErR1yqqYMrOKwZUlH9THfamkXcx7foURC19MmKdw>
    <xmx:IMpnZ6HG0IQ0VtMp2CDQPg1-tDCT_FcJEOJQ6G1xc7jtWvJVPgHZcw>
    <xmx:IMpnZ9_Uq1qaYQw5L65XxSAyeD40ftKfC1UDy4-voHXE8BHa5FG10g>
    <xmx:IMpnZ3mOmw4F0uOQxL64-0F-_9X-NKk7kTMNCjF9fyz2uevT4BkauQ>
    <xmx:IMpnZ9B_YbRlTH8FMPZlowtWbYbzSAejANB2iSKN7cF6nwgWlyQuJ_Ik>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Dec 2024 03:13:19 -0500 (EST)
Date: Sun, 22 Dec 2024 10:13:17 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Radu Rendec <rrendec@redhat.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Roopa Prabhu <roopa@nvidia.com>, bridge@lists.linux.dev,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next v3 1/2] net: vxlan: rename
 SKB_DROP_REASON_VXLAN_NO_REMOTE
Message-ID: <Z2fKHbXg0TLYD4k7@shredder>
References: <20241219163606.717758-1-rrendec@redhat.com>
 <20241219163606.717758-2-rrendec@redhat.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219163606.717758-2-rrendec@redhat.com>

On Thu, Dec 19, 2024 at 11:36:05AM -0500, Radu Rendec wrote:
> The SKB_DROP_REASON_VXLAN_NO_REMOTE skb drop reason was introduced in
> the specific context of vxlan. As it turns out, there are similar cases
> when a packet needs to be dropped in other parts of the network stack,
> such as the bridge module.
> 
> Rename SKB_DROP_REASON_VXLAN_NO_REMOTE and give it a more generic name,
> so that it can be used in other parts of the network stack. This is not
> a functional change, and the numeric value of the drop reason even
> remains unchanged.
> 
> Signed-off-by: Radu Rendec <rrendec@redhat.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
