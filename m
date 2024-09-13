Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388FF1465A1
	for <bridge@lists.linux.dev>; Fri, 13 Sep 2024 19:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726254215; cv=none; b=ZDCieb6PFoWhv+h2Hotr4EwdV5i0FBrmMtKGduutAWgg+93ZDZDW9oiC9D1vxFqSV92st4Q7iYm9AtJzgFnaspFOucZ46llUx0qSyge+02mFbNB22wjc6+QZw51HWngNl+0OjuEiiqiL/HGOZmNemsDVGQv+QponxJJnwNL7XUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726254215; c=relaxed/simple;
	bh=uPPKn2uf1nbEAXnGBv89AKKcDRtw0kMo25WfEJUlpWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CoNHragx9v0ouuTcF9D5TcN8zx7wuORoo1UyY98aHJFYiUBZbKIdHxOAyltlxfsxKNeWJSQj9DkJkbtqfYC4OdTE+hDOhd7mBjWuZ5LWAwoeEorOyA8xguHzBRB0BxkW9i960NWxBsIn7PF62TFqkEhlX3rgsDDlgsyd/1bj3hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EuXBxbjp; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuXBxbjp"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8a7dddd2aaso28019066b.3
        for <bridge@lists.linux.dev>; Fri, 13 Sep 2024 12:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726254211; x=1726859011; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TBIMwqenBTlQyVFFphBQuwVmjoh+DZcsKHp9ZHR5PXg=;
        b=EuXBxbjpdGofme3Ui+YFWRb/3f5PRm/8N/miTaRiYGug4XtQ9SUsQVlp27wUgtsfyo
         EnDBbPVxCzBQ/727vaM6xlOwbAX8cj+1JsN4wjpQvhN+BAP0Na2VFB0t8lPrpIbWXeAn
         tGOMErUGzOIQFXjelAXufe7RWX8YAw1MtVrq0K93l34nypMNJ2QbM9BwJvCxe9OouAu7
         B31zOhTwChE2MkfVXTXTx1YY/o5RnGHcgzrh+gmMZb0JSqS3pMLvj9vzhOl+Dsvyw3X2
         EmXD6/b/Zat0znIJhNyEIUVn6GDGuW+Vyc4RLNz5HqUmtrIIrAFZSadExVHTc7jyaTK0
         IWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726254211; x=1726859011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBIMwqenBTlQyVFFphBQuwVmjoh+DZcsKHp9ZHR5PXg=;
        b=GSfuOfs4MiFXc9NAnUsWKFIeTECCAfMgBAkazgfe2bBONnYwrDg3hWuOkJokkHPrho
         xg6qey6UpFB3eYTIyiPFwHlFaRd8XMKlM9fUoqhLPh6Xu0YIibiYYJOSR+e1xlM4K9On
         N/dOBoy2ILRYhum3qMQP6KWfc0SJ21Xzah2rPzEN8CxzYZw81zKprhZ0XBwYCYc6QF/L
         aWJ5weZN5fQHmT2Lcm8iGFdkkXpIGyJcpTQrrkxdg20xU9e+ZVYEt8CwNlek0/CqRL7z
         t2FmaR7ejvMoSqHoiid+Ez5DVXHqIBJJaD7gaoLVGpZIHydNEcw6SrEP83MFL288SkTo
         iCog==
X-Forwarded-Encrypted: i=1; AJvYcCXLN1fHbULXGT+6grmvVNo2b1QmsWISy4nN8LfWaek8WOg1OeaP3xXYlVivXSZ1sT5hot+3eAs=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw40aQQ+PoPFkZqmRkykXcEgVwlUteY+2jcno4WheT441ooVRW1
	dRwpxc4v7bVEuQM4gs4ByWTHqjPC3Wat2pWwCbHshi4sPEE+/8Nu
X-Google-Smtp-Source: AGHT+IEFcJdzMYFYOmvlUuhnXhTbuLeCY0FzC6g7bkBjN8v5ZD4dSVxjAxsr9KFndBGPhyGR7ijAZA==
X-Received: by 2002:a17:907:3d8e:b0:a8d:2623:dd19 with SMTP id a640c23a62f3a-a902966809fmr261184066b.14.1726254210706;
        Fri, 13 Sep 2024 12:03:30 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d55709sm901937966b.210.2024.09.13.12.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 12:03:29 -0700 (PDT)
