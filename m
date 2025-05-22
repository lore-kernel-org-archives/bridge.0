Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2F31A239A
	for <bridge@lists.linux.dev>; Thu, 22 May 2025 20:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747944433; cv=none; b=kqP3ndtQlGU2R5uSus9TjvVySevJjXlPQdvBsrdvOP9mH7EVXIqkfF5GB33EK4ztck3xnQi1v+c3MA0UIO1WcQvRarwcFaLclevUmZKQVkiqQKCtuzALIt+mLkeY7kGeGi8NrtxKMzT9dvD4vFbbNAuCBHn9Q8upZvtHvHTGYqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747944433; c=relaxed/simple;
	bh=2IW2R209pVFeKDP8TKFbRcxwbXUxPzIyFAnm0vtxaak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KCF0MAU/J75hLaZP0QkjjzRGCE9h2qzBwJGA8PiOniv5cflaBcFZtDbhoSYtptms+fcW4Sxnvt8eESv8qt5KDh0ycZxn+yIJzfhED7lGzUS40cYJ9e5OupsnfD06kjKJr1k3rT8QXxTRqFkw8zp2C+c8ZZYzBPnwPBkq9msBzeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BBCF354C351;
	Thu, 22 May 2025 22:00:00 +0200 (CEST)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: bridge@lists.linux.dev
Cc: netdev@vger.kernel.org,
	openwrt-devel@lists.openwrt.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Ivan Vecera <ivecera@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jonathan Corbet <corbet@lwn.net>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>,
	Markus Stockhausen <markus.stockhausen@gmx.de>,
	Jan Hoffmann <jan.christian.hoffmann@gmail.com>,
	Birger Koblitz <git@birger-koblitz.de>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Subject: [PATCH net-next 0/5] net: bridge: propagate safe mcast snooping to switchdev + DSA
Date: Thu, 22 May 2025 21:17:02 +0200
Message-ID: <20250522195952.29265-1-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

For a plain Linux bridge we have a safety mechanism before applying
multicast snooping to payload IP packets in the fast path: We only apply it
if both multicast snooping is enabled and an active IGMP/MLD querier was
detected. Otherwise we default to flooding IPv4/IPv6 multicast traffic.

This reduces the risk of creating multicast packet loss and by that
packet loss for IPv6 unicast, too, which relies on multicast to work.
Without an active IGMP/MLD querier on the link we are not able to get
IGMP/MLD reports reliably and by that wouldn't have a complete picture
about all multicast listeners.

This safety mechanism was introduced in commit
b00589af3b04 ("bridge: disable snooping if there is no querier").

To be able to use this safty mechanism on DSA/switchdev capable hardware
switches, too, and to ensure that a DSA bridge behaves similar to
a plain software bridge this patchset adds a new variable to track
if multicast snooping is active / safely applicable. And notifies DSA
and switchdev when this changes.

This has been tested on an OpenWrt powered Realtek RTL8382 switch,
a ZyXEL GS1900-24HP v1, with the following, pending patchset for OpenWrt
to integrate this: https://github.com/openwrt/openwrt/pull/18780

Regards, Linus

