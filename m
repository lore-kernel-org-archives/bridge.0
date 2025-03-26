Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2957C2475E3
	for <bridge@lists.linux.dev>; Wed, 26 Mar 2025 18:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743013487; cv=none; b=HF4PcYlDLPIif16oozAUXU5vgh7VzqOfkwYJpyKuycL+F+vLOohHljHgW0OYt8dZQ3W5X1EjlWphtAtndpAwAIgrrZ7iocNwIGQ+aMxNjsg2wpmj8zITAeX/vS1bEOVOrkLVEHHYTkc2v1m4GFvg4Vv2lRWSgYoo1AC2ZedSSXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743013487; c=relaxed/simple;
	bh=1UhRK95LP8hqlPseMawABnpT11GCkmJwEaKCs8WEWW8=;
	h=Message-ID:From:To:Cc:Subject:Date; b=NeWL5eVTsFtZXPYFni3LNP6h5Mxd/z+TBIPlGPJ7rgewrq3t01CtIC3zOuUV885cGlewjR2uyk5aZkIpqKTxXNp5JlbnndxjmYJ0Fr6kqtRPkYSyceaB8/rmvBYVcf/ovX4u7plG360se37b6BiWG+w3HyQuNgupmEy/OPdPCi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=cIrnw/1V; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="cIrnw/1V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1743013479; bh=h7q4/X5vEb/MoGY6Kon60isqwwB6JHPQYp8IebAK9+8=;
	h=From:To:Cc:Subject:Date;
	b=cIrnw/1VeAq0sZMgcX/7I4mKflDOPqnQPj//bodgqph8BNTtR7rBguxZh4hmX09XY
	 ylNHcXwMPwVr030XqzBQCUlcxrv1gCw7rp3sxbOCIGIlzO/MoaDUfpvIn2XOXbq32R
	 FoJvStWjNk/hNYZprmFxnPpnY36Z6SvEBLoLWqaU=
Received: from localhost.localdomain ([111.19.95.140])
	by newxmesmtplogicsvrszgpua8-1.qq.com (NewEsmtp) with SMTP
	id 2D7030FB; Thu, 27 Mar 2025 02:11:23 +0800
X-QQ-mid: xmsmtpt1743012683tr4silwsz
Message-ID: <tencent_4B358ADB8A54F04A32CD9933114B8B383606@qq.com>
X-QQ-XMAILINFO: NtvpdyJXE1j9rTsJZGXp36RuJGdcd4cfQo+bmpS4rT6vnuQaugyzqnOI+uNC8s
	 KxTx0gzAHsEdaqPze4ZGJ/OgIHedjsd+uWRzOtbnoKAaCIn5n/8Rb0E+AhRpjcAL1VsFehcFMia3
	 FbbKRi8STTb2kDybragRDljfgu/PCle3JheOJit+g/y8GiulBfmOMCyIj4vrExNsfwVSJbeHAFkK
	 ssVK+7JUIg09otzF3zBO1lsExNGlx5tiySzuXmWmMz+t/gD4gparwAGb+CJSNX1LshCa81FbKnY4
	 v7rJnmjzcv8BONfOqcztsMxmOdutoFn3gXljX6NA7aH+GZ1TiRVzf87gaYYCcubKGSEvvpGPhlhL
	 devgtzi/Rz0fmu/M4BKX3Q7eIhol/8A2F5hJOx4WDHpr3Q68Rg7TOn2VN69bUz1z5MMhR483Mtcv
	 /xjpnaf31CZYa76k2jUXVHm/GBj6M9hajhOszKCJz1gMbg+FkqHaG9TQMvCS/zkIun+tAse7usgD
	 9sn0NaqtVgY/fWA1daKpZAiK/BYz1Ii8Az14YlVb4s0DEqNhoq8On+aEH9b2+h/TdZar+pMu98oo
	 HWIBi7dChmiJouDyJvB93Qwb7AG5j5yWjvWkTjt32cv+DdNlOe7E4s8xIDSg1u81kCoYxeApAepL
	 rJ2gLLtLVmvWpunfQD4BooC8fPNU07W9bftztKFffvhAvn6QV7kJXBHossg3xpCkOKtvGMxss7gh
	 /tZwtBE/UgWlTt3qT/kFrQpJl98cV2XcfwqKLm95B3HNEZawMlNafL0BeDjeiq+D6IE3msMinRhw
	 RdBkbcSSq5YwLWi2iyCBjc8z0ja+pLGrGq7kr38mJz6hSqPSXbOqWNFqhBcIeStsSmYw++Oh7Lse
	 D8kgICXJ4hw1v4RnBhIA0I02X/6rsH0qO+dFMGzylArGSOnV2FdpoTTd5lv7B0lk1+DLUx0lB0Ri
	 NBy8iRxgZu28ztIp7E9DyvmssSaGJm
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: inuc@qq.com
To: bridge@lists.linux.dev
Cc: netdev@vger.kernel.org,
	roopa@nvidia.com,
	razor@blackwall.org,
	Liu Jie <inuc@qq.com>
Subject: [PATCH] net: bridge: set skb->protocol for 802.1Q VLAN packets
Date: Thu, 27 Mar 2025 02:11:17 +0800
X-OQ-MSGID: <20250326181117.15513-1-inuc@qq.com>
X-Mailer: git-send-email 2.16.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>

From: Liu Jie <inuc@qq.com>

When bridging locally originated VLAN-tagged packets, we must ensure
skb->protocol is properly set to ETH_P_8021Q. Currently, if this field
remains unset, br_allowed_ingress() may incorrectly drop valid VLAN
packets during the bridge transmission path.

Fix this by explicitly checking eth_hdr(skb)->h_proto for VLAN tags when
handling locally generated packets.

Signed-off-by: Liu Jie <inuc@qq.com>
---
 net/bridge/br_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 0ab4613aa..9094ba7e4 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -63,6 +63,9 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 	skb_reset_mac_header(skb);
 	skb_pull(skb, ETH_HLEN);
 
+	if (eth_hdr(skb)->h_proto == htons(ETH_P_8021Q))
+		skb->protocol = htons(ETH_P_8021Q);
+
 	if (!br_allowed_ingress(br, br_vlan_group_rcu(br), skb, &vid,
 				&state, &vlan))
 		goto out;
-- 
2.17.1

