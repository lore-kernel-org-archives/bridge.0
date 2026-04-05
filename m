Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010032.outbound.protection.outlook.com [52.101.85.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458E32DCC13
	for <bridge@lists.linux.dev>; Sun,  5 Apr 2026 20:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775422351; cv=fail; b=BvsL8/yLhK4xg+9en58Bep6Jqfobvm75/uDsL22jL7PJ8Q4zjCbu92K4zlSayk7jMFCf9pDXBMCANyjBodp9z9wecP1vIem2byPuhh6DDNxdRvcO+dsPwE1sjtC0iq0prL/ZKMTW6vcbpZSq8j2dGYUHFXUmmEUjsrd2bxQK75o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775422351; c=relaxed/simple;
	bh=1XJxVdWgwSNHFnYq7IqL7DyI72/uNnb1S91dSh+LZ9A=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cs5ZZ1fLP7RWuMhBSupYwoAmgKj8Q42e42l1IjOcLGGTPM3L6EnyGck0dBL78XjgVbbIX+aC8dRlNSxtZZVb2bOCQ89OoHPtrT6+KBoVx3j72wxpbChBXRbLcydCnol0yVF1MqpklKXORxDvmuoC5hq3Wo+tQN6SgNAXqxPYj6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TUoKZL3L; arc=fail smtp.client-ip=52.101.85.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TUoKZL3L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EIsIU/AgKNYQLVZxCmYcDYCRK0DKMSu7iI+8iTdiKtJ56LKdOqDM1VRE7BL4duTOC8WPf2l10dt50gDPizc5Jg3QizXQi5TgYL2QA0k8FbHtIcSE1qV4UWn2N46dXE1SFSUiDqBfY8zCUlQTchHHvouZ/eL5X8L5RK4sNbYMl1AUKk7MWKSePejDAuwL6snKvCnNN+uqc43f8ERnDz71oZITN4pfK46T/IcX0cXTYl9UwN3dgQuMCeGW6c/hw2OGjvvGDNEnOyXcLwRu99iOnOUUAvJfh5GPUq8aAtlRDG0PWtVhn/B2DZYmtKeqHWCvbfpFg1BdtxVlt6TMo2ceVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKE246/EfbHcVLHXWA6oip8MNOQGPZtdHpKVa9uk0qc=;
 b=dNFFFwrdHxD/E9halW4MhamGhNBm0gXHKBuVJb7qRqEaPuiawgoMBMb+Co0GvYKbVg/TT1h/67WTsVh5vLX5F5gu0TBTkhVjGdfClqyjmBNyHTy2Xak1SxYfciGAWptGZcs4H+50Os3SzmcE1nUkuegpJC7MrALRIbZ91ZdFcNfsCgXQ0uF2XXYZYtdf96tVPfJzqDGEdy64fzC69wWlRyCK8vVTvyPSqRKCm9I+doVLV7Tz+MxR/PhAKn/XSapjQCA9YyBpNVEpi+3SD5e8lLPxoqie2Cwi+fhCwA95nWhHKeFU4pUZctLfmuGzUTb+OLhOiNZykQArJ8yrVONdSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKE246/EfbHcVLHXWA6oip8MNOQGPZtdHpKVa9uk0qc=;
 b=TUoKZL3LIWrsLob3BCjbvwbllw3Hx8O8M5qskYmkKEmeM85kbDfLO8zKcCxd0/LJShQC65TOMH3RrfY9k32zlrpugn+J3jD7OOG7bXlHvrVIjYX86dw2e78L3dNBw1P/GjaRRq0BUTTxEhvZJrb/YeRx8Al3Wg6OWQDLcXxkzinURaNl2N1HcuFBI+kkcXtJC/85TV73mHOOt13jG9res1VWEWP6C/4cJBqUzrP+MP121WjWooBXokiStnS5J/ma8yJfeakp6YJFGnAHIx0gEDWDfF64xwCmMGqNFGzP95KaGezEtu9A0b+QRXpSeHRt4SHahFA8ZbMO2DIq7tgAqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB8202.namprd12.prod.outlook.com (2603:10b6:8:e1::13) by
 SJ2PR12MB8807.namprd12.prod.outlook.com (2603:10b6:a03:4d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Sun, 5 Apr
 2026 20:52:26 +0000
Received: from DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e]) by DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e%6]) with mapi id 15.20.9769.020; Sun, 5 Apr 2026
 20:52:26 +0000
