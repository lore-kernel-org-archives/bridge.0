Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CC525DB12
	for <bridge@lists.linux-foundation.org>; Mon, 18 Aug 2025 19:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755545886; cv=none; b=BaaTJKhW0GXSeQ0mdDpVZCqgH3WLNcPVrXJqtFkkspnQB7ZZhB4dJllSUhPhYJSaFg3RtFEY0ZLi48e4c2J0fJdQgmRTfi85aGHN4sr97IOqoCG8D/KHN6yacvF3G+Q87N3RSlNdPiG+YGksgx9Bw1zvfdH3JVAv0MHz4aLmYNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755545886; c=relaxed/simple;
	bh=aHDTJC80xzx8ZOzlW6Tzm8/N3mz1cAe+X+PIfpn9EKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MYkslJ0L2dCoAeq8I4oqGcTJpRGVlVcGrqprh+DId+6mfWhqE7hpp511E/VN8pkuPc0bJEdk+r79Upt1+YNnFxWFQzgwoCf1f6u5c2KzdW3hcb5jZQ/y3MtQNFFQcqZzj/a2z7CG6sCu7juZ3hp0QBBuHmY1J78iemUYEyYmtGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=IcnQIWhR; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="IcnQIWhR"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B8BC880A76
	for <bridge@lists.linux-foundation.org>; Mon, 18 Aug 2025 19:38:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -15.582
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gcqoCCM3wfBe for <bridge@lists.linux-foundation.org>;
 Mon, 18 Aug 2025 19:38:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=173.37.142.94; helo=alln-iport-7.cisco.com; envelope-from=mrghosh@cisco.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 722ED80A66
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 722ED80A66
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=IcnQIWhR
Received: from alln-iport-7.cisco.com (alln-iport-7.cisco.com [173.37.142.94])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 722ED80A66
	for <bridge@lists.linux-foundation.org>; Mon, 18 Aug 2025 19:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=6038; q=dns/txt;
  s=iport01; t=1755545883; x=1756755483;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3U01ZhpNno6cY3iah8uF/NxSwsBcEHgLUlk/2wB92G0=;
  b=IcnQIWhRArXZeiA0/DZ3Qeq9qzch6clqNTYJNuwvg99kfgZx41UqJS+b
   +X0s1UNrfB75QTBHxk0SzFjcAbHk19hFn70Hw3NqJTfHSfDOhgDXDxD1Z
   YV9e5K/JxbN2wYOna63JDOkn1qAAdl1etNRI5gEp8ifr4uuCQ00wPZ00Z
   YV0anhZ+feyo40dR7Vx2yB7zu6nRP8sfRsineRwaH4LOvKsICGZTN2433
   QbX5/cnsKDklW5NvAea1i90xkFs7laN9AY4Ur8AdvdYPyBj7kuQogjCVB
   Wj4Hnu9JOMSSN5556WsQZe44zlWgi4mLM3ECt/AOXNgypZgfLpbhnayRE
   g==;
X-CSE-ConnectionGUID: jLL9QlC4Q4OSWl81Lv8b6Q==
X-CSE-MsgGUID: zfsGybHmSBqQkzP6Znw43Q==
X-IPAS-Result: =?us-ascii?q?A0AEAADHf6No/4r/Ja1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBgX8FAQEBAQsBgkZ6WUNJBIxsiVWDAYhmkjaBfw8BAQEPRA0EA?=
 =?us-ascii?q?QGFB4wmAiY0CQ4BAgQBAQEBAwIDAQEBAQEBAQEBAQELAQEFAQEBAgEHBYEOE?=
 =?us-ascii?q?4ZPDYZdKwsBOgyBPhKDAgGCOgM1AxGxcIF5M4EB3jiBZwaBSQGNTHCEdycbg?=
 =?us-ascii?q?UlEgRWBO4Itgh9CBIElhn0EgiKBAhSLHoVBgmkihlxIgR4DWSwBVRMNCgsHB?=
 =?us-ascii?q?YFjAyoLDAsSHBVuMh2BJ4UWhCcrT4UOhG0kaw8GgRWDZQaCA0ADCxgNSBEsN?=
 =?us-ascii?q?xQbBj5uB5NOgjlxAYEPKxdJgTOTTrJccYQmjB6PPoV7GjOqa5kGIo1mhAmRX?=
 =?us-ascii?q?GuEaYFoPIFZMxoIGxWDIhM/GQ+OLRaIca0rRjICATkCBwsBAQMJkWqBfQEB?=
