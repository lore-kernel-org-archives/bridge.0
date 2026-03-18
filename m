Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4476D366064
	for <bridge@lists.linux.dev>; Wed, 18 Mar 2026 06:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773816681; cv=none; b=RJ0jQTBNNW2J0ujLjKzoAr+8J5Ki0JxHVz3UGwaM4gYz1z1CEfO6g6z3lQqOK2/0hOJvKPIAUI8ZHw6SIQEJh6PVKLYnQ/2J8qst/sq0td1/hYGxSMgSwyunH61QPgjDzNI5kwOO3TaaxzKQ3Dw2kwpYlWbsR8lqLoTFkZONr4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773816681; c=relaxed/simple;
	bh=uDtdBqMRVAugjMyqIMXog1TMy4/UYJcnwI7IpRnZ0RU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jBdKlAoZjfhWcy21mYFNefaahxgCU8uV4Cdpn2ZZ9ltxUlmE0Mgl0PoVDbV2s/35f2JLXBzf21olKmcX61re/hIN/ekheZmNZcMWGR8qj21SXz/7usrMMI0bL60cuP3spytBtiQtV/kM/QGrE5NWKMqu1pIJxg8hK2n2PkDssPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kl17PUhZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gA7fTIPw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kl17PUhZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gA7fTIPw"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62I3ZuG62730262
	for <bridge@lists.linux.dev>; Wed, 18 Mar 2026 06:51:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dVw1W12K8D9H6jAvdaq/0zYSu/Z0gjDFdppar3Jnxls=; b=kl17PUhZxRh1ipMk
	QfKWvHUMbBvjkGTCMNRvLN4hojloY22pXsxAjetw8x6e2mwLwLFEi2xmMFk+15Ad
	qaM1pzD+SJPvz8VSfxZ/YQIGB2LaENg+rMRsCrJAwxdL3QDHYYe9GS7x8UmcTbwL
	RtFaxB+RHwwitvN5CtMNngGPf/yNsBX8eWTurUu4+tVYD6is4iJaDrN8F906NZ45
	wJHCINm1wSxoBXC9RQamycetwvV+EUsg9RT72pXU/NjOheBDWCiKVuQ1NJyd9ZOI
	owEduan2/PyBEEAELKJe8JDUlnrafg5/bC9cFknHOdJbjcSQnWX/sQTYZk50Fved
	WQdYmw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cy8kjuftj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bridge@lists.linux.dev>; Wed, 18 Mar 2026 06:51:19 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-509177a915aso50470091cf.1
        for <bridge@lists.linux.dev>; Tue, 17 Mar 2026 23:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773816678; x=1774421478; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dVw1W12K8D9H6jAvdaq/0zYSu/Z0gjDFdppar3Jnxls=;
        b=gA7fTIPwDS5mjI4r+W8Ax6buzcGb0nCWuMiis2Jv/1S5M0JUQJMHIb7PkhZZ3fI4oo
         bcu415sJfvgQQ86rfJ9ouuaetZWN9VW4m01y5jYLywJdTGOp3o8kcCUGLR+gVSmUW9vp
         +E1u9h+ctPzrxtKxfutm2CdB0vz5mfuw2H8X6vpzleyAy3GwEx2iFrKjcDKPLNlyigZW
         V+Gv5LRf7ukz2PkiuccVlbx9pcuHLqnb4kBtoHi15l7crEb+4yL7zyFFg1PBLp3nrtkZ
         3RF7GYbuUeUeUdaW7mDTugR2QGZms+jQdvY2bXVTR9rd0IxhsBR4kG++gzDaduD6Ooix
         gPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773816678; x=1774421478;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVw1W12K8D9H6jAvdaq/0zYSu/Z0gjDFdppar3Jnxls=;
        b=rYbK2blS2AIbNYMIyHejsGbiIH2X0zxI1ErXS4vbn/J+ajrLaWll6jF9Eh9M0hcg2V
         pyV7syHRQvCgXnmXBvlzCqg+p3DW24ASz59ozymkRj7CL+XCLM+QZPYN9Y0OoqeGTdoV
         iMmW4xPno1OLxHvWmh46uinX1hcUJrB5iMQdqrWZGX8kXZt34xjWS+bAR9vqOMl5BxxM
         O5vE2WaWuLpizAp9hvLu18mfrQ8zvwu81BAdyqoxWOcuGIRXIqWebob/HYgoFCbn926Y
         P4xj79JIGp2GZ5Jm6A268uoHwC2LZ7NFyL8t5SeMFKZniiuOEi4yStVAVwb8t5E8GOFH
         jEyA==
