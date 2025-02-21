Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965E41F427D
	for <bridge@lists.linux-foundation.org>; Fri, 21 Feb 2025 04:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740112477; cv=none; b=RNx3sewZoS67JsEcNBzJd7J71t85vSgN6YNM8ZCjoBKRv2bbDyuSjkWQLQf5CcwpS4SDU5hc1ZmdVJZhUi37y9suujs0fwCxlbHMe+/RQxp/77DIiJuBETHW5HIg+9XYmZ5m9IJ4baPVO/sOIJa+PIkvMyx1SVuBXuwirxGeMCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740112477; c=relaxed/simple;
	bh=e5oJ9l1t1ThUP00tMAZ9g8jHbBLkoLXdR2Qk2gnN098=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cCk/DzN31ZHgpNRbsiJtOOjiqVRS/jBXTd37r31kxR7hbE5ZWrAL7TFg9wsn9WrzrJJzGqOkr3jgZ05HzHQ1nSQi5eZ+T01VRlY0pkmnRKKD0T6kdcPF+EvtdV0W/E6xbo2kInaT6oYsCKPrma/xmKFymuDEbxVO/slP73nktFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 096B261AD0
	for <bridge@lists.linux-foundation.org>; Fri, 21 Feb 2025 04:34:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -6.491
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g8XMqZBFSmWE for <bridge@lists.linux-foundation.org>;
 Fri, 21 Feb 2025 04:34:34 +0000 (UTC)
X-Greylist: delayed 578 seconds by postgrey-1.37 at util1.osuosl.org; Fri, 21 Feb 2025 04:34:34 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 5065A61AC4
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5065A61AC4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.203.183.178; helo=mail.aperture-lab.de; envelope-from=linus.luessing@c0d3.blue; receiver=<UNKNOWN> 
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5065A61AC4
	for <bridge@lists.linux-foundation.org>; Fri, 21 Feb 2025 04:34:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D8C4354203E
	for <bridge@lists.linux-foundation.org>; Fri, 21 Feb 2025 05:24:52 +0100 (CET)
Date: Fri, 21 Feb 2025 05:24:51 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: bridge@lists.linux-foundation.org
Subject: Switches which use Linux bridge IGMP/MLD snooping?
Message-ID: <Z7gAE6vpDVa3Zlt6@sellars>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3

Hi,

I would like to get our hackspace more multicast ready. Especially
to do some multicast routing between our hackspace and our
Freifunk wireless mesh network, which thanks to batman-adv and the Linux
bridge is now multicast aware. We do have several donated, older switches
that others outsourced. But I don't trust them to do IGMP/MLD snooping
correctly.

Therefore I'm looking for something that does the multicast
forwarding in hardware but uses the IGMP/MLD snooping from the
Linux bridge in kernelspace and runs on OpenWrt. So I guess I'm
looking for something DSA + switchdev capable, but I guess not
all of them support using IGMP/MLD snooping in kernelspace?
I see some drivers which use DSA's port_mdb_add (b53, bcm_sf2,
lan9303, microchip ksz, mt7530, mv88e6xxx, ocelot felix, qca8k-8xxx,
sja1105) and/or switchdev's switchdev_obj_port_mdb (same as for
DSA plus ksz9477, freescale dpaa2, marvell prestera,
mellanox mlx5/mlxsw, lan966x, sparx5, ti am65-cpsw/icssg).

Does anyone know of specific devices/products which should work for us
and might have some recommendations?

Regards, Linus

PS: Minimum spec would be 8 ports, managed, 1Gbit, ideally with
at least 4 PoE ports. (The hackspace in total also has 46x RJ45
network sockets distributed over three rooms. But I don't think we
need full multicast capabilities on all of them to start with.
especially as that would probably considerably bump the price.)