IronPort-Data: A9a23:vjPcBazxduY3RJ84PVV6t+clxyrEfRIJ4+MujC+fZmUNrF6WrkUGn
 DcdD2uPb/bYZzH1ct51PI7joENX7JbRzoA1TFE5+1hgHilAwSbn6Xt1DatR0we6dJCroJdPt
 p1GAjX4BJlqCCea/FH0a+KJQUBUjcmgXqD7BPPPJhd/TAplTDZJoR94kobVuKYw6TSCK13L4
 IyaT/H3Ygf/hmYkazJMsspvlTs21BjMkGJA1rABTagjUG/2zxE9EJ8ZLKetGHr0KqE8NvK6X
 evK0Iai9Wrf+Ro3Yvv9+losWhRXKlJ6FVHmZkt+A8BOsDAbzsAB+vpT2M4nVKtio27hc+adZ
 zl6ncfYpQ8BZsUgkQmGOvVSO3kW0aZuoNcrLZUj2CCe5xWuTpfi/xlhJEMSGdwh/s0rOD1pz
 sMceGkpcECJ2dvjldpXSsE07igiBNPgMIVavjRryivUSK5/B5vCWK7No9Rf2V/chOgXQq2YP
 JVfM2cyKk2bM3WjOX9PYH46tOKyiXn4aD1wo1OOrq1x6G/WpOB0+OW2a4OMIYPVG625mG6Kq
 Hnp7m7ZByowLeWc2wLbwHSz2rT2yHaTtIU6UefQGuRRqFiJx2oWDwwhWnO7puW8g0+6HdlYL
 iQ88DAvoac/3EiqVcXmGRm5pmOU+xAbRtxcGvE77wfLzbDbiy6CGmUcTjNHQNorqNAxXz8y0
 kKMld7zQzt1v9W9T3+B+rqKhS29NDJTLmIYYyIACwwf7LHeTJoblBnDSJNnVaWylNCwQWi2y
 DGRpy94jLIW5SIW65iGEZn8q2rEjvD0osQdv207gkrNAttFWbOY
IronPort-HdrOrdr: A9a23:qn4Zma4OhiBjG+x2XAPXwPvXdLJyesId70hD6qm+c3Bom6uj5q
 KTdZsguyMc5Ax6ZJhCo6HiBEDjexLhHPdOiOF7AV7IZmbbUQWTQb1K3M/L3yDgFyri9uRUyK
 tsN5RlBMaYNykesS+D2mmF+xJK+qjhzEhu7t2uq0tQcQ==
X-Talos-CUID: =?us-ascii?q?9a23=3AW5ziYmgvjooIsrDzd31Ajaw1TjJucFn5nU7UCBO?=
 =?us-ascii?q?BVUFSd7nFEHuOqKk6qp87?=
X-Talos-MUID: 9a23:UANCjAjgXa8UMWYxrkc/C8MpJslzzLWkKEU2u4w/uNu8ax52JGvGtWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,300,1747699200"; 
   d="scan'208";a="533113776"
Received: from rcdn-l-core-01.cisco.com ([173.37.255.138])
  by alln-iport-7.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 18 Aug 2025 19:38:01 +0000
