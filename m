Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A169138C
	for <bridge@lists.linux-foundation.org>; Tue, 26 Nov 2024 02:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732587857; cv=none; b=D1XLmYa/NqgAwE1CqhgQoPsNvekRQoDsxbKacg6pIRfVNQC4O517OcHVLSz/S0Eypo1VsO7tpImryTJDpr9ls6juGf5xXR2jyOpODv61HQ5ElEkJ8c6uwbuONo6OZ9lML232Ee0ATK7gXtv0C/5bKRCxOW30RP5NN+fI5qiOSdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732587857; c=relaxed/simple;
	bh=dqn+22mLMBFKN19NER36d/kkeWRSefiSGaWLiUbesh8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gOzdFFcEvTZLp6lTHBVtVPLLvLfbbLVeHh8nk2TEg7KqNd0LipehEYiRhk25St4GhnzmUvv44YhyPtZxGWgFEmmhGA3VyF5ZFkjKZPUtopLe9CuHbBzC/KUjvTth6czTJ/3vlYSMlE6ratlHyEG2ICLys0OffO6FG5LtiC4IBEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB69485058
	for <bridge@lists.linux-foundation.org>; Tue, 26 Nov 2024 02:24:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.19
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZH4VP7mcuOZV for <bridge@lists.linux-foundation.org>;
 Tue, 26 Nov 2024 02:24:13 +0000 (UTC)
X-Greylist: delayed 306 seconds by postgrey-1.37 at util1.osuosl.org; Tue, 26 Nov 2024 02:24:11 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org CAF1A85050
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CAF1A85050
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=124.126.103.232; helo=mailgw.kylinos.cn; envelope-from=heminhong@kylinos.cn; receiver=<UNKNOWN> 
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CAF1A85050
	for <bridge@lists.linux-foundation.org>; Tue, 26 Nov 2024 02:24:11 +0000 (UTC)
X-UUID: c808083eab9c11efa216b1d71e6e1362-20241126
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_UNTRUSTED, SA_LOWREP
	SA_EXISTED, SN_UNTRUSTED, SN_LOWREP, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:d5ae44ce-c823-48a7-af27-e769f57a09f7,IP:10,
	URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:3,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:33
X-CID-INFO: VERSION:1.1.38,REQID:d5ae44ce-c823-48a7-af27-e769f57a09f7,IP:10,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:3,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:33
X-CID-META: VersionHash:82c5f88,CLOUDID:d4c66fa315b9db6f1c8ddd0e86fb86ed,BulkI
	D:2411261018554LEOE9NK,BulkQuantity:0,Recheck:0,SF:19|25|43|66|72|74|81|82
	|100|101|102,TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,Q
	S:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: c808083eab9c11efa216b1d71e6e1362-20241126
X-User: heminhong@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw.kylinos.cn
	(envelope-from <heminhong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1881880197; Tue, 26 Nov 2024 10:18:53 +0800
From: Minhong He <heminhong@kylinos.cn>
To: razor@blackwall.org
Cc: heminhong@kylinos.cn,
	netdev@vger.kernel.org,
	stephen@networkplumber.org,
	roopa@nvidia.com,
	bridge@lists.linux-foundation.org
Subject: [PATCH iproute2 v2] bridge: fix memory leak in error path
Date: Tue, 26 Nov 2024 10:18:19 +0800
Message-Id: <20241126021819.18663-1-heminhong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <385b4ead-8d43-4845-ac66-4218b285be32@blackwall.org>
References: <385b4ead-8d43-4845-ac66-4218b285be32@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'json' object doesn't free when 'rtnl_dump_filter()' fails to process,
fix it.

Signed-off-by: Minhong He <heminhong@kylinos.cn>
---
 bridge/mst.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bridge/mst.c b/bridge/mst.c
index 32f64aba..37362c45 100644
--- a/bridge/mst.c
+++ b/bridge/mst.c
@@ -153,6 +153,7 @@ static int mst_show(int argc, char **argv)
 
 	if (rtnl_dump_filter(&rth, print_msts, stdout) < 0) {
 		fprintf(stderr, "Dump terminated\n");
+		delete_json_obj();
 		return -1;
 	}
 
-- 
2.25.1

