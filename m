Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=G4Lf3IeHTYSBP2jBlrEzBtLYrCtWftbohLvXAydSyEo=;
 b=S5NtrlUiP9am+mfWWs0tdCtoJF8LvNMfNHuBR0cH25+Xpn3ZnLgDT87648YbKHJ1/i
 0w0gru0NSrKVP38xmgX+es38tXRq1lmxRK/A7qXb9LaBBrcmt0gakCd3bfwwL1CvUUWT
 abEqtMI0job1tDc+M8I/C3ZpW8mK5ejPKawnfxxQEZwg1lmITGg16vsJGeF3JRx8W6fX
 PjQCCBVPSeTF8tmwS2uhHXNRfPOSAjlJI8F9Lh2YeKfwvFOlro59hJSoikLGiHJqaPA+
 HXfFFQPlSRLnHhEXB0856jTQwYzGKOBnCGyPGG/PLJkO9BzzsEd79CvZGhROfPjo6LIR
 Z4lw==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Mon, 11 Apr 2022 20:29:27 +0300
Message-Id: <20220411172934.1813604-2-razor@blackwall.org>
In-Reply-To: <20220411172934.1813604-1-razor@blackwall.org>
References: <20220411172934.1813604-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v2 1/8] net: rtnetlink: add RTM_FLUSHNEIGH
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, idosch@idosch.org, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

Add a new rtnetlink type used to flush neigh objects. It will be
initially used to add flush with filtering support for bridge fdbs, but
it also opens the door to add similar support to others (e.g. vxlan).

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 include/uapi/linux/rtnetlink.h | 3 +++
 security/selinux/nlmsgtab.c    | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
index 83849a37db5b..06001cfd404b 100644
--- a/include/uapi/linux/rtnetlink.h
+++ b/include/uapi/linux/rtnetlink.h
@@ -194,6 +194,9 @@ enum {
 	RTM_GETTUNNEL,
 #define RTM_GETTUNNEL	RTM_GETTUNNEL
 
+	RTM_FLUSHNEIGH = 124,
+#define RTM_FLUSHNEIGH	RTM_FLUSHNEIGH
+
 	__RTM_MAX,
 #define RTM_MAX		(((__RTM_MAX + 3) & ~3) - 1)
 };
diff --git a/security/selinux/nlmsgtab.c b/security/selinux/nlmsgtab.c
index d8ceee9e0d6f..ff53aea8790f 100644
--- a/security/selinux/nlmsgtab.c
+++ b/security/selinux/nlmsgtab.c
@@ -95,6 +95,7 @@ static const struct nlmsg_perm nlmsg_route_perms[] =
 	{ RTM_NEWTUNNEL,	NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
 	{ RTM_DELTUNNEL,	NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
 	{ RTM_GETTUNNEL,	NETLINK_ROUTE_SOCKET__NLMSG_READ  },
+	{ RTM_FLUSHNEIGH,	NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
 };
 
 static const struct nlmsg_perm nlmsg_tcpdiag_perms[] =
@@ -180,7 +181,7 @@ int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm)
 		 * structures at the top of this file with the new mappings
 		 * before updating the BUILD_BUG_ON() macro!
 		 */
-		BUILD_BUG_ON(RTM_MAX != (RTM_NEWTUNNEL + 3));
+		BUILD_BUG_ON(RTM_MAX != (RTM_FLUSHNEIGH + 3));
 		err = nlmsg_perm(nlmsg_type, perm, nlmsg_route_perms,
 				 sizeof(nlmsg_route_perms));
 		break;
-- 
2.35.1

