Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D1C59155
	for <bridge@lists.linux.dev>; Tue, 30 Jan 2024 09:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706606756; cv=none; b=PDTr2kymRMx/cYTfDd1DNdQKZCghAZPlU2e0g48rnaOVmlJnngGmFV3ytZpCc4O4o6bcfCgqM0DHD/fS+WN1tjzsHFzts/BSVHFgt+vYzHRrPOlfwzCG0ZTVTpCGnErF/0fa/4GBGwhKk6bLrNZmOVeC0ffjEzVhB9lVJtOBBCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706606756; c=relaxed/simple;
	bh=Q1D2Qua3GXjBcUCsDMqOLa6GLF12L1EvbvlN/oSCpQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DuOO8SZUZLOxz6D9xOs0YUW+gY9IG1svwYadJiHcUqzIgQ4escgqrFQ9AEPfT7WznH6j7LrOsKEspm+RsAMv/tg1garf0Hzc/NglbPIi0xWipB74BDZ1Vh80IuP3BAKFwFgdSABRWsTheZUDl7Dw7Tn57zb7hA6pPfeBNVVW2C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0bf179d996444cc293d435d5babfbdee-20240130
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:d687b045-17cd-48e7-8110-96ada6d493ec,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:5
X-CID-INFO: VERSION:1.1.35,REQID:d687b045-17cd-48e7-8110-96ada6d493ec,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-META: VersionHash:5d391d7,CLOUDID:191bea7f-4f93-4875-95e7-8c66ea833d57,B
	ulkID:240130172548ZPLOI4XG,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|44|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 0bf179d996444cc293d435d5babfbdee-20240130
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1661973547; Tue, 30 Jan 2024 17:25:47 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id F413BE000EB9;
	Tue, 30 Jan 2024 17:25:46 +0800 (CST)
X-ns-mid: postfix-65B8C09A-7931421039
Received: from kernel.. (unknown [172.20.15.213])
	by mail.kylinos.cn (NSMail) with ESMTPA id 93986E000EB9;
	Tue, 30 Jan 2024 17:25:43 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: roopa@nvidia.com,
	razor@blackwall.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH net-next] net: bridge: Use KMEM_CACHE instead of kmem_cache_create
Date: Tue, 30 Jan 2024 17:25:36 +0800
Message-Id: <20240130092536.73623-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

commit 0a31bd5f2bbb ("KMEM_CACHE(): simplify slab cache creation")
introduces a new macro.
Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
to simplify the creation of SLAB caches.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 net/bridge/br_fdb.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index c622de5eccd0..c77591e63841 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -35,10 +35,7 @@ static struct kmem_cache *br_fdb_cache __read_mostly;
=20
 int __init br_fdb_init(void)
 {
-	br_fdb_cache =3D kmem_cache_create("bridge_fdb_cache",
-					 sizeof(struct net_bridge_fdb_entry),
-					 0,
-					 SLAB_HWCACHE_ALIGN, NULL);
+	br_fdb_cache =3D KMEM_CACHE(net_bridge_fdb_entry, SLAB_HWCACHE_ALIGN);
 	if (!br_fdb_cache)
 		return -ENOMEM;
=20
--=20
2.39.2

