Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 10 Jul 2019 10:08:20 +0200
Message-Id: <20190710080835.296696-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH] [net-next] netfilter: bridge: make
	NF_TABLES_BRIDGE tristate
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, Roopa Prabhu <roopa@cumulusnetworks.com>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, "David S. Miller" <davem@davemloft.net>
Cc: wenxu <wenxu@ucloud.cn>, Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, coreteam@netfilter.org, netfilter-devel@vger.kernel.org

The new nft_meta_bridge code fails to link as built-in when NF_TABLES
is a loadable module.

net/bridge/netfilter/nft_meta_bridge.o: In function `nft_meta_bridge_get_eval':
nft_meta_bridge.c:(.text+0x1e8): undefined reference to `nft_meta_get_eval'
net/bridge/netfilter/nft_meta_bridge.o: In function `nft_meta_bridge_get_init':
nft_meta_bridge.c:(.text+0x468): undefined reference to `nft_meta_get_init'
nft_meta_bridge.c:(.text+0x49c): undefined reference to `nft_parse_register'
nft_meta_bridge.c:(.text+0x4cc): undefined reference to `nft_validate_register_store'
net/bridge/netfilter/nft_meta_bridge.o: In function `nft_meta_bridge_module_exit':
nft_meta_bridge.c:(.exit.text+0x14): undefined reference to `nft_unregister_expr'
net/bridge/netfilter/nft_meta_bridge.o: In function `nft_meta_bridge_module_init':
nft_meta_bridge.c:(.init.text+0x14): undefined reference to `nft_register_expr'
net/bridge/netfilter/nft_meta_bridge.o:(.rodata+0x60): undefined reference to `nft_meta_get_dump'
net/bridge/netfilter/nft_meta_bridge.o:(.rodata+0x88): undefined reference to `nft_meta_set_eval'

This can happen because the NF_TABLES_BRIDGE dependency itself is just a
'bool'.  Make the symbol a 'tristate' instead so Kconfig can propagate the
dependencies correctly.

Fixes: 30e103fe24de ("netfilter: nft_meta: move bridge meta keys into nft_meta_bridge")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/bridge/netfilter/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/netfilter/Kconfig b/net/bridge/netfilter/Kconfig
index 154fa558bb90..d0c75d7ec074 100644
--- a/net/bridge/netfilter/Kconfig
+++ b/net/bridge/netfilter/Kconfig
@@ -6,7 +6,7 @@
 menuconfig NF_TABLES_BRIDGE
 	depends on BRIDGE && NETFILTER && NF_TABLES
 	select NETFILTER_FAMILY_BRIDGE
-	bool "Ethernet Bridge nf_tables support"
+	tristate "Ethernet Bridge nf_tables support"
 
 if NF_TABLES_BRIDGE
 
-- 
2.20.0

