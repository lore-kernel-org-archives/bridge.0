Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C9533938C
	for <bridge@lists.linux.dev>; Mon, 31 Aug 2026 11:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788176163; cv=none; b=X1cX6MF4Aq6wcwMtS+aYYbey9Po3kYcF4i35TipLWOst/Ai8nXuZbD88KC7xfA4XGRxb0DMcrBgtXz90L2h+76qgleLICTRxr0OmTkyHE+0kOLxhI7XTqmuGhqpKeLuZqhfEwXbB5UGfZW/q0wvd+Ex74552ZpfQsrTwCzdtz/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788176163; c=relaxed/simple;
	bh=upeTNwClNbq9B51NVl8i3ff1vl3WuTSp9/K3a/wxP0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jWQ2SHqNluJg5kZLiLZWiUnpvAUYc/k+paLRTab3LL7KlSmIZn13KyMuN05R1EbrkU3ST1YazoAUIIp2MshibjF/RCKePeD3j1KoJ8FzSlGZi9CDapHoSqV8GRn1+J0UETBmhPy+UXyWAfUuYB+FDiWqT/FluAAuI6yPN1rd/Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pT49vniB; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pT49vniB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=kO
	NEFvotTHHBnWnSbNumpgW0xqS+D7b4+hqKLYLOK8c=; b=pT49vniB6Kp5+x2HCw
	qiCSF8qvnowzPTSSjtbptp8o2l0uKgpvzVvLJF9Ia2SmYDdhjKJGYJvXcUpMVEi3
	fi8rdRmQkF8dIW8eznX4QGkgtTPRxi/tLBv59NbkhaOQ5wcKNd+atJUzJCwtUzHl
	u/rn6AkiMpyHut5nse+XNzAtM=
Received: from WIN-TOG0NDEIICD.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wAnLpjwZpVqCttOSg--.5522S2;
	Mon, 31 Aug 2026 19:35:13 +0800 (CST)
From: Zhao ShiRong <shxzhaosr@163.com>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	bridge@lists.linux.dev,
	Zhao ShiRong <shxzhaosr@163.com>,
	syzbot+128e9f5a0f85a51215b1@syzkaller.appspotmail.com
Subject: [PATCH net] bridge: skip generic XDP on locally re-injected packets
Date: Mon, 31 Aug 2026 19:30:51 +0800
Message-ID: <20260831113051.13072-1-shxzhaosr@163.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnLpjwZpVqCttOSg--.5522S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFWrXr43Gw1UZF17Kw17Wrg_yoW8uFW8pF
	W5KF9xKrWkWr1Fvw4jyF18Zr13Ars3CFW5KFW5C34FvwnxGF4rGr92y34jgay5CFs5Wa1f
	tr1DGr4fWF1DZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRNo7LUUUUU=
X-CM-SenderInfo: hvk06xhdrv2qqrwthudrp/xtbCxhPVFGqVZvPBzwAA3w

Packets locally delivered by the bridge are re-injected into the
receive path via br_pass_frame_up() -> br_netif_receive_skb() ->
netif_receive_skb() with skb->dev set to the bridge device.  If the
bridge device has an XDP program attached, __netif_receive_skb_core()
runs do_xdp_generic() a second time on such packets.

A locally-delivered packet that was allocated on the TX path (e.g. an
MLD packet built by mld_newpack()) does not carry the
XDP_PACKET_HEADROOM that generic XDP requires, so
netif_skb_check_for_xdp() calls pskb_expand_head() and reallocates the
skb head buffer.  This frees the head that the bridge rx path
(br_handle_frame() / br_handle_frame_finish()) is still using, leading
to a use-after-free read in br_handle_frame():

  BUG: KASAN: slab-use-after-free in is_multicast_ether_addr [inline]
  BUG: KASAN: slab-use-after-free in is_valid_ether_addr [inline]
  BUG: KASAN: slab-use-after-free in br_handle_frame+0xcfb/0x1510 net/bridge/br_input.c:349

netif_receive_generic_xdp() already refuses to run generic XDP on
reinjected packets by checking skb_is_redirected().  Reuse that marker:
set it right before the bridge re-injects the packet, so generic XDP is
skipped and the head buffer is left intact.

Reported-by: syzbot+128e9f5a0f85a51215b1@syzkaller.appspotmail.com
Link: https://lore.kernel.org/all/6a6d4406.2d659fcc.1d46f5.01ad.GAE@google.com/T/
Signed-off-by: Zhao ShiRong <shxzhaosr@163.com>
---
 net/bridge/br_input.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -26,6 +26,12 @@ static int
 br_netif_receive_skb(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
 	br_drop_fake_rtable(skb);
+
+	/* Re-injected for local delivery: do not let generic XDP run on the
+	 * bridge device a second time, it could reallocate the head via
+	 * pskb_expand_head() and free a buffer still in use.
+	 */
+	skb_set_redirected_noclear(skb, false);
 	return netif_receive_skb(skb);
 }
 
--
2.43.0

