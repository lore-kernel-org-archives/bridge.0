Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB35F3FE66F
	for <bridge@lists.linux.dev>; Sun,  4 Oct 2026 04:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791087201; cv=none; b=f4s8zxinqWdl/nMu39nZw4P+qf9hcGiF6ha/nLv1CN9WxpAzm4aXuKMKnxMFtWjEVFbJqGalJpZdiBnJKpruFD2PLclKdpTCJgjejau8r4W/nOVxHX/j6U7J2zlo1rN+OYulInhVknW3KsJyfYTipVecS3DzN71AhJBJNPXxslM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791087201; c=relaxed/simple;
	bh=cLyUZfUYFXIzbCAwyOKQyHx4QBFz0Lt+G5rOXM9O4bM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W7ToqnI02+dO3YDIA0iIjwdTvLkTibyMzG753/AENL8PKjAmrRcrxyKXrea2n6fWZVKd9Z5Qb5yAiw0P/zLbAi9HUM8C8kDkf1eo53DN75g8VUXllKpRb9Uf7gETPbPsoL1DkTba9Gy0DrkY+DYM5WGJPlRwgZOeKRfCUmsxvKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+kTniJk; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+kTniJk"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-35129e4607cso6183eec.1
        for <bridge@lists.linux.dev>; Sat, 03 Oct 2026 21:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791087197; x=1791691997; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G6M1WYVkDHa9ex64IkHqpsltatAPllWLtUA7ND2mm+I=;
        b=L+kTniJkxR8HsoQoEokwqJrLS7MsXo44F4flSNvFPTVVUUDPErP4SEq4C71k0Mwday
         aJiAbj7ceY9IAnyNCTRWwBfhUdSNOATq0awn+Hpanj0REgp6RxYZnDdVUBL7ZILkBeED
         ocEWilvT6oYk54LGIiVYSzDzdljAs4HhGa00Yry7hKHYQpCpIUhsLc5NSLBz8ZGqrSAk
         eXmv2gak9pKJsR37oXTPT/E9bDq8FD2SlcMDxzPAZWf2qhMyCumDr0AGHo1FN1mALfK4
         Ij3GPv0lriqakR1RQocn9UccKl8Uffs5+tPF3So1JU3tWr2vmEXGQEUdZ2vT+HVThVoW
         s1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791087197; x=1791691997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G6M1WYVkDHa9ex64IkHqpsltatAPllWLtUA7ND2mm+I=;
        b=M9VFdUq982TPSw09p69J5i3Xrb/QQ3BGok7O4tPom7BAM1jiHL30LXE7Ag+UKKrU/T
         sraALH6ARn98zfc278utGjWoNG2gcdp9yUG/A1fp8vvuAst0SuG9ZisykeGacShGvJBX
         4jeH37vbBiKxR5c1Wk3Vx1ZYCvRKccKPcxoiboQ6Q358FLuVxhNJ6sxc23XqpDEinygv
         JixeQd9S3WK/xz5e8aSXcbc55FCNEpFHNeIkm9k5cnbvwJVkzfmPrPiXusJR4O0YacgA
         SAsijA9EEo0Fj+QfvhSE/bGpdDZHUG2AUg3lCw9dSCTHOZQZPu3pl03wbj+80JyLc4fU
         XpuA==
X-Forwarded-Encrypted: i=1; AKwUvBwb7ER7BUhDv3UaudY77wJ+81nE10c1TGk9SsZhucj9eHBAcjnlcS7wDo0JcGmIwWVJELE3GzE=@lists.linux.dev
X-Gm-Message-State: AFuF++kwBCkb4SbVAPCxBpynA9h1QvvJPBdzvGp3AiuG2kAMQBr25KbR
	fH9oTn/AV4IBHUq2NE3CVQSy72ilErK9szUtXb/1zM0AkVDHA43vS6Iy
X-Gm-Gg: AYBFou0Rg6ICZugVl36YceknGuqkyqQJ8xoaycpz5loxIc67UPT7l9CUQ4A+cYIGvCD
	wMnbpJ2bTmc2obXojG9/26a1SNmZ04d/DFqDafm+C3Xqxvdq5IIEYekJSp7LFeuJ1LStltpVquw
	LCSCRr4xqOLg7juQkInc9GfG2eJIBVqKKPh2Cm0YcEhcvoOxukL4yiDFOhkHIQ8+/bxGwCDYmp5
	ta+36Yug0Za+fo8RcXbOlCkXc5MqAKB+PtEw0a16rzq6jvjUmsruXZE6uGfqMAIhi6SaZ+YEQiY
	zhAlRbiq8ZzH20ZTlqtD5YTgBiZfcSPHviq3rkXXhuQSN5DospvKdfj4SesD52g1KiPTWCY0v9B
	w1IIBNtiwlWOf1gNdBCWm2tl7qnTDPBzCA0eLLO+PjFnQelcOOBocM/4oIW5y2JzFzLITB7/qxH
	xhaYjJsvP39qC6lJRkK6qiieHYqarYbA12IAZE5mZRoGFBHPE8oI/+EFX9YVjFlM+++Xv6mIpim
	Ehop9U=
