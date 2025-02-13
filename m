Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA102046BD
	for <bridge@lists.linux.dev>; Thu, 13 Feb 2025 05:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739425760; cv=none; b=MNzWVKBdDobxgSimVyCv5QEbW0mL9oL2rYamKQwscQkcD2FACgEk1zotZO2IT0+HZmLOtEHSuRB3Z4Z4T8E7/FX2dwRBRVGCUH9ykXikC8KSCTFoxvhyqnHugmfqmNJJczXJGr3bljAPwiU/WfmEnizSUtUELW/A44v8mAsy1cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739425760; c=relaxed/simple;
	bh=JZO8hTv+tJW2aK5aBTAN6q5T0bbD7q/X0NgiV9zstAE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tpXAFrmXgNy38Uch5Z6LA1vh4HHk4IYLi2bTFR1d66mNgTiFcB8cqYd1aDNyEQztU2FbW4H58GAZjqa/DaJHdk8UvAJzffPP/PELxLWb+FyhqQ3Wibd6CuQpwc65q8MKOg+l2JnWqc0FmqQmLM1LGZbuCtmh9ZhOA17FJq/dAfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=tfevQMuh; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="tfevQMuh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739425759; x=1770961759;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2H6L2IVdEyIK/cEvvFHgSWxdXbDY3pM4JrV+qKQ3oRc=;
  b=tfevQMuhUgtCb9dkBIA+Mge0MmoryFBT4daPY6PSB3V76P/zAMVpBQNR
   DuO6OEBG47UC0exqxtCw385IMR07qe2YLmXE2cvkiBoVKorPDetyi0Kpm
   tPnM7Ye4ETznKun7zT7Ntu/oDYN3iwPKXgbZ6RVPnThsH10RVyrbsvh5p
   k=;
X-IronPort-AV: E=Sophos;i="6.13,282,1732579200"; 
   d="scan'208";a="471752672"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 05:49:13 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:24405]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.136:2525] with esmtp (Farcaster)
 id 4661396c-a15f-4263-9318-13d4ea54af5c; Thu, 13 Feb 2025 05:49:12 +0000 (UTC)
X-Farcaster-Flow-ID: 4661396c-a15f-4263-9318-13d4ea54af5c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 13 Feb 2025 05:49:12 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Feb 2025 05:49:03 +0000
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
Subject: Re: [PATCH net-next v9 04/11] ieee802154: 6lowpan: Validate link netns in newlink() of rtnl_link_ops
Date: Thu, 13 Feb 2025 14:48:53 +0900
Message-ID: <20250213054853.285-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250210133002.883422-5-shaw.leon@gmail.com>
References: <20250210133002.883422-5-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA004.ant.amazon.com (10.13.139.109) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Xiao Liang <shaw.leon@gmail.com>
Date: Mon, 10 Feb 2025 21:29:55 +0800
> Device denoted by IFLA_LINK is in link_net (IFLA_LINK_NETNSID) or
> source netns by design, but 6lowpan uses dev_net.
> 
> Note dev->netns_local is set to true and currently link_net is
> implemented via a netns change. These together effectively reject
> IFLA_LINK_NETNSID.
> 
> This patch adds a validation to ensure link_net is either NULL or
> identical to dev_net. Thus it would be fine to continue using dev_net
> when rtnetlink core begins to create devices directly in target netns.
> 
> Signed-off-by: Xiao Liang <shaw.leon@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
