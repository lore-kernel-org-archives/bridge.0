Return-Path: <dan.carpenter@oracle.com>
Date: Fri, 7 Dec 2012 14:10:46 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Message-ID: <20121207111045.GA9676@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20121207093107.GA2996@casper.infradead.org>
Subject: [Bridge] [patch v2] bridge: make buffer larger in br_setlink()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, kernel-janitors@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

We pass IFLA_BRPORT_MAX to nla_parse_nested() so we need
IFLA_BRPORT_MAX + 1 elements.  Also Smatch complains that we read past
the end of the array when in br_set_port_flag() when it's called with
IFLA_BRPORT_FAST_LEAVE.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: Style tweak.

Only needed in linux-next.

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 850b7d1..cfc5cfe 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -239,7 +239,7 @@ int br_setlink(struct net_device *dev, struct nlmsghdr *nlh)
 	struct ifinfomsg *ifm;
 	struct nlattr *protinfo;
 	struct net_bridge_port *p;
-	struct nlattr *tb[IFLA_BRPORT_MAX];
+	struct nlattr *tb[IFLA_BRPORT_MAX + 1];
 	int err;
 
 	ifm = nlmsg_data(nlh);

