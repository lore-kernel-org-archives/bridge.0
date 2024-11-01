Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B7812AAE2
	for <bridge@lists.linux-foundation.org>; Fri,  1 Nov 2024 15:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730473685; cv=none; b=aNysiHhNony14VqQdq6EyhhULjqdN2XJm2umzUAdA4tuBCjIC2SUlKiCDGKoRYAbf9rPCkdYeAIcH7WMGu7z6D/3iLixCR/QUu/y0MRJs3EHmQsoVJDHu4MuK02rMB6bAvSyxoEQWko5+B2UB0p08tp3NRLUZB0Gxfqa13820aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730473685; c=relaxed/simple;
	bh=Z6Dr2PgbqzIdIWSiIp258pot0TuM6/5gHcxvt7FOJpY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Tael8TtXBN1olZphJCKmjTtApjjawdKGFmjL1sN9wZRSc/HCVoiCCsriDBeAS1USTP13xNCoaWwhGBM6iLcBcnJL9/M+KScg9eXZjkqickx6cCpETlU8SrAqrCxRG7eKBVfr3wFc2Du5n+ePii8Vv3L7DiSVdpjM/wj+/PTRxdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 61C5A81926
	for <bridge@lists.linux-foundation.org>; Fri,  1 Nov 2024 15:08:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -6.292
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w4i-zvNRxBQf for <bridge@lists.linux-foundation.org>;
 Fri,  1 Nov 2024 15:08:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.178.238; helo=mx0b-0064b401.pphosted.com; envelope-from=prvs=1035e1bbb5=randy.macleod@windriver.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 46F9781F52
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 46F9781F52
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 46F9781F52
	for <bridge@lists.linux-foundation.org>; Fri,  1 Nov 2024 15:08:00 +0000 (UTC)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A18jBJp023074;
	Fri, 1 Nov 2024 15:07:49 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42mf2e934y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 01 Nov 2024 15:07:48 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 1 Nov 2024 08:07:47 -0700
Received: from pop-os.wrs.com (172.25.44.6) by ala-exchng01.corp.ad.wrs.com
 (147.11.82.252) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 1 Nov 2024 08:07:46 -0700
From: <Randy.MacLeod@windriver.com>
To: <stable@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <sashal@kernel.org>
CC: <sherry.yang@oracle.com>, <bridge@lists.linux-foundation.org>,
        <davem@davemloft.net>, <kuba@kernel.org>, <netdev@vger.kernel.org>,
        <nikolay@nvidia.com>, <roopa@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <randy.macleod@windriver.com>
Subject: [PATCH 0/1: 5.10/5.15] net: bridge: xmit: make sure we have at least eth header len bytes
Date: Fri, 1 Nov 2024 11:07:44 -0400
Message-ID: <20241101150745.3671416-1-Randy.MacLeod@windriver.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=K4dwHDWI c=1 sm=1 tr=0 ts=6724eec4 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=eMPNgDwjIQXpT8XC:21 a=VlfZXiiP6vEA:10 a=t7CeM3EgAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=owxRARuu7T3lYmZcKXwA:9
 a=FdTzh2GWekK77mhwV6Dw:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-GUID: BE-Q3zTQ4R7TRNS4izKP4odOP0PX-KoJ
X-Proofpoint-ORIG-GUID: BE-Q3zTQ4R7TRNS4izKP4odOP0PX-KoJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-01_09,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1011 impostorscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=993 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2411010109

From: Randy MacLeod <Randy.MacLeod@windriver.com>

This is my first commit to -stable so I'm going to carefully explain what I've done.
I work on the Yocto Project and I have done some work on the Linux network
stack a long time ago so I'm not quite a complete newbie.

I took the commit found here:
   https://lore.kernel.org/stable/20240527185645.658299380@linuxfoundation.org/

and backported as per my commit log:
   Based on above commit but simplified since pskb_may_pull_reason()
   does not exist until 6.1.

I also trimmed the original commit log of the "Tested by dropwatch" section
as well as the full stack trace since that may have changed in 5.10/5.15 and
It compiles fine for 5.10 and 5.15 but I have not tested with dropwatch since
the patch is just dropping short xmit packets for bridging.

Finally, since the patch is much simpler than the original, I've removed the
original patch author's SOB line.

Please let me know if any of this is not what y'all'd like to see.

Randy MacLeod (1):
  net: bridge: xmit: make sure we have at least eth header len bytes

 net/bridge/br_device.c | 5 +++++
 1 file changed, 5 insertions(+)


base-commit: 5a8fa04b2a4de1d52be4a04690dcb52ac7998943
-- 
2.34.1

