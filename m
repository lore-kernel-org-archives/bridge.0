Return-Path: <liuhangbin@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aKVkEDBagljuX3YCkGFMWzS+lPPdBp7IpdpqtPio3EU=;
 b=f0NIGHVBopI0yPqJVr/PiUV/mhKQiqe9Zkr1Ss+4XSbNk5DhohIa6DolWNsmB2DccW
 6ljXAdWx0+uM7qFc/tpWeUvJx+IQhUU4WZEQOMpM5PFfCvCcawF+21VSP+7hbhtvSVoH
 vXg5fWv1FdiYiyrSfvy1wLtuqn39uPftTEtbPbhb8DK036ka0oTsJtcNby9QPy0ipT10
 mKeC80M6GDWPx+xX1naF5S0AGlEWgRgwo0H8LUOecxg/mTWmpjnXwIV9vMhhUoX9Gd6M
 OTZ5mg69q2xam+YVhbRRsQo/rEnPUalloNWn1vm2jfaGhM4rGSvf74PG2Iq4le7LHsTb
 USiw==
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Tue, 26 Jan 2021 12:09:49 +0800
Message-Id: <20210126040949.3130937-1-liuhangbin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next] bridge: Propagate NETDEV_NOTIFY_PEERS
	notifier
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>, Jiri Pirko <jiri@resnulli.us>, bridge@lists.linux-foundation.org, Jarod Wilson <jarod@redhat.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>, Roopa Prabhu <roopa@nvidia.com>, "David S . Miller" <davem@davemloft.net>

After adding bridge as upper layer of bond/team, we usually clean up the
IP address on bond/team and set it on bridge. When there is a failover,
bond/team will not send gratuitous ARP since it has no IP address.
Then the down layer(e.g. VM tap dev) of bridge will not able to receive
this notification.

Make bridge to be able to handle NETDEV_NOTIFY_PEERS notifier.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 net/bridge/br.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bridge/br.c b/net/bridge/br.c
index ef743f94254d..b6a0921bb498 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -125,6 +125,7 @@ static int br_device_event(struct notifier_block *unused, unsigned long event, v
 		/* Forbid underlying device to change its type. */
 		return NOTIFY_BAD;
 
+	case NETDEV_NOTIFY_PEERS:
 	case NETDEV_RESEND_IGMP:
 		/* Propagate to master device */
 		call_netdevice_notifiers(event, br->dev);
-- 
2.26.2

