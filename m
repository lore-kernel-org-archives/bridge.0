Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3993254A3;
	Wed,  6 May 2026 22:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778105159; cv=none; b=lK9rcro9/i9FzjjurM3GsOpqVqpfmcrLukT6MfUWtdP1hwg5oYFvG3+r3k3EHCBBbUxcQpuUCt4KNqr5SVK48uxIKI+BGeGOI7K1eJnxO1R06aWM7OCkDLsCaevYIpXsfoS1+ic4ka3zZOo9f5nJFlGUk0T5YWr0xVQjSV+AmU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778105159; c=relaxed/simple;
	bh=7F24RCSEGcHNBqpTUjBOLIoqOUalOAHE3T0rlCEnNYU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dCdxnY1z/MWwvvVXhqFJF7jbyvBq4wRA6rFxOWipFX/OtEysTcL7EPAYcVko31napJ42E13J7VeU63Iv+ZqX9ckxd/6s8Oih18+Hw+uoGc2lDKbKQo+cBZ7kI2WmkX2o4tefthft3wQwbkj3A3j5sztdSnwyYddEyqaqnaFarYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbROPbMe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbROPbMe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B49C2BCB0;
	Wed,  6 May 2026 22:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778105158;
	bh=7F24RCSEGcHNBqpTUjBOLIoqOUalOAHE3T0rlCEnNYU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RbROPbMeWGL0lt9IywQ+7IHYW65nBivjEU6qbICNhPyZePCMHTfvo+V65VKi66H5h
	 S7Jpfo1wJnrmeGHrcBZj6N+SbdN06IDq6lxj/r/9J1jIiVt0wRtc2tywWBmcJ1qlnx
	 90tdoXcst+7YQf/xl6//aSBCPk5X2xirTC5gNFLzF/TbkYvtIQEV9TRpBRqNJ9xjLw
	 183YLqSa00CI9DwwKgRYzNQ3DHRf1bazXpAxhaA93Y2TuyKobGITQYxXIXASwv7urK
	 nY23UNAaOzdGNpzqklo44UzKwOdLG+GWvI0cNCtzHelXukrwglm/GT0cwsSUdCJRJD
	 fAzWBuawRxRpQ==
Date: Wed, 6 May 2026 15:05:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: Ido Schimmel <idosch@nvidia.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "donald.hunter@gmail.com"
 <donald.hunter@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
 "razor@blackwall.org" <razor@blackwall.org>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "shuah@kernel.org" <shuah@kernel.org>,
 "ast@fiberby.net" <ast@fiberby.net>, "liuhangbin@gmail.com"
 <liuhangbin@gmail.com>, "daniel@iogearbox.net" <daniel@iogearbox.net>, Andy
 Roulin <aroulin@nvidia.com>, "fmaurer@redhat.com" <fmaurer@redhat.com>,
 "sdf.kernel@gmail.com" <sdf.kernel@gmail.com>, "sd@queasysnail.net"
 <sd@queasysnail.net>, "kees@kernel.org" <kees@kernel.org>,
 "nickgarlis@gmail.com" <nickgarlis@gmail.com>, "amorenoz@redhat.com"
 <amorenoz@redhat.com>, "alasdair@mcwilliam.dev" <alasdair@mcwilliam.dev>,
 "johannes.wiesboeck@aisec.fraunhofer.de"
 <johannes.wiesboeck@aisec.fraunhofer.de>, Petr Machata <petrm@nvidia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bridge@lists.linux.dev" <bridge@lists.linux.dev>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 1/6] bridge: uapi: Add neigh_forward_grat
 netlink attributes
Message-ID: <20260506150556.4e540854@kernel.org>
In-Reply-To: <DM6PR12MB45167562767CFC70DA9AE8D0D83F2@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20260503073532.2138165-1-danieller@nvidia.com>
	<20260503073532.2138165-2-danieller@nvidia.com>
	<20260505190044.0608dfb1@kernel.org>
	<20260506070334.GA617302@shredder>
	<DM6PR12MB45167562767CFC70DA9AE8D0D83F2@DM6PR12MB4516.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 May 2026 08:31:01 +0000 Danielle Ratson wrote:
> > > I think this should be u8 ? neigh-vlan-suppress looks buggy too  
> > 
> > I pointed this out during internal review, but assumed I am missing something
> > since almost all the attributes use flag when they are in fact u8. We can fix  
> 
> This is in fact the reason why I also changed it myself to use flag before sending.
> 
> > neigh-forward-grat to use u8 in v2 and change the rest in net. To be clear, I
> > believe the following should be converted from flag to u8:
> > 
> > mode, guard, protect, fast-leave, learning, unicast-flood, proxyarp, learning-
> > sync, proxyarp-wifi, mcast-flood, mcast-to-ucast, vlan-tunnel, bcast-flood,
> > neigh-suppress, isolated, mrp-ring-open, mrp-in-open, locked, mab, neigh-
> > vlan-suppress
> 
> So should we proceed as Ido suggested?

I think so. Tweak this patch and send a separate fix to net for the
existing attrs.

> > > flag is a type without a payload, the presence of the attr is the
> > > entire information
> > >
> > > None of the AIs seem to catch this, I think you may have over-split
> > > this submission a little bit. This patch may have been better off
> > > squashed into patch 4 ?  
> 
> It seems like the patch has enough content, but I can squash. I guess
> ill split the commit between patches 4 and 5 accordingly.

Could be my lack of familiarity with bridge but FWIW reading the
submission it felt like it was split by "area of code" rather than
logical steps. Splitting work into patches is a bit of an art..

> > Related: The AI also did not catch that the spec was missing (easy
> > to forget for rtnetlink). Do you think it's worth adding to
> > review-prompts?  

I assumed Sashiko missed this because it doesn't spent too much time on
the series as a whole right now (I was going to tweak that but looks
like Claude is having another meltdown, crazy inference latency,
patches backlogging for review..)

Are you saying that the review prompts-based test is also not catching
this even if you give it the range of commits that form the series?
