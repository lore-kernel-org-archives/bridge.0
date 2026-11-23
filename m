Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795456895;
	b=IkMBs327196tmvShL2TwlU2T0buSXPAogmlxnphhUariBvkCgHmCrVduektxGmGKLafi
	 m11Bfm4jr4/ubdY4xYDZHoOGdoLI0Bn11+2LWfl9vRohyC3V2WmH2Esz4isCV0q30J+8A
	 g0NBKpangJ5z47S7dlIjrAiePOitVLCElmjFysrmAJcmxnJ4WEAwS2j1WUqSUnA5rDYac
	 7s8735yZt4S/dsJvnqEwsjRnRx4RnDGt/ESwUGXSdlanmcoUrMkl4HgmNyJCqnt02/WoH
	 MExe1U4BzKpMoucCUys1iWiHjnEgZ+myBWIrDV5iKCPw2Bqk0nM2elzdjV3B7D6K3WQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456895;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=76TfjmZBYKGLSt+yllHZCe29tS1/lTufuq8zP6D/IPY=;
	b=RfLwNqPqnLVQ8v5OLy+G3d0ri5ZFS/taR5OoDOgNYP9uB/0+VMHn+zozmfklHTqm/T58
	 kuEq0ibjsmNnsh/R+dfhR9BEJPe6KV44yzkQrQ1cxk9Cj33F0wucAwjYcOiY1xLEOEqiI
	 w+hLjnPwn5QtbDWsJ3JUPZNS55svTexT9DXQ0Vk56G/s+oCPCXTMnTXEwa7HTx8J1aVnh
	 jpRxh1KeLpaG4Z9koJ5oVh9s3qSlKxGom6jXN6+D9oy/PissEb8CXxif/xQ9yaPgQUMCT
	 WVmOQIAy0sH5IJB+rZJ/sXuG36bzxN3F2Tp6YwV2vlK+zmxs4KOjGF74MCaK53Fwm9g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GvvRunmJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.21
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012021.outbound.protection.outlook.com [40.107.209.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938EE606A32D
	for <bridge@lists.linux.dev>; Mon, 23 Nov 2026 18:01:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 938EE606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GvvRunmJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iNTUOiVJERfHAJPy8m+3skJyt9qSYgNyTFwqfTw/nsnoumB52SLztM1++yVPO5QoE0CKJjDB5ynKgQ6nM8btINn7a7g4ZV7qjrTEO2lxh/D/73EcESJE9gHZu4Ugv98iW87aUORkbKIIWJwpbVbVk20+IEMccBIPh9xnmuWkqeIkOApaExwIZg59Bnu8aIR38Rp4nGPg3rUHQ7lmL/wS1v/q7SU89/sQ4hR2VU6ZsV2G8zt35zoDpFwkeSqu06uFa2mWtnyy+2oasSZcluti1APEqr3djWK7W2s4K3yCQYIjPdTRCuTHioTkKoMez5svSFw4c59Gk10H0yyXrKM7rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76TfjmZBYKGLSt+yllHZCe29tS1/lTufuq8zP6D/IPY=;
 b=iv/LoVkd1tMS7vsa1ey0mbDfYz+V/xNepQ+k3nDU4qJ9QGLqgyYPpkVK9diecfqYeAXehci4oyEH6BWsmKW47vyBCkOKqJVj/6BE3v6m+NKhyDeHHBn59emGUlUkwREXvsTkH1U3HYx2WNtwBruxGvqXpIGuvEGXmzyMa1BNOfSYSkCHXmKjGDOTaDqVeiw9oc0thhCQTDps4kbPKZ+N4i0pSJwm3tw0YeXaJYF+nRDB20ewo89Ryr7u1Q2LCdOP8MtqwQZWtlbFdpzVZhzm9Z38Gfe1T02BBUvEF8AClJnzpoNtHEBUnJwA6bq02kSB/rSCAbiL0moKjJcrw9pZJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76TfjmZBYKGLSt+yllHZCe29tS1/lTufuq8zP6D/IPY=;
 b=GvvRunmJXS51Uh47R42DrcuByVat2dZ3j9FZBPTUsSKum/anFLfnrBqvWft1MNK4+4qaPobB8jjstvHUIpQn9q9UJ+1oT8TVQoKo0ZrKP7RCZS5PZluf8bzERN8eDYMBx0sFq3p2Oet9DCIwioVxbmr+8OKVJ4NgbJO20Ueu5TsMBb69GN6BPFQVNL1cdrIiQX53o3bLiXJLeBwg+UyeKC2Ipi6Momg9Fwx5uULDxsJNjgF1Sghg5JkAls6FP65YM7LxaagI0JB/hff0uXC3+goZzPuDtJfh0RHF9mBG9m/eOJxOtDMHfM5E2cLkP3XyGnJjSySqsy6vLQYYTomiMw==
Received: from CY5PR19CA0112.namprd19.prod.outlook.com (2603:10b6:930:64::12)
 by PH7PR12MB7017.namprd12.prod.outlook.com (2603:10b6:510:1b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 18:01:29 +0000
Received: from PH3PEPF00059617.namprd05.prod.outlook.com
 (2603:10b6:930:64:cafe::26) by CY5PR19CA0112.outlook.office365.com
 (2603:10b6:930:64::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 18:01:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 PH3PEPF00059617.mail.protection.outlook.com (10.167.243.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 18:01:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 23 Nov
 2026 10:01:00 -0800
Received: from tuxedo.docsis.vodafone.cz (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 10:00:55 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Nikolay Aleksandrov
	<razor@blackwall.org>, <bridge@lists.linux.dev>, Ido Schimmel
	<idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Andy Roulin
	<aroulin@nvidia.com>, <mlxsw@nvidia.com>, Donald Hunter
	<donald.hunter@gmail.com>
Subject: [PATCH net-next 11/13] tools: ynl: Add NLM_F_BULK
Date: Mon, 23 Nov 2026 18:59:26 +0100
Message-ID: <b79846c382aa33de18a38000500cc542f67e3925.1795447450.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <cover.1795447450.git.petrm@nvidia.com>
References: <cover.1795447450.git.petrm@nvidia.com>
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
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF00059617:EE_|PH7PR12MB7017:EE_
X-MS-Office365-Filtering-Correlation-Id: 5020530a-143a-4496-a630-08df498bcc2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|23010399003|36860700016|6133799003|18002099003|22082099003|261009223027099003|261021123027099003|261021121427099003|261026140227099003|261102123227099003|261026121527099003|261022105027099003|261028144727099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	CmI88G4VmH8d3vAasSKDP/IbmsCnw79ROcmHMvLy0JvjV+bS9DrOHXpvatjnIczkaD6xDfvFOoC2ImMjtxz3uTF4RR9hTVPqL0Cx0B3V8B/aGIQGL/XHnufRpwOTRCyxxwC0+zazyZIBH+oQM7neW4oiOka76Nz8eNSFqLT9PfssJmMUNgZBDmKTodJjmyjtASu0QvNcNqIKM4crG0AfJRAbF77nTbFoJy+iIEJZLxHa2Xj6TLSa2JpHNjDnHD8wCqSCCvSls6GR+Y4Fa+2D5fDJjNVsxsWLvYyTqGzz7RCmuyCE/nzayLs/NOxR7jUhoLMx8hY5O33VfbFPjeOgEraWz+vNL7GjpuRAb/RnpMR3NSU/cUvHtK+Tt1qUf0vkZbACSep55QNVB/xi8Q4TecdvzkIYRawTMknqlGMmsd4eRGRTOpa8QVg06KcKCYq9oPclZnhMLomp+ZVXguoAY77UoQh/OBXfhgvf7JT8NRx+AVdGhqWe6BKet/BXmtrcSBOywwMaywBH2BYHOKc3WTnIGleQvvElqmBTt/w7a80/5N365oH3rAwGsdIjEQyb5L3XL+H4ClWcIwoez1XqoafjTh38n0kc20fBSPFG5hF2NT/t4nuH2+Xzzf7pLL4cmG+OmmfvzpBRrtdWbvq3PIfCxgGhH42NxkmwrtV2yndQOYto3wV16UO82VhL3BYmcUSesm3Y4NgzT5X/iDfYEQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(23010399003)(36860700016)(6133799003)(18002099003)(22082099003)(261009223027099003)(261021123027099003)(261021121427099003)(261026140227099003)(261102123227099003)(261026121527099003)(261022105027099003)(261028144727099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TMHu0MzVJyICY8GH5gBuW7/aS34C5Ez2RpikVyy78EGCtzRqMRvJ6rl17I5p0inlqSpgAAQ3PUaI0ndIc0A8zsQg79M64AKUx8OZFk6mMx133gepxnhjNRWNSonJSbhaEiFrseVwqRv4WN8UfWYYCsnPlAXspHT7I/5G3aFtx4e49rCCOE+N76wBdKT6BAY6gMFzZwdyCQCzaMv/BuHt3LdUTk2spq6K9eBawetjYj3ax3FOh/gauYCTNW53PDaYHumeuZCrs22QkoMiK52YTnGNlR0IBqvB0Nb4Q7wL3xl8O9Z40NnTuzh4LBiSiPQ2XiTt8x8oY0M7il+Q885T0bNICoKJAi5Fd96xnO1P7O7xtOlnR55q5Tye5Ad2AKDG+9KfrtJ6ZjUKjLWmdL9b2TTKjtuTHvkIaLkJ0gRg5t+aSCxeeTfLD1WnM2VYz7eh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 18:01:28.3685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5020530a-143a-4496-a630-08df498bcc2b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH3PEPF00059617.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7017

Add the NLM_F_BULK flag, which marks a delete request as a bulk delete, to
the netlink flags known to the YNL Python library. It has the same value as
NLM_F_ACK_TLVS, but that one is only used in replies, whereas NLM_F_BULK is
only used in requests.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
CC: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/pyynl/lib/ynl.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index fb5acb8acded..0e9bcd0f2599 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -61,6 +61,8 @@ class Netlink:
     NLM_F_CREATE = 0x400
     NLM_F_APPEND = 0x800
 
+    NLM_F_BULK = 0x200
+
     NLM_F_CAPPED = 0x100
     NLM_F_ACK_TLVS = 0x200
 
-- 
2.56.1

