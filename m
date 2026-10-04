Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587BF4A99B5
	for <bridge@lists.linux.dev>; Sun,  4 Oct 2026 21:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791149082; cv=none; b=rt8D7LLulKAhc03kNVTKHufnUkRTqPHnJd66gQyfy8OOegDZnjGccx2YFqgtar91DaNZ4W5W5cTikMiBiWKixhSMZCywfSSVkweSuMLNkshZbm2SMYLnay4cbiXHmLL9376eb38E50hNScJ6NGNPFgdeU9f9UXNM0/Os6aDPHTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791149082; c=relaxed/simple;
	bh=g4wrCZPfDP7wCd12CyPcGfR1zTDHVfS0kS2wAb83fj4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UwM457aelG/5dYJ4El9yCWpsKrWxEMmIguq5UeDSj2xwM/XECdmQ+vD73UJ0fF92d5MSXrpEs/E1Z56Jeg5Eyt9sRdglxXVXG2SCv5Ei4ntmryIT5ZmjUdjqtMXZMWnQiddniRmJQkmNpqHl///p/BYJ6pio1obiY06ks7hdINM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVOeYHp7; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVOeYHp7"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48b06bb6e40so833872f8f.0
        for <bridge@lists.linux.dev>; Sun, 04 Oct 2026 14:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791149079; x=1791753879; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iquxO7jnYX2lg3f86GXs02ckl6WQPTZjoaobmRLuQcU=;
        b=AVOeYHp7guruPSdXHC001ATQByTBFRAFzgLFH1lDi8yUNUSO3qpfYqvdjYbWM3+Lra
         RaDwh/Cz67Yzdy0bd3qT4aH5f+RdehG4yf9H/wH/3iDyOCLy47j8ccMwIf76PPJzBKIJ
         DbUvEUKmBA91N4uCcxbFQsYxggNeWGDt/beh/NPe9V3xukQRJT9qD2WPxfxtKz3r3IRW
         Gs22S9s0cgrsnzJjrzHINr+7IduB6lJNh9ycTs/jnk+3S1LIJXSwl4Kq5lwFbqITNt3U
         fio0KaxD5j6ogKGaS5tfJ1ZXEmzmpCkPr7Xi9O5QzWwHODJrS1hyIxLXSOPEQaCqd9Es
         EpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791149079; x=1791753879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iquxO7jnYX2lg3f86GXs02ckl6WQPTZjoaobmRLuQcU=;
        b=HCxFA9I1UbqY+d0KUInECcEG0RR6mSsdph0tFNZMkxlbwIx9r3I3OSgWmFfvdzbLSM
         HCN2x811UVEOmCt7xAoU4N6kGTqlH/GixpAG8437sZgw0Zc4dzIIE0J16IdDYlue+Ei7
         b9WOiI0Ryu239LCbDo/q5xt0wtJ3dk2vjathpxi9m2eEJi5SDGjSrJQq03T1yq9KytYH
         LDYuzRC8hgn9ygjR8hgnEFxAm39qh66gQH7582hsbYeqlasmzE6BaQ8/H5BKF2ZAR8AH
         jHn/vWH612/muXCKps5GbXQr5OixgE6KdXwp7ZR6/GJ0yQo2F5fTEZVcYGn+MR99k4vU
         SIfA==
X-Forwarded-Encrypted: i=1; AKwUvBz2tq0MEYKJm2/m7v106phOByMX/SFJ9Yg00Uj87B8T5/pMf7Zyia0YKFdt673aWzWE4ldRaaE=@lists.linux.dev
X-Gm-Message-State: AFq9FYIOVygtxlcc3I10PsF4rrHYIalyjegbx9HNy40GV+YTGZLdAFDW
	P09gbT9Z8b0vYm7ayIR3PjB9LpHvul6xBybEDYhX9Suwx1Bu12T6oAMG
X-Gm-Gg: AYBFou0j65CpyTBucu5vwn9urVqGNP4XLRl2TV3LkkKwufyd3QJFlN8F4Qxx1K0nlcK
	4QLVyOKKyBjyGCMbY8cv0ADDm4rSIv8Oio6Wps7GeDMz3ZdusuwCer7QCb42lQkGcUTasN2VNii
	xW6bDHXWdsE9iKHZW35FUbPP2z9nuqSdHVPmBeYs2Xh2/yETcBzkmz8N0yvXnaUnnM4FTjDsIKf
	H68OTdq/XF5luPDe2LUBVMnTQTAjPxeRMR9wxYupMqfFhXMPEnSMK3lKLnG2d/5UDZCuKaMQpSx
	6UET4y6vEpdSHOkd1BNDJvpTxFzquU8Eg02aDC0NZmc3C4dQ05hFkAvxGCBCjtxn625mBu6tKj2
	Lz2KlFUNmKxcdA5s7zyhK9mUqa1/WkgXHMqCsqYgKzg7gGmMZOVMLZNFrwnx69MaVNa6fZ41fsW
	6/eySZ6rd7WY3zWVOVRe2yVoStdVNrSQu/yW9jLBce/er1vkZ0sUCRi5nKEkO1QHOkSOgYfGXwB
	XjoRo1cm5qm15/Ht6DfXXyIy0eVaI3OPmhNPeQU46CK7XHeex5aIYNe5BTM
X-Received: by 2002:a5d:6f01:0:b0:48b:6b4:db5c with SMTP id ffacd0b85a97d-48c47c8d305mr9575410f8f.6.1791149079168;
        Sun, 04 Oct 2026 14:24:39 -0700 (PDT)
Received: from andreayoga.localdomain ([195.122.200.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b38104417sm20407354f8f.27.2026.10.04.14.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 14:24:38 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	netfilter-devel@vger.kernel.org
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Bernhard Thaler <bernhard.thaler@wvnet.at>,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH nf v2 0/2] netfilter: preserve bridge egress VLAN tags
Date: Sun,  4 Oct 2026 23:24:26 +0200
Message-ID: <20261004212429.3648-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Conntrack-reassembled packets forwarded by a VLAN-aware bridge must
retain the VLAN state selected for their egress port when br_netfilter
refragments them.

The first patch saves the VLAN metadata for IPv6 as well as IPv4. The
second clears stale ingress tags on reused fragments when the egress
packet is untagged.

Both patches were tested under virtme-ng on a VLAN-aware bridge with
br_netfilter and nftables conntrack. With the series applied, all
fragments have the expected tag. The test is available on request.

Changes in v2:
  - Add a second fix to clear stale ingress VLAN tags from reused
    frag_list skbs on untagged egress.
  - Document the reproduced symptoms and the separate IPv4 and IPv6
    origins, narrow the first fix's claim to newly built fragments,
    reword the helper comment, and make the helper take a const skb.

v1: https://lore.kernel.org/all/20260928161830.351199-1-parri.andrea@gmail.com/

Andrea Parri (2):
  netfilter: br_netfilter: restore VLAN tag on refragmented IPv6 packets
  netfilter: br_netfilter: clear stale VLAN tag on refragmented packets

 net/bridge/br_netfilter_hooks.c | 51 +++++++++++++++++----------------
 1 file changed, 26 insertions(+), 25 deletions(-)

-- 
2.53.0

