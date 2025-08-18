Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9AC274B47
	for <bridge@lists.linux-foundation.org>; Mon, 18 Aug 2025 19:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755546905; cv=fail; b=oey0t4jnoUDuE1+7jKrRv7t3giYmmwkXXhyinJAoXKAyTHHCfZSBXopWLOW+ose8vJ8FrnPHLlK2YAevi6Jj+qLamehedqeGZL1bewKx9HZtALsrdt6LlYsOTRlrzEDNs1MyI/w8BuFdKUyS3MhgRYzaf5SmLQ3+NlcI6dNWlBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755546905; c=relaxed/simple;
	bh=oTh3e5RuKsuSnV+T+xC/1r9Ipufhl6tL1vusDQcPQ/I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xn5SlCnd8waK7EAJGvxNHXauELjf4ImlmYizJjDr42yT29qhwfrFiUiCdl6JlGwW/SapIitY6qKhxka3tQYl8D7BCqH6Ie0vYDrfFlPNFqS1DMwFYKBzB0dOi/J5QxrmSEfRadMtTfv+TG3D5yGRYChGFTb608d8ZzVSP0dNRNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=cUJ6odzi; arc=fail smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="cUJ6odzi"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5986640735
	for <bridge@lists.linux-foundation.org>; Mon, 18 Aug 2025 19:55:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -15.582
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mAo_c1_wnsVF for <bridge@lists.linux-foundation.org>;
 Mon, 18 Aug 2025 19:55:02 +0000 (UTC)
X-Greylist: delayed 427 seconds by postgrey-1.37 at util1.osuosl.org; Mon, 18 Aug 2025 19:55:02 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 6C907404ED
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6C907404ED
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=cUJ6odzi
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=173.37.86.77; helo=rcdn-iport-6.cisco.com; envelope-from=mrghosh@cisco.com; receiver=<UNKNOWN> 
Received: from rcdn-iport-6.cisco.com (rcdn-iport-6.cisco.com [173.37.86.77])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6C907404ED
	for <bridge@lists.linux-foundation.org>; Mon, 18 Aug 2025 19:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1890; q=dns/txt;
  s=iport01; t=1755546902; x=1756756502;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PwEJoTnBTCTIBvcgq0gvyTShCWAfuJ/8YjrEZGMULsA=;
  b=cUJ6odzi7jTe1/lS8WiTezloYIQQ0iqTgd58mbaA0ZeQK+tvB4ozQUT4
   J6pzt1vk8mzMAcAKWaSo40iIZW4KAzrgz0pCaigG0VX2W1NVCag7XTdyO
   Yjto/asIqwkcolGl6C316TLrte4CNrtAYVQTZ/ei2UO3Au95vy//jVTmr
   ll7jx0EwQu5ahgmFwUmq7oBL/0eRCXWV2FVVFSJLXPyLtpVHnPw0V30wi
   LIMLjloKVxp91szSXsz1HgV8jt1nwFOReyQ/dIU1Nqu0deZ5czOJEd7tK
   /dT+wssViQyZvGk+0YhvmN8M8DI43+cDELN8qM941FukM/0CZ324oOlyT
   A==;
X-CSE-ConnectionGUID: gq4TNyJSSbiarv3d3LSZbA==
X-CSE-MsgGUID: A7XmtT/tSOSrBhBxZSKl5w==
X-IPAS-Result: =?us-ascii?q?A0BGAAChgqNo/4sQJK1aGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAJYEugW5SB3qBHEkEiBwDhSyIeYJ+iGaUNQ8BAQENA?=
 =?us-ascii?q?i4WDQQBAYUHAowkAiY4EwECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBAQECA?=
 =?us-ascii?q?QcFgQ4Thk8NhloBAQEBAgEBESg/BQcEAgEIEQQBAR8QJwodCAIEDgUIGoJhg?=
 =?us-ascii?q?joDDyYDARCmFQGBQAKKK3iBNIEB4B8GgUkBiE8BhWwbhFwnG4FJRIFXeYFvP?=
 =?us-ascii?q?oIfQgSBYIQTgi8Egg0VRFKINoJohUGCaYZ+UngcA1ksAVUTFwsHBYEgQwOBD?=
 =?us-ascii?q?yNLBS0dgSd9hBmEJytPgiJ1gXdaP4NUEgwGaw8GgRUZHS4CAgIFAkM+gVwXB?=
 =?us-ascii?q?h4GHxICAwECAoEkQAMLbT03FBsFBIE1BZNEhGWBGHvFejBxCoQcjB6NPYIBh?=
 =?us-ascii?q?jEXqmuZBo4IhAmRd4UOAgQCBAUCEAEBBoF/JYFZcBWDIhM/GQ+XNK1AeAIBO?=
 =?us-ascii?q?QIHCwEBAwmTZwEB?=
