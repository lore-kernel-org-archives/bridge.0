Return-Path: <mirq-linux@rere.qmqm.pl>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
	t=1541719023; bh=ky8C6eplGuBajDm0RFjipSqP2G9lfh65NQrooaqyJps=;
	h=Date:From:Subject:To:Cc:From;
	b=opacw6TSXzGLYV71lpHcvG6pGexmZ/ofrRCUYS8BWyC+V3aZs+kjtwZGYpLMnjk6H
	m8w1FOJSWvzxdmrkm0ipPo+JCQi3s3kZ/zQZ6Bz1J12IodzXslN7VAuS7PoON8iQ4J
	o/qR/Ue4y0zYwylHSjIqvEdMPbUNjUQPI+mEvkBRRmldkx0fjwwpEHalAYhlZcWTov
	Oxed9rm/NxX29F6sNmtJKeKGJ1H1mmy5z76L9BGxA/M5/XHhEhgzFsDTFNlKhIGahS
	yc6YtXvPgfz8C/V4nmOV1bHJhSGelXWszO90vBOUxcVLI9LunByaflyn56QuYBm2pA
	b5SHYSoEqMiYg==
Date: Fri, 09 Nov 2018 00:17:58 +0100
Message-Id: <cover.1541718583.git.mirq-linux@rere.qmqm.pl>
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 0/9] Use __vlan_hwaccel_*() helpers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>, Somnath Kotur <somnath.kotur@broadcom.com>, linux-rdma@vger.kernel.org, bridge@lists.linux-foundation.org, coreteam@netfilter.org, Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Pablo Neira Ayuso <pablo@netfilter.org>, Jiri Pirko <jiri@resnulli.us>, Steve Wise <swise@chelsio.com>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Roopa Prabhu <roopa@cumulusnetworks.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Sathya Perla <sathya.perla@broadcom.com>, Cong Wang <xiyou.wangcong@gmail.com>, Mirko Lindner <mlindner@marvell.com>, Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Tariq Toukan <tariqt@mellanox.com>

This series removes from networking core and driver code an assumption
about how VLAN tag presence is stored in an skb. This will allow to free
up overloading of VLAN.CFI bit to incidate tag's presence.

Michał Mirosław (9):
  cxgb4: use __vlan_hwaccel helpers
  nfnetlink/queue: use __vlan_hwaccel helpers
  net/core: use __vlan_hwaccel helpers
  8021q: use __vlan_hwaccel helpers
  bridge: use __vlan_hwaccel helpers
  ipv4/tunnel: use __vlan_hwaccel helpers
  benet: use __vlan_hwaccel helpers
  mlx4: use __vlan_hwaccel helpers
  sky2: use __vlan_hwaccel helpers

 drivers/infiniband/hw/cxgb4/cm.c            |  2 +-
 drivers/net/ethernet/emulex/benet/be_main.c | 13 +++++++++----
 drivers/net/ethernet/marvell/sky2.c         |  6 ++----
 drivers/net/ethernet/mellanox/mlx4/en_rx.c  |  2 +-
 net/8021q/vlan_core.c                       |  2 +-
 net/bridge/br_netfilter_hooks.c             | 15 +++++++++------
 net/bridge/br_private.h                     |  2 +-
 net/bridge/br_vlan.c                        |  6 +++---
 net/core/dev.c                              |  8 +++++---
 net/core/skbuff.c                           |  2 +-
 net/ipv4/ip_tunnel_core.c                   |  2 +-
 net/netfilter/nfnetlink_queue.c             |  5 +++--
 net/sched/act_vlan.c                        |  2 +-
 13 files changed, 38 insertions(+), 29 deletions(-)

-- 
2.19.1

