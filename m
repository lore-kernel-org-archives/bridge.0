Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70B820FA85
	for <bridge@lists.linux.dev>; Thu, 13 Feb 2025 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739444430; cv=none; b=eSF3Vi9W0beuGQOqhR1A8TN0djBxixI/G73qdgwBeAvNwETXvlFwSMm/b8XmMls3oCoTHN0q7SXJ2DphZuk6E8d1Czu9XZ/uO2gww4auhPZunKdukdvBeOSFdldVz92XmwShWHEgG1GkQ8AC3KAyHgvN9LndFYhqOMWhLp8ZNug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739444430; c=relaxed/simple;
	bh=yt4q0aiydpz/xrX8H61gkGQoaptx4FvmQGKDE/dCBJI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OHMwDsPiIcx7RHO2TrD1rANDwTLeTAF9Zjy9n5MCEYRMfckf+5+au1rqxWe30mqaEjYVe//3UyAvHQDzxlNM1hNE/e3VNTvutiSMA3Cl2340ClnERP2xyDQYrUfmZiZ82VXH+rMr4FHrexFZSBV7A8TH4ANamllqBPJ5z/rBRHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=R82/HQrL; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="R82/HQrL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739444429; x=1770980429;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x6a76+cOw96XPtQyXhpo63qOZBEMTvYTLb5LP/CLpRQ=;
  b=R82/HQrLtUh6W51x1swIKV0mPrQMJaL8zVH9ZYQp4GwboTBhKjIVMTdk
   /a5p6ASKj8NymuXJnrOLcJoKek21ha1Qn9YC1HTPyRoJuwI4swY61IQog
   4DIIufDIxzvRst0ACMlRGzKUXLRS5wHM60b+wEF8EEYYD1Z+eqq6QtrCX
   0=;
X-IronPort-AV: E=Sophos;i="6.13,282,1732579200"; 
   d="scan'208";a="270835605"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 11:00:25 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:61563]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.208:2525] with esmtp (Farcaster)
 id 84cbae71-03ca-491c-8392-66d89dbb8c97; Thu, 13 Feb 2025 11:00:24 +0000 (UTC)
X-Farcaster-Flow-ID: 84cbae71-03ca-491c-8392-66d89dbb8c97
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 13 Feb 2025 11:00:24 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Feb 2025 11:00:14 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <shaw.leon@gmail.com>
CC: <alex.aring@gmail.com>, <andrew+netdev@lunn.ch>,
	<b.a.t.m.a.n@lists.open-mesh.org>, <bpf@vger.kernel.org>,
	<bridge@lists.linux.dev>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
	<dsahern@kernel.org>, <edumazet@google.com>, <herbert@gondor.apana.org.au>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-ppp@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
	<linux-wpan@vger.kernel.org>, <miquel.raynal@bootlin.com>,
	<netdev@vger.kernel.org>, <osmocom-net-gprs@lists.osmocom.org>,
	<pabeni@redhat.com>, <shuah@kernel.org>, <stefan@datenfreihafen.org>,
	<steffen.klassert@secunet.com>, <wireguard@lists.zx2c4.com>
Subject: Re: [PATCH net-next v9 06/11] net: ipv6: Use link netns in newlink() of rtnl_link_ops
Date: Thu, 13 Feb 2025 20:00:04 +0900
Message-ID: <20250213110004.38415-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <CABAhCORgi7Jqu=Aigs6Fc8ewG5OshFvcunye03R43C+Z0ojZyw@mail.gmail.com>
References: <CABAhCORgi7Jqu=Aigs6Fc8ewG5OshFvcunye03R43C+Z0ojZyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D040UWA003.ant.amazon.com (10.13.139.6) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Xiao Liang <shaw.leon@gmail.com>
Date: Thu, 13 Feb 2025 17:55:32 +0800
> On Thu, Feb 13, 2025 at 4:37 PM Xiao Liang <shaw.leon@gmail.com> wrote:
> >
> > On Thu, Feb 13, 2025 at 3:05 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> > >
> > [...]
> > > > diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> > > > index 863852abe8ea..108600dc716f 100644
> > > > --- a/net/ipv6/ip6_gre.c
> > > > +++ b/net/ipv6/ip6_gre.c
> > > > @@ -1498,7 +1498,8 @@ static int ip6gre_tunnel_init_common(struct net_device *dev)
> > > >       tunnel = netdev_priv(dev);
> > > >
> > > >       tunnel->dev = dev;
> > > > -     tunnel->net = dev_net(dev);
> > > > +     if (!tunnel->net)
> > > > +             tunnel->net = dev_net(dev);
> > >
> > > Same question as patch 5 for here and other parts.
> > > Do we need this check and assignment ?
> > >
> > > ip6gre_newlink_common
> > > -> nt->net = dev_net(dev)
> > > -> register_netdevice
> > >   -> ndo_init / ip6gre_tunnel_init()
> > >     -> ip6gre_tunnel_init_common
> > >       -> tunnel->net = dev_net(dev)
> >
> > Will remove this line.
> 
> However, fb tunnel of ip6_tunnel, ip6_vti and sit can have
> tunnel->net == NULL here. Take ip6_tunnel for example:
> 
> ip6_tnl_init_net()
>     -> ip6_fb_tnl_dev_init()
>     -> register_netdev()
>         -> register_netdevice()
>             -> ip6_tnl_dev_init()
> 
> This code path (including ip6_fb_tnl_dev_init()) doesn't set
> tunnel->net. But for ip6_gre, ip6gre_fb_tunnel_init() does.

Ah, okay.  Then, let's set net in a single place, which would
be better than spreading net assignment and adding null check
in ->ndo_init(), and maybe apply the same to IPv4 tunnels ?
