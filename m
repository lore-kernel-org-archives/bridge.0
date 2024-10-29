Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25857208992
	for <bridge@lists.linux-foundation.org>; Tue, 29 Oct 2024 21:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730238897; cv=none; b=oGmSC/awwYxGzuVYuJAmqPq5/WpnWOKUbvfNTR7tOr7ccSs+sTIl3n+3xTwEThEVVKINJwJuRykH+qXKzeYYYO7yLFHea5G60g7qEvy8egGG7vWe3L5GCWj8zFSHenAkavzD0nfjusWpTb75mdFH+xE6haK0lt58UZEUGL95OfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730238897; c=relaxed/simple;
	bh=0Hmfu0Dmd+ONojT8fbkDPeqhboxJBVmLmMSWyx58uPM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cQw9NWBh82UQkqOfapBCzVaRH3ac0Lcx+0bOS0my1nKNb7bMSrOFajz5tzzr6P1SLJ23/o1hXGOjkA3M64kkQrAAOpZZbZJ2dh4ycy5YAKKwNzmjo3DSDor8CwLc9Fogddq+jHyXfhXJrlgJtupM4KFx4Ll6iOT0POCRQjDwhGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AD2B7605B1
	for <bridge@lists.linux-foundation.org>; Tue, 29 Oct 2024 21:54:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -6.289
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mTlsGOPuskyZ for <bridge@lists.linux-foundation.org>;
 Tue, 29 Oct 2024 21:54:54 +0000 (UTC)
X-Greylist: delayed 2412 seconds by postgrey-1.37 at util1.osuosl.org; Tue, 29 Oct 2024 21:54:54 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 66F3360728
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 66F3360728
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.178.238; helo=mx0b-0064b401.pphosted.com; envelope-from=prvs=10322c57c5=randy.macleod@windriver.com; receiver=<UNKNOWN> 
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 66F3360728
	for <bridge@lists.linux-foundation.org>; Tue, 29 Oct 2024 21:54:54 +0000 (UTC)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49THNuUr024976;
	Tue, 29 Oct 2024 21:14:29 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42gqd8m43p-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 29 Oct 2024 21:14:29 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 14:14:28 -0700
Received: from pop-os.wrs.com (172.25.44.6) by ala-exchng01.corp.ad.wrs.com
 (147.11.82.252) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 29 Oct 2024 14:14:27 -0700
From: <Randy.MacLeod@windriver.com>
To: <sherry.yang@oracle.com>
CC: <bridge@lists.linux-foundation.org>, <davem@davemloft.net>,
        <gregkh@linuxfoundation.org>, <kuba@kernel.org>,
        <netdev@vger.kernel.org>, <nikolay@nvidia.com>, <roopa@nvidia.com>,
        <sashal@kernel.org>, <stable@vger.kernel.org>,
        <randy.macleod@windriver.com>
Subject: [PATCH 5.15.y] net: bridge: xmit: make sure we have at least eth header len bytes
Date: Tue, 29 Oct 2024 17:14:26 -0400
Message-ID: <20241029211426.3046219-1-Randy.MacLeod@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241004170328.10819-3-sherry.yang@oracle.com>
References: <20241004170328.10819-3-sherry.yang@oracle.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: I5g67KRVeGwd-XnB4L0ZUcMFU6Y4VrpW
X-Authority-Analysis: v=2.4 cv=dKj0m/Zb c=1 sm=1 tr=0 ts=67215035 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=eMPNgDwjIQXpT8XC:21 a=DAUX931o1VcA:10 a=t7CeM3EgAAAA:8 a=hSkVLCK3AAAA:8 a=edf1wS77AAAA:8 a=IJ2IFIBGmV0-FWXsoRQA:9
 a=FdTzh2GWekK77mhwV6Dw:22 a=cQPPKAXgyycSBL8etih5:22 a=DcSpbTIhAlouE1Uv7lRv:22
X-Proofpoint-GUID: I5g67KRVeGwd-XnB4L0ZUcMFU6Y4VrpW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_16,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1011
 spamscore=0 mlxscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2410290159

From: Randy MacLeod <Randy.MacLeod@windriver.com>

[ Upstream commit 8bd67ebb50c0145fd2ca8681ab65eb7e8cde1afc ]

Based on above commit but simplified since pskb_may_pull_reason()
does not exist until 6.1.

syzbot triggered an uninit value[1] error in bridge device's xmit path
by sending a short (less than ETH_HLEN bytes) skb. To fix it check if
we can actually pull that amount instead of assuming.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+a63a1f6a062033cf0f40@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a63a1f6a062033cf0f40
Signed-off-by: Randy MacLeod <Randy.MacLeod@windriver.com>
---
 net/bridge/br_device.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 8d6bab244c4a..b2fa4ca28102 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -38,6 +38,11 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 	const unsigned char *dest;
 	u16 vid = 0;
 
+	if (unlikely(!pskb_may_pull(skb, ETH_HLEN))) {
+		kfree_skb(skb);
+		return NETDEV_TX_OK;
+	}
+
 	memset(skb->cb, 0, sizeof(struct br_input_skb_cb));
 
 	rcu_read_lock();
-- 
2.34.1

