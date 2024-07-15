Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E414D79C4
	for <bridge@lists.linux.dev>; Mon, 15 Jul 2024 02:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721011934; cv=none; b=CNySSp//KfOzCm3UcHD7EGjQ1EiK8kLGZkF4LOSvDQXNTTVQ9jw7cZuRHegqJIX8ALKK2LOMvqy5gwgT7bmONjInz7E2WeXqSCNbmlEQOQv2Lf5w3fh6r4rl1nXTBO/H6dl6lfaqGNIGEVPOQJK+9iB39wd4jkiSbrwHlCNKzr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721011934; c=relaxed/simple;
	bh=X4Zat/Y0hsdoDe5Svj/icJkSVmFXQVcN6YIDamtiEFs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qIu1qj7vsuCkhLkvE08AZmhhVvLWSWxw11M7tYpQnvDqnnJoKTnzWTC25kl4LVHg83A2YrPgDueTDtmikrgBprnHBvbM8zg0sOd8EA3Gb63CwqviV7+9W3020+bddWl74VWeasaaZKxR+kfIVbVCzz5I4XnZFo6/5uKtZHS53Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowAD3_1vRjpRm23TOFQ--.12132S2;
	Mon, 15 Jul 2024 10:52:01 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: roopa@nvidia.com,
	razor@blackwall.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] net: bridge: remove unnecessary cast from netdev_priv()
Date: Mon, 15 Jul 2024 10:44:57 +0800
Message-Id: <20240715024457.3743560-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAD3_1vRjpRm23TOFQ--.12132S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr13ZryDWF1UXF4fCryxuFg_yoW8JFWfpa
	4UGan3AF47Xw1Ygw48ZFWUAry3tFn5KrW3Gr12y34Fvrn3tFy0kFWktryUCr1rAF4Dur13
	Jr12gF1Syw1DZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7Cj
	xVA2Y2ka0xkIwI1lc2xSY4AK67AK6r4UMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VU1UGYJUUUUU==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Remove unnecessary cast of void * returned by netdev_priv().

Fixes: 928990631327 ("net: bridge: add notifications for the bridge dev on vlan change")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 net/bridge/br_netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index f17dbac7d828..d02cc1497281 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1085,7 +1085,7 @@ static int br_setport(struct net_bridge_port *p, struct nlattr *tb[],
 int br_setlink(struct net_device *dev, struct nlmsghdr *nlh, u16 flags,
 	       struct netlink_ext_ack *extack)
 {
-	struct net_bridge *br = (struct net_bridge *)netdev_priv(dev);
+	struct net_bridge *br = netdev_priv(dev);
 	struct nlattr *tb[IFLA_BRPORT_MAX + 1];
 	struct net_bridge_port *p;
 	struct nlattr *protinfo;
@@ -1143,7 +1143,7 @@ int br_setlink(struct net_device *dev, struct nlmsghdr *nlh, u16 flags,
 /* Delete port information */
 int br_dellink(struct net_device *dev, struct nlmsghdr *nlh, u16 flags)
 {
-	struct net_bridge *br = (struct net_bridge *)netdev_priv(dev);
+	struct net_bridge *br = netdev_priv(dev);
 	struct net_bridge_port *p;
 	struct nlattr *afspec;
 	bool changed = false;
-- 
2.25.1

