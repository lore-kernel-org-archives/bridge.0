Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E958A15CD75
	for <bridge@lists.linux.dev>; Tue,  2 Jul 2024 12:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719922114; cv=none; b=TJPnGw7vZyyzy8R0XKnSVWrTZ9QNEeQhWWoK4TF17GKaAI0OZL98KniF9OBvngKgvuBzZFRvdr45CubloYYwv0d76cvMg0P0p5djQOFXysS/EZ8+dxWxVIqFI2Pv/tNc6PnnJbyizWXhP32SroaJ66r5Lk6vUZVCnwH47ulkJHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719922114; c=relaxed/simple;
	bh=9eIa7E2SX1m1tEX0xIgUzdbIr1Wl1VNa5TpYucuVwRc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i+36YhWEa8sZaWhrhPB+djzK9twU4BXaquBRCRQRcyJrF1xQVi+QPJCXbpexLr4lH3llg5A5LLr/sq2sy03iC/P5ng28NyeZ4yj0IXbqEyAIKbTfMoLiATC9btP0aDIeb9r19LeZqdqFO7BEcbe7LlXpEvqh+Nn3FNw7drDHivI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=nh8xylLN; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="nh8xylLN"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52cdc4d221eso4486630e87.3
        for <bridge@lists.linux.dev>; Tue, 02 Jul 2024 05:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1719922111; x=1720526911; darn=lists.linux.dev;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xgQdQMdjhR92R38qSZNVEOOBIPnKqiUX7hdimYEwX3o=;
        b=nh8xylLNJakq40EPI4pcP/+tlTlgl7/mK5RooBqjyI21SeMRaiFLPBDlkoio9oipeq
         wu511R9/UGDmD/MuifT6zVBqwY133WNMJka2u4AeQJM8U1sUWgcA3v5/nS0mdlKSjsUX
         5cguqVpIbRDn9qocvLOjI4Tc34jCqE8B5oGR2O1VXYzZwNdWZ1wD7/GsARWaPA4fzLBw
         X/uOk3XFSf1iDKvkESBs8uNRxcV200Bx4+Jz4Zm0Tt6LLsaX6rpJ88kX12pls+26+H+a
         9CiT+sjAa5Pz9284/IhlbBtAQld1R6NTGxA+JF/oT49PuxgnXArjn5dt6TEAK7MLioC9
         t1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719922111; x=1720526911;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xgQdQMdjhR92R38qSZNVEOOBIPnKqiUX7hdimYEwX3o=;
        b=Ql/jkC5BC1PB2VvIEhqTDv5Fv5mBCUFlecoINFSjbI26x/8iEwLY174uNlFD9lC9g2
         7YbLWphejngqmZ9qpsy0pc5Yt18mjyIECMLJFbXb+3uX03OFlNYczhHLtFH76sMKUpxM
         oRIU6E5ht5Xy+d2KPMhkyZBsEFw2mlmL2pGwYTnlO+cYWxp7AxxFLi6RIF6qFZXvMVy3
         yQawga5fYuRUs99svj2+jcsMPId4MbSV4aVJ4J9b0gkuV67+rGt/KvCtQrBfnEGdRt/K
         CVQvMGqkTPYIxk2j9fZ06MqMUH7EBpBkO0nLFjprjlBSVn/8GKiiTg2CcdVvMr4sgMM6
         Zj2g==
X-Forwarded-Encrypted: i=1; AJvYcCUtpuc7xCHQUUG3R0qpjNhMgJROW40rUweWveuKF1vj2YuMRd9gYjr5LgF2fxIzYr1iwFXICY+eooeESluDYg2RaIhGsSDo
X-Gm-Message-State: AOJu0Yyp3K/cQaw+ea+Sko54MJkrVHypn9cINQG5U/dbUmvoYpLpHk17
	JANcXArO1V8XnXk+cSNeERo4rgwuXE5HAi7+f5Z0Z1ZiwvEBlIy1WiGMiwaENgU=
X-Google-Smtp-Source: AGHT+IF9a7ftKNDrAOgX8w4585WgK8NDzBb6lJXOWfgSlcymGaTYJe9zpCyUWmrbLNn+2S9C05uAVg==
X-Received: by 2002:a05:6512:3e1c:b0:52c:dfa7:53a2 with SMTP id 2adb3069b0e04-52e826f7609mr5987406e87.50.1719922110452;
        Tue, 02 Jul 2024 05:08:30 -0700 (PDT)
