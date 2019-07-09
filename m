Return-Path: <yuehaibing@huawei.com>
From: YueHaibing <yuehaibing@huawei.com>
Date: Tue, 9 Jul 2019 15:01:26 +0800
Message-ID: <20190709070126.29972-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next] netfilter: nft_meta: Fix build error
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de, roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com, wenxu@ucloud.cn
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org, coreteam@netfilter.org, netfilter-devel@vger.kernel.org

If NFT_BRIDGE_META is y and NF_TABLES is m, building fails:

net/bridge/netfilter/nft_meta_bridge.o: In function `nft_meta_bridge_get_init':
nft_meta_bridge.c:(.text+0xd0): undefined reference to `nft_parse_register'
nft_meta_bridge.c:(.text+0xec): undefined reference to `nft_validate_register_store'

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 30e103fe24de ("netfilter: nft_meta: move bridge meta keys into nft_meta_bridge")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/bridge/netfilter/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bridge/netfilter/Kconfig b/net/bridge/netfilter/Kconfig
index fbc7085..ca3214f 100644
--- a/net/bridge/netfilter/Kconfig
+++ b/net/bridge/netfilter/Kconfig
@@ -12,6 +12,7 @@ if NF_TABLES_BRIDGE
 
 config NFT_BRIDGE_META
 	tristate "Netfilter nf_table bridge meta support"
+	depends on NF_TABLES
 	help
 	  Add support for bridge dedicated meta key.
 
-- 
2.7.4


