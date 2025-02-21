Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317CB288D2
	for <bridge@lists.linux.dev>; Fri, 21 Feb 2025 04:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740111146; cv=none; b=rH6Tufi+aM0hlw5BIB5iUTrDUeV+g2AZWkcAbyRC1SEWlz41qdqrdNCOZmXJAtFLqyXAdM4qFOUReKgYdb3Sw4QIP5LGVAiuWkA9p4WVZd0jzQIRZhfwxRGSk5jWF2QS15b7p3mxZEGLekc1cGt5ke2ZgvoqAku7fo3S1LE8AH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740111146; c=relaxed/simple;
	bh=9eFro1cZSR7h6W4E0c7vvZc5M0AlGe832eUs6PbfLJ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G65a3/2v1ZrKdOOMqQlRWPzroOLlybrrdXC37KY/4pjOPimd5isYZ/WphAejaM6oJQQg3KgZvjSEEnZqmthNU/22BlxsYP+OaC9ui+tc6/urPoZrQ5Sy19Adt3hhrZT9cEX7SxeFVeoKOLTz9I0AaHH8XmdzidKR7/ZqNQXR8TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=b17h5X5T; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="b17h5X5T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740111145; x=1771647145;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YzTaMIXfTQW5u2lkanlpdTtaryhWFAt2zcKLntOoUF0=;
  b=b17h5X5TLTwN2CXvtMPce/YS6k+gvNeGb+R3MawOs1TZDvvPk++jDUoA
   jtCZmDqTqq1ahPDqfwSsIyXKTMcsG9/N4fcECrGwEBy4iJlvqE3TPrLSc
   C6R7KafF3xfjY0Fc47/13/72yhpO+2HpI4Xy0Ajt6BcHWCkkyjT15TDrG
   4=;
X-IronPort-AV: E=Sophos;i="6.13,303,1732579200"; 
   d="scan'208";a="464524007"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 04:12:20 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:45617]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.186:2525] with esmtp (Farcaster)
 id f7b7ed86-b5d1-4be4-9e7b-55d4fb0bed97; Fri, 21 Feb 2025 04:12:14 +0000 (UTC)
X-Farcaster-Flow-ID: f7b7ed86-b5d1-4be4-9e7b-55d4fb0bed97
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 21 Feb 2025 04:12:08 +0000
Received: from 6c7e67bfbae3.amazon.com (10.135.209.63) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Feb 2025 04:12:03 +0000
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
Subject: Re: [PATCH net-next v10 10/13] rtnetlink: Remove "net" from newlink params
Date: Thu, 20 Feb 2025 20:11:54 -0800
Message-ID: <20250221041155.78502-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250219125039.18024-11-shaw.leon@gmail.com>
References: <20250219125039.18024-11-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA003.ant.amazon.com (10.13.139.44) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Xiao Liang <shaw.leon@gmail.com>
Date: Wed, 19 Feb 2025 20:50:36 +0800
> Now that devices have been converted to use the specific netns instead
> of ambiguous "net", let's remove it from newlink parameters.
> 
> Signed-off-by: Xiao Liang <shaw.leon@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
