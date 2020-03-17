Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CdpI6plcLqffgBOnjrXIKu3Uafpf4rcXyJ3pN99AXIc=;
 b=ShQsp79LXm5GC7td8lqoA5hp/BSeNQvRiooz2UKFzmJRaAOzkgZjn7b41Fvhmuu49M
 ZOSLn29Uj5nZ3XIkCxxwHGn2zMBaz3HEqE6LtEqOfAjivToFZCCTvMvo7J5GAXaE/lgb
 PGCme0lxaWYhE70YuoIlNnCe0UdQsRuMBaFmI=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Tue, 17 Mar 2020 14:08:32 +0200
Message-Id: <20200317120836.1765164-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 0/4] net: bridge: vlan options: add
	support for tunnel mapping
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

Hi,
In order to bring the new vlan API on par with the old one and be able
to completely migrate to the new one we need to support vlan tunnel mapping
and statistics. This patch-set takes care of the former by making it a
vlan option. There are two notable issues to deal with:
 - vlan range to tunnel range mapping
   * The tunnel ids are globally unique for the vlan code and a vlan can
     be mapped to one tunnel, so the old API took care of ranges by
     taking the starting tunnel id value and incrementally mapping
     vlan id(i) -> tunnel id(i). This set takes the same approach and
     uses one new attribute - BRIDGE_VLANDB_ENTRY_TUNNEL_ID. If used
     with a vlan range then it's the starting tunnel id to map.

 - tunnel mapping removal
   * Since there are no reserved/special tunnel ids defined, we can't
     encode mapping removal within the new attribute, in order to be
     able to remove a mapping we add a vlan flag which makes the new
     tunnel option remove the mapping

The rest is pretty straight-forward, in fact we directly re-use the old
code for manipulating tunnels by just mapping the command (set/del). In
order to be able to keep detecting vlan ranges we check that the current
vlan has a tunnel and it's extending the current vlan range end's tunnel
id.

Thanks,
 Nik


Nikolay Aleksandrov (4):
  net: bridge: vlan options: rename br_vlan_opts_eq to
    br_vlan_opts_eq_range
  net: bridge: vlan tunnel: constify bridge and port arguments
  net: bridge: vlan options: add support for tunnel id dumping
  net: bridge: vlan options: add support for tunnel mapping set/del

 include/uapi/linux/if_bridge.h |  2 +
 net/bridge/br_netlink_tunnel.c | 12 +++---
 net/bridge/br_private.h        |  4 +-
 net/bridge/br_private_tunnel.h | 17 +++++---
 net/bridge/br_vlan.c           |  3 +-
 net/bridge/br_vlan_options.c   | 74 +++++++++++++++++++++++++++++++---
 net/bridge/br_vlan_tunnel.c    |  5 ++-
 7 files changed, 94 insertions(+), 23 deletions(-)

-- 
2.24.1

