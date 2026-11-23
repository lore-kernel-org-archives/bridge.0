Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795429723;
	b=J1o9UAqdSSkIKOsazMOpyTaYM1NsvF51S6sQKVUrhYiZJshBirFp15w1C+rSsPtCZ8O8
	 HgWbfvaBgfZMAXfeGDTV4g+Wln0xKhVhVMBbWNWctxz6Cnak6m2egG+YjtPCsfSJzPYhh
	 8R2StWH+n4WaV70hyx68r+rJVBSQ8BRobEXZZB8R37+qLW8uLOKLvYYQRRfl37fFYdpZL
	 /KnOdhSoOiY6xHyQqu0Rlq4vLZ/m0WmP2JrrqXkJOBsDeBsJhuk0xldPfVBXNE6xjApXj
	 U7WYJctCUqAe1snR/5UU0UCXHp2uHjTEmCKa8LVhrLxsESLZrVIaTj2ZH/8wcoDeGkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795429723;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AW+DzSmH4Qpcnnf73oxX0bRUNYCJrzW9mky9pTU2XQU=;
	b=1yFzqEyiYh0UqPxf+Q1Qww4ELk0xKqttYxvz3+qzbT7rxvXO0LMq1vSg4dmDXhSMtokU
	 cwP1g5/eSKeAKBKCRW0GDNgYFPE2bI/doykCdEhWUQEZsoQuKxONRv6JDUnEkNT4PIsL+
	 Ik/K0xowMXLJ6oLKOSx7p2oPYRuOm5hG7F82q8TkNHMU7f2u0ld0izGhyE3SXNxMa52zh
	 cWvjjGkuyUrlXEKRntlv9VuR9VurpTX7DBt7bKT4tKBcADP89ZB0VST0d3l7SLHHXIdpK
	 eH6h74esb0jmVK1rffAMqMgf2H2qymV9LIKyUEs1obVGOmFF35S2RjXvoRvTZDpIPIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=URGKnC3P;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D20606A32E
	for <bridge@lists.linux.dev>; Mon, 23 Nov 2026 10:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8D20606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=URGKnC3P
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4a3e706b5dfso2028259f8f.2
        for <bridge@lists.linux.dev>; Mon, 23 Nov 2026 02:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1795429721; x=1796034521; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AW+DzSmH4Qpcnnf73oxX0bRUNYCJrzW9mky9pTU2XQU=;
        b=URGKnC3PRCkJAfLbzHPJf0N5sAh9JD8OJNidP82gmaYDwH0JgYfoGcF6j6aQ406XaI
         ORgmuijSMKg2ejyN/4xuURqaDLXO+xUzf5fd1M02tUho4yhZeFZeD0W5kafDAYTaFdET
         Qrf6ZSpMJfqoDhzEkFkmsdV5hTink1NXEA/hG+vQ68ac7QWsFjrj1lxaIRP089Po8GId
         /ZN/bXJmonbfSIlqdIn4pjZdO8QtbtwItasfHJepgpzt3ikqppZy7acrqb8lu2oO7dsk
         oMTNaF+4Qzx6djhV7ufC9v7n819iLJVPAJiyZvW1Sa0UxR6uPU0XVez4O4Zy3KNm5yts
         2I9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795429721; x=1796034521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AW+DzSmH4Qpcnnf73oxX0bRUNYCJrzW9mky9pTU2XQU=;
        b=pgTY3F1r6uNdJLI295WZQGqvRzRgaPJrmZeSjohvGd62qR0wbx+eB5ME30OODripkd
         2G3xkzuL2WZxSEVameMacz3uJ2OW8+gbqUGVO41F1rJgufkvDB+cHtPHD3burymX11B6
         YkWQAfNKWhSaevHP5t5nAs/UDQN7ydGg+cyEn3v6ui3cRxaf0/N7yWcUtu2doykKRltF
         IrmsWXmvMMg0+2cVRZFJxPBULDUWoRPhSlGWlld3ugTaxWUAhBhYyz08N1uJmmyGfg0p
         njhkn7MJjpUW6pp4XAElwPKb2CG72aNPRw5qQ+pMVdqc5xfoquWGPyYXbRQUb8MBLAJ4
         zIEw==
X-Forwarded-Encrypted: i=1; AL+hErHxlwXuJB8bnbGCBoCA2QxAV4GL7kYsl4seDY6AJShbrUX58sx9NlL5OskygtYdJDF99SJMkzQ=@lists.linux.dev
X-Gm-Message-State: APuU4Z8DgclZ85ibxa0CimQDbZhQXml8XxDEcZo5yCcUaSRG7vqUe4p3
	DrGyNWFu4rCOrdJCgEv19MQaXPYIX64VIjj8rYYQLuhA0AD8cKMq/c3WIky5DsDpLRqPnrrRFpg
	Ad3kGM6xrBQ==
