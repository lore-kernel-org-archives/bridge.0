Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lW472399iAATdZUH6brslOgK+ubydfGqN4ZbFSeA9SE=;
 b=LYDkLAitkc8jMhqsrjA/I9/1TucWGtQXhpZVkc+yfh8sywXR9dU9JnFjDA9RW82LSN
 9xtQ3jsSaLQ4UN/a7ho6Gtj8kitQIA6bdfmQHaFbXxj2DiMZgOcz9v69Oa0azfHKVO4B
 nyDB8+0P81BIZROb5p8Lcy34i/JcAH52mdnZI=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Thu, 23 Jan 2020 15:28:03 +0200
Message-Id: <20200123132807.613-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 0/4] net: bridge: add per-vlan state option
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
 net/bridge/br_private.h        |  58 +++++++++++++-
 net/bridge/br_vlan.c           |  99 ++++++++++++++++++-----
 net/bridge/br_vlan_options.c   | 142 +++++++++++++++++++++++++++++++++
 8 files changed, 287 insertions(+), 28 deletions(-)
 create mode 100644 net/bridge/br_vlan_options.c

-- 
2.21.0