From: Andy Roulin <aroulin@nvidia.com>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Roulin <aroulin@nvidia.com>
Subject: [PATCH net-next v4 0/3] net: bridge: add stp_mode attribute for STP mode selection
Date: Sun,  5 Apr 2026 13:52:21 -0700
Message-ID: <20260405205224.3163000-1-aroulin@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0001.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::14) To DS7PR12MB8202.namprd12.prod.outlook.com
 (2603:10b6:8:e1::13)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8202:EE_|SJ2PR12MB8807:EE_
X-MS-Office365-Filtering-Correlation-Id: fbbc6973-1e10-4a2e-b29d-08de93553e5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kwPbjc0KwZxWyKmK4utaBjDQz4V9XPRFKoZ18kUUOjjnnuUOPzKujmboJXtIv75NDIc3CXyuBRJHVW7Z6kSKv6aq1cMFE+TQxFC7zQu5GRSUqDsCrYKUQC6t6UB0ovb+Xks3Oykj6dIF7CV/L+AcP+PBX2yNdjGE4Zz7DldawZYqRVUi8VEKnTNz5OG5prsrwzG1xDPRiVI5rBibubxX2q2sE+AS7PkhXjkDd8WQt7ytTDmTaggTceIRwMnKw3CCTgyIVLFJ3fnw7riIpc0/KeBm6ydic4f94H07AMMnOsRnKVIYl8vsuhlrEUInKFEFXueCDlCNvn69JikSaKgRW8KGBvmNKGluFaFP2zJ4Vnvl1+zoy7RQHCkw1n1eu7fDN8A80OG/psW8DB5ljW3OX6gOv23yAaBCQvAceCkAiQ7Wc6hm4ypw6wm0vD8pgK6IPZbDO/08Y7vWuxDK1k+C+NeMTQ7QgQFMmU0r/GwdO9JBFEz4qonYwQ983WigBP2t8UOiq/WnktOS/gzg+ICEf+6LK+Cjns80zfkfGAvOieOqPZQKqo4iqchtY+XYbeRjYBrUmRAGqbzW7QiDfKrldmjyU407fWcEuA5+mT7lg/c2/+pUkJNIzFBWt722uayL6x35RglwV8yLwST5iADWu8msSdsVJrk2ASpwvvTuLaXymxnDBmsAGOYjkGx39N1lJrAkKOLsVMAetybzCMEuCPxMjMf7+bk1O/v/VOcym5Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aCbnmpGx3ORJ/nQ5KhWlfGTrkvAPeVhbwyd7JhJ6/RSt1sM2GCikzBnbXuk0?=
 =?us-ascii?Q?VfxVRfnVeFFiHLs3whqWygBApjuEFVV8YUCYaAvF0fdA1HLCkEU388Rf7JSU?=
 =?us-ascii?Q?+99AU/fxyPh7iSfeymZAqVSusbHm7Os/sxlw5X0rZ9RX8xHaB22ECbFGNJv5?=
 =?us-ascii?Q?CraSAaXmG6w1OtAo0dkkBhd9si0HrkEECeLZILjN99mNLuSijLdogmZCygYD?=
 =?us-ascii?Q?hAeO1gb4QaEeGSWnQLC/hVVBgUZ5lIhWsDhdjCKULp03SoCaMOKhSrVFHH+N?=
 =?us-ascii?Q?XKXOGWAAHuXTaByZWugKmm98reya3JehtQigWiVYoCb608QtoYorACQnmQhw?=
 =?us-ascii?Q?t6BS231RTUHni9XcrubCZmn/MDdg4Q11N67ldDDesu3AtToeZfPugCZzNlKy?=
 =?us-ascii?Q?1hTJSeL/nnphOCJuuoNE2d4yOHWiEjxcvFCP3Zhtcmhile/vJg9Y4ka/4dIn?=
 =?us-ascii?Q?MF7XGTFRD/q64b8OHQnLc1m6F8E5pxVAf/BB5gwLenEq5tefrU3IWzz/b2Hs?=
 =?us-ascii?Q?LujTZgNoopfJg8h/9FQfXxT8wZW/Vbjv6SIJ3agt5ku4qH2UwXVAtyOVrw2S?=
 =?us-ascii?Q?5mYWCSGBCqLMyuItfmKv8o8ZXaZ/Gwl+ATbZ0iYj2YbneJrg6J7A1JOJNbVz?=
 =?us-ascii?Q?M/OjMCUU6VcKdPc3qpdL7uKHohS6CxVrrqzx6NWAJY/rcYzhzsQKXNlfpPLz?=
 =?us-ascii?Q?fGGw0rwGrrHOAQNEpWw+5VwxrsL2vD2ISQZo813As1SoNFA1Yu2CKzAtrzuh?=
 =?us-ascii?Q?7Xjh8XO6gMtubwb4F7oSzSGRx2NvDsOwfeJJImemxBl3BxEyMOEfTlPkhC0a?=
 =?us-ascii?Q?euTf6OJocqMFvmN43mJ7TVICme6rXQUXK827UI07E5TmBrmouzY4lbM5b8Z3?=
 =?us-ascii?Q?CL+iGDmxAcKrouLgsXGffLIkXIfVYkMdRNgFmKOXsZ95AUw9oqbm+5mKyinb?=
 =?us-ascii?Q?Mak+SnG/DsRAIjpL55embFCC14hfvgzt0Fy6wjKMe7zyyrHUgEHdMKtqSRN6?=
 =?us-ascii?Q?b/T/h6Y2N8tp6YtFmg2frvoNjZKOZzYWBN2B7Ir/BtfViAXWmU2eiBeY4Pyd?=
 =?us-ascii?Q?SAa99RQnJeIq6MNfAfptzFzL3gH76Ldija9yxafuWHx13XXaCbgJpShYjgLU?=
 =?us-ascii?Q?vbo7IA9lTui9dwB7+85XVHCTvEIX+nHb5tIPRxFLlslEESkEZv3LqkjSZGJV?=
 =?us-ascii?Q?AbNXgPPkXPfQOcoytfUh49CiVKmyzrtDtdH1N4xak9g9bmo1UV1m73e6ZQmF?=
 =?us-ascii?Q?TKiPTszJYMsLyzplk/UGW2ZEzaHUSWXRT5LlW0Pr2dcTxQ7S2uNjQJHXmH4t?=
 =?us-ascii?Q?Hj+A0xGLnOmeIgmgGguxiRQp2cTbYRWJ6E2pMCW/JSY3dq3E8V5Pcp2xGyi3?=
 =?us-ascii?Q?bZNICzQec5OdswTLpnvvDltar6s2jsKI/rYin8CwMVfjiGt2QaXQh0YFd7Id?=
 =?us-ascii?Q?j74rqhkdUDXIcK/QEA++W/igDebPRIzjc0I2RyprIBs+2ENl8QexZHTZWoJB?=
 =?us-ascii?Q?wnrE61JEw17iFcmDWZ8Ym+etHV69n3IJRdQiMlHkrQ35/0IVAOyRNso7nsY3?=
 =?us-ascii?Q?I9DoSeuoRPwVOlbFhdhJzJs9w8Ivdoyrc+73rBXoHbDfI5z5iWIOKzXPejsb?=
 =?us-ascii?Q?dG2UA+KvlvA03UkTpZHPLqhfLaILnaCBX239Zus5GVaGHUG5yDDXBIZQ7E4N?=
 =?us-ascii?Q?mobrShDcJ440GD3JreDIT7ZoDmXo0fATVPHaJeUEjt17yzN1FRb49Zulk4D9?=
 =?us-ascii?Q?K46NhSTYJQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbbc6973-1e10-4a2e-b29d-08de93553e5d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2026 20:52:26.1932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V6PR46G6UmY3UD9KrnBckBkZzX6aH0MoTl6BMYPgQzVHl1WGm3dU0hXC/AJw/VpJx+AIIDzLiyG5v9pjFzej8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8807