X-Received: by 2002:a05:693c:6391:10b0:34e:7f9a:c722 with SMTP id 5a478bee46e88-34f218665camr8553111eec.34.1791087196666;
        Sat, 03 Oct 2026 21:13:16 -0700 (PDT)
Received: from vscode-11-19.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35127136b8esm1366253eec.6.2026.10.03.21.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 21:13:16 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	idosch@nvidia.com,
	razor@blackwall.org,
	horatiu.vultur@microchip.com,
	bridge@lists.linux.dev
Subject: [PATCH iproute2-next 1/2] uapi: import cfm_bridge.h
Date: Sun,  4 Oct 2026 04:13:06 +0000
Message-ID: <20261004041307.2683990-2-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261004041307.2683990-1-w453y.me@gmail.com>
References: <20261004041307.2683990-1-w453y.me@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bridge CFM netlink attributes use the MEP domain, MEP direction and
CCM interval enums from cfm_bridge.h, but the header was never imported.
The bridge cfm command in the next patch needs it. Copied as is from
net-next.

Signed-off-by: Abdul Wasey <w453y.me@gmail.com>
---
 include/uapi/linux/cfm_bridge.h | 64 +++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 include/uapi/linux/cfm_bridge.h

diff --git a/include/uapi/linux/cfm_bridge.h b/include/uapi/linux/cfm_bridge.h
new file mode 100644
index 00000000..3c1cbd1d
--- /dev/null
+++ b/include/uapi/linux/cfm_bridge.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+
+#ifndef _UAPI_LINUX_CFM_BRIDGE_H_
+#define _UAPI_LINUX_CFM_BRIDGE_H_
+
+#include <linux/types.h>
+#include <linux/if_ether.h>
+
+#define ETHER_HEADER_LENGTH		(6+6+4+2)
+#define CFM_MAID_LENGTH			48
+#define CFM_CCM_PDU_LENGTH		75
+#define CFM_PORT_STATUS_TLV_LENGTH	4
+#define CFM_IF_STATUS_TLV_LENGTH	4
+#define CFM_IF_STATUS_TLV_TYPE		4
+#define CFM_PORT_STATUS_TLV_TYPE	2
+#define CFM_ENDE_TLV_TYPE		0
+#define CFM_CCM_MAX_FRAME_LENGTH	(ETHER_HEADER_LENGTH+\
+					 CFM_CCM_PDU_LENGTH+\
+					 CFM_PORT_STATUS_TLV_LENGTH+\
+					 CFM_IF_STATUS_TLV_LENGTH)
+#define CFM_FRAME_PRIO			7
+#define CFM_CCM_TLV_OFFSET		70
+#define CFM_CCM_PDU_MAID_OFFSET		10
+#define CFM_CCM_PDU_MEPID_OFFSET	8
+#define CFM_CCM_PDU_SEQNR_OFFSET	4
+#define CFM_CCM_PDU_TLV_OFFSET		74
+#define CFM_CCM_ITU_RESERVED_SIZE	16
+
+struct br_cfm_common_hdr {
+	__u8 mdlevel_version;
+	__u8 opcode;
+	__u8 flags;
+	__u8 tlv_offset;
+};
+
+enum br_cfm_opcodes {
+	BR_CFM_OPCODE_CCM = 0x1,
+};
+
+/* MEP domain */
+enum br_cfm_domain {
+	BR_CFM_PORT,
+	BR_CFM_VLAN,
+};
+
+/* MEP direction */
+enum br_cfm_mep_direction {
+	BR_CFM_MEP_DIRECTION_DOWN,
+	BR_CFM_MEP_DIRECTION_UP,
+};
+
+/* CCM interval supported. */
+enum br_cfm_ccm_interval {
+	BR_CFM_CCM_INTERVAL_NONE,
+	BR_CFM_CCM_INTERVAL_3_3_MS,
+	BR_CFM_CCM_INTERVAL_10_MS,
+	BR_CFM_CCM_INTERVAL_100_MS,
+	BR_CFM_CCM_INTERVAL_1_SEC,
+	BR_CFM_CCM_INTERVAL_10_SEC,
+	BR_CFM_CCM_INTERVAL_1_MIN,
+	BR_CFM_CCM_INTERVAL_10_MIN,
+};
+
+#endif
-- 
2.53.0

