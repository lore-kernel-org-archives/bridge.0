Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uUhhwavoelOAutf6ZINYv5+4TG3VETWVUGFixQHcuak=;
 b=rLSJSouYiv7OkG/FyDtfvfS0x+gh2sGEdXXD3TxkUkcmfLkc4s3DwFs9WTIygFn5Fj
 9dSFB3Q1LOeTUmj52Pu5jrZS6Lqgao9V4kPo8O8KEc2Q/Kez1XjZZY4DPSluEyfFd4Ww
 EydDZh+HT81QxaYKcL6dvGh6SYfTkUwGZ+P7sw8+uGAjks7+/cXXSX2OzW4UjCXD4jly
 fx8cx49P+Jph5i4PQluNOpPv8OtonmhYKrDY9BeqB4i4IEa6rZhhDcdKDVufnhylZZ9E
 aPGeIj0Il1AgFqn+S7NrqP+SoGJSPoPoJSTOaVbWq47E7ub44xVG+fFXXW8ChJPQthi6
 CPQw==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Wed, 13 Apr 2022 13:51:54 +0300
Message-Id: <20220413105202.2616106-5-razor@blackwall.org>
In-Reply-To: <20220413105202.2616106-1-razor@blackwall.org>
References: <20220413105202.2616106-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v4 04/12] net: netlink: add NLM_F_BULK
	delete request modifier
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

Add a new delete request modifier called NLM_F_BULK which, when
supported, would cause the request to delete multiple objects. The flag
is a convenient way to signal that a multiple delete operation is
requested which can be gradually added to different delete requests. In
order to make sure older kernels will error out if the operation is not
supported instead of doing something unintended we have to break a
required condition when implementing support for this flag, f.e. for
neighbors we will omit the mandatory mac address attribute.
Initially it will be used to add flush with filtering support for bridge
fdbs, but it also opens the door to add similar support to others.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 include/uapi/linux/netlink.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/netlink.h b/include/uapi/linux/netlink.h
index 4c0cde075c27..855dffb4c1c3 100644
--- a/include/uapi/linux/netlink.h
+++ b/include/uapi/linux/netlink.h
@@ -72,6 +72,7 @@ struct nlmsghdr {
 
 /* Modifiers to DELETE request */
 #define NLM_F_NONREC	0x100	/* Do not delete recursively	*/
+#define NLM_F_BULK	0x200	/* Delete multiple objects	*/
 
 /* Flags for ACK message */
 #define NLM_F_CAPPED	0x100	/* request was capped */
-- 
2.35.1

