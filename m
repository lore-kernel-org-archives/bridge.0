Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5F7CB40883
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C166E40881
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/QRSh7zayDiVWVnBLdQsy9cF/0w0ZylzDkjTo837pQ=;
 b=Dt2/QRjRqJZiZPjxrWiW7Ll0BPIqByaEjmSJ6Q3/Dckh7YkQMzjp2XfWOsgekYN/Nwx0SA2z+VvUdWxcwCDIsE/mUiwSPOsTVMwLRF5n8OPktUI69MOHjMItchMFPYu5bSn9tAcu6G274qr7aCEXh5OgVmkAYNymIO/GdZ/e7ie7f1iZaxJa6P0BgCiDE44LvQPxYkzSLbaTupuG8wd/rUPyBb2LXgddZ4/OavpLdGDaTgegPEkR1IycR58AH0MMFvR7Za9idtfSiLOi1iIyueVsccPbmVMlaZ+yQ7qqUTJRHrSaK/KnoDQyVl/RvisU2XLY4wAf0tPctLntVD0Y4w==
From: Ido Schimmel <idosch@nvidia.com>
Date: Thu,  9 Feb 2023 09:18:48 +0200
Message-Id: <20230209071852.613102-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 0/4] bridge: mcast: Preparations for VXLAN
	MDB
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: petrm@nvidia.com, mlxsw@nvidia.com, razor@blackwall.org, Ido Schimmel <idosch@nvidia.com>, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

This patchset contains small preparations for VXLAN MDB that were split
from this RFC [1]. Tested using existing bridge MDB forwarding
selftests.

[1] https://lore.kernel.org/netdev/20230204170801.3897900-1-idosch@nvidia.com/

Ido Schimmel (4):
  bridge: mcast: Use correct define in MDB dump
  bridge: mcast: Remove pointless sequence generation counter assignment
  bridge: mcast: Move validation to a policy
  selftests: forwarding: Add MDB dump test cases

 net/bridge/br_mdb.c                           | 49 +++++----
 .../selftests/net/forwarding/bridge_mdb.sh    | 99 +++++++++++++++++++
 2 files changed, 127 insertions(+), 21 deletions(-)

-- 
2.37.3

