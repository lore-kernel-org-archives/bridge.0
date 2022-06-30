Return-Path: <hans@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7592C60A6C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C2A4360899
From: Hans Schultz <hans@kapio-technology.com>
Date: Thu, 30 Jun 2022 12:05:12 +0200
Message-Id: <20220630100512.604364-2-hans@kapio-technology.com>
In-Reply-To: <20220630100512.604364-1-hans@kapio-technology.com>
References: <20220630100512.604364-1-hans@kapio-technology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v1 1/1] net: bridge: ensure that multicast
	packets cannot unlock a locked port
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

This makes it possible to use the locked port feature with learning
turned on which is needed for various driver features.

Signed-off-by: Hans Schultz <hans@kapio-technology.com>
---
 net/bridge/br_input.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 68b3e850bcb9..a3ce0a151817 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -215,6 +215,7 @@ static void __br_handle_local_finish(struct sk_buff *skb)
 	if ((p->flags & BR_LEARNING) &&
 	    nbp_state_should_learn(p) &&
 	    !br_opt_get(p->br, BROPT_NO_LL_LEARN) &&
+	    !(p->flags & BR_PORT_LOCKED) &&
 	    br_should_learn(p, skb, &vid))
 		br_fdb_update(p->br, p, eth_hdr(skb)->h_source, vid, 0);
 }
-- 
2.30.2

