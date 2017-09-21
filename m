Return-Path: <bernat@luffy.cx>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=bernat.im; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=postfix; bh=X
	ejBQGnJyRIUPue9V8sTsism0V4=; b=CFHPSnPYQQcEIu4vIUSZOcbYMPTRqTDVv
	Hl8FyC0MhtODNZZEmB90RKVFVFPx++3vSku5rrcxpKVci2eKsKoELXUVIzFLsGer
	2hZmMUMxlDWyXHa5FaAXJ3EPcEwYUEjwYzV8sAoAskqbtXWawZi3v9FFbnH7tiH3
	kTcHaZubIw=
From: Vincent Bernat <vincent@bernat.im>
Message-Id: <20170921100525.20395-1-vincent@bernat.im>
In-Reply-To: <20170920162140.369bb198@xeon-e3>
References: <20170920162140.369bb198@xeon-e3>
Subject: [Bridge] [net-next v3] bridge: trigger RTM_NEWLINK when interface
	is modified by bridge ioctl
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Thu, 21 Sep 2017 10:05:49 -0000
To: Stephen Hemminger <stephen@networkplumber.org>, David Ahern <dsahern@gmail.com>, David Miller <davem@davemloft.net>, bridge@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: Vincent Bernat <vincent@bernat.im>

Currently, there is a difference in netlink events received when an
interface is modified through bridge ioctl() or through netlink. This
patch generates additional events when an interface is added to or
removed from a bridge via ioctl().

When adding then removing an interface from a bridge with netlink, we
get:

5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue master bridge0 state UNKNOWN group default
    link/ether 9e:da:60:ee:cf:c8 brd ff:ff:ff:ff:ff:ff
5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
    link/ether 9e:da:60:ee:cf:c8
5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
    link/ether 9e:da:60:ee:cf:c8
5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
    link/ether 9e:da:60:ee:cf:c8
5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
    link/ether 9e:da:60:ee:cf:c8
5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue master bridge0 state UNKNOWN group default
    link/ether 9e:da:60:ee:cf:c8 brd ff:ff:ff:ff:ff:ff

5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue master bridge0 state UNKNOWN group default
    link/ether 9e:da:60:ee:cf:c8 brd ff:ff:ff:ff:ff:ff
5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
    link/ether 9e:da:60:ee:cf:c8
Deleted 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
    link/ether 9e:da:60:ee:cf:c8
5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default
    link/ether 9e:da:60:ee:cf:c8 brd ff:ff:ff:ff:ff:ff

When using ioctl():

5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue master bridge0 state UNKNOWN group default
    link/ether 9e:da:60:ee:cf:c8 brd ff:ff:ff:ff:ff:ff
5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
    link/ether 9e:da:60:ee:cf:c8
5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
    link/ether 9e:da:60:ee:cf:c8
5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
    link/ether 9e:da:60:ee:cf:c8
5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue master bridge0 state UNKNOWN group default
    link/ether 9e:da:60:ee:cf:c8 brd ff:ff:ff:ff:ff:ff

5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue master bridge0 state UNKNOWN group default
    link/ether 9e:da:60:ee:cf:c8 brd ff:ff:ff:ff:ff:ff
5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
    link/ether 9e:da:60:ee:cf:c8
Deleted 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
    link/ether 9e:da:60:ee:cf:c8
5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default
    link/ether 9e:da:60:ee:cf:c8 brd ff:ff:ff:ff:ff:ff

Without this patch, the last netlink notification is not sent.

Signed-off-by: Vincent Bernat <vincent@bernat.im>
---
 net/bridge/br_ioctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bridge/br_ioctl.c b/net/bridge/br_ioctl.c
index 7970f8540cbb..66cd98772051 100644
--- a/net/bridge/br_ioctl.c
+++ b/net/bridge/br_ioctl.c
@@ -102,6 +102,9 @@ static int add_del_if(struct net_bridge *br, int ifindex, int isadd)
 	else
 		ret = br_del_if(br, dev);
 
+	if (!ret)
+		rtmsg_ifinfo(RTM_NEWLINK, dev, IFF_MASTER, GFP_KERNEL);
+
 	return ret;
 }
 
-- 
2.14.1

