Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bxnUQR9V57rGqYOjdVUj6Nc/+H1dclO6Pe3lE8dzyks=;
 b=v0xXGtzEyPwMy5K5G8fUCwmcOyh3wq4YsIIBIWH6HBnko3nwWalZWY4oFTHxmdk4pi
 M92GRFrT5Bsy3V/YNM/ezVhobRWp1KXQfxbqubgOItaCQ0t0e6NXoj9+3KiLBCi3DPV0
 Z87K75gLIM0v1GHRrLD95VMaKoXTjIKQcW12HfCn1Ogn3dYbQCuAHhJnKwlDCPhIaHjb
 s6UtWIMHBwYe5NubtFzkWx5+HX8dYwPpgO04JtZD3s0gTHQ+BgmQK46asyGkoZXNwD2I
 T26Wnsou5l8DcA/UuvQY66AeHoxKysm5vtQJ3e42nNV9kQhcJ2LV8gs7pA2b/uU7Slbb
 iRyw==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Wed, 13 Apr 2022 13:51:53 +0300
Message-Id: <20220413105202.2616106-4-razor@blackwall.org>
In-Reply-To: <20220413105202.2616106-1-razor@blackwall.org>
References: <20220413105202.2616106-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v4 03/12] net: rtnetlink: use BIT for flag
	values
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <razor@blackwall.org>, dsahern@kernel.org, bridge@lists.linux-foundation.org, idosch@idosch.org, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

Use BIT to define flag values.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
v4: new patch

 include/net/rtnetlink.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index c51c5ff7f7e2..0bf622409aaa 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -10,7 +10,7 @@ typedef int (*rtnl_doit_func)(struct sk_buff *, struct nlmsghdr *,
 typedef int (*rtnl_dumpit_func)(struct sk_buff *, struct netlink_callback *);
 
 enum rtnl_link_flags {
-	RTNL_FLAG_DOIT_UNLOCKED = 1,
+	RTNL_FLAG_DOIT_UNLOCKED = BIT(0),
 };
 
 enum rtnl_kinds {
-- 
2.35.1

