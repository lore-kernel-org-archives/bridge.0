Return-Path: <sevinj.aghayeva@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5F7D84016B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A37E840183
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date;
 bh=EnLNkzzS7uvp8qzIOHofbmM/lr6EdUZwCfdgBKsBFIA=;
 b=WnJNpsrV7HdjGnzo2nkpOIxfT2GxSQjATwHQe5v3dxoDnhipC0pkWqvbDRaaAkHUQl
 BjuI5IHPTPKLxcBGbBky4ToOKprKzwbMjyJdETPc++bA6kflYiSa0oVI5YALYKtStEuX
 s1AF/+zVhqgaqkyDkFWxaQAq6J2FxoK8ra3/X/7zVu9rmMsb+T//OX3VmA7rJq+gLfEe
 gOxjRTSUCB8XAqhqASuiItzDRhGM19ybGOKOn2CR581W61gTdJ96XBxuQCX63STtniZn
 E1DEGEdZCY7FTpS43bWkkxm1MTCoN7tiTtmtCzJmyvIzjeVwjJ6IEahZE+9GSiOCGeZT
 m3uA==
From: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Date: Sat, 17 Sep 2022 16:17:56 -0400
Message-Id: <cover.1663445339.git.sevinj.aghayeva@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH RFC net-next 0/5] net: vlan: fix bridge binding
	behavior and add selftests
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: aroulin@nvidia.com, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, sbrivio@redhat.com, Eric Dumazet <edumazet@google.com>, Sevinj Aghayeva <sevinj.aghayeva@gmail.com>, roopa@nvidia.com, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

When bridge binding is enabled for a vlan interface, it is expected
that the link state of the vlan interface will track the subset of the
ports that are also members of the corresponding vlan, rather than
that of all ports.

Currently, this feature works as expected when a vlan interface is
created with bridge binding enabled:

  ip link add link br name vlan10 type vlan id 10 protocol 802.1q \
        bridge_binding on

However, the feature does not work when a vlan interface is created
with bridge binding disabled, and then enabled later:

  ip link add link br name vlan10 type vlan id 10 protocol 802.1q \
        bridge_binding off
  ip link set vlan10 type vlan bridge_binding on

After these two commands, the link state of the vlan interface
continues to track that of all ports, which is inconsistent and
confusing to users. This series fixes this bug and introduces two
tests for the valid behavior.

Sevinj Aghayeva (5):
  net: core: export call_netdevice_notifiers_info
  net: core: introduce a new notifier for link-type-specific changes
  net: 8021q: notify bridge module of bridge-binding flag change
  net: bridge: handle link-type-specific changes in the bridge module
  selftests: net: tests for bridge binding behavior

 include/linux/if_vlan.h                       |   4 +
 include/linux/netdevice.h                     |   3 +
 include/linux/notifier_info.h                 |  21 +++
 net/8021q/vlan.h                              |   2 +-
 net/8021q/vlan_dev.c                          |  20 ++-
 net/bridge/br.c                               |   5 +
 net/bridge/br_private.h                       |   7 +
 net/bridge/br_vlan.c                          |  18 +++
 net/core/dev.c                                |   7 +-
 tools/testing/selftests/net/Makefile          |   1 +
 .../selftests/net/bridge_vlan_binding_test.sh | 143 ++++++++++++++++++
 11 files changed, 223 insertions(+), 8 deletions(-)
 create mode 100644 include/linux/notifier_info.h
 create mode 100755 tools/testing/selftests/net/bridge_vlan_binding_test.sh

-- 
2.34.1

