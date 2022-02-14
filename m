Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfP6ixMSlLLBQi8hwtgYo+mzjMgRuDn0LKTSk9S0G6s=;
 b=DgnS3dE+0u/MR+rQb1k1FntJf4B5WHWD/9AQe7b8RStDAOtygjV8qEWAYGQcRxadl5xuvk49yLFgdz5oL1/CsoiYABy2bdJjnfDYpqeyZjPqs4sR1i1JHW8ftMI7DSoxjwf+6lAEsFIXa6VfDNKU+Us84dUWXsZLGkPs1CprGaLs9caAlOaaeOf92qwW1tQiOffkET2kuuOIHLt5eXjy5xGqdoZvOLKezYeKDMiVfsRyyBSkyTw5r6WxiuPjkKhBZQhm/1LSaTXfOGPjYJSEIQnAG5zeUxI3mGvCRGzG3ua9uLLw+EZYKZFXc5GvFYjlNKjdpf8f1XlnyQEqVJHmEw==
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Date: Mon, 14 Feb 2022 13:23:32 +0200
Message-ID: <20220214112332.3330923-1-nikolay@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net] MAINTAINERS: bridge: update my email
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@nvidia.com>, kuba@kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

I'm leaving NVIDIA and my email account will stop working in a week, update
it with my personal account.

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
Routing through -net to get merged in net-next so there are no
discrepancies. It applies also to net-next if that is preferred.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2ac90c8b432a..4251553ea2e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7180,7 +7180,7 @@ F:	drivers/net/can/usb/etas_es58x/
 
 ETHERNET BRIDGE
 M:	Roopa Prabhu <roopa@nvidia.com>
-M:	Nikolay Aleksandrov <nikolay@nvidia.com>
+M:	Nikolay Aleksandrov <razor@blackwall.org>
 L:	bridge@lists.linux-foundation.org (moderated for non-subscribers)
 L:	netdev@vger.kernel.org
 S:	Maintained
-- 
2.34.1

