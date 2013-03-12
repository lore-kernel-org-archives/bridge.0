Return-Path: <silviupopescu1990@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:from:to:cc:subject:date:message-id:x-mailer;
	bh=Y7WbPuQ35jqn38WN1ZvX/3LuHf6HlnAASJ4b8bLP+vo=;
	b=jCsiUyY7Ibjb4jLUt6/JS3DMceymkO1zuX19sIgCSmtZFSrs9BP6e5Er6yGCTsSCHe
	CRDacw+xOvshM6DnOipHWpPAF3KPBdAv1CJx+7bJ/IB44rff+NS33CnnpD0lIb3Fj3H+
	KcjPDxHv+P4rKYYfvTvN/lTmo+JX5XgakSrqaS2E/cHQ6DHXUSWgzfOhxXhOLBI9n80S
	vLlypg3zR2pmWhsMazjpoUvZpuSzeXsbMVZCjIlDgHbl4rQ2Ao7OvIQUVxJ/mhorYJIV
	G6In3bAjD8684MKWXExHOhUor8ALQF0h53j1JuNLuozYrETdZ/c6FFtsd9frCo/6UTqw
	MStQ==
From: Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
Date: Tue, 12 Mar 2013 20:11:33 +0200
Message-Id: <1363111893-25146-1-git-send-email-silviupopescu1990@gmail.com>
Subject: [Bridge] [PATCH] bridge: netfilter: use PTR_RET instead of IS_ERR +
	PTR_ERR
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netfilter-devel@vger.kernel.org
Cc: coreteam@netfilter.org, Silviu-Mihai Popescu <silviupopescu1990@gmail.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, davem@davemloft.net, stephen@networkplumber.org, netfilter@vger.kernel.org, bart.de.schuymer@pandora.be, kaber@trash.net, pablo@netfilter.org

This uses PTR_RET instead of IS_ERR and PTR_ERR in order to increase
readability.

Signed-off-by: Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
---
 net/bridge/netfilter/ebtable_broute.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/bridge/netfilter/ebtable_broute.c b/net/bridge/netfilter/ebtable_broute.c
index 40d8258..70f656c 100644
--- a/net/bridge/netfilter/ebtable_broute.c
+++ b/net/bridge/netfilter/ebtable_broute.c
@@ -64,9 +64,7 @@ static int ebt_broute(struct sk_buff *skb)
 static int __net_init broute_net_init(struct net *net)
 {
 	net->xt.broute_table = ebt_register_table(net, &broute_table);
-	if (IS_ERR(net->xt.broute_table))
-		return PTR_ERR(net->xt.broute_table);
-	return 0;
+	return PTR_RET(net->xt.broute_table);
 }
 
 static void __net_exit broute_net_exit(struct net *net)
-- 
1.7.9.5

