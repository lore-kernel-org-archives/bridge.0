Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC05B17836B
	for <bridge@lists.linux.dev>; Thu, 19 Dec 2024 16:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734626182; cv=none; b=p9/QWE2JZBJ7yhQAgxraELML78E/Wk41Hkj5DEB93ftSYzLD55s7nUmeDGVHlA0OPswG8QnsnGKzRWR5UmKTDAMDUN+B0WygohJgoSg0Td/pSQR9mEkmFMWzOpcMIG4mNHSfLRAM1Cn65NpVQlfxCdFC0M0yMFkobManlXwcvjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734626182; c=relaxed/simple;
	bh=ZNQIE+krTV9MH9Ngy5qFgSz4pB24tAflC36G+yYs6PM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qky3vl6Dz5uiSRHLcJmCwasgDGu04cXEoaxh84wlwBgdK8Og7VNzOFjIueKDK4oS0owiwFfMcfyC0fVLnpiDjyxWXRXEOtm55ll4uajoTd8dUPimIn/jC6TFW40KCP/5Vn7JGzf+DjD0yGaak5WF8++XLTGgbx7crZbk9mXNt9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dVFj+F3m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dVFj+F3m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734626179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=i1OnVpyPx1+KI2UG1wOwvTzwNitObp5Vh/G2hC41IKo=;
	b=dVFj+F3mYvtTuupwE65OLXUVwqMPsFCPVAsYoCAeOw9sU4pzdOrOUk0bYBZVyDIU0FLZnN
	Ot6ePtxPxHesRMsRarhgaMYTi5Qf3YaFtf/aUeBK11XO0aBT96rujd9bNKx431eA4rnsnl
	cR+aUkEiY/WRHrLYu/mZlyVnSbWs/0M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-435-Fu8r_77zMsu-t0tfUE8Kew-1; Thu,
 19 Dec 2024 11:36:18 -0500
X-MC-Unique: Fu8r_77zMsu-t0tfUE8Kew-1
X-Mimecast-MFC-AGG-ID: Fu8r_77zMsu-t0tfUE8Kew
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 55B9E19560BD;
	Thu, 19 Dec 2024 16:36:16 +0000 (UTC)
Received: from thinkpad-p1.localdomain.com (unknown [10.22.81.102])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E7DC319560AD;
	Thu, 19 Dec 2024 16:36:13 +0000 (UTC)
From: Radu Rendec <rrendec@redhat.com>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@idosch.org>,
	Roopa Prabhu <roopa@nvidia.com>
Cc: bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH net-next v3 0/2] net/bridge: Add skb drop reasons to the most common drop points
Date: Thu, 19 Dec 2024 11:36:04 -0500
Message-ID: <20241219163606.717758-1-rrendec@redhat.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The bridge input code may drop frames for various reasons and at various
points in the ingress handling logic. Currently kfree_skb() is used
everywhere, and therefore no drop reason is specified. Add drop reasons
to the most common drop points.

The purpose of this series is to address the most common drop points on
the bridge ingress path. It does not exhaustively add drop reasons to
the entire bridge code. The intention here is to incrementally add drop
reasons to the rest of the bridge code in follow up patches.

Most of the skb drop points that are addressed in this series can be
easily tested by sending crafted packets. The diagram below shows a
simple test configuration, and some examples using `packit`(*) are
also included. The bridge is set up with STP disabled.
(*) https://github.com/resurrecting-open-source-projects/packit

The following changes were *not* tested:
* SKB_DROP_REASON_NOMEM in br_flood(). It's not easy to trigger an OOM
  condition for testing purposes, while everything else works correctly.
* All drop reasons in br_multicast_flood(). I could not find an easy way
  to make a crafted packet get there.
* SKB_DROP_REASON_BRIDGE_INGRESS_STP_STATE in br_handle_frame_finish()
  when the port state is BR_STATE_DISABLED, because in that case the
  frame is already dropped in the switch/case block at the end of
  br_handle_frame().

    +-------+
    |  br0  |
    +---+---+
        |
    +---+---+  veth pair  +-------+
    | veth0 +-------------+ xeth0 |
    +-------+             +-------+

SKB_DROP_REASON_MAC_INVALID_SOURCE - br_handle_frame()
packit -t UDP -s 192.168.0.1 -d 192.168.0.2 -S 8000 -D 8000 \
  -e 01:22:33:44:55:66 -E aa:bb:cc:dd:ee:ff -c 1 \
  -p '0x de ad be ef' -i xeth0

SKB_DROP_REASON_MAC_IEEE_MAC_CONTROL - br_handle_frame()
packit -t UDP -s 192.168.0.1 -d 192.168.0.2 -S 8000 -D 8000 \
  -e 02:22:33:44:55:66 -E 01:80:c2:00:00:01 -c 1 \
  -p '0x de ad be ef' -i xeth0

SKB_DROP_REASON_BRIDGE_INGRESS_STP_STATE - br_handle_frame()
bridge link set dev veth0 state 0 # disabled
packit -t UDP -s 192.168.0.1 -d 192.168.0.2 -S 8000 -D 8000 \
  -e 02:22:33:44:55:66 -E aa:bb:cc:dd:ee:ff -c 1 \
  -p '0x de ad be ef' -i xeth0

SKB_DROP_REASON_BRIDGE_INGRESS_STP_STATE - br_handle_frame_finish()
bridge link set dev veth0 state 2 # learning
packit -t UDP -s 192.168.0.1 -d 192.168.0.2 -S 8000 -D 8000 \
  -e 02:22:33:44:55:66 -E aa:bb:cc:dd:ee:ff -c 1 \
  -p '0x de ad be ef' -i xeth0

SKB_DROP_REASON_NO_TX_TARGET - br_flood()
packit -t UDP -s 192.168.0.1 -d 192.168.0.2 -S 8000 -D 8000 \
  -e 02:22:33:44:55:66 -E aa:bb:cc:dd:ee:ff -c 1 \
  -p '0x de ad be ef' -i xeth0

Changes since v2:
- Minor update to the description of SKB_DROP_REASON_NO_TX_TARGET.
- Do not trigger a warning in br_flood() and br_multicast_flood() if
  maybe_deliver() returns a different error than -ENOMEM.
- Keep the error path consolidated in br_handle_frame_finish() and
  br_handle_frame(), and use a `reason` variable.

Changes since v1:
- Add patch #1, which makes it possible to reuse the existing
  SKB_DROP_REASON_VXLAN_NO_REMOTE drop reason from vxlan in the bridge
  module, where a similar drop case exists.
- Don't add SKB_DROP_REASON_BRIDGE_NO_EGRESS_PORT. Instead, use either
  SKB_DROP_REASON_NO_TX_TARGET or SKB_DROP_REASON_NOMEM, depending on
  the case.
- For better clarity, rename SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD to
  SKB_DROP_REASON_BRIDGE_INGRESS_STP_STATE.

Radu Rendec (2):
  net: vxlan: rename SKB_DROP_REASON_VXLAN_NO_REMOTE
  net: bridge: add skb drop reasons to the most common drop points

 drivers/net/vxlan/vxlan_core.c |  4 ++--
 drivers/net/vxlan/vxlan_mdb.c  |  2 +-
 include/net/dropreason-core.h  | 18 +++++++++++++++---
 net/bridge/br_forward.c        | 16 ++++++++++++----
 net/bridge/br_input.c          | 20 +++++++++++++++-----
 5 files changed, 45 insertions(+), 15 deletions(-)

-- 
2.47.1

