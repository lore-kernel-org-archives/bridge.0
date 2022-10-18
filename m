Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3395282F57
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E8D3182F19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s10p0x8l2IB9To2cQuTum0TS+L6JRi3MMfMwlGMqbSQ=;
 b=pob6JF4qw80DscsIeD8xb06s9wM4e3CYSYWtgR9gUbgeOyGpgVIU+96scPcoAQp1jzb0mBOlP6o1fOtMogQtlXNjRJYgYv8oulm1Uc39ZFE4jmfLct9OFlpr/rzOVRsrGrLRcrb4J7mUAJRet6X8mukx4qLHXETW6dNt4XQE5A7AGC1MWvEjMK2JBRSeePbhPbqgvEhv+dp5s6RYg+u83tMF3InAhtmuANRzSQwf4HaJdKEQIoXtLyJhctbsR687MVmKu83x8dcwyRQao17c/azbF9PjxUEVFD6ecQM2F838VXwc7brzmTi+qeGCuau4oHaC1JtI/JB1EvH8xY7P2A==
From: Ido Schimmel <idosch@nvidia.com>
Date: Tue, 18 Oct 2022 09:39:57 +0300
Message-Id: <20221018064001.518841-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 0/4] bridge: A few multicast cleanups
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: mlxsw@nvidia.com, razor@blackwall.org, Ido Schimmel <idosch@nvidia.com>, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

Clean up a few issues spotted while working on the bridge multicast code
and running its selftests.

Ido Schimmel (4):
  selftests: bridge_vlan_mcast: Delete qdiscs during cleanup
  selftests: bridge_igmp: Remove unnecessary address deletion
  bridge: mcast: Use spin_lock() instead of spin_lock_bh()
  bridge: mcast: Simplify MDB entry creation

 net/bridge/br_mdb.c                                   | 11 +++--------
 net/bridge/br_multicast.c                             |  8 ++++----
 tools/testing/selftests/net/forwarding/bridge_igmp.sh |  3 ---
 .../selftests/net/forwarding/bridge_vlan_mcast.sh     |  3 +++
 4 files changed, 10 insertions(+), 15 deletions(-)

-- 
2.37.3

