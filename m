Return-Path: <jnixdorf-oss@avm.de>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2F7A3414C3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 93118409AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1697463932; bh=WMHTWn0lzdZOJlUHydcATxCX7rNJUapqeqgSH/9Czxc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=aeSwQC4kNzxsKoVOEG24z2ghHtJ3HcnBKZrokW+L7E3garrMeBmAaHW0ixzYTQ/lE
 pV0J6WcMnwfol76rJY1C47I1AdKiJOBDA5FwOVLkj8pATgyGG5373IwTw2FSrCdL6j
 kmweacdVj+P41M/V6VXK6NtRVkkopnmuD3Jrk99o=
From: Johannes Nixdorf <jnixdorf-oss@avm.de>
Date: Mon, 16 Oct 2023 15:27:23 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231016-fdb_limit-v5-4-32cddff87758@avm.de>
References: <20231016-fdb_limit-v5-0-32cddff87758@avm.de>
In-Reply-To: <20231016-fdb_limit-v5-0-32cddff87758@avm.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697462840; l=807;
 i=jnixdorf-oss@avm.de; s=20230906; h=from:subject:message-id;
 bh=WMHTWn0lzdZOJlUHydcATxCX7rNJUapqeqgSH/9Czxc=;
 b=T9u4sURSiCaNXZzQHRNZ49OmpzQLzcXSoa6jHXmSuSN0/chz3AUafsFqnGeMtjqfpjU1IKBto
 kNwPnMrNUWBAz5qDbdRWI/24/WcYh5FRu+O3YKuAn/J2A5e2+QRFySb
X-Developer-Key: i=jnixdorf-oss@avm.de; a=ed25519;
 pk=KMraV4q7ANHRrwjf9EVhvU346JsqGGNSbPKeNILOQfo=
Subject: [Bridge] [PATCH net-next v5 4/5] net: bridge: Set strict_start_type
 for br_policy
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>, David Ahern <dsahern@gmail.com>, Eric Dumazet <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>, Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Oleksij Rempel <linux@rempel-privat.de>, Paolo Abeni <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>, Shuah Khan <shuah@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Johannes Nixdorf <jnixdorf-oss@avm.de>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

Set any new attributes added to br_policy to be parsed strictly, to
prevent userspace from passing garbage.

Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
---
 net/bridge/br_netlink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 0c3cf6e6dea2..5ad4abfcb7ba 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1229,6 +1229,8 @@ static size_t br_port_get_slave_size(const struct net_device *brdev,
 }
 
 static const struct nla_policy br_policy[IFLA_BR_MAX + 1] = {
+	[IFLA_BR_UNSPEC]	= { .strict_start_type =
+				    IFLA_BR_FDB_N_LEARNED },
 	[IFLA_BR_FORWARD_DELAY]	= { .type = NLA_U32 },
 	[IFLA_BR_HELLO_TIME]	= { .type = NLA_U32 },
 	[IFLA_BR_MAX_AGE]	= { .type = NLA_U32 },

-- 
2.42.0

