Return-Path: <tyhicks@canonical.com>
From: Tyler Hicks <tyhicks@canonical.com>
Date: Fri, 20 Jul 2018 21:56:51 +0000
Message-Id: <1532123814-1109-6-git-send-email-tyhicks@canonical.com>
In-Reply-To: <1532123814-1109-1-git-send-email-tyhicks@canonical.com>
References: <1532123814-1109-1-git-send-email-tyhicks@canonical.com>
Subject: [Bridge] [PATCH net-next v3 5/8] net-sysfs: require net admin in
	the init ns for setting tx_maxrate
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>, "David S. Miller" <davem@davemloft.net>, Stephen Hemminger <stephen@networkplumber.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, netdev@vger.kernel.org, Linux Containers <containers@lists.linux-foundation.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>

An upcoming change will allow container root to open some /sys/class/net
files for writing. The tx_maxrate attribute can result in changes
to actual hardware devices so err on the side of caution by requiring
CAP_NET_ADMIN in the init namespace in the corresponding attribute store
operation.

Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
---
 net/core/net-sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index ffa1d18f2c2c..405c41ecb20b 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1087,6 +1087,9 @@ static ssize_t tx_maxrate_store(struct netdev_queue *queue,
 	int err, index = get_netdev_queue_index(queue);
 	u32 rate = 0;
 
+	if (!capable(CAP_NET_ADMIN))
+		return -EPERM;
+
 	err = kstrtou32(buf, 10, &rate);
 	if (err < 0)
 		return err;
-- 
2.7.4