Received: from wkz-x13.addiva.ad (h-176-10-146-181.NA.cust.bahnhof.se. [176.10.146.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab1064asm1799414e87.103.2024.07.02.05.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 05:08:29 -0700 (PDT)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: stephen@networkplumber.org,
	dsahern@kernel.org,
	roopa@nvidia.com,
	razor@blackwall.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org
Cc: liuhangbin@gmail.com
Subject: [PATCH v3 iproute2 1/4] ip: bridge: add support for mst_enabled
Date: Tue,  2 Jul 2024 14:08:02 +0200
Message-Id: <20240702120805.2391594-2-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240702120805.2391594-1-tobias@waldekranz.com>
References: <20240702120805.2391594-1-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

When enabled, the bridge's legacy per-VLAN STP facility is replaced
with the Multiple Spanning Tree Protocol (MSTP) compatible version.

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 ip/iplink_bridge.c    | 19 +++++++++++++++++++
 man/man8/ip-link.8.in | 14 ++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
index 6b70ffbb..f01ffe15 100644
--- a/ip/iplink_bridge.c
+++ b/ip/iplink_bridge.c
@@ -30,6 +30,7 @@ static void print_explain(FILE *f)
 		"		  [ max_age MAX_AGE ]\n"
 		"		  [ ageing_time AGEING_TIME ]\n"
 		"		  [ stp_state STP_STATE ]\n"
+		"		  [ mst_enabled MST_ENABLED ]\n"
 		"		  [ priority PRIORITY ]\n"
 		"		  [ group_fwd_mask MASK ]\n"
 		"		  [ group_address ADDRESS ]\n"
@@ -169,6 +170,18 @@ static int bridge_parse_opt(struct link_util *lu, int argc, char **argv,
 				bm.optval |= no_ll_learn_bit;
 			else
 				bm.optval &= ~no_ll_learn_bit;
+		} else if (strcmp(*argv, "mst_enabled") == 0) {
+			__u32 mst_bit = 1 << BR_BOOLOPT_MST_ENABLE;
+			__u8 mst_enabled;
+
+			NEXT_ARG();
+			if (get_u8(&mst_enabled, *argv, 0))
+				invarg("invalid mst_enabled", *argv);
+			bm.optmask |= mst_bit;
+			if (mst_enabled)
+				bm.optval |= mst_bit;
+			else
+				bm.optval &= ~mst_bit;
 		} else if (strcmp(*argv, "fdb_max_learned") == 0) {
 			__u32 fdb_max_learned;
 
@@ -609,6 +622,7 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 	if (tb[IFLA_BR_MULTI_BOOLOPT]) {
 		__u32 mcvl_bit = 1 << BR_BOOLOPT_MCAST_VLAN_SNOOPING;
 		__u32 no_ll_learn_bit = 1 << BR_BOOLOPT_NO_LL_LEARN;
+		__u32 mst_bit = 1 << BR_BOOLOPT_MST_ENABLE;
 		struct br_boolopt_multi *bm;
 
 		bm = RTA_DATA(tb[IFLA_BR_MULTI_BOOLOPT]);
@@ -622,6 +636,11 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 				   "mcast_vlan_snooping",
 				   "mcast_vlan_snooping %u ",
 				    !!(bm->optval & mcvl_bit));
+		if (bm->optmask & mst_bit)
+			print_uint(PRINT_ANY,
+				   "mst_enabled",
+				   "mst_enabled %u ",
+				   !!(bm->optval & mst_bit));
 	}
 
 	if (tb[IFLA_BR_MCAST_ROUTER])
diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index c1984158..eabca490 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -1685,6 +1685,8 @@ the following additional arguments are supported:
 ] [
 .BI stp_state " STP_STATE "
 ] [
+.BI mst_enabled " MST_ENABLED "
+] [
 .BI priority " PRIORITY "
 ] [
 .BI no_linklocal_learn " NO_LINKLOCAL_LEARN "
@@ -1788,6 +1790,18 @@ or off
 .RI ( STP_STATE " == 0). "
 for this bridge.
 
+.BI mst_enabled " MST_ENABLED "
+- turn multiple spanning tree (MST) support on
+.RI ( MST_ENABLED " > 0) "
+or off
+.RI ( MST_ENABLED " == 0). "
+When enabled, sets of VLANs can be associated with multiple spanning
+tree instances (MSTIs), and STP states for each port can be controlled
+on a per-MSTI basis. Note: no implementation of the MSTP protocol is
+provided, only the primitives needed to implement it. To avoid
+interfering with the legacy per-VLAN STP states, this setting can only
+be changed when no bridge VLANs are configured.
+
 .BI priority " PRIORITY "
 - set this bridge's spanning tree priority, used during STP root
 bridge election.
-- 
2.34.1

