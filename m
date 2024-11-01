Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C3A14265F
	for <bridge@lists.linux-foundation.org>; Fri,  1 Nov 2024 16:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730478389; cv=none; b=d2Du9gLYZbevS825d8MbBFDuB+PEz0zoe+WVSoE0mPB3TUzl331joF63jCZo75c7vtATxNr/8+rpSIqwHh/el91e3rOjMA0UwpLJitR0RgYkk0yQYqBCCHfj1seA8uK9G3PFoR9FEX4PZcy4PsXb6LxnMUOCQvRsmf36KJfI68Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730478389; c=relaxed/simple;
	bh=6a1dZSp9HvKtLL61oi/0+jzB9aOQa/17P7GLTEW2QBg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qmcYPSawOcFYBmFBKDg+PJa8YfRj88XTXYqah+5T5zu6ujnDTVedoI17TJoLTp5wl5PgRYWhAlZwOMnUeexc1nBApniPCI8VACG9YviE7TCgZ3iXD2FjB1NlkAITdNWy3QkC8QmvrtJvGIXqNyfxEtsGyQTzlz19/ZJH8A4SIWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 868BB40BBF
	for <bridge@lists.linux-foundation.org>; Fri,  1 Nov 2024 16:26:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -6.289
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VdYywJSU2r1d for <bridge@lists.linux-foundation.org>;
 Fri,  1 Nov 2024 16:26:25 +0000 (UTC)
X-Greylist: delayed 4702 seconds by postgrey-1.37 at util1.osuosl.org; Fri, 01 Nov 2024 16:26:24 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 66EA040B53
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 66EA040B53
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.166.238; helo=mx0a-0064b401.pphosted.com; envelope-from=prvs=1035e1bbb5=randy.macleod@windriver.com; receiver=<UNKNOWN> 
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 66EA040B53
	for <bridge@lists.linux-foundation.org>; Fri,  1 Nov 2024 16:26:24 +0000 (UTC)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A18rZut032555;
	Fri, 1 Nov 2024 08:07:49 -0700
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42mew213k8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 01 Nov 2024 08:07:49 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 1 Nov 2024 08:07:48 -0700
Received: from pop-os.wrs.com (172.25.44.6) by ala-exchng01.corp.ad.wrs.com
 (147.11.82.252) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 1 Nov 2024 08:07:47 -0700
From: <Randy.MacLeod@windriver.com>
To: <stable@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <sashal@kernel.org>
CC: <sherry.yang@oracle.com>, <bridge@lists.linux-foundation.org>,
        <davem@davemloft.net>, <kuba@kernel.org>, <netdev@vger.kernel.org>,
        <nikolay@nvidia.com>, <roopa@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <randy.macleod@windriver.com>
Subject: [PATCH 1/1: 5.10/5.15] net: bridge: xmit: make sure we have at least eth header len bytes
Date: Fri, 1 Nov 2024 11:07:45 -0400
Message-ID: <20241101150745.3671416-2-Randy.MacLeod@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241101150745.3671416-1-Randy.MacLeod@windriver.com>
References: <20241101150745.3671416-1-Randy.MacLeod@windriver.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 6_PsvydZLq400R8lmhL0uJb2o0wSTisC
X-Authority-Analysis: v=2.4 cv=dLb0m/Zb c=1 sm=1 tr=0 ts=6724eec5 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=eMPNgDwjIQXpT8XC:21 a=VlfZXiiP6vEA:10 a=t7CeM3EgAAAA:8 a=hSkVLCK3AAAA:8 a=edf1wS77AAAA:8 a=IJ2IFIBGmV0-FWXsoRQA:9
 a=FdTzh2GWekK77mhwV6Dw:22 a=cQPPKAXgyycSBL8etih5:22 a=DcSpbTIhAlouE1Uv7lRv:22
X-Proofpoint-ORIG-GUID: 6_PsvydZLq400R8lmhL0uJb2o0wSTisC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-01_09,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 mlxlogscore=999 suspectscore=0
 phishscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411010109

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
index d3ea9d0779fb..84e37108c6b5 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -36,6 +36,11 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
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

