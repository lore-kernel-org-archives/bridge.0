Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793284547;
	b=Lwb/2t3D5hTnVS8P9QSRzeZXhWkvW5/d5Lvjj1KiWoPeJXDJKJHOu4wN1sDvnISXrxeZ
	 8wShDJCKwfN9pVOq2p+1BXKsz+nI9FTW8VxHaCM4YVKcsMHq8yQLcaiOyoKNw5y8gw5TG
	 3r6YF7bfyic75JhepZYXq3pMio8qbBbhCRnMFiS3vwKrAQZp7Gh6gitY9yDoCIblC50sA
	 zwpujmMhIB64xRVDlWiTHD9iPOR77eHsClAkhyZXBNedpgBuuI6/6i0PDY28CFnd7mxI/
	 QMzOFHKs6Tmbm79U7zKD+SpiiHPEtHoX6538MyxPmqC0rFJXt3wDZphP5LFadX/5UcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793284547;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=l6xcxDtlzQpcugPAaSZmvKKzHwB4F3KDnx148FqKe9A=;
	b=2FQ5QRi0zSP7N4U2BjWR+TZEAVj2UUgklBlSkk5TVfM/zZ6ApaOzqcCsdLvDO3Yi8GLv
	 AvAur7HW8NPQsYK9cOF65Pnact2D2OR7IfeYGnjx5/08cu50mNUXj4Hv3JtimDaskYzKd
	 4Xq15LTLRdoQxyZIlM2N3O3DpHTraaQpjx75ufWz9mCxqDBKpwSQNwpawt6R2zioYvP5L
	 C3c/d1H3ifRi70eHvZrtsAFiPgViibu1DqE6D2M7ADbW9QcBeHTX8eN9g+yNdnQfaYbcE
	 YzchB11nYNTIvMu4o7HtKehcn82aw64BGGzUP2ZIHFsZxY6m0R4i4sFp934Y1fB84xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YwQmvSmw;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A10E606A323
	for <bridge@lists.linux.dev>; Thu, 29 Oct 2026 14:35:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A10E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YwQmvSmw
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3535a54bed9so3176960eec.1
        for <bridge@lists.linux.dev>; Thu, 29 Oct 2026 07:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793284547; x=1793889347; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l6xcxDtlzQpcugPAaSZmvKKzHwB4F3KDnx148FqKe9A=;
        b=YwQmvSmwZhp9h5pXFHcrEdfK+AW9WRs/f28ahebSqOsz02FcE8ZOCnyHM0lcPZcgX9
         DFEqiR9mPEjT1cufjw/xPX/8zwNduhmpm+fwXzVTMS+DfCIdZGwXl+gKdrfWGbDBSRIG
         qkfhvbeugetvfUysdwiX+OPY/vFUiBtVafwDsA585gGVHJL6aE1QDT16YqM5PtFCc3ei
         hatpncEFJaAOBaI4jUS7G9eu/MRDpA3Ywx3F31X6GxuJ0kezz+y48S3cRK07hw+NJ/mQ
         XYJhKMhtRR/ilJw5vms9IbfBMBTtxCuRrGnTe5fPc/Wnzn3V86B6d9x798jMcWZ8xMsD
         DD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793284547; x=1793889347;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l6xcxDtlzQpcugPAaSZmvKKzHwB4F3KDnx148FqKe9A=;
        b=yA181G2B+EsV0/cRpFe1fgb2aEkI27jJ7peWH1m7Pxdw4jFvoG7vYgdEIQ25gYnX55
         xalXOoids2RYduxH9P6S818JWHUT6t6Vv2bi0Uit2OlApKuzCtzjxprqk0TKT+YLrFar
         qWZ414WqHeiKPbTF2LJ1vmtPgn4AbHw8Crck0XMs/T0ei0+qrEWK2rMgM/+P7yvQh6Gu
         cRsVoWWC0er49QEy1sPB1FfdejSye6uXcWIVfvcI93qmrqTl/dzE4IUvMkFRoJ1OP2I8
         N4sG+Lhb3+mkxLdw2rhTe3f0hKJdxO7zuz89d2hbXzD3h8JdCszXOQBFMM0kFXMpF2OI
         +wNw==
X-Forwarded-Encrypted: i=1; AKwUvBwCXVv2Xajni/hnEMYJOAH+zOX/i4WnoU/SRE2mxorMmdMTKn7QGgVDxK45UhvTh08m4Zt3Z6U=@lists.linux.dev
X-Gm-Message-State: AFq9FYLhDz2Tlf+YJR0lYK2Rp3WzNyPjHfiH8O6+hCcow7ciGS1/QnNA
	QANbIIP92wDtJDMasAbU5rj4e3ytVj2I9IldGgCX83seAEt3nTgs/5d7
X-Gm-Gg: AYBFou2oeazUWFE0XpWgnU02ciGZPA7GJN/QQi0vvPUElP6oKtJjOYsHbkWi0TJTEtH
	TzgYNlU8EBu/hK7gR+pPYr86544YJ/lEgUVssLKyOSmrfOPtzMyoPHXSSrHUZT4Am+2dWYrqJM4
	dUcLay71WPt1nom3TYd4H61mn1vo9/gzY/kA1SEcEEP+IVM6j7hqzp89rl7BEYRdeoCjeh7j1Xb
	B0391tc4i6A+d/sKNgDr7myvB7YDrQ+RCD6ONK8IzZfka0pA2uxm2E/3ENgz4mZ1HcB3P4vGvwa
	zSZBE9702iJiH3IdLO6gcYUa5sduYaW2goyrWPDE9OcGXJ5fPkthxjzd8fow2U+eXkxe6pYmQmp
	F2foJYWXxZHs//+WA1545EL18kOnjA4bi1onC7l2/0Yk+1WMtH0C25nJ9EdAQZjSY4tG2iY9+A2
	dwF98lt5TrxXNIHy1MkpRDBG3ue6X2B3QWKB9gA4WEJtwV9NSjVH6R1x0OGHTTsgD+/Z4b/7pvn
	jMyqUP/TaeemhAqMmK5xue1FoY4qhl9TSTN4k7KonZ28LResEHZCR0zOB7jPkOEBsXmOb/2feo4
	XjNBK5ZO90NsXwD5Pv4RgdC09fj7FwUytadRW2fR+nbZIJM1AGeHL9VCzwTnm2NXoBhshBWGq4A
	=
X-Received: by 2002:a05:7301:4701:b0:359:8492:20ff with SMTP id 5a478bee46e88-36a20393e95mr6826737eec.12.1793284546478;
        Thu, 29 Oct 2026 07:35:46 -0700 (PDT)
Received: from [127.0.1.1] (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a2395bee6sm17248533eec.21.2026.10.29.07.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:35:45 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: netdev-bot+sinfo@kernel.org
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bridge: mcast: release the EHT host budget for
 zero-address hosts
Date: Thu, 29 Oct 2026 07:35:34 -0700
Message-ID: <179328453413.1172981.17449459861301643018@gmail.com>
In-Reply-To: <179328352676.3327.7322681510650096532@kernel.org>
References: <179328314076.648427.17991367257682028617@gmail.com>
 <179328352676.3327.7322681510650096532@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

The PoC sends an IGMPv3/MLDv2 report from the unspecified source
address, creates and deletes the corresponding EHT set entries, and
observes that the host's num_entries budget is not released, while the
same sequence with a non-zero report source releases it.