X-Gm-Gg: AZFdTZeF/Hb+9oiiUaCJQTBKgOQxWVFaCySHRsviBnRc6NJiK2edsZ7cwWhJAcg+Gyd
	4EzpNS8dDUPZ+YrEsQRsrHvpmDMJj/l+1sC7GjBDfig8Dp+Vbw4Ktg/9Zom9MVAifnuILxK9RYj
	b+z92qzzBqqKIXSMSIpXY5yjDDJ1dPHXg6zG9eTerNloafKtuL0LA/5pozqrX8syjUaysGC212L
	0MfdT1w+4qD9gNh9wv5wS4jE9xgRT7BkpdVOH5cq1kJgXNL75TMoyroJ9kIS4c1UpnEXyj5+bQR
	tQ/RmilJqy8H2zpaNkXXtFh13BiQ2k6pLtB2BKhOiMFnT/klbCmFEeY6ALPD1p9B6AQqUsxnAe9
	3/4hePwIsU3YuOzm4JvV0/wUiq2HK/qrtzNzI2Z/AoeEnNcAxq07CesOsaJ8GybNCX3fyIKTZIU
	+tYVVVHDfSM889Qba1ltr7QYox5dmG5BnKuV2EZF3sJy5AysqP8AHY0JRZb0fxcFBTcykVM8Yqe
	t3nkYdAT+VO26/3KcTrOuKIVpPYQsSs8xBfzsCHpZv8EzJrDyCyKAvd2mz1CiOAaPmsoFfMUzu4
	3KsjxmtKYbAzqnn0c57eOfaX6RIawQAcoXI8zkC/dIq0rQV7d8PFnXwR8lN9CtMklzUuKLKo
X-Received: by 2002:a05:6000:4024:b0:4a5:2e5b:51c2 with SMTP id ffacd0b85a97d-4abb4f59b72mr21945148f8f.29.1795429720967;
        Mon, 23 Nov 2026 02:28:40 -0800 (PST)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4ab6a67f204sm24748138f8f.21.2026.11.23.02.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 02:28:40 -0800 (PST)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bridge@lists.linux.dev
Subject: [PATCH net-next 0/3] net: bridge: optimize vlan multicast forwarding
Date: Mon, 23 Nov 2026 12:28:30 +0200
Message-ID: <20261123102833.924427-1-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
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

Hi,
This is the last part of the patch-sets that optimize forwarding by caching
VLANs. It adds the forwarding optimizations to the bridge multicast code
and also optimizes vlan range add (see tables below).

Patch 01 - use the vlan already stored in the in per-VLAN router context
Patch 02 - use a small hash (64 entries) to find the port vlan groups
           without walking all
Patch 03 - cache the port-VLAN destination in mdbs to avoid egress VLAN
           lookups

VLAN Add improvement (patch 02):
Operation  VLANs   Global ms before/after   Change %   Per-VLAN ms before/after   Change %
  ------------------------------------------------------------------------------------------
  add            1      0.0519 /   0.0900      +73.52       0.0481 /   0.0895      +86.16
  add           64      2.2500 /   0.7190      -68.04       2.2726 /   0.7441      -67.26
  add         1024     32.7464 /   5.7028      -82.58      32.9841 /   6.3116      -80.86
  add         4094    149.6750 /  34.3223      -77.07     151.5808 /  35.4586      -76.61

Single vlan add is slower, but vlan group add is 67-80% faster. Vlan del is
pretty much the same.

VLAN forwarding improvement (patch 03):
  VLANs  Listeners  Mpps before  Mpps after  Gain %  Cycles before  Cycles after  Saved %
  ---------------------------------------------------------------------------------------
    8          4     0.785571    0.865156  +10.13         3771.2        3381.2    10.34
    8          8     0.454257    0.511490  +12.60         6900.5        6091.0    11.73
    8         16     0.249896    0.288575  +15.48        13144.0       11362.9    13.55
   64          4     0.765468    0.841916   +9.99         3881.6        3462.1    10.81
   64          8     0.437448    0.501744  +14.70         7153.6        6215.6    13.11
   64         16     0.238901    0.279188  +16.86        13690.2       11674.2    14.73
 4094          4     0.583447    0.695246  +19.16         5271.6        4339.3    17.68
 4094          8     0.293712    0.373710  +27.24        11001.0        8492.8    22.80
 4094         16     0.140026    0.191269  +36.60        23509.6       17213.7    26.78

Medians of 6 runs, 64-byte frames, one group per VLAN, and packet VIDs
chosen at random. Cycles are PMU cycles / input packet on the fwding CPU.

CC: Ido Schimmel <idosch@nvidia.com>
CC: David S. Miller <davem@davemloft.net>
CC: Eric Dumazet <edumazet@kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>
CC: bridge@lists.linux.dev

Thanks,
 Nik

Nikolay Aleksandrov (3):
  net: bridge: avoid VLAN lookups for multicast router forwarding
  net: bridge: mdb: index port groups by VLAN
  net: bridge: mdb: avoid VLAN lookups in listener forwarding

 net/bridge/br_forward.c   | 21 +++++++++++++--------
 net/bridge/br_multicast.c | 31 ++++++++++++++++++++++++++++++-
 net/bridge/br_private.h   | 30 ++++++++++++++++--------------
 net/bridge/br_vlan.c      |  2 ++
 4 files changed, 61 insertions(+), 23 deletions(-)

-- 
2.47.3