X-Forwarded-Encrypted: i=1; AJvYcCV9drGmjzfYZ699kvvUp6wxwS6nGnPNSJZmpvl9JRSVg/KWFSfwfE1WDNfUfL1EpTBbib/KWe4=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+6mvHkZ+YpgPSaTl16TY1bjP1WpM3MxwAll+oifm95GvR+lSU
	Z2P7faMxDYjbnJFRVt+Jb4wqcB0bqH79eLSXGb1tVhtT+drJ71AZc+lMBdL5z3ZrchCdSlXuDJY
	GHfj/FIVT2IRtAhU2OThiD1QTK0QvU5bHL/dUNKF2gJ8ZNxeVl2ri3oUBodo=
X-Gm-Gg: ATEYQzxwpV1lk4i+XJS0XAKVzoMjtCFBc40oAUToPeJs/bmc023EgGhateKVlxzgzzT
	sThFPwHkTxLciDgx1N5l0IMvQflWHJnHCvFlyM8Lmqr25+XYNAoZKjS/A2/xu0pA9KaCUFSTfuE
	irKUF49QRn74cpJKjqir2HyqTkwO91kV2rhwka80rPYVHFN8KrVer9cuS1waz+nGMIBgu0WAHV9
	j0BdPwbIsajb+MTHXeAzSFj3d6snMTHN0k4gM22+flFbBLISPilampygkbEU6MN99Nbos7XpyEE
	9L2lBvaqzyxedcm2xzF5Ray7o7/+BiXP6OZWtlK52eiVaPddVoXDyJrvBmg/EU702EvltVx+gG+
	/aP5ulrUnC3gxq4IFWwcpHBUmCC5NnAQMFX2QLNqfKdJ1FraM
X-Received: by 2002:a05:622a:18a2:b0:508:fe5a:a5bc with SMTP id d75a77b69052e-50997e5de45mr77980761cf.0.1773816678584;
        Tue, 17 Mar 2026 23:51:18 -0700 (PDT)
X-Received: by 2002:a05:622a:18a2:b0:508:fe5a:a5bc with SMTP id d75a77b69052e-50997e5de45mr77980081cf.0.1773816678050;
        Tue, 17 Mar 2026 23:51:18 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b51852ab3sm5409518f8f.12.2026.03.17.23.51.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 23:51:17 -0700 (PDT)
Message-ID: <69dd007c-16d3-44c2-bc30-4e7f5a95addb@oss.qualcomm.com>
Date: Wed, 18 Mar 2026 07:51:12 +0100
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10 net-next v3] ipv6: convert CONFIG_IPV6 to built-in
 only and clean up Kconfigs
To: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org
Cc: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Selvin Xavier
 <selvin.xavier@broadcom.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>, Simon Horman <horms@kernel.org>,
        Saurav Kashyap <skashyap@marvell.com>,
        Javed Hasan <jhasan@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        Varun Prakash
 <varun@chelsio.com>,
        Alexander Aring <aahringo@redhat.com>,
        David Teigland <teigland@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        David Ahern <dsahern@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>, Jon Maloy <jmaloy@redhat.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Michal Simek <michal.simek@amd.com>,
        Luca Weiss <luca.weiss@fairphone.com>, Sven Peter <sven@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kuan-Wei Chiu <visitorckw@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ryota Sakamoto <sakamo.ryota@gmail.com>,
        Kuniyuki Iwashima <kuniyu@google.com>, Kir Chou <note351@hotmail.com>,
        David Gow <david@davidgow.net>, Vikas Gupta <vikas.gupta@broadcom.com>,
        Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
        Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>,
        =?UTF-8?Q?Markus_Bl=C3=B6chl?= <markus@blochl.de>,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-rdma@vger.kernel.org, oss-drivers@corigine.com,
        linux-scsi@vger.kernel.org, gfs2@lists.linux.dev,
        bridge@lists.linux.dev, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, linux-afs@lists.infradead.org,
        linux-sctp@vger.kernel.org, tipc-discussion@lists.sourceforge.net