The bridge-stp usermode helper is currently restricted to the initial
network namespace, preventing userspace STP daemons like mstpd from
operating on bridges in other namespaces. Since commit ff62198553e4
("bridge: Only call /sbin/bridge-stp for the initial network
namespace"), bridges in non-init namespaces silently fall back to
kernel STP with no way to request userspace STP.

This series adds a new IFLA_BR_STP_MODE bridge attribute that allows
explicit per-bridge control over STP mode selection. Three modes are
supported:

  - auto (default): existing behavior, try /sbin/bridge-stp in
    init_net, fall back to kernel STP otherwise
  - user: directly enable BR_USER_STP without invoking the helper,
    works in any network namespace
  - kernel: directly enable BR_KERNEL_STP without invoking the helper

The user and kernel modes bypass call_usermodehelper() entirely,
addressing the security concerns discussed at [1]. Userspace is
responsible for ensuring an STP daemon manages the bridge, rather
than relying on the kernel to invoke /sbin/bridge-stp.

Patch 1 adds the kernel support. The mode can only be changed while
STP is disabled and is processed before IFLA_BR_STP_STATE in
br_changelink() so both can be set atomically in a single netlink
message.

Patch 2 adds documentation for the new attribute in the bridge docs.

Patch 3 adds a selftest with 9 test cases. The test requires iproute2
with IFLA_BR_STP_MODE support and can be run with virtme-ng:

  vng --run arch/x86/boot/bzImage --skip-modules \
      --overlay-rwdir /sbin --overlay-rwdir /tmp --overlay-rwdir /bin \
      --exec 'cp /path/to/iproute2-next/ip/ip /bin/ip && \
              cd tools/testing/selftests/net && \
              bash bridge_stp_mode.sh'

iproute2 support can be found here [2].

[1] https://lore.kernel.org/netdev/565B7F7D.80208@nod.at/
[2] https://github.com/aroulin/iproute2-next/tree/bridge-stp-mode

v4:
        Patch #1:
                * Use u8 for stp_mode struct field.
                * Add stp_helper_active bool to track whether the
                  usermode helper was invoked during start.
                * Allow mode change when STP is being disabled in
                  the same netlink message.
        Patch #3:
                * Add disable+mode-change simultaneous test.
v3:
        Patch #1:
                * Name enum br_stp_mode for YNL codegen.
                * Add enum-name to rt-link.yaml spec.
v2:
        Patch #1:
                * Add rt-link.yaml netlink spec update.
                * Allow idempotent stp_mode set while STP is active.
                * Move stp_mode next to root_port to fill a struct
                  hole.
                * Rephrase BR_STP_MODE_USER doc.
        Patch #3:
                * Fix shellcheck CI: add SC2329 suppression.
                * Add idempotent stp_mode test.

Suggested-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Andy Roulin <aroulin@nvidia.com>

Andy Roulin (3):
  net: bridge: add stp_mode attribute for STP mode selection
  docs: net: bridge: document stp_mode attribute
  selftests: net: add bridge STP mode selection test

 Documentation/netlink/specs/rt-link.yaml      |  12 +
 Documentation/networking/bridge.rst           |  22 ++
 include/uapi/linux/if_link.h                  |  39 +++
 net/bridge/br_device.c                        |   1 +
 net/bridge/br_netlink.c                       |  24 +-
 net/bridge/br_private.h                       |   2 +
 net/bridge/br_stp_if.c                        |  19 +-
 tools/testing/selftests/net/Makefile          |   1 +
 .../testing/selftests/net/bridge_stp_mode.sh  | 288 ++++++++++++++++++
 9 files changed, 400 insertions(+), 8 deletions(-)
 create mode 100755 tools/testing/selftests/net/bridge_stp_mode.sh

--
2.43.0

