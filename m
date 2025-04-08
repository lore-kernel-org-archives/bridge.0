Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149F31C460A
	for <bridge@lists.linux.dev>; Tue,  8 Apr 2025 14:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744122396; cv=none; b=Uhq8StyZyzBgncAxjNip67/Z80gWA68SPxsfi/xnCt9RoIUiDRa/r1VOeuSZxtB3tbr20x8QqC7xp7Ucxzvfzht4SzRupOXHSXvXSNqOLTwPbm7ceQN9ekFVuULxa6cr573YAPFB5uSyPqMCoVzmLmjO4IBkL3ZNH/GbadTDyIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744122396; c=relaxed/simple;
	bh=l+rq4i8J5Ngw2JGG5LfWtQw/3Dy/KRpSN3Qn/Hiz+sg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NWt6rOyxNnzsA/BHl00OoZuYoHdmyiqSvs9bTAIY1R6z2zk0V25Sfp1rhOW0ej9/7PCcecKhiq7aedh7qfX5R2wOq8KpYnajcC1mXQN95Ya9kZBDJyleNzXcJ2blKkIewl826lZJO+QmofPbDOweVCQabfw8snCIzw8na58H8eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iXD0sdQ9; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXD0sdQ9"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abbd96bef64so1094434466b.3
        for <bridge@lists.linux.dev>; Tue, 08 Apr 2025 07:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744122392; x=1744727192; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nXIabCjmMZX+FDkTq1YmGQSIJSKoWD1ZNsXqU2bqHAc=;
        b=iXD0sdQ9p/ufMSCc2AFQyQcy7xRDhCyzMn1EttKgGXRU8K3k4V1eV+U6qqPs6GNgiK
         qrlRLIce3J7scMa61n2cWGVgOOyCx7e+EA0r/tdqOSUSUVmrLuIGb2wxJHjkbWADkuRT
         QhS5Mm/sIdWhnZCQATh2Nqpak9v4HXZ4u87WzmM5JaVLl8OXcMrdxCiW/n4i1pQqZd8C
         V+NhWs4RXG66aTXOIxju4q7PZ/vAqPm+1QqKyPKHWMPe6XPlkfUGhwr4WUHwdmd13G4C
         0AZaAoXBhYA4VnlDp3Ls7eB/XkYzH/dNC4tfpcjbYfrFUihFcOiu2/ce0RDVf3oimpTB
         0hHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744122392; x=1744727192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nXIabCjmMZX+FDkTq1YmGQSIJSKoWD1ZNsXqU2bqHAc=;
        b=cygku+c+jNzFyTadAbCJlx06E8KLZ3eyNRhY5MvHPZWSaTD7NzuZwQpRCcGdxPUggS
         nfEkZ1ZqAlBm0Hjg/bhWSf5/irp2QkRDoPE4RNVKgTCeSJC2dLBKvIOZePZuVcVfqAd2
         LWXio6b1NU5VHnvHIQ2xdJrE5AqIFfcwfVfCPjkBlKYt2ig6Zzrd9xy8flkaDJIrNgzm
         eXov7I2uZNgkp7ghlXHUZGOYin2vwZLJ6lkjEEkp8iRmq2mlcn+8rx9GlprewsaffJcJ
         gI/x3gR7siddc90I5IR+wivpSE3n7TRkrqEXgFxsPIWBOM/Suhrg9vUYJ26YewMoauHZ
         Tm/A==
X-Forwarded-Encrypted: i=1; AJvYcCW7V2glwiiZ5rzLvMr/cZ5GlpLcpZwxkp9heM61kZD2gd3c5jeGFQIx/5viGERLBBgpfbUSGFY=@lists.linux.dev
X-Gm-Message-State: AOJu0YwsIvWBWNaMpQANFElPMh0q8GZ6IP1W/UiCqGDaHHJORWcxs4Nj
	SATrfyJqt3pRFBJrYrSEqwXfjEESkF2N4fw19DIaSghZAbfh3kvn
X-Gm-Gg: ASbGnct0IIIR2sK5CWneQAicfriglB9zD3DLaH8f6CPl86EnjTJxDPSRw452gFZae5+
	Ealb7yawqJndHec/vS2PF4JvXn6RwBqzfsEdV/6gysTM8qWEmnN4OWxeFlTWi3xTAMyXNnwvs+7
	czpr1Xc/0TardGkJ6o5Z834StOxlpfGVJI/kaLbcGdLZGA4ek2QcVFfdTXekA22Jes9oh5W/WOh
	NaKubCl2ckmaFJbvt2OEmxvp1zW9g6q//OEgY2JrHA4uxkHz3k6LUnGbfUrG4yjfc9TvwZOkSzc
	9J6+mJEudsEkGL1hr1daphdxY9un9zjtKYIsZF2XfijzFzNcvuhye6q+1U8tNZiIdygzR4Lf5Q+
	qgMee7TnCyu9jwOFQTEbWYAB4JstH6U8Nz3zK8mMa0bQed2pQ58HHljQ+yz7m3f8=
X-Google-Smtp-Source: AGHT+IHhJGLMZljze0+v79hLavxELQKwwnzzaeNKQU7oqe/wMLuyNCH91Efq9UB9Y8f+2RQTaGEw3A==
X-Received: by 2002:a17:907:2d87:b0:ac7:391b:e68b with SMTP id a640c23a62f3a-ac7d1c1dfb0mr1456005766b.61.1744122391898;
        Tue, 08 Apr 2025 07:26:31 -0700 (PDT)
Received: from localhost.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7bfee2591sm926664566b.79.2025.04.08.07.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 07:26:31 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netfilter-devel@vger.kernel.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v11 nf-next 0/2] conntrack: bridge: add double vlan, pppoe and pppoe-in-q
Date: Tue,  8 Apr 2025 16:26:17 +0200
Message-ID: <20250408142619.95619-1-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Conntrack bridge only tracks untagged and 802.1q.

To make the bridge-fastpath experience more similar to the
forward-fastpath experience, add double vlan, pppoe and pppoe-in-q
tagged packets to bridge conntrack and to bridge filter chain.

Changes in v11:

- nft_do_chain_bridge(): Proper readout of encapsulated proto.
- nft_do_chain_bridge(): Use skb_set_network_header() instead of thoff.
- removed test script, it is now in separate patch.

v10 split from patch-set: bridge-fastpath and related improvements v9

Eric Woudstra (2):
  netfilter: bridge: Add conntrack double vlan and pppoe
  netfilter: nft_chain_filter: Add bridge double vlan and pppoe

 net/bridge/netfilter/nf_conntrack_bridge.c | 83 ++++++++++++++++++----
 net/netfilter/nft_chain_filter.c           | 37 ++++++++++
 2 files changed, 108 insertions(+), 12 deletions(-)

-- 
2.47.1

