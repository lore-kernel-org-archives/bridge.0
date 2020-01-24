Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0FtJ6MlkdUyddBUzFcRR+OPGQmZ6SOcizcRhY4N8y5g=;
 b=H7F9m+jtsbzB+CI3Nr3fqV0xj5szLDh+/z4SjVgAzAwlpGQQEOJ/CYvk4Xdte7rtxs
 5GfABf37WsmS0BNydt0ZHx65l4KyjDSDOCyU4D50sgRpBsNb0QrphykWy4XuEc7dBrhP
 xdZicEqlUBXkpHsijNsUT/bK3YtpynMYyOzb0=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Fri, 24 Jan 2020 13:40:18 +0200
Message-Id: <20200124114022.10883-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v2 0/4] net: bridge: add per-vlan state
	option
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
This set adds the first per-vlan option - state, which uses the new vlan
infrastructure that was recently added. It gives us forwarding control on
per-vlan basis. The first 3 patches prepare the vlan code to support option
dumping and modification. We still compress vlan ranges which have equal
options, each new option will have to add its own equality check to
br_vlan_opts_eq(). The vlans are created in forwarding state by default to
be backwards compatible and vlan state is considered only when the port
state is forwarding (more info in patch 4).
I'll send the selftest for the vlan state with the iproute2 patch-set.

v2: patch 3: do full (all-vlan) notification only on vlan
    create/delete, otherwise use the per-vlan notifications only,
    rework how option change ranges are detected, add more verbose error
    messages when setting options and add checks if a vlan should be used.

Thanks,
 Nik

Nikolay Aleksandrov (4):
  net: bridge: check port state before br_allowed_egress
  net: bridge: vlan: add basic option dumping support
  net: bridge: vlan: add basic option setting support
  net: bridge: vlan: add per-vlan state

 include/uapi/linux/if_bridge.h |   2 +
 net/bridge/Makefile            |   2 +-
 net/bridge/br_device.c         |   3 +-
 net/bridge/br_forward.c        |   2 +-
 net/bridge/br_input.c          |   7 +-
 net/bridge/br_private.h        |  59 +++++++++++-
 net/bridge/br_vlan.c           | 108 ++++++++++++++++------
 net/bridge/br_vlan_options.c   | 160 +++++++++++++++++++++++++++++++++
 8 files changed, 311 insertions(+), 32 deletions(-)
 create mode 100644 net/bridge/br_vlan_options.c

-- 
2.21.0