Date: Fri, 13 Sep 2024 22:03:26 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: netdev@vger.kernel.org,
	=?utf-8?B?QXIxbsOnIMOcTkFM?= <arinc.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	linux-mediatek@lists.infradead.org, bridge@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] net: dsa: RCU-protect dsa_ptr in struct net_device
Message-ID: <20240913190326.xv5qkxt7b3sjuroz@skbuf>
References: <20240910130321.337154-1-alexander.sverdlin@siemens.com>
 <20240910130321.337154-2-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910130321.337154-2-alexander.sverdlin@siemens.com>

Hi Alexander,

On Tue, Sep 10, 2024 at 03:03:15PM +0200, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> There are multiple races of zeroing dsa_ptr in struct net_device (on
> shutdown/remove) against asynchronous dereferences all over the net
> code. Widespread pattern is as follows:
> 
> CPU0					CPU1
> if (netdev_uses_dsa())
> 					dev->dsa_ptr = NULL;
>         dev->dsa_ptr->...
> 
> One of the possible crashes:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010
> CPU: 0 PID: 12 Comm: ksoftirqd/0 Tainted: G O 6.1.99+ #1
> pc : lan9303_rcv
> lr : lan9303_rcv
> Call trace:
>  lan9303_rcv
>  dsa_switch_rcv
>  __netif_receive_skb_list_core
>  netif_receive_skb_list_internal
>  napi_gro_receive
>  fec_enet_rx_napi
>  __napi_poll
>  net_rx_action
> ...
> 
> RCU-protect dsa_ptr and use rcu_dereference() or rtnl_dereference()
> depending on the calling context.
> 
> Rename netdev_uses_dsa() into __netdev_uses_dsa_currently()
> (assumes ether RCU or RTNL lock held) and netdev_uses_dsa_currently()
> variants which better reflect the uselessness of the function's
> return value, which becomes outdated right after the call.
> 
> Fixes: ee534378f005 ("net: dsa: fix panic when DSA master device unbinds on shutdown")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> ---
>  drivers/net/dsa/mt7530.c                    |   3 +-
>  drivers/net/dsa/ocelot/felix.c              |   3 +-
>  drivers/net/dsa/qca/qca8k-8xxx.c            |   3 +-
>  drivers/net/ethernet/broadcom/bcmsysport.c  |   8 +-
>  drivers/net/ethernet/mediatek/airoha_eth.c  |   2 +-
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c |  22 +++--
>  drivers/net/ethernet/mediatek/mtk_ppe.c     |  15 ++-
>  include/linux/netdevice.h                   |   2 +-
>  include/net/dsa.h                           |  36 +++++--
>  include/net/dsa_stubs.h                     |   6 +-
>  net/bridge/br_input.c                       |   2 +-
>  net/core/dev.c                              |   3 +-
>  net/core/flow_dissector.c                   |  19 ++--
>  net/dsa/conduit.c                           |  66 ++++++++-----
>  net/dsa/dsa.c                               |  19 ++--
>  net/dsa/port.c                              |   3 +-
>  net/dsa/tag.c                               |   3 +-
>  net/dsa/tag.h                               |  19 ++--
>  net/dsa/tag_8021q.c                         |  10 +-
>  net/dsa/tag_brcm.c                          |   2 +-
>  net/dsa/tag_dsa.c                           |   8 +-
>  net/dsa/tag_qca.c                           |  10 +-
>  net/dsa/tag_sja1105.c                       |  22 +++--
>  net/dsa/user.c                              | 104 +++++++++++---------
>  net/ethernet/eth.c                          |   2 +-
>  25 files changed, 240 insertions(+), 152 deletions(-)

Thank you for the patch, and I would like you to not give up on it, even
if we will go for a different bug fix for 'stable'.

It's just that it makes me a bit uneasy to have this as the bug fix.
"Stable" kernels are supposedly named as such because you're not backporting
such a major usage pattern change from the core down to all switch drivers
and N other Ethernet drivers which you can't even test. The diffstat
here says it all, I believe.

This kind of change, in principle, is okay for an early net-next opening.
I have it in my tree, have made a few changes to it, will run more tests
on the HW I have, and will let you know over the course of the following
weeks when it reaches a stage that I'm also comfortable with.
