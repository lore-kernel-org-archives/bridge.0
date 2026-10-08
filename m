Received: from out28-100.mail.aliyun.com (out28-100.mail.aliyun.com [115.124.28.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C821F16B
	for <bridge@lists.linux.dev>; Thu,  8 Oct 2026 02:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791427873; cv=none; b=O8FExRoz8eFTjHlnp1yxSRB39jfF9kErR8hGE48AUaknrVcXfTcM3upmdoOp4giIHsvMNz5FmPq1ZyXMnS1NiHoRqJpJGGnCbmZ9ctVtNv5uPqFxIQlcC8h5uYFMdGLwIa0fdsOdq69T/j+E0dlwMCtbZpgTgteOwnESXOsEw08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791427873; c=relaxed/simple;
	bh=UfDhaCDDMm7kAZVIqt+mVGPSLmZKVM6WAVVA2x99/M8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4dfp4CUUb0YH9orCyY5nouH+Uhy5m7pGAd+9EWOeuARCYQdmxxJnuDezJyTZlPY4ssHWER+bmuOH2yrsmxG1pCvYRSdw6013DbfdVqboLzcpRUJMc4R4yVlFnCUKIpDwMPJY0MgtE54cISGRkq40/djfs4dNaTdTo8nm8Qt2Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=XewzCZei; arc=none smtp.client-ip=115.124.28.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="XewzCZei"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1791427868; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=lI1GALVEJrn/SwrfBIlIqj+oyWhvCwuNikjGXJLM/cc=;
	b=XewzCZeiwX7ibuKc/eXBw6zrL15o12gvlkYdziGQ2QQp/0oXz1ejTrfY0WiiP26CNGvd8rIlXklAEIEn3nio5kRelmmoyj7AmZdQrHLWDfPqd5MyCOgbxb6yRizpdBL9dpFTVdoj8Ay5bY0tdgjbVOBnI4vSDYeZX1WYhospB1c=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08667126|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.141551-0.00588351-0.852565;FP=18319517013567864945|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032053168;MF=guozh23@xiaopeng.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.jWKvv6R_1791427549;
Received: from localhost(mailfrom:guozh23@xiaopeng.com fp:SMTPD_---.jWKvv6R_1791427549 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 08 Oct 2026 10:45:50 +0800
From: Guo Zihao <guozh23@xiaopeng.com>
To: netdev-bot+sashiko@kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfilter: ebtables: ebt_802_3: drop short frames before the match reads LLC
Date: Thu,  8 Oct 2026 10:45:49 +0800
Message-ID: <20261008024549.4115339-1-guozh23@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <179077865471.434549.9648522947578914338@kernel.org>
References: <179077865471.434549.9648522947578914338@kernel.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Thanks for the review. All five findings check out against the source,
and I have posted v2 addressing them:

https://lore.kernel.org/netdev/20261008024539.4106699-1-guozh23@xiaopeng.com/

Point by point:

[High] skb_header_pointer() negative offset. Agreed, and I was wrong to
doubt __skb_header_pointer() in v1. v2 now uses

    skb_header_pointer(skb, skb_mac_offset(skb), hlen, &_frame)

which covers paged frames as well, instead of my hand-rolled linear-only
check.

[High] The abs(mac_offset) threshold was inconsistent across hooks.
Gone with skb_header_pointer(); the requirement is now expressed as
"bytes from the mac header" and follows whatever the hook did to the
mac header, including the br_send_bpdu() path where mac_offset is 0.

[High] hotdrop silently ignored by ebtables legacy. The match now
returns false instead, the ebt_stp_mt() pattern, so legacy ebtables and
nftables agree again. The commit message also points users who want such
frames dropped at a plain "--802_3 -j DROP" rule rather than hiding a
drop inside a SAP/TYPE check.

[Medium] Reading 23 bytes for a SAP-only rule. v2 reads only
offsetof(struct ebt_802_3_hdr, llc.ui.ctrl) = 16 bytes unless a TYPE
constraint is set, so a 21-byte topology change BPDU still matches
"--802_3 --802_3-sap 0x42 -j ACCEPT" like it did before (the union type
and the control byte are only needed for the TYPE match).

[Low] Fixes tag. v2 carries

    Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

pw-bot: cr

Guo Zihao
