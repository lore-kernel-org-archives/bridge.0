Return-Path: <trix@redhat.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621111136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RjAWv7j/zHfhk0YuuOMHIejR7YmGA5R8BOsaPxYr0kQ=;
 b=iC4MK9UWM+xdb0TPBGyvYy/9wSSexD1CNPRg5/tRO9tya6zISQNMZiC99pz7HKOSE/mvSe
 sxJtBNzlSH+y9Dps9vel3HW+fIL9GV1qGHtv/bWO4FcU+5Zw3A08CvQcGS78HO0JwfBS5s
 e3CLl8Vlz+eJRRraNt2Oxw/J9MgITJY=
From: trix@redhat.com
Date: Sat, 15 May 2021 13:38:49 -0700
Message-Id: <20210515203849.1756371-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH] net: bridge: fix signature of stub
	br_multicast_is_router
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: roopa@nvidia.com, nikolay@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>

From: Tom Rix <trix@redhat.com>

Building with CONFIG_IPV6 off causes this build error

br_input.c:135:8: error: too many arguments to function
  ‘br_multicast_is_router’
        br_multicast_is_router(br, skb)) {
        ^~~~~~~~~~~~~~~~~~~~~~
In file included from net/bridge/br_input.c:23:
net/bridge/br_private.h:1059:20: note: declared here
 static inline bool br_multicast_is_router(struct net_bridge *br)
                    ^~~~~~~~~~~~~~~~~~~~~~

Comparing the stub with the real function shows the stub needs
another parameter.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 net/bridge/br_private.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index f9a381fcff094..9fd54626ca809 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1056,7 +1056,7 @@ static inline void br_multicast_flood(struct net_bridge_mdb_entry *mdst,
 {
 }
 
-static inline bool br_multicast_is_router(struct net_bridge *br)
+static inline bool br_multicast_is_router(struct net_bridge *br, struct sk_buff *skb)
 {
 	return false;
 }
-- 
2.26.3

