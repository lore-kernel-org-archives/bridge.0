Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793091154;
	b=1+00hIE2YBPIdrtUAjemf+j4VWRcRcnKUb5/nA/X7J3w6dcLsJ6+M4JtPkZpT55tDtCh
	 VpM32JTCieRmSuR19Oqs5c88t9t/Miyqtsp5J7JJwetVIyGfY4KH17tcSoZG3D3dT/xdN
	 C7EXAOMVuuIAgWVmXl/lkQIlC/L37LV906I3mWQU5TbhELMWvXmB1BnpvwRqtjvjDvDtR
	 DdOPFnO6Ad2clhiL+5mhu9FHS+epuOPotNeS2q1cfZtjA7MCCBzdqr+u+MAu56xQENU2v
	 DTqNXCuJhoRa6w3ZtWc4sKGOtK4R7bJAZFHOx16jHCEINASu8XYChsQJe1Jf3bR9GAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793091154;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=ZvZnWihFbxw483qh4KeYM/1CzNFyVp8lIcdiBtlen3M=;
	b=oSkXGEKVqe9IqemTKTQq9sC5nFS28aJz8pl7F4O883FhUW4IkGQEfjzIxSWivpPXt9gf
	 iX9X2lw3ZIB0/PnpBAeXwRdh4W9/f5DOLIDus4cguEkhIcn7bUi18w5c+hv1k5bJg28Qp
	 HDOWaLdPpTj50fNtMaiWw0shuDy3JsgR3BEozlnpEmpRt8HpBeqlRmlq+LnQW8M0dJMlg
	 DxekuDRtxpUz1zUcHYjIp7R1UXBOR5tMq35i5AsxYFeY1Uk7o5Wmbp0Qmnk0TtBxIwAYm
	 MeGn1X8PXQNBcgvU5qkCZTr9Kmo9rhN2F90UzNXlFpEnLCOhdgJU4lqDG5iR33B5EdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=126.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b="oFA46/Eq";
	arc=none smtp.remote-ip=117.135.210.9
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35787606A321
	for <bridge@lists.linux.dev>; Tue, 27 Oct 2026 08:52:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35787606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=oFA46/Eq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Zv
	ZnWihFbxw483qh4KeYM/1CzNFyVp8lIcdiBtlen3M=; b=oFA46/Eq8QxcasNRIA
	4jWYHtRr1xdc2ztzFZsbbdze6+3AMhxnEPBOWHa93r33KRfGyjWjkFkgGy/E2uxm
	VGIkILhxS8B+T4whXK/Dj1ysdzBXkrCpwW2iSywhw7y7W2qCkxKXYkzsHdMucw8r
	WRmjNh9FbCiZ6x/nLPgtTHb5k=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3H+UzZuBqVA77BA--.59983S2;
	Tue, 27 Oct 2026 16:52:05 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: razor@blackwall.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: [PATCH net] net: bridge: netlink: do not clear the vlan info dump error
Date: Tue, 27 Oct 2026 16:52:00 +0800
Message-Id: <20261027085200.1501599-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H+UzZuBqVA77BA--.59983S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tryUur45tr45GF1xCrWUtwb_yoW8Aw15pF
	4Y9r9xJrWqqay8Kw109F4jqa43ZwnxGFW5CFn2kryIyF90gF1kZFZ5KFZ3Cw1UAF4kJFWY
	v3ZFqr1Yyrn8uFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UlhFsUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlBV5UGrgZjUJcQAA3J

From: Linkui Xiao <xiaolinkui@kylinos.cn>

br_fill_ifinfo() assigns the result of br_fill_vlan_tunnel_info() over
the result of br_fill_ifvlaninfo() or br_fill_ifvlaninfo_compressed()
instead of only running the second helper when the first one succeeded.

When the vlan information no longer fits in the skb but the port has no
vlan mapped to a tunnel dst, br_fill_vlan_tunnel_info() walks the vlan
list and returns 0 without touching the skb. The -EMSGSIZE is lost,
br_fill_ifinfo() completes a message whose IFLA_AF_SPEC is truncated,
and the dump carries on to the next interface instead of stopping, so
userspace silently sees an incomplete vlan list.

Only fill the tunnel information when the vlan information was filled
successfully.

This was flagged as a pre-existing issue in the Sashiko review of the
net-next series, which noted that the VLAN fill result is overwritten
before it is tested (see the Link tag below).

Fixes: efa5356b0d97 ("bridge: per vlan dst_metadata netlink support")
Link: https://lore.kernel.org/bridge/ed1de95e-e112-4076-93f0-6f7668e657ad@blackwall.org/T/#u#5
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 net/bridge/br_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index b2cd4e39326d..8ed86bf71a00 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -540,7 +540,7 @@ static int br_fill_ifinfo(struct sk_buff *skb,
 		else
 			err = br_fill_ifvlaninfo(skb, vg);
 
-		if (port && test_bit(BR_VLAN_TUNNEL_BIT, &port->flags))
+		if (!err && port && test_bit(BR_VLAN_TUNNEL_BIT, &port->flags))
 			err = br_fill_vlan_tunnel_info(skb, vg);
 		rcu_read_unlock();
 		if (err)
-- 
2.25.1

