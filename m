Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A604E703FE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0A8196FA4C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1698401162; x=1699005962;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EzUFAA0TdPmj/Cb4HKxf5oHBR+/7qG5RzYUy2yOEkT4=;
 b=QbAUJl0RJy9Dp597RzPngMlhIrnOzrPZxinJG872JxBDCFZt8ImF0G+53LzGf/8bB4
 3d7hZGvTDmZ0X0DAYkmbcXjs/v5s2NGRmD5G2YtTcthHkfZwhQahaYHuknJlv1xOUgAs
 GGKvS9Pju+3yHQtt7V66GKBYSVj6diBfF1iJyVsKqW1vfbl5ZvJ5+nb7gVGd6E4EtbfX
 UkZ63RCg4VwioFTzw4n0W44/EXVIdnEnH0Dv4d01CgzDJX2FZhbR0HaS40QDE83yP5Xb
 AvuKAW5Cqyh/WwFYeuIkNjpe0QFhO0gM6TrE+gnHdYE2qI7KggvLK2xuK1yyZCnuv2mv
 DXkw==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Fri, 27 Oct 2023 13:05:49 +0300
Message-Id: <20231027100549.1695865-1-razor@blackwall.org>
In-Reply-To: <20231026190101.1413939-1-kuba@kernel.org>
References: <20231026190101.1413939-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next] net: bridge: fill in MODULE_DESCRIPTION()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, roopa@nvidia.com

Fill in bridge's module description.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bridge/br.c b/net/bridge/br.c
index a6e94ceb7c9a..cda9d7871f72 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -477,3 +477,4 @@ module_exit(br_deinit)
 MODULE_LICENSE("GPL");
 MODULE_VERSION(BR_VERSION);
 MODULE_ALIAS_RTNL_LINK("bridge");
+MODULE_DESCRIPTION("Ethernet bridge driver");
-- 
2.38.1

