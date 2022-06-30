Return-Path: <hans@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 919D5404EE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B35B24023B
From: Hans Schultz <hans@kapio-technology.com>
Date: Thu, 30 Jun 2022 12:05:11 +0200
Message-Id: <20220630100512.604364-1-hans@kapio-technology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v1 0/1] enable locked port feature with
	learning
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, Hans Schultz <hans@kapio-technology.com>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Hans Schultz <schultz.hans+netdev@gmail.com>, Ido Schimmel <idosch@nvidia.com>, linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, Vivien Didelot <vivien.didelot@gmail.com>

This patch is related to the patch set
"Add support for locked bridge ports (for 802.1X)"
Link: https://lore.kernel.org/netdev/20220223101650.1212814-1-schultz.hans+netdev@gmail.com/

This patch makes the locked port feature work with learning turned on,
which is enabled with the command:

bridge link set dev DEV learning on

Without this patch, multicast packets like EAPOL packets will create a
fdb entry when ingressing on a locked port with learning turned on, thus
unintentionally opening up the port for traffic for the said MAC.

Some switchcore features like Mac-Auth and refreshing of FDB entries,
require learning enables on some switchcores, f.ex. the mv88e6xxx family.
Other features may apply too.

Since many switchcores trap or mirror various multicast packets to the
CPU, they will unintentionally unlock the port for the SA mac in
question unless prevented by this patch.

Hans Schultz (1):
  net: bridge: ensure that multicast packets cannot unlock a locked port

 net/bridge/br_input.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.30.2

