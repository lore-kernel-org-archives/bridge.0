Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agdLMeXNj3vtQdFOSwcUfVCjKkjkOOZrCNaDnKJJ13U=;
 b=fYF9+Wi4sJ+CbxaPpQdKGgHTWWHWrAF6PPei09eM9y544d0HevIhFGnYWFQENDzZOAP+teWUqg0yH7cJhsx+0Wk5hTdJywO1rcUnj8ovAnrvbkFVwQeGIU88597ssipGhLkpy0Ck0Wrfi7lERmLMJ42xGqSXC5LTRHlDbmcLa8Y=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 19 Jul 2021 16:51:37 +0300
Message-Id: <20210719135140.278938-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 0/3] Fan out FDB entries pointing towards
	the bridge to all switchdev member ports
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, DENG Qingfang <dqfext@gmail.com>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@idosch.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Tobias Waldekranz <tobias@waldekranz.com>

The "DSA RX filtering" series has added some important support for
interpreting addresses towards the bridge device as host addresses and
installing them as FDB entries towards the CPU port, but it does not
cover all circumstances and needs further work.

To be precise, the mechanism introduced in that series only works as
long as the ports are fairly static and no port joins or leaves the
bridge once the configuration is done. If any port leaves, host FDB
entries that were installed during runtime (for example the user changes
the MAC address of the bridge device) will be prematurely deleted,
resulting in a broken setup.

I see this work as targeted for "net-next" because technically it was
not supposed to work. Also, there are still corner cases and holes to be
plugged. For example, today, FDB entries on foreign interfaces are not
covered by br_fdb_replay(), which means that there are cases where some
host addresses are either lost, or never deleted by DSA. That will be
resolved once more work gets accepted, in particular the "Allow
forwarding for the software bridge data path to be offloaded to capable
devices" series, which moves the br_fdb_replay() call to the bridge core
and therefore would be required to solve the problem in a generic way
for every switchdev driver and not just for DSA.

These patches also pave the way for a cleaner implementation for FDB
entries pointing towards a LAG upper interface in DSA (that code needs
only to be added, nothing changed), however this is not done here.

Vladimir Oltean (3):
  net: switchdev: introduce helper for checking dynamically learned FDB
    entries
  net: switchdev: introduce a fanout helper for
    SWITCHDEV_FDB_{ADD,DEL}_TO_DEVICE
  net: dsa: use switchdev_handle_fdb_{add,del}_to_device

 include/net/switchdev.h   |  62 ++++++++++++
 net/dsa/dsa_priv.h        |  19 +++-
 net/dsa/slave.c           | 199 +++++++++++++++++++-------------------
 net/switchdev/switchdev.c | 190 ++++++++++++++++++++++++++++++++++++
 4 files changed, 365 insertions(+), 105 deletions(-)

-- 
2.25.1

