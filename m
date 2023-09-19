Return-Path: <jnixdorf-oss@avm.de>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 36DA5614AA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DA29F60608
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1695125794; bh=sl503WT+JbQzr0PX1UeglL1eOYNs5r/CaovdgyxCXb4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=dalE7vUS2VX9zd1t4D/R0Ev6r+Qj3jaMeyq2U/S0vGhAcSwd8lAdEt+8Gsm8Bp1eu
 KjSrFFjvZfOxqwmz1kzhvfn5TlFb9oQ2/+mnB0zt6fsHVx4OByenolTjoujucDRjij
 kjLG1pmuBIkhBjUKQIYEd9zS628mNR06kCcTqPGA=
From: Johannes Nixdorf <jnixdorf-oss@avm.de>
Date: Tue, 19 Sep 2023 10:12:49 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230919-fdb_limit-v4-2-39f0293807b8@avm.de>
References: <20230919-fdb_limit-v4-0-39f0293807b8@avm.de>
In-Reply-To: <20230919-fdb_limit-v4-0-39f0293807b8@avm.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695111167; l=817;
 i=jnixdorf-oss@avm.de; s=20230906; h=from:subject:message-id;
 bh=sl503WT+JbQzr0PX1UeglL1eOYNs5r/CaovdgyxCXb4=;
 b=CD0YGMfLKNVRvbluKMbocG6VTuD+aNifNX7GZPqGAWKInzmZ79SN4khFtt/aAmBp5rzcWc6SI
 t8kYXAaNjNsC6tAp3c4MFY+KprTITZa+RCDqYiduf79UlI0H0wXutJ/
X-Developer-Key: i=jnixdorf-oss@avm.de; a=ed25519;
 pk=KMraV4q7ANHRrwjf9EVhvU346JsqGGNSbPKeNILOQfo=
Subject: [Bridge] [PATCH net-next v4 2/6] net: bridge: Set strict_start_type
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
index 10f0d33d8ccf..505683ef9a26 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1229,6 +1229,8 @@ static size_t br_port_get_slave_size(const struct net_device *brdev,
 }
 
 static const struct nla_policy br_policy[IFLA_BR_MAX + 1] = {
+	[IFLA_BR_UNSPEC]	= { .strict_start_type =
+				    IFLA_BR_MCAST_QUERIER_STATE + 1 },
 	[IFLA_BR_FORWARD_DELAY]	= { .type = NLA_U32 },
 	[IFLA_BR_HELLO_TIME]	= { .type = NLA_U32 },
 	[IFLA_BR_MAX_AGE]	= { .type = NLA_U32 },

-- 
2.42.0

