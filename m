Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=S0ul/Cv2dQbKe/+VkzJwYP8SRzCc6gtnQ2xRNVtkMc0=;
 b=c//x2Wu8QQjep3b73PCrWSfxZQ4GrQCYCM06KdY08LzlRD/XXci3LlNWeGqEOJmS2a
 +mUcT6qH0Jv3LRXfhTajKHw9GpWyALwuw3574Au0s9zFhmfPgXJmEw4owWVU5F6sxzmz
 eQpq00UxnUs0BshzQkq0LL66Im4uYfBrU4ugfnnnSb7EH3hHJtNF0yaLw6lO21ExS9nM
 v+V+McMSquZdlMC1k11Zc2kiXHkSbAKxi2YH31QfsnKqSLDovj6foEfsDXuVXeWiwy/a
 wDZGUPTFP2EYp7EF65lITb0JsetISqOOSztIgA6rYZ88JJr7z35vfZsE3l68bp9ZyNBV
 boAQ==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Tue, 10 Aug 2021 18:29:18 +0300
Message-Id: <20210810152933.178325-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 00/15] net: bridge: vlan: add global mcast
	options
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

Hi,
This is the first follow-up set after the support for per-vlan multicast
contexts which extends global vlan options to support bridge's multicast
config per-vlan, it enables user-space to change and dump the already
existing bridge vlan multicast context options. The global option patches
(01 - 09 and 12-13) follow a similar pattern of changing current mcast
functions to take multicast context instead of a port/bridge directly.
Option equality checks have been added for dumping vlan range compression.
The last 2 patches extend the mcast router dump support so it can be
re-used when dumping vlan config.

patches 01 - 09: add support for various mcast options
patches 10 - 11: prepare for per-vlan querier control
patches 12 - 13: add support for querier control and router control
patches 14 - 15: add support for dumping per-vlan router ports

Next patch-sets:
 - per-port/vlan router option config
 - iproute2 support for all new vlan options
 - selftests

Thanks,
 Nik


Nikolay Aleksandrov (15):
  net: bridge: vlan: add support for mcast igmp/mld version global
    options
  net: bridge: vlan: add support for mcast last member count global
    option
  net: bridge: vlan: add support for mcast startup query count global
    option
  net: bridge: vlan: add support for mcast last member interval global
    option
  net: bridge: vlan: add support for mcast membership interval global
    option
  net: bridge: vlan: add support for mcast querier interval global
    option
  net: bridge: vlan: add support for mcast query interval global option
  net: bridge: vlan: add support for mcast query response interval
    global option
  net: bridge: vlan: add support for mcast startup query interval global
    option
  net: bridge: mcast: move querier state to the multicast context
  net: bridge: mcast: querier and query state affect only current
    context type
  net: bridge: vlan: add support for mcast querier global option
  net: bridge: vlan: add support for mcast router global option
  net: bridge: mcast: use the proper multicast context when dumping
    router ports
  net: bridge: vlan: use br_rports_fill_info() to export mcast router
    ports

 include/uapi/linux/if_bridge.h |  14 +++
 net/bridge/br_mdb.c            |  60 ++++++-----
 net/bridge/br_multicast.c      |  71 +++++++------
 net/bridge/br_netlink.c        |  14 ++-
 net/bridge/br_private.h        |  78 ++++++++++++--
 net/bridge/br_sysfs_br.c       |  10 +-
 net/bridge/br_vlan_options.c   | 186 ++++++++++++++++++++++++++++++++-
 7 files changed, 354 insertions(+), 79 deletions(-)

-- 
2.31.1

