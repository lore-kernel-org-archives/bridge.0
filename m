Return-Path: <sevinj.aghayeva@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B97C740A38
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CB942408B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zgmGl0zOLMrX607mh9XkqEoaOPwjCXk2yDE13rCP8S4=;
 b=brWrA3BHLdXgaMLYNPn15nUSgJ+ICxG8mg77/mh6pbRg07FjjG6pva4xRLwxB0eghG
 Dfq+F+V+x1NOiHFkSbvx4tMx1QCHMIqqEBpB/oHd3QWHQqP92Z2xKTlHXFeP6Dx3NAZe
 sgtPmxYbpV0bnJUMme0La5BDx5Cp7c0CaFwYJczWmdWyvrpFLdPNJzk0Yv4J8rFViFe4
 ha3HU+A9U8BGTgtkjkQaBg7QnHTC3qfTulG7b6UZPbBImBZDyYVk72mOQ+V89AT2p5jo
 KppSykFsfouzX7UG9IQw2bdyE/Zmw5sx5Xah/jVB5rKs+S/K+2cvEFj2Dk/rj+VK9YS0
 4rog==
From: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Date: Sat, 30 Jul 2022 12:03:29 -0400
Message-Id: <cover.1659195179.git.sevinj.aghayeva@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 0/3] net: vlan: fix bridge binding
	behavior and add selftests
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: aroulin@nvidia.com
Cc: netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, sbrivio@redhat.com, Eric Dumazet <edumazet@google.com>, Sevinj Aghayeva <sevinj.aghayeva@gmail.com>, roopa@nvidia.com, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

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
  net: bridge: export br_vlan_upper_change
  net: 8021q: fix bridge binding behavior for vlan interfaces
  selftests: net: tests for bridge binding behavior

 include/linux/if_bridge.h                     |   9 ++
 net/8021q/vlan.h                              |   2 +-
 net/8021q/vlan_dev.c                          |  21 ++-
 net/bridge/br_vlan.c                          |   7 +-
 tools/testing/selftests/net/Makefile          |   1 +
 .../selftests/net/bridge_vlan_binding_test.sh | 143 ++++++++++++++++++
 6 files changed, 176 insertions(+), 7 deletions(-)
 create mode 100755 tools/testing/selftests/net/bridge_vlan_binding_test.sh

-- 
2.25.1

