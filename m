Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B6B2BEFF3
	for <bridge@lists.linux.dev>; Tue, 17 Jun 2025 06:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750143535; cv=none; b=W0ldSajkpfB+ful1c2taiQhi45uS/GnXzzsd9yGQ4oEGXV+cRcS1+/QlywCGL6WqOPZNTu6cfDQTbRC4Fh0BcC1SgH8iqiKPPhCVSB5/GbVoDsPieUN6V7ckwZmUiFH7IgGpn3gIubmYx77CmENzvucvDOH1ALhBkaTO1HaV5yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750143535; c=relaxed/simple;
	bh=NyldArvQ1w/4Y84MUaUrw2GtMMsFi72AmBHahegFWGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QSR7H3CM52DohLw0WXt1fdc5LRgvGole+Q8nL1R1+1mDUjyLljL3eauLBtIwqpGk6ImXBj11njlEoGZu+2M0Lpehwfr3bSs8dUrhBzALrt5u43+fgvXNhxoR68TIwZvzmP1kMorp1sYLlnKS+FKVR6WrdgjUDaXiJFtf50tLY+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gP9I+wE2; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gP9I+wE2"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-607cc1a2bd8so9155824a12.2
        for <bridge@lists.linux.dev>; Mon, 16 Jun 2025 23:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750143532; x=1750748332; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEHkovM/ftOTKmDVv8tlHJdRjSXgOoZevlav+wL3M/0=;
        b=gP9I+wE2T+5k2sK2M+Y1jaEpChLXiba1h66MTBaATN+3EhfTVHF33apkHKeo9hXIef
         XOog15f2xxr2mkc8ZN2V4npX5v+qbNVC/YEdsibOCZaHgBEajdpR+6aHI8omAq/SAwch
         +KNhpqqha9G9rF2WjmSKxYJqnX7Hc7s98U0f1nkcrwwv8ac3S997dcxKJyDX5L2Hp+xN
         7gE5w+b6jMNREFOnNuGjZnq6uPP/JDJODz4+45/KvU8tMTo9WXQ6HDY6FHwwCTP9VVGp
         MbSG2dxqk01PnigtYpxmoZiszOy/muLkE0Ax57AZo9J7iMs+oP8QNmiJVCaTw0MvFMvO
         KspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750143532; x=1750748332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZEHkovM/ftOTKmDVv8tlHJdRjSXgOoZevlav+wL3M/0=;
        b=Et6MsgA3ufg8h3KYtdqDEjqrIh6rxILmRN+CbpBrTyQSLp3XyxfRzweUT593AMJcCw
         ZAlZL3Sipua45JSV7MOYcR/38BY7G+J+YiSo922118DzJtwZQRWxxO/UUwCXjjrwqfUz
         CgwSy0mxs108kzQrLALK8WOCeQbbiZ/82UpD8W4hKmHuVAy4VBHc2JN7yqLgEX9cjA7p
         scfeEyCTw7105X3Sn6C05Nyb/NEwZPPerBnvENhasbHZtmiFeunQT/GkxXxKIT87ZloL
         Hy1OFFAxIZJ7KwVDmfeL+kG6eUZ7N7g8aLGVilr1irFglLXk69GBln0CcIv0TrDB9t5Q
         HdIw==
X-Forwarded-Encrypted: i=1; AJvYcCWaLxTGVz2WW8hWSsg+X38XKVBxuvn3tj35SrjpskU4snoLAl1n+IXNDxgIi/gfYthsztQL+Rg=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz0S2Oq98wJTP0huy+JG0tAAgHodT9TihzmysejNFys5lVLX84V
	I2HcLKG8pBnm02NgFc+XQXCGfAFLb5kMZnPzj1/4q/EtF2vo3HQi13Ad
X-Gm-Gg: ASbGncs+AQS0XtOxEXlref8WxnkBxM2/TchO1ZztEGs0rwJ7l6HrdCMkUCuFVtxBaLn
	yOwQpR/8Wj4NY6zANsw+zrfqIrXq+PFJbNWphxyRlZmcfQfeAcylZjYHl7lyCkMUHspOwUTPcEJ
	GtSnTwqULNgAs5DN6vuWQ1evsyAZpLHSw5J7NuDiNfG5e6cd8Qwkgf7nkQ4WyjEOmN6zRXdsUM1
	ZaNr1y+uuvZqqF/+sPfIjRrP/AGu1xovibKYXw6vW0y+soDaMLgXXKjZN8KxiobUSkpL8DZ3pEA
	fnuLZSwxrX4HFW2DUgJ93EDZVDNcxqZHEn2MFW8C9dKzCdaaA2HUgM8gCP1Piyw/B7mJRYhAnQh
	Tjf2lqhqJLE8HgS3UpH+2j0OY3Uu97YVt1AcSwoS4dSaN7Jy42h8Qw6J5+rRVzlh3Vy58/rmh8N
	m8P+PH
X-Google-Smtp-Source: AGHT+IEkEroXt6hnnQAHHBHds3G+bUNLpqeXOk2KWlfIM9C4ys+anUXEcA/XK2csXAWbF2ucdi7ILg==
X-Received: by 2002:a17:907:868a:b0:ad8:932e:77ba with SMTP id a640c23a62f3a-adfad4181e5mr1163989366b.38.1750143531293;
        Mon, 16 Jun 2025 23:58:51 -0700 (PDT)
Received: from localhost.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec81be674sm811109566b.53.2025.06.16.23.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 23:58:50 -0700 (PDT)
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
Subject: [PATCH v12 nf-next 0/2] conntrack: bridge: add double vlan, pppoe and pppoe-in-q
Date: Tue, 17 Jun 2025 08:58:33 +0200
Message-ID: <20250617065835.23428-1-ericwouds@gmail.com>
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

Changes in v12:

- Only allow tracking this traffic when a conntrack zone is set.
- nf_ct_bridge_pre(): skb pull/push without touching the checksum,
   because the pull is always restored with push.
- nft_do_chain_bridge(): handle the extra header similar to
   nf_ct_bridge_pre(), using pull/push.

Changes in v11:

- nft_do_chain_bridge(): Proper readout of encapsulated proto.
- nft_do_chain_bridge(): Use skb_set_network_header() instead of thoff.
- removed test script, it is now in separate patch.

v10 split from patch-set: bridge-fastpath and related improvements v9

Eric Woudstra (2):
  netfilter: bridge: Add conntrack double vlan and pppoe
  netfilter: nft_chain_filter: Add bridge double vlan and pppoe

 net/bridge/netfilter/nf_conntrack_bridge.c | 83 ++++++++++++++++++----
 net/netfilter/nft_chain_filter.c           | 55 +++++++++++++-
 2 files changed, 125 insertions(+), 13 deletions(-)

-- 
2.47.1