IronPort-PHdr: A9a23:Qy8Q0xxe/uR7VrnXCzPsngc9DxPP853uNQITr50/hK0LLuKo/o/pO
 wrU4vA+xFPKXICO8/tfkKKWqKHvX2Uc/IyM+G4Pap1CVhIJyI0WkgUsDdTDCBjTJ//xZCt8F
 8NHPGI=
IronPort-Data: A9a23:fuqfS6K2/pbq1lv7FE+RgZQlxSXFcZb7ZxGr2PjKsXjdYENS0jYEm
 jcdXWnVP66JMzGhf4glaYq/8RxQusfRz4RgGgYd+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcoZsCCWa/073WlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDnRVrS0
 T/Oi5eHYgL9i2ckajt8B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKqFIHvS3T
 vr017qw+GXU5X8FUrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRuukoPD8fwXG8M49m/c3+d/
 /0W3XC4YV9B0qQhA43xWTEAe811FfUuFLMqvRFTvOTLp3AqfUcAzN1hFR0KG5w6wd19AGhU6
 6cUcxQ2XBqq0rfeLLKTEoGAh+wqKM3teYdasXZ6wHSBV7AtQIvIROPB4towMDUY358VW62AI
 ZNHL2M0PXwsYDUXUrsTIJckk+evnXnXeDxDo1XTrq0yi4TW5FApgeC0aYCFKrRmQ+18wXadu
 l6B41/eOQswNPaP+wGm9i+z07qncSTTHdh6+KeD3vRwgVGcy0QXCQYKTh2/oP+kmguwXM9ZJ
 0UI+y0o668o+ySWosLVVhm8pjuA+xUbQdcVS7d84wCWwa2S6AGcboQZcgN8hBUdnJZebRQh1
 0SCmJXiAjkHjVFfYSj1Gmu8xd9qBRUoEA==
IronPort-HdrOrdr: A9a23:gXeqsquuroeQ0zLhfNj9wdLI7skCOYAji2hC6mlwRA09TyXGrb
 HMoB1L73/JYWgqOU3IwerwRpVoIUmxyXZ0ibNhW4tKLzOWyVdAS7sSorcKogeQVxEWmdQtr5
 uIH5IObOEYSGIK8voSgzPIXerIouP3jZxA7N22pxwCPGMaDp2IrT0JdjpzeXcGPTWucKBJb6
 Z0kfA33wZIF05nCfiTNz0uZcSGjdvNk57tfB4BADAayCTmt1mVwY+/OSK1mjMFXR1y4ZpKyw
 X4egrCiZmLgrWe8FvxxmXT55NZlJ/K0d1YHvGBjcATN3HFlhuoTJ4JYczDgBkF5MWUrHo6mt
 jFpBkte+5p7WnKQ22zqRzxnyH9zTcV7WP4w1PwuwqhnSW5fkN5NyNyv/McTvLr0TtmgDi66t
 MM44utjesTMfoHplWl2zGHbWAzqqP+mwtTrQdatQ0tbWJZUs4RkWTal3klSqvp20nBmdsaOf
 grA8fG6PlMd1SGK3jfo2l02dSpGm8+BxGcXyE5y4eoOhVt7TlEJnEjtYQit2ZF8Ih4R4hP5u
 zCPKgtnLZSTtUOZaY4AOsaW8O4BmHEXBqJaQupUBnaPbBCP2iIp4/84b0z6u3vcJsUzIEqkJ
 CEVF9Dr2Y9d0/nFMXL1pxW9RLGRnm7QF3Wu4tjzok8vqe5SKvgMCWFRlxrm8y8o+8HCsmeQP
 q3MII+OY6UEYIvI/c/4+TTYegnFZBFarxmhj8SYSP6nv72
