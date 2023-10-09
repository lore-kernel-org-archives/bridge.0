Return-Path: <amcohen@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CD3066112E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DED5D61066
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgU32kMQJx+V3Xklh3fbskuhi5Xd+GA4Kqhc5xoDvuM=;
 b=J30yKq1y2v7cBEwxKY15KNaDVQI0WCtWrV+8c0RP+wKYl8bdecZh7dERZ86io41gSnOqGclJKhYKcE5xCKOWAnS4JANdUHJwcXQa/OzwYECNsvLVJrVM+IDo9S5fmXraipCVqToiLNtvjZ/TiXnTzPcFNhsN86hklvXur6qUqyndTKBWviNul1U5ECRsYJaDhSujYlQqnoOn2I44UxPsQ7UhT6DA2PoGsUFI9I81d0S0TV9ClXOyuBGwZqi6rugjAlYnDECEM9yHlecQq5KJ7+XEb2dXFPnnBtEJmB24RRNOzZLaINc9aZOeefWqavOp2c8GISE5J682ijJZXuwt8g==
From: Amit Cohen <amcohen@nvidia.com>
Date: Mon, 9 Oct 2023 13:06:07 +0300
Message-ID: <20231009100618.2911374-1-amcohen@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 00/11] Extend VXLAN driver to support FDB
	flushing
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: razor@blackwall.org, Amit Cohen <amcohen@nvidia.com>, mlxsw@nvidia.com, dsahern@kernel.org, bridge@lists.linux-foundation.org, idosch@nvidia.com, linux-kselftest@vger.kernel.org, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, davem@davemloft.net

The merge commit 92716869375b ("Merge branch 'br-flush-filtering'") added
support for FDB flushing in bridge driver. Extend VXLAN driver to support
FDB flushing also. Add support for filtering by fields which are relevant
for VXLAN FDBs:
* Source VNI
* Nexthop ID
* 'router' flag
* Destination VNI
* Destination Port
* Destination IP

Without this set, flush for VXLAN device fails:
$ bridge fdb flush dev vx10
RTNETLINK answers: Operation not supported

With this set, such flush works with the relevant arguments, for example:
$ bridge fdb flush dev vx10 vni 5000 dst 193.2.2.1
< flush all vx10 entries with VNI 5000 and destination IP 193.2.2.1>

Some preparations are required, handle them before adding flushing support
in VXLAN driver. See more details in commit messages.

Patch set overview:
Patch #1 prepares flush policy to be used by VXLAN driver
Patches #2-#3 are preparations in VXLAN driver
Patch #4 adds an initial support for flushing in VXLAN driver
Patches #5-#9 add support for filtering by several attributes
Patch #10 adds a test for FDB flush with VXLAN
Patch #11 extends the test to check FDB flush with bridge

Amit Cohen (11):
  net: Handle bulk delete policy in bridge driver
  vxlan: vxlan_core: Make vxlan_flush() more generic for future use
  vxlan: vxlan_core: Do not skip default entry in vxlan_flush() by
    default
  vxlan: vxlan_core: Add support for FDB flush
  vxlan: vxlan_core: Support FDB flushing by source VNI
  vxlan: vxlan_core: Support FDB flushing by nexthop ID
  vxlan: vxlan_core: Support FDB flushing by destination VNI
  vxlan: vxlan_core: Support FDB flushing by destination port
  vxlan: vxlan_core: Support FDB flushing by destination IP
  selftests: Add test cases for FDB flush with VXLAN device
  selftests: fdb_flush: Add test cases for FDB flush with bridge device

 drivers/net/vxlan/vxlan_core.c           | 207 +++++-
 include/linux/netdevice.h                |   8 +-
 net/bridge/br_fdb.c                      |  29 +-
 net/bridge/br_private.h                  |   3 +-
 net/core/rtnetlink.c                     |  27 +-
 tools/testing/selftests/net/Makefile     |   1 +
 tools/testing/selftests/net/fdb_flush.sh | 812 +++++++++++++++++++++++
 7 files changed, 1049 insertions(+), 38 deletions(-)
 create mode 100755 tools/testing/selftests/net/fdb_flush.sh

-- 
2.40.1

