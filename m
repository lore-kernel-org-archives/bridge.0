Return-Path: <sevinj.aghayeva@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BD2E4815AB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F038C8149D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc;
 bh=Qsaks7TDshu/iK351NtgsaMj5QdevHA6XP1FxmCgHpM=;
 b=prA8AdKyGpyxCd8Aos45URzvOY5yjVOK3DMwVJn4Uyj6A9PHRoPL8JiQJOeze0vVH1
 IymCOhC3puc17K5WM58lCpsEP+oWXmVcoQRE9PrPlxaHxsNfRv2oW+sEYwuMHbcSzJvT
 QICYi5m9/jfaan/f4/MNKyZ/LM9l29ejjs3YAuHaZ20kJTOrlwEcUe3hUKhBYG6PDaA7
 FU1gIjwleabfvG//4FVXGxTvOPROTeeL/vDrYHuxPTq0fyJkeyruwg6zr6dnGtJdrGSj
 c7dWFpmRGGF8pIYDr6i4nJ96ey9CCNsrhkBfsmBn+Rbqa27+5lPmy8DJ9juOPhhgogoa
 57og==
From: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Date: Tue,  9 Aug 2022 23:11:18 -0400
Message-Id: <cover.1660100506.git.sevinj.aghayeva@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH RFC net-next 0/3] net: vlan: fix bridge binding
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

Sevinj Aghayeva (3):
  net: core: export call_netdevice_notifiers_info
  net: 8021q: fix bridge binding behavior for vlan interfaces
  selftests: net: tests for bridge binding behavior

 include/linux/netdevice.h                     |   2 +
 net/8021q/vlan.h                              |   2 +-
 net/8021q/vlan_dev.c                          |  25 ++-
 net/core/dev.c                                |   7 +-
 tools/testing/selftests/net/Makefile          |   1 +
 .../selftests/net/bridge_vlan_binding_test.sh | 143 ++++++++++++++++++
 6 files changed, 172 insertions(+), 8 deletions(-)
 create mode 100755 tools/testing/selftests/net/bridge_vlan_binding_test.sh

-- 
2.25.1