References: <20260317140141.5723-1-fmancera@suse.de>
 <20260317140141.5723-2-fmancera@suse.de>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20260317140141.5723-2-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA1NiBTYWx0ZWRfXwJ8dbhgX3p3x
 kDHXYKQT4JfO+3g9hbYoNCe+DF+OzQBupLoQH8vlMbqRLzWNQiR1CJH8vGN2QU66rp128UU/hnd
 Mu5SDQP84lxj0L4ERFAN/eGMQwAQ4LKY01mB4HOcxqclXFtna3CXmVpEccYQ8HcJPfGDWnevAXm
 CSrr2M6u25J7T5ZsPitOORRr1xDYcfr/UHeeTJKHmtan6l8ga5fLU9kd3If4m7KgHxMYS7tWxD2
 i6MhePfn336S0mTVhzDl+0osV6u8d0LX8NPzubaKr+NXEtPNjS2ybDD6qt3axX51/acfSBPo4US
 +UTl6K3aJJrY2eI7dPhUXMcpqIEzMzdfzYxdHG15ylvZlx2aAKSmOMpZa0oX9eh1bRpKLoS4a/k
 I3u94Wzj8h1MYbb2xXWzuSus9ICdD6TQbU8+brAbp9M7FJCJdMTI6/aZ1PY7FNUeyk/3wRvEtj7
 USi7AGfrBb7hOxzvGwg==
X-Authority-Analysis: v=2.4 cv=P8I3RyAu c=1 sm=1 tr=0 ts=69ba4b67 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=tBb2bbeoAAAA:8 a=iox4zFpeAAAA:8 a=VwQbUJbxAAAA:8 a=jkvUz-bvcPb0UOHwX5IA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=Oj-tNtZlA1e06AYgeCfH:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-ORIG-GUID: VQScRWpep8YgAaMo2OX3Bw5CkuHnJIq_
X-Proofpoint-GUID: VQScRWpep8YgAaMo2OX3Bw5CkuHnJIq_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603180056

On 17/03/2026 15:00, Fernando Fernandez Mancera wrote:
> Maintaining a modular IPv6 stack offers image size savings for specific
> setups, this benefit is outweighed by the architectural burden it
> imposes on the subsystems on implementation and maintenance. Therefore,
> drop it.
> 
> Change CONFIG_IPV6 from tristate to bool. Remove all Kconfig
> dependencies across the tree that explicitly checked for IPV6=m. In
> addition, remove MODULE_DESCRIPTION(), MODULE_ALIAS(), MODULE_AUTHOR()
> and MODULE_LICENSE().
> 
> This is also replacing module_init() by device_initcall(). It is not
> possible to use fs_initcall() as IPv4 does because that creates a race
> condition on IPv6 addrconf.
> 
> Finally, modify the default configs from CONFIG_IPV6=m to CONFIG_IPV6=y
> except for m68k as according to the bloat-o-meter the image is
> increasing by 330KB~ and that isn't acceptable. Instead, disable IPv6 on
> this architecture by default. This is aligned with m68k RAM requirements
> and recommendations [1].
> 
> [1] http://www.linux-m68k.org/faq/ram.html
> 
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> Tested-by: Ricardo B. Marlière <rbm@suse.com>

That's a Kconfig/defconfig only patch, so build system. You cannot test
it in a meaning of testing code. Building code is not testing.

> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

You removed important parts of Ack. It was not provided like that.

Best regards,
Krzysztof