Received: from mrghosh-ub.cisco.com (unknown [10.26.161.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mrghosh@cisco.com)
	by rcdn-l-core-01.cisco.com (Postfix) with ESMTPSA id 72831180001DF;
	Mon, 18 Aug 2025 19:38:00 +0000 (GMT)
From: Mrinmoy Ghosh <mrghosh@cisco.com>
To: netdev@vger.kernel.org,
	stephen@networkplumber.org
Cc: bridge@lists.linux-foundation.org,
	Mrinmoy Ghosh <mrghosh@cisco.com>,
	Mrinmoy Ghosh <mrinmoy_g@hotmail.com>,
	Mike Mallin <mmallin@cisco.com>,
	Patrice Brissette <pbrisset@cisco.com>
Subject: [PATCH iproute2-next] bridge:fdb: Protocol field in bridge fdb
Date: Mon, 18 Aug 2025 19:37:56 +0000
Message-ID: <20250818193756.277327-1-mrghosh@cisco.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: mrghosh@cisco.com
X-Outbound-SMTP-Client: 10.26.161.178, [10.26.161.178]
X-Outbound-Node: rcdn-l-core-01.cisco.com

This is to add optional "protocol" field for bridge fdb entries.
The introduction of the 'protocol' field in the bridge FDB for EVPN Multihome,
resses the need to distinguish between MAC addresses learned via the control p
 and those learned via the data plane with data plane aging. Specifically:
    * A MAC address in an EVPN Multihome environment can be learned either thr
 the control plane (static MAC) or the data plane (dynamic MAC with aging).
    * The 'protocol' field uses values such as 'HW' for data plane dynamic MAC
d 'ZEBRA' for control plane static MACs.
    * This distinction allows the application to manage the MAC address state
ine effectively during transitions, which can occur due to traffic hashing bet
 EVPN Multihome peers or mobility of MAC addresses across EVPN peers.
    * By identifying the source of the MAC learning (control plane vs. data pl
, the system can handle MAC aging and mobility more accurately, ensuring synch
zation between control and data planes and improving stability and reliability
MAC route handling.

This mechanism supports the complex state transitions and synchronization requ
 in EVPN Multihome scenarios, where MAC addresses may move or be learned diffe
ly depending on network events and traffic patterns.

Change Summary:
fdb.c: Allows 'bridge fdb [add | replac ]' with optional protocol field.
       print 'proto' with 'bridge fdb show' except if proto is RTPROT_UNSPEC
rt_protos : new RT proto 'hw'
rtnetlink.h: new RT Proto RTPROT_HW definition
rt_names.c: String representation of new RT proto 'hw' definition

e.g:
 $ bridge fdb add 00:00:00:00:00:88 dev hostbond2 vlan 1000 master dynamic extern_learn proto hw

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
 $ bridge fdb replace  00:00:00:00:00:88 dev hostbond2 vlan 1000 master dynamic extern_learn proto zebra

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

Kernel Change Patch review: https://lore.kernel.org/netdev/20250818175258.275997-1-mrghosh@cisco.com/T/#u

Signed-off-by: Mrinmoy Ghosh <mrghosh@cisco.com>
Co-authored-by: Mrinmoy Ghosh <mrinmoy_g@hotmail.com>
Co-authored-by: Mike Mallin <mmallin@cisco.com>
Co-authored-by: Patrice Brissette <pbrisset@cisco.com>
---
 bridge/fdb.c                   | 18 +++++++++++++++++-
 etc/iproute2/rt_protos         |  1 +
 include/uapi/linux/rtnetlink.h |  1 +
 lib/rt_names.c                 |  1 +
 4 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/bridge/fdb.c b/bridge/fdb.c
index d57b5750..b308fe7d 100644
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
@@ -306,6 +306,14 @@ int print_fdb(struct nlmsghdr *n, void *arg)
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
 	close_json_object();
@@ -478,6 +486,7 @@ static int fdb_modify(int cmd, int flags, int argc, char **argv)
 	char *endptr;
 	short vid = -1;
 	__u32 nhid = 0;
+	__u32 proto = RTPROT_UNSPEC;
 
 	while (argc > 0) {
 		if (strcmp(*argv, "dev") == 0) {
@@ -555,6 +564,10 @@ static int fdb_modify(int cmd, int flags, int argc, char **argv)
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
@@ -615,6 +628,9 @@ static int fdb_modify(int cmd, int flags, int argc, char **argv)
 	if (via)
 		addattr32(&req.n, sizeof(req), NDA_IFINDEX, via);
 
+	if (proto != RTPROT_UNSPEC)
+		addattr8(&req.n, sizeof(req), NDA_PROTOCOL, proto);
+
 	req.ndm.ndm_ifindex = ll_name_to_index(d);
 	if (!req.ndm.ndm_ifindex)
 		return nodev(d);
diff --git a/etc/iproute2/rt_protos b/etc/iproute2/rt_protos
index 48ab9746..7ec06e1e 100644
--- a/etc/iproute2/rt_protos
+++ b/etc/iproute2/rt_protos
@@ -24,3 +24,4 @@
 188	ospf
 189	rip
 192	eigrp
+193	hw
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

