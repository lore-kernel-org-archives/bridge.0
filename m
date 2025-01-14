Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553FC212D70
	for <bridge@lists.linux.dev>; Tue, 14 Jan 2025 01:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736818775; cv=none; b=Gn3IOZ+P9+H1fa7sK2xeYVSP9XSd7bDZBiL5J3KaJFkF3ZGRRg5MCBLQb5dKAKyey1enpAz6wZAPJBJj40hUBf1n4rfITx1P6wuyKO0fPyKXwypvERusZ14HKDSEputmbhBIx5IunD2q0ej73UijughRkUAPq6bqqAPvcqljazI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736818775; c=relaxed/simple;
	bh=fvsXsSG3rvQldIY/85wzJ0AHdohJOHv8n5QAPKehmcM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DiqVNV7VfOo+9yVWhGe3xbwyrLrmex0Ez7ljioPbXrDaETbjUsogfXd9K07CIny2mJy437Kdd37GPPuV7JV/xQS7WduHOjnb8BqkhFozZvob9vb4lr0RSK6TBZmVIlaByUn7DOLmgjnIfYXzVmN7cwlqswIn2ZSyDkbviXNeopU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ulYOiJrG; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ulYOiJrG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736818773; x=1768354773;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0cedPuJPQkStIGe+OXyB1F52+EDOiClOdRu6CBFc8ew=;
  b=ulYOiJrGfwLLIQlaC5df0p8qTUHookFX4E1EVMGeB2zzuJEaXCcr3ywE
   pYgIAgWxZ7gAWt33PfS6ikic9TiKNRKx6wyF+zm+AVwOTILNPavNIM1Jr
   M8k8dFUxwxE0txLTiPla8I/1/5NfNhICw449qbzjF7h/dePAirdXDZhAo
   g=;
X-IronPort-AV: E=Sophos;i="6.12,312,1728950400"; 
   d="scan'208";a="458589578"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 01:39:28 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:58030]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.236:2525] with esmtp (Farcaster)
 id 86aea7c8-dd91-44b2-aaf7-7a7eff52786e; Tue, 14 Jan 2025 01:39:28 +0000 (UTC)
X-Farcaster-Flow-ID: 86aea7c8-dd91-44b2-aaf7-7a7eff52786e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 14 Jan 2025 01:39:27 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.11.99) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 14 Jan 2025 01:39:19 +0000
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
Subject: Re: [PATCH net-next v8 01/11] rtnetlink: Lookup device in target netns when creating link
Date: Tue, 14 Jan 2025 10:39:09 +0900
Message-ID: <20250114013909.7102-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250113143719.7948-2-shaw.leon@gmail.com>
References: <20250113143719.7948-2-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA004.ant.amazon.com (10.13.139.91) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Xiao Liang <shaw.leon@gmail.com>
Date: Mon, 13 Jan 2025 22:37:09 +0800
> When creating link, lookup for existing device in target net namespace
> instead of current one.
> For example, two links created by:
> 
>   # ip link add dummy1 type dummy
>   # ip link add netns ns1 dummy1 type dummy
> 
> should have no conflict since they are in different namespaces.
> 
> Signed-off-by: Xiao Liang <shaw.leon@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
