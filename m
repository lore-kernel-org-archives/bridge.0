Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3448B79EA
	for <bridge@lists.linux-foundation.org>; Sat, 16 Aug 2025 04:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755319661; cv=none; b=l1+z0zpq9s2ZuV7hnWAv81hs+XbHZCAf6wYsEP2lvqs/HW+2GknEk5YXC5ZCawFWUBfIc0qT1193WAWBJdZjJleh3MVAStvkvSNtiJPJ4Z0vYkLNgm/lV/rL/Y0kYjpdV0rWSZNQerPNXSOBnSSeiRYixDUDWDBDpYZocMzXbL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755319661; c=relaxed/simple;
	bh=nak1WHXiv2dKHTKcqggVW6w5Guq4Ovxh/4C3oHCqbyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ns6YLApIX0q5wWBm/al2MMLFjX/VFnqwP49REjc342PMBAodLzeFvbZQgGXjvyu8qI9O1CKnaHJoLw5W1V1cFtIoWI/6KmF/pKg6dPsT21nzIPoEP/chaEan/TUqNc5zo1EAWOz0CAUhA3bJxIfQkdQkUuDSYWHxR60Ue4VlN1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=jcEblX7W; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="jcEblX7W"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CEAF461491
	for <bridge@lists.linux-foundation.org>; Sat, 16 Aug 2025 04:47:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -15.582
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UtcBgEzpnu_s for <bridge@lists.linux-foundation.org>;
 Sat, 16 Aug 2025 04:47:38 +0000 (UTC)
X-Greylist: delayed 426 seconds by postgrey-1.37 at util1.osuosl.org; Sat, 16 Aug 2025 04:47:37 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org BE2BD61461
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BE2BD61461
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=jcEblX7W
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=173.37.142.89; helo=alln-iport-2.cisco.com; envelope-from=mrghosh@cisco.com; receiver=<UNKNOWN> 
Received: from alln-iport-2.cisco.com (alln-iport-2.cisco.com [173.37.142.89])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BE2BD61461
	for <bridge@lists.linux-foundation.org>; Sat, 16 Aug 2025 04:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=5358; q=dns/txt;
  s=iport01; t=1755319657; x=1756529257;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rZ45E8uRt6lN/hvDsnSCm2r8Z/0epp+vTKFKDlCTErA=;
  b=jcEblX7WpNAz60zW6scEHxvYqOzkk/VJaJkatkXFit17IkmnhsTlAWUR
   syDLgHvvklvuGu8IpIuf/SLndOVxeGhfyNSBCWYTw0MZTWTCl2mSaC62j
   V+kzUQ6ixH4BA0+mFlfSvCnTyULSlBRk17RVG5caph3F0uIWpKyyh8LpJ
   odd/I0HTVYLPKgNCj48BJdCW8clqp1cKeFv+8oJn/14PAL6WHLnAxbDMO
   kND2VBjo1AslFgychQMRxcoT2cbYUH38jsadQa//eHyPflrtKh0iXsZKs
   gHuZF3btGWUYLBEli7rBydSr/UH6nYDKym/W5TjKeUR5pdEoK+RvHq38V
   g==;
X-CSE-ConnectionGUID: A9EckXdmTJWW5lD2X+6vTg==
X-CSE-MsgGUID: mOrbGNqcTK6ukx8BYXglHg==
X-IronPort-AV: E=Sophos;i="6.17,293,1747699200"; 
   d="scan'208";a="530114137"
Received: from rcdn-l-core-02.cisco.com ([173.37.255.139])
  by alln-iport-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 16 Aug 2025 03:11:53 +0000