X-Talos-CUID: 9a23:AIaE2WFPJSSV6hy2qmJo7RIoPNEHSUbXzX7KPRS0UkJSere8HAo=
X-Talos-MUID: =?us-ascii?q?9a23=3ApZoniwz6sedTPEZlWC/5CtjaoaGaqI3xOEURrdI?=
 =?us-ascii?q?agO6/LwZwESevtxezH5Byfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-l-core-02.cisco.com ([173.36.16.139])
  by rcdn-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 18 Aug 2025 19:47:54 +0000
Received: from rcdn-opgw-4.cisco.com (rcdn-opgw-4.cisco.com [72.163.7.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-02.cisco.com (Postfix) with ESMTPS id 5BD8318000178
	for <bridge@lists.linux-foundation.org>; Mon, 18 Aug 2025 19:47:54 +0000 (GMT)
X-CSE-ConnectionGUID: oW2CHkTTQi+96HYc63nrbw==
X-CSE-MsgGUID: 7kP5+SNOTyi5ogLOH7lW3w==
Authentication-Results: rcdn-opgw-4.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.17,300,1747699200"; 
   d="scan'208";a="57538444"
Received: from mail-dm6nam11lp2175.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.175])
  by rcdn-opgw-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 18 Aug 2025 19:47:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YI4vX1H1vUjqQH5PpCZJ7Yuw9Ccn1goB9QJlHa8ewFo3XaLWKdr8Spuw27MIpIzDK3uTU++koMsJXR7I5aEFACb/vPCGx5WUl5w7DzlLNPucxGl2f+dxa4D+mG9yeGFhESc2G2EbJnPCTKCcDBQNalMslzkNE5/l200h1MTHRG6iBcBD/UjCWh3xHf5rWdS3eTb5aPMa04QbHWClVCBRiOfnE2CNVTyMnIwuNmqNoiFIsyZaSLceAVf3NXz33GWOQlNf9SYXKsJd0qbysk2Yb7q+Kzw2+52JUoQnJBl07FMIl4jB8NzWarMmQKOkB2xKNoVNH8LkS5Mwe+tJcN5LMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwEJoTnBTCTIBvcgq0gvyTShCWAfuJ/8YjrEZGMULsA=;
 b=l9UvppfUNiMkaSJNEJKTWCT5ly4TFdtLsNtEevpvT/GUAns0ZzgGY00+NHp8HDc5R/ZSjfIo7G/cU3aCNdAoGoseHV2PO/tQIYFDQh0pnxTDB0xRW4QNpRqWOuRYkwYmLW8L5Va2DTdjS+t6MrSLcm7+o6TsvyLTJLC185BgreirR0l7KcrQH2K0mlveLwSbS5ucg6eEevXLMoeyOmP9yD5CLPg4mlc4Oo8efHiwJ6QOX/yxFt6ph5xmVkEGAo4sLCpmG0SeYWRUeuiQ8HwawETN0EaRy6B+6KSPmzTFN92h/ho4LGVSKUA/Wr1j9KIVACnpLg1X0kQYjvjAisGj4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from SN7PR11MB7491.namprd11.prod.outlook.com (2603:10b6:806:349::8)
 by SJ0PR11MB5200.namprd11.prod.outlook.com (2603:10b6:a03:2df::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 19:47:51 +0000
Received: from SN7PR11MB7491.namprd11.prod.outlook.com
 ([fe80::4b22:100c:8231:120]) by SN7PR11MB7491.namprd11.prod.outlook.com
 ([fe80::4b22:100c:8231:120%3]) with mapi id 15.20.9031.019; Mon, 18 Aug 2025
 19:47:51 +0000
From: "Mrinmoy Ghosh (mrghosh)" <mrghosh@cisco.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>,
	"mrinmoy_g@hotmail.com" <mrinmoy_g@hotmail.com>, "Patrice Brissette
 (pbrisset)" <pbrisset@cisco.com>
Subject: RE: [PATCH iproute2] bridge:fdb: Protocol field in bridge fdb
Thread-Topic: [PATCH iproute2] bridge:fdb: Protocol field in bridge fdb
Thread-Index: AQHcDmfg/HByRIHOeUmtdsgj6F/OWbRldqeAgANcO3A=
Date: Mon, 18 Aug 2025 19:47:51 +0000
Message-ID:
 <SN7PR11MB7491F1A40BB259F4EF7603C4A431A@SN7PR11MB7491.namprd11.prod.outlook.com>
References: <20250816031145.1153429-1-mrghosh@cisco.com>
 <20250816092051.1a8e4ed3@hermes.local>
In-Reply-To: <20250816092051.1a8e4ed3@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7491:EE_|SJ0PR11MB5200:EE_
x-ms-office365-filtering-correlation-id: e0ae95a5-731c-49c2-5bbf-08ddde901de6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|13003099007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?dAxrMmTT2gP8L2vuV4pCqKhtT4bmjvRxa+JcX0u3APuFy5jViuSuxkncTzBs?=
 =?us-ascii?Q?GqgIFekNQQSCa9+1q6+ttfUUdsJXfWCcvNVJjwJhwyehqqWMGcjIChg6/ikp?=
 =?us-ascii?Q?A9nggwG4jJchgEfwLPRwuUfEWK5KKlJWJAQfomsE/jCMFqj2GOqPyhh5mkeg?=
 =?us-ascii?Q?W//UxccvqO75TdQ90vkAJje6d+uEc6j5+aJgpW5nt5SP6ItAwe2d36epZdUa?=
 =?us-ascii?Q?8rF/r4IJPkkiAGqXzctrAaDMlTHvsEbGHgNW2yRPkNNIlSZ4+3McADE/QLHG?=
 =?us-ascii?Q?pkelYeGPPk0GeZ5n8kvXfrVg9Nht+/MqerBLyT5+7OSEsNhQSTgRTkbpDyjH?=
 =?us-ascii?Q?V3+r3pB9XHEWhECewSx5+NPHZVDznWqiBCO4TBSt1ADvVwCOMAtQm3kTTRoI?=
 =?us-ascii?Q?9VqXCuon34oYvBP1qRa3Q3C9OokvHo7nFx2o12rGM4iZmyCsYytEoR+FpVYO?=
 =?us-ascii?Q?ru2st5Wj+g3G6ufoQ+P2i7onDm0rPIlDhGO78qEOtRWaCA+ofQdjmty/sgQb?=
 =?us-ascii?Q?7ZapRfO2J4PQOUdvJhXh7wqi9Wr35jG/oaZ95TaZqesWfNh0nheOj3XLkxgC?=
 =?us-ascii?Q?6pWToa6g2TDZLlxaVtqrRUilJXfnyA0nx70pcp6RG3DVJxpCansgJ9SCc7+j?=
 =?us-ascii?Q?KsbjDUk0B3lp50X+Z28psrPUK8lE0N17gBY96bCqarNyI+b1YiaGSkGNmAKW?=
 =?us-ascii?Q?LjPcPAsgT5u3te2gHQuv4XKuisM4R3omqjoYpM3agqMOphLDoejZVC4vRANg?=
 =?us-ascii?Q?dYffGV4E+/jT3pAZKqGIk79M/dnta+rGuuq8y64mK4MEZ0eg/P4VVSVrMNcZ?=
 =?us-ascii?Q?LM6Ix/a1kqXzUTLdHm1Oh9h9lgA+OnoCqq8SQHtmur+PnTZvVfsJce6KOwVG?=
 =?us-ascii?Q?nGYFvlN30DTuPnlkcGKsexPmxJgcmLyteIR4yDhLtueHsypMpEqnnG/PPuJ6?=
 =?us-ascii?Q?gVsUNDmksoDY846u43hzIBmG4vhIcFd3iYutrDdX2FbOR8PRrD149WORZVtk?=
 =?us-ascii?Q?dtZ1kPPvyFmQG0/CPvu60VIkFEnE24llWjUjlGGKvymYNri44pkTsKmmsa/u?=
 =?us-ascii?Q?qMfpCojTb+/jpF+wBXYWKmtZkdSIPSqiEQ6edSMBlJGbpt2VSz+fcKNzYPog?=
 =?us-ascii?Q?ikXT5W1+8Amex5UD+EGNdLXAr3bYtgRX+bWufuYzYQ4kugxksFRL+QpzbOMa?=
 =?us-ascii?Q?7PDVYkWd+nW2AWTdzpoXngTgmQmNjAVITf2kN9pn4KT29+u5R+qbrxWTc1BN?=
 =?us-ascii?Q?3bwVkot/sBSCJkms3LOLLaCapG3tX7GDviNleTt8KaLG7hWWtq/ZlLz3GCl9?=
 =?us-ascii?Q?/zSmWrs2y/OiD3PL1rhjaTFpfOP8GlVnsHrZhtIoz0VzXHO4Nnk1YCBfGdEe?=
 =?us-ascii?Q?ow5HDmPBGwni9o1gHQ/0ECLg0HWazY9/vezWNk0KklDz4SPVmUjdqe3YrUar?=
 =?us-ascii?Q?FWtwhFzD+vBgJYmX+s1HYnfCzzQhqc6O?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7491.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(13003099007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?blXw4Frl8i+2oA4WfFYsoO4EA4KJnHaVyoDyo7643ge0f5tiPl38zFT12n0U?=
 =?us-ascii?Q?e0BmMCglx8TNkIOrTgLrV+nPwtRaK50O9pVsUzWkEz9nT9aJqXFbGb3fm6pX?=
 =?us-ascii?Q?cjV1UvqJgSdvRR5a+oubpOgVLFN1Nr/4qsqVqctqgo3dG/vUtWBEde10Bcy+?=
 =?us-ascii?Q?nkz14Fsg4uczpVtzkFB5kEeVEH44s+o+QQKSQhJvtrBNt3MIv8YWEX6ybGVD?=
 =?us-ascii?Q?nAp4ydyCh/ihouyw6IbX9QRgFxrN6nZVRagwbZYHSmDehuJBcPY8z17dpdfI?=
 =?us-ascii?Q?MtGxauMZjXzTe08mN8PFszAzdXMxndIqMa4Lt2RZR6KLFuIMEizSkL1jR3tS?=
 =?us-ascii?Q?oqPl3wNtgeOB+Sagi7DnQzNiJBcFWtv5BQpbyGVqNl/5rqbXveqvBDAdSPSM?=
 =?us-ascii?Q?cdgb3QOHvAwIx0VUawa5zr1bDDt6sf3lrV5Np4reyqRywk3YgUf7IVmBYR5l?=
 =?us-ascii?Q?SoD6kMZKcGr/sDs7zmlvC3WeLOkjg7/J/gtB02dUPUV6y7dMVYXi/xII0UCT?=
 =?us-ascii?Q?fy4JJ7tQ9tmOYnz2yQn66bOiu3gAC21kmWM+tGakDSDQp/u1sZYvYD+cfFNY?=
 =?us-ascii?Q?uubOCr52QvSnvHQ+eOzF3AyiHWvaXMYXaR4S7g8LBeDLCvxHai9CpArUUqHV?=
 =?us-ascii?Q?sl4HhPzAXZQpNWIdfPkixW4unhYQNSCFzUstxHepYo+DgKMuZVAZQMWr//LV?=
 =?us-ascii?Q?csLPTyaiiMJFPYxT86vXTCpSXapzYJP5kYkgEmEksMsCGX8+L06wJiLu42li?=
 =?us-ascii?Q?BWH83m7w1xVjXs7rSU5CV55QX63L7csoyCuS1g8uqcimlWXTaH3WpiGc/Jny?=
 =?us-ascii?Q?r4fNK7dt+clswEeW7wkuut4CAYsI6GegiFx0v1vV3A7Gj1dfSmuvfrhX/YFj?=
 =?us-ascii?Q?LgUDo0hFRYL3/zvFIyQLQAwBJ7qvu+K/qoAaAL0lcogSZIFtDVtD0+Tdb52G?=
 =?us-ascii?Q?HQsH6K0NKnU7Hg55nFPy6hG8PJ9ZhV3VsN+12G7A1isZoosVzWxSGiaZnb95?=
 =?us-ascii?Q?+8Bza4z8xJFoiLhBYav458ZBdKh2m25rhaoS7mBiSa9x3KERgsW6UVHEZ9cK?=
 =?us-ascii?Q?zvPks6mUQUg5XZC1BILvibB1q1SVozr85dgJd1u+y9yLjT7V5wuI17MxbJSx?=
 =?us-ascii?Q?sPU4Tdp+SjNEKQXia+r8UVh6xKGWjtsHDF+9IL2VYueRQIFcqbg5A+n0MMUu?=
 =?us-ascii?Q?7qkl6dU6zRuqsWp9q6vcB2RlsZZvB+ayxmI6wS0jHwrkqDpMzScO6UhMcoOE?=
 =?us-ascii?Q?wsOzZfXF2EkQFg5drU02q9xHz5+IVBGgmjoCp6YMR2DA4lxUvhlJ929QG6w4?=
 =?us-ascii?Q?Ihjs++cMAg1gcTFxNAjBx/kb2xl+RKD3KsYCudPWvZDOeVNUKo7Z9IdT8qnK?=
 =?us-ascii?Q?iKmek6hIurzx2tJCxViHz1isdOAt/WJKsS/MBYzTAOLI5dlstht5Fz1L1+yU?=
 =?us-ascii?Q?rcys6Sl1ekvN06JLxshxf1hxbbKo8Rhd5KwpXNGU3+RvKs7qG29eWy1HFap6?=
 =?us-ascii?Q?qoT0Oer2A0r1aDtkBuj4v7jFArR53sTIUKMLQTD+QEotE7MpWqsGq9S+g6TT?=
 =?us-ascii?Q?9FoUF8ad4rj4Fj6y28w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7491.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ae95a5-731c-49c2-5bbf-08ddde901de6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2025 19:47:51.4370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VSTBG7VI403FNUVdphpgEkS+mD/tAyCze+gQwnWJuHzrlBhgKURbb948spj9slaXHe9vIphkFv0wm+2FbEt2IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5200
X-Outbound-SMTP-Client: 72.163.7.165, rcdn-opgw-4.cisco.com
X-Outbound-Node: alln-l-core-02.cisco.com

Hi Stephen,

Thanks for the review.
The kernel patch is in:
https://lore.kernel.org/netdev/20250818175258.275997-1-mrghosh@cisco.com/T/=
#u

I have created a new patch review request for iproute2-next. Updated, the e=
tc/iproute2/rt_protos based on your review comments:
https://lore.kernel.org/netdev/20250818193756.277327-1-mrghosh@cisco.com/T/=
#u

Thanks,
Mrinmoy

-----Original Message-----
From: Stephen Hemminger <stephen@networkplumber.org>=20
Sent: Saturday, August 16, 2025 12:21 PM
To: Mrinmoy Ghosh (mrghosh) <mrghosh@cisco.com>
Cc: netdev@vger.kernel.org; bridge@lists.linux-foundation.org; mrinmoy_g@ho=
tmail.com; Mike Mallin (mmallin) <mmallin@cisco.com>; Patrice Brissette (pb=
risset) <pbrisset@cisco.com>
Subject: Re: [PATCH iproute2] bridge:fdb: Protocol field in bridge fdb

On Sat, 16 Aug 2025 03:11:45 +0000
Mrinmoy Ghosh <mrghosh@cisco.com> wrote:

> diff --git a/include/uapi/linux/rtnetlink.h=20
> b/include/uapi/linux/rtnetlink.h index 085bb139..1ff9dbee 100644
> --- a/include/uapi/linux/rtnetlink.h
> +++ b/include/uapi/linux/rtnetlink.h
> @@ -314,6 +314,7 @@ enum {
>  #define RTPROT_OSPF		188	/* OSPF Routes */
>  #define RTPROT_RIP		189	/* RIP Routes */
>  #define RTPROT_EIGRP		192	/* EIGRP Routes */
> +#define RTPROT_HW		193	/* HW Generated Routes */
> =20
>  /* rtm_scope
> =20
> diff --git a/lib/rt_names.c b/lib/rt_names.c index 7dc194b1..b9bc1b50=20
> 100644
> --- a/lib/rt_names.c
> +++ b/lib/rt_names.c
> @@ -148,6 +148,7 @@ static char *rtnl_rtprot_tab[256] =3D {
>  	[RTPROT_OSPF]	    =3D "ospf",
>  	[RTPROT_RIP]	    =3D "rip",
>  	[RTPROT_EIGRP]	    =3D "eigrp",
> +	[RTPROT_HW]	    =3D "hw",
>  };
> =20
>  struct tabhash {

This is iproute2-next material.

Where is the kernel patch for this?
Iproute headers are synced from kernel headers.

If you add new RTPROT entry also need new line into etc/iproute2/rt_protos


