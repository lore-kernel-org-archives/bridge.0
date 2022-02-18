Return-Path: <schultz.hans@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:organization:content-transfer-encoding;
 bh=C074Ts6t1RuR/7tYyDWuvKC2BHBuBtLTBdnTVQAyV3k=;
 b=iwfCoLafgG9YVKvV7zo8I8SL8yF6TiOcM8BFJrMe1xkCw4BADvUTqPrpxBwb/uipbS
 o6MKYERLMZeEr1Q2SvSAg4Wcv0g/ma3fWCOa9IS/Be+/8LzmTrfFnv9hFVMkZB/DxHGT
 hRXi7MSSw14vn241aMy0fXph+8OwcZygLZ6WTabZWP4THo1j83Pj/Hpzai6goXcwe15u
 I1hl2KQNdzbFrfQgjZpGtWw7p4RwIPKyirv1BCmSsisKbh1Zu+8cQN5IT57459jAzh6u
 1/osLqneFyc3ffWmmJKZmdnoOaguwG7Ad44FGamwS2PP9DHtHsFW55YAeGQ/Xb5fxSnj
 7OcQ==
From: Hans Schultz <schultz.hans@gmail.com>
Date: Fri, 18 Feb 2022 16:51:45 +0100
Message-Id: <20220218155148.2329797-3-schultz.hans+netdev@gmail.com>
In-Reply-To: <20220218155148.2329797-1-schultz.hans+netdev@gmail.com>
References: <20220218155148.2329797-1-schultz.hans+netdev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v3 2/5] net: bridge: Add support for
	offloading of locked port flag
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org
Cc: Petr Machata <petrm@nvidia.com>, Andrew Lunn <andrew@lunn.ch>, Baowen Zheng <baowen.zheng@corigine.com>, Florian Fainelli <f.fainelli@gmail.com>, Amit Cohen <amcohen@nvidia.com>, netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Stephen Suryaputra <ssuryaextr@gmail.com>, Hans Schultz <schultz.hans+netdev@gmail.com>, Po-Hsu Lin <po-hsu.lin@canonical.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, Vivien Didelot <vivien.didelot@gmail.com>

Various switchcores support setting ports in locked mode, so that
clients behind locked ports cannot send traffic through the port
unless a fdb entry is added with the clients MAC address.

Signed-off-by: Hans Schultz <schultz.hans+netdev@gmail.com>
---
 net/bridge/br_switchdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index f8fbaaa7c501..bf549fc22556 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -72,7 +72,7 @@ bool nbp_switchdev_allowed_egress(const struct net_bridge_port *p,
 
 /* Flags that can be offloaded to hardware */
 #define BR_PORT_FLAGS_HW_OFFLOAD (BR_LEARNING | BR_FLOOD | \
-				  BR_MCAST_FLOOD | BR_BCAST_FLOOD)
+				  BR_MCAST_FLOOD | BR_BCAST_FLOOD | BR_PORT_LOCKED)
 
 int br_switchdev_set_port_flag(struct net_bridge_port *p,
 			       unsigned long flags,
-- 
2.30.2

