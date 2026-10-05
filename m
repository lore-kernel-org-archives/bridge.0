Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24AA30D41D
	for <bridge@lists.linux.dev>; Mon,  5 Oct 2026 04:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791175115; cv=none; b=CGnuNeir/qhFrgR5iEZgVWIA4zgDMWxwqiqWr7YMKpmU5q4g+PWZQKSO9ssdkumd9/2EN9Lw4P6abt3ulEMBMkp32SZel/swBHi23XhpSiB59CqrYsplrQNV1x+pkQEf3Fd/bkLAzljhwHuakt+otQoGE4G2SrWQnJewcAjXW5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791175115; c=relaxed/simple;
	bh=WL8BkZfBmynsOQljiOg3YEkZaeHg1x9r1zprVn1fyHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rZxQE2rYtjbWnzIH1/qkFqdcWeD1nLr+U8IDK9v2znwdtKHVE5xVZqxqlJtlXzw5tSpOUw2eHtdKiATiU5DQ/LPOK6VgKMKWYRKdxmYRjZN6fzdhZ5jcKLvOfjfRFVewmz8anqvyA8XaDdfxZbsY8SDJd8IyFA/eEClHnS40+w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3TubxV3; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3TubxV3"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-35120d43ecaso1724466eec.1
        for <bridge@lists.linux.dev>; Sun, 04 Oct 2026 21:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791175113; x=1791779913; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IQ+LmaGpGiijcsTJ1qk0sHsM2h6jT0RkKgmxLE6xfsI=;
        b=i3TubxV33h+L3/peEz2jViYv6uG3gIzlYq167ifW90mUeoR7ym3siCr6Ulrz/KLAG2
         uTARLR0hQCkOhMaDyLB9PMBcOHOm4k+IapSzyhuWlSu2ClRJ30JQKLVcxNmW2xvXEbrb
         569b2EM8HgwTvrdmlLBleR7HnjDAdmEsFKY9It+hE3YBG3oPS6ybQr+W9gWi91j6WE2e
         0z874TR5Nf/b5vYgbMBrIxUmXDwyB/s4ktr9GOh9Xge1VWAKsctfdeaoUTXHXFLl1Rm1
         NrQIr/EFyHskmHAKRX8KstkIGA20TlS8StCk88KrCO6BaxFz1vQIJ22EHRPndL4vPc7C
         IVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791175113; x=1791779913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IQ+LmaGpGiijcsTJ1qk0sHsM2h6jT0RkKgmxLE6xfsI=;
        b=StwKCeJ6gxxRGvTpOicWNQQlliNqfMNC16xhUuhHEbcFryVutE9cq/IC0hrX011Vkg
         cW2y+GjGehRUsf92ZtTWpdOKcH9LMnUiLqT50dmHPlQCIN68L+xEQGfOxyOhhxGjNwN1
         gTFYoS6asWvSdM7Tw4S0d+i4qmsOeVUbAzegfsF/RIt0tXYBB0YszLkbwrHB9Ui61zym
         FxAit4DgkZQE7M9qJDF+mULZf0xFxkIT4Bl3NSD9JwsmcdyaffJyl9WQTPMnrPMswI1n
         nLpvOgtiLGnWqHNu9H2HjQMHz4JbS/8KGgPAz1NUo7JtxdahzjYIoYrw3BMd3gZlJzDR
         G4HA==
X-Forwarded-Encrypted: i=1; AKwUvBw/5W2NCFLEUR5z8O5DtLUs5dpcR6dQFV4nsh4mYIqPWCY+/m3/WeWYH/d6JN8g+VH/T+SQh0o=@lists.linux.dev
X-Gm-Message-State: AFq9FYI+H+B7IBgdF7jfm59w9gTkw8w9eEK65+4l9Wm26Ut2n8tMKI+p
	15gOvQYCaQiUJ+d9xmQlD4hbXXDAvoFhr2MkL2zm75VbffyeJ/or1inb
X-Gm-Gg: AYBFou2z/Iqk8C1KQPK+/s4qmDCAtwi+Y2/k7QyWCt2n+57IkXBqwNNaH12F1IBWwkL
	Vg2YEDThOzZImf8nEsfKeYziOR+x6DxsGNmtkYDFLLLxPIREQpPPk0eQJWLNaSZcbGFwO/n7Z1i
	QMUwWMO1PPWBcuwgVcRp7UcnPVHOy3GrL6cf0kWjLFcAswgLf7jFTdjTNEQxqO+AwOVz/SiyZHZ
	ZI7XBwZztmKW2xB1dAThW/tBCx20cLQKxmDGPJxYYb+alpBSUzuDygDE4uJ2Y5J5ZHO87Fssodt
	Gv32XxYiqn4kmftLjVMYx7liX3Hc5tI4PSM/xlUG3lDyB0sIPfYwqLFeYVtFMhqQMiSZZX/VYEh
	1kmPHM7sO5zm59MawwxFAvZx5w2BUTafYy2MlMFMBEDn4+VyJdb/5lhjlcLKsDKI23XLj9zbxqH
	oIeTtGOOEafw5khYGy96YzD4EKGf/SEeDoVCRRwduENJby3BSOvpHr0KIKOqI5FnJgHgnqoaA6Y
	IrTYenCHsox+VmDHHo=