Received: from mrghosh-ub.cisco.com (unknown [10.160.1.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mrghosh@cisco.com)
	by rcdn-l-core-02.cisco.com (Postfix) with ESMTPSA id C806C18000237;
	Sat, 16 Aug 2025 03:11:52 +0000 (GMT)
From: Mrinmoy Ghosh <mrghosh@cisco.com>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org,
	mrghosh@cisco.com,
	mrinmoy_g@hotmail.com,
	Mike Mallin <mmallin@cisco.com>,
	Patrice Brissette <pbrisset@cisco.com>
Subject: [PATCH iproute2] bridge:fdb: Protocol field in bridge fdb
Date: Sat, 16 Aug 2025 03:11:45 +0000
Message-ID: <20250816031145.1153429-1-mrghosh@cisco.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: mrghosh@cisco.com
X-Outbound-SMTP-Client: 10.160.1.156, [10.160.1.156]
X-Outbound-Node: rcdn-l-core-02.cisco.com

From: Mrinmoy Ghosh <mrinmoy_g@hotmail.com>

This is to add optional "protocol" field for bridge fdb entries.
The introduction of the 'protocol' field in the bridge FDB for EVPN Multihome, addresses the need to distinguish between MAC addresses learned via the control plane and those learned via the data plane with data plane aging. Specifically:
* A MAC address in an EVPN Multihome environment can be learned either through the control plane (static MAC) or the data plane (dynamic MAC with aging).
* The 'protocol' field uses values such as 'HW' for data plane dynamic MACs and 'ZEBRA' for control plane static MACs.
* This distinction allows the application to manage the MAC address state machine effectively during transitions, which can occur due to traffic hashing between EVPN Multihome peers or mobility of MAC addresses across EVPN peers.
* By identifying the source of the MAC learning (control plane vs. data plane), the system can handle MAC aging and mobility more accurately, ensuring synchronization between control and data planes and improving stability and reliability in MAC route handling.

This mechanism supports the complex state transitions and synchronization required in EVPN Multihome scenarios, where MAC addresses may move or be learned differently depending on network events and traffic patterns.

This change:
fdb.c: Allows 'bridge fdb [add | replace]' with optional protocol field.

e.g:

$ bridge -d fdb show dev hostbond2 | grep 00:00:00:00:00:88
00:00:00:00:00:88 vlan 1000 extern_learn master br1000 proto hw

$ bridge -d -j -p fdb show dev hostbond2

...

[ {
        "mac": "00:00:00:00:00:88",
        "vlan": 1000,
        "flags": [ "extern_learn" ],
        "master": "br1000",
        "flags_ext": [ ],
        "protocol": "hw",
        "state": ""
    },{
...

Transition to Zebra:

$ bridge -d fdb show dev hostbond2 | grep 00:00:00:00:00:88
00:00:00:00:00:88 vlan 1000 extern_learn master br1000 proto zebra

$ bridge -d -j -p fdb show dev hostbond2
...
[ {
        "mac": "00:00:00:00:00:88",
        "vlan": 1000,
        "flags": [ "extern_learn" ],
        "master": "br1000",
        "flags_ext": [ ],
        "protocol": "zebra",
        "state": ""
    },
...

Signed-off-by: Mrinmoy Ghosh <mrghosh@cisco.com>
Co-authored-by: Mrinmoy Ghosh <mrinmoy_g@hotmail.com>
Co-authored-by: Mike Mallin <mmallin@cisco.com>
Co-authored-by: Patrice Brissette <pbrisset@cisco.com>
---
 bridge/fdb.c                   | 20 +++++++++++++++++++-
 include/uapi/linux/rtnetlink.h |  1 +
 lib/rt_names.c                 |  1 +
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/bridge/fdb.c b/bridge/fdb.c
index d57b5750..9c5dd763 100644
--- a/bridge/fdb.c
+++ b/bridge/fdb.c
@@ -41,7 +41,7 @@ static void usage(void)
 		"              [ sticky ] [ local | static | dynamic ] [ vlan VID ]\n"
 		"              { [ dst IPADDR ] [ port PORT] [ vni VNI ] | [ nhid NHID ] }\n"
 		"	       [ via DEV ] [ src_vni VNI ] [ activity_notify ]\n"
-		"	       [ inactive ] [ norefresh ]\n"
+		"	       [ inactive ] [ norefresh ] [ protocol PROTO ]\n"
 		"       bridge fdb [ show [ br BRDEV ] [ brport DEV ] [ vlan VID ]\n"
 		"              [ state STATE ] [ dynamic ] ]\n"
 		"       bridge fdb get [ to ] LLADDR [ br BRDEV ] { brport | dev } DEV\n"
@@ -306,8 +306,18 @@ int print_fdb(struct nlmsghdr *n, void *arg)
 		print_string(PRINT_ANY, "master", "master %s ",
 			     ll_index_to_name(rta_getattr_u32(tb[NDA_MASTER])));
 
+	if (tb[NDA_PROTOCOL]) {
+		__u8 proto = rta_getattr_u8(tb[NDA_PROTOCOL]);
+		if (proto != RTPROT_UNSPEC) {
+			SPRINT_BUF(b1);
+			print_string(PRINT_ANY, "protocol", "proto %s ",
+					 rtnl_rtprot_n2a(proto, b1, sizeof(b1)));
+		}
+	}
 	print_string(PRINT_ANY, "state", "%s\n",
 			   state_n2a(r->ndm_state));
+
+
 	close_json_object();
 	fflush(fp);
 	return 0;
@@ -478,6 +488,7 @@ static int fdb_modify(int cmd, int flags, int argc, char **argv)
 	char *endptr;
 	short vid = -1;
 	__u32 nhid = 0;
+	__u32 proto = RTPROT_UNSPEC;
 
 	while (argc > 0) {
 		if (strcmp(*argv, "dev") == 0) {
@@ -555,6 +566,10 @@ static int fdb_modify(int cmd, int flags, int argc, char **argv)
 			inactive = true;
 		} else if (strcmp(*argv, "norefresh") == 0) {
 			norefresh = true;
+		} else if (matches(*argv, "protocol") == 0) {
+			NEXT_ARG();
+			if (rtnl_rtprot_a2n(&proto, *argv))
+				invarg("\"protocol\" value is invalid\n", *argv);
 		} else {
 			if (strcmp(*argv, "to") == 0)
 				NEXT_ARG();
@@ -615,6 +630,9 @@ static int fdb_modify(int cmd, int flags, int argc, char **argv)
 	if (via)
 		addattr32(&req.n, sizeof(req), NDA_IFINDEX, via);
 
+	if (proto != RTPROT_UNSPEC)
+		addattr8(&req.n, sizeof(req), NDA_PROTOCOL, proto);
+
 	req.ndm.ndm_ifindex = ll_name_to_index(d);
 	if (!req.ndm.ndm_ifindex)
 		return nodev(d);
diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
index 085bb139..1ff9dbee 100644
--- a/include/uapi/linux/rtnetlink.h
+++ b/include/uapi/linux/rtnetlink.h
@@ -314,6 +314,7 @@ enum {
 #define RTPROT_OSPF		188	/* OSPF Routes */
 #define RTPROT_RIP		189	/* RIP Routes */
 #define RTPROT_EIGRP		192	/* EIGRP Routes */
+#define RTPROT_HW		193	/* HW Generated Routes */
 
 /* rtm_scope
 
diff --git a/lib/rt_names.c b/lib/rt_names.c
index 7dc194b1..b9bc1b50 100644
--- a/lib/rt_names.c
+++ b/lib/rt_names.c
@@ -148,6 +148,7 @@ static char *rtnl_rtprot_tab[256] = {
 	[RTPROT_OSPF]	    = "ospf",
 	[RTPROT_RIP]	    = "rip",
 	[RTPROT_EIGRP]	    = "eigrp",
+	[RTPROT_HW]	    = "hw",
 };
 
 struct tabhash {
-- 
2.43.0

