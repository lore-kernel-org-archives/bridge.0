Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC82D524B4
	for <bridge@lists.linux.dev>; Tue, 10 Sep 2024 13:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725973418; cv=none; b=IP1MnwRB42vACIJGsjindYJ7o5t3o2PaHAVPcc/6IMe2+6edHzIaLfSpLAUhRaPKTTGgzSGd7KyV1MT30vPXpkKo9IOBgJ5Fku2TdG6+eBM41UM4+sChDI64LanmCSJRvBHUm+9lgXkyGm0vS7R1W2ECTo+UTYR9ySmG0QuWM0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725973418; c=relaxed/simple;
	bh=ECm36IN+3omIy18PtQlL361xcr/oeClg+Z4pONa7UtY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L7wtapatPBwAHzh0mTAOKwcDCq3XIShboxLmQyr6XLHC4wtXUgPnMlKfCEE20FPGGfQOEhOlTmgWh5iy7Dno7OFk+u3NWNPTIHc422sopUMN/quu6sCXXivIAt6+32kHUCseYjNvOsetgUSrI00nOMm5FtcyTkUDHZ4Ds4HWg9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=Lm+poT+z; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="Lm+poT+z"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2024091013033240972f6dabf1c5bc01
        for <bridge@lists.linux.dev>;
        Tue, 10 Sep 2024 15:03:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=ysY9Sm6/JWBZ3bOT6S/Yzq5jj/3qAL5EYD8foDPm2Q0=;
 b=Lm+poT+zCYhcBoxzXcBNf1re8bJ0YaLedOb4LNRNhibSLtF7DeWFZTM+QwdLNheEe1GVtD
 fAYFg5nzY321NNl0BXrEGHrWz4iFDOxbO5oFYIVX4p/N/16fI2r2I43dksAS2K3I2H+s/Dr+
 PkG8P7eg5oiXD1m5T6F/GrFBbKmcjfji5Hezn+olJ7yiadhEXLMRK7x9iF21DGvSOi0wXQGb
 BcZp8VLrBoBPC+qB9oEAAnLrNCdke/xheqwKD8q8C423IR0/vwiREcGg9h5rOterU52C88Fx
 8VRNHrikSmVukCpuqgUxdvzs6iwIbSZhxemAC8yd/76ocmRGsTcIQbXQ==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: netdev@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 =?ISO-8859-1?Q?Ar1n=E7_=DCNAL?= <arinc.unal@arinc9.com>, Daniel Golle
 <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, Sean Wang
 <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
 <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Claudiu Manoil
 <claudiu.manoil@nxp.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, UNGLinuxDriver@microchip.com, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>, Mark
 Lee <Mark-MC.Lee@mediatek.com>, Roopa Prabhu <roopa@nvidia.com>, Nikolay
 Aleksandrov <razor@blackwall.org>, linux-mediatek@lists.infradead.org,
 bridge@lists.linux.dev, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org
Subject: [PATCH 0/2] net: dsa: RCU-protect dsa_ptr in struct net_device
Date: Tue, 10 Sep 2024 15:03:14 +0200
Message-ID: <20240910130321.337154-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

There are multiple races of zeroing dsa_ptr in struct net_device (on
shutdown/remove) against asynchronous dereferences all over the net
code. Widespread pattern is as follows:

CPU0					CPU1
if (netdev_uses_dsa())
					dev->dsa_ptr = NULL;
        dev->dsa_ptr->...

RCU-protect the dsa_ptr and ajust the documentation where unsafe patterns
were mentioned.

The first patch has been compiled with ARCH=arm64 and allyesconfig against
v6.11-rc6. Backported to v6.1 and tested on arm64 HW with LAN9303 switch
(where the issue was initially reproduced), including LOCKDEP and
PROVE_RCU. Therefore I will be able to provide v6.1 backport (for -stable
purposes) and later v6.8 backport as well.

Alexander Sverdlin (2):
  net: dsa: RCU-protect dsa_ptr in struct net_device
  docs: net: dsa: RCU protection of dsa_ptr in struct net_device

 Documentation/networking/dsa/dsa.rst        |  18 ++--
 drivers/net/dsa/mt7530.c                    |   3 +-
 drivers/net/dsa/ocelot/felix.c              |   3 +-
 drivers/net/dsa/qca/qca8k-8xxx.c            |   3 +-
 drivers/net/ethernet/broadcom/bcmsysport.c  |   8 +-
 drivers/net/ethernet/mediatek/airoha_eth.c  |   2 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c |  22 +++--
 drivers/net/ethernet/mediatek/mtk_ppe.c     |  15 ++-
 include/linux/netdevice.h                   |   2 +-
 include/net/dsa.h                           |  36 +++++--
 include/net/dsa_stubs.h                     |   6 +-
 net/bridge/br_input.c                       |   2 +-
 net/core/dev.c                              |   3 +-
 net/core/flow_dissector.c                   |  19 ++--
 net/dsa/conduit.c                           |  66 ++++++++-----
 net/dsa/dsa.c                               |  19 ++--
 net/dsa/port.c                              |   3 +-
 net/dsa/tag.c                               |   3 +-
 net/dsa/tag.h                               |  19 ++--
 net/dsa/tag_8021q.c                         |  10 +-
 net/dsa/tag_brcm.c                          |   2 +-
 net/dsa/tag_dsa.c                           |   8 +-
 net/dsa/tag_qca.c                           |  10 +-
 net/dsa/tag_sja1105.c                       |  22 +++--
 net/dsa/user.c                              | 104 +++++++++++---------
 net/ethernet/eth.c                          |   2 +-
 26 files changed, 249 insertions(+), 161 deletions(-)

-- 
2.46.0