X-Received: by 2002:a05:7301:182e:b0:345:84eb:7153 with SMTP id 5a478bee46e88-351113bfd63mr8233346eec.11.1791175112963;
        Sun, 04 Oct 2026 21:38:32 -0700 (PDT)
Received: from vscode-11-19.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35127136b8esm9518581eec.6.2026.10.04.21.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 21:38:32 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: netdev@vger.kernel.org
Cc: razor@blackwall.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	horatiu.vultur@microchip.com,
	bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/3] net: bridge: cfm: count CFM config attributes in the link message size
Date: Mon,  5 Oct 2026 04:38:20 +0000
Message-ID: <20261005043822.3106580-2-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005043822.3106580-1-w453y.me@gmail.com>
References: <20261005043822.3106580-1-w453y.me@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

br_get_link_af_size_filtered() only counts the CFM attributes when
RTEXT_FILTER_CFM_STATUS is set. With RTEXT_FILTER_CFM_CONFIG alone it
returns before counting anything, while br_fill_ifinfo() still writes
the whole config, about 250 bytes per MEP and 20 per peer MEP.

Dumps cope with that, they just get a bigger buffer. A message built by
br_info_notify() can't, it fails with -EMSGSIZE and hits the WARN_ON
there. No notification asks for the CFM config today, but the next
patch adds one.

Count the config attributes when RTEXT_FILTER_CFM_CONFIG is set.

Signed-off-by: Abdul Wasey <w453y.me@gmail.com>
---
 net/bridge/br_netlink.c | 42 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index f65b8b6ca..5160e801d 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -90,6 +90,36 @@ static int br_get_num_vlan_infos(struct net_bridge_vlan_group *vg,
 	return num_vlans;
 }
 
+static size_t br_cfm_config_info_size(u32 num_meps, u32 num_peer_meps)
+{
+	size_t mep_sz, peer_sz;
+
+	/* IFLA_BRIDGE_CFM_MEP_CREATE_INFO: instance, domain, direction,
+	 * ifindex
+	 */
+	mep_sz = nla_total_size(4 * nla_total_size(sizeof(u32)));
+	/* IFLA_BRIDGE_CFM_MEP_CONFIG_INFO: instance, unicast mac, mdlevel,
+	 * mepid
+	 */
+	mep_sz += nla_total_size(3 * nla_total_size(sizeof(u32)) +
+				 nla_total_size(ETH_ALEN));
+	/* IFLA_BRIDGE_CFM_CC_CONFIG_INFO: instance, enable, interval, maid */
+	mep_sz += nla_total_size(3 * nla_total_size(sizeof(u32)) +
+				 nla_total_size(CFM_MAID_LENGTH));
+	/* IFLA_BRIDGE_CFM_CC_RDI_INFO: instance, rdi */
+	mep_sz += nla_total_size(2 * nla_total_size(sizeof(u32)));
+	/* IFLA_BRIDGE_CFM_CC_CCM_TX_INFO: instance, dmac, seq no update,
+	 * period, if tlv, if tlv value, port tlv, port tlv value
+	 */
+	mep_sz += nla_total_size(5 * nla_total_size(sizeof(u32)) +
+				 nla_total_size(ETH_ALEN) +
+				 2 * nla_total_size(sizeof(u8)));
+	/* IFLA_BRIDGE_CFM_CC_PEER_MEP_INFO: instance, peer mepid */
+	peer_sz = nla_total_size(2 * nla_total_size(sizeof(u32)));
+
+	return num_meps * mep_sz + num_peer_meps * peer_sz;
+}
+
 static size_t br_get_link_af_size_filtered(const struct net_device *dev,
 					   u32 filter_mask)
 {
@@ -122,17 +152,25 @@ static size_t br_get_link_af_size_filtered(const struct net_device *dev,
 	if (p && vg && (filter_mask & RTEXT_FILTER_MST))
 		vinfo_sz += br_mst_info_size(vg);
 
-	if (!(filter_mask & RTEXT_FILTER_CFM_STATUS))
+	if (!(filter_mask & (RTEXT_FILTER_CFM_CONFIG | RTEXT_FILTER_CFM_STATUS)))
 		return vinfo_sz;
 
 	if (!br)
 		return vinfo_sz;
 
-	/* CFM status info must be added */
 	br_cfm_mep_count(br, &num_cfm_mep_infos);
 	br_cfm_peer_mep_count(br, &num_cfm_peer_mep_infos);
 
 	vinfo_sz += nla_total_size(0);	/* IFLA_BRIDGE_CFM */
+
+	if (filter_mask & RTEXT_FILTER_CFM_CONFIG)
+		vinfo_sz += br_cfm_config_info_size(num_cfm_mep_infos,
+						    num_cfm_peer_mep_infos);
+
+	if (!(filter_mask & RTEXT_FILTER_CFM_STATUS))
+		return vinfo_sz;
+
+	/* CFM status info must be added */
 	/* For each status struct the MEP instance (u32) is added */
 	/* MEP instance (u32) + br_cfm_mep_status */
 	vinfo_sz += num_cfm_mep_infos *
-- 
2.53.0

