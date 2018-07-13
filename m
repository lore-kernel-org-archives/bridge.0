Return-Path: <tyhicks@canonical.com>
From: Tyler Hicks <tyhicks@canonical.com>
Date: Fri, 13 Jul 2018 16:05:45 +0000
Message-Id: <1531497949-1766-4-git-send-email-tyhicks@canonical.com>
In-Reply-To: <1531497949-1766-1-git-send-email-tyhicks@canonical.com>
References: <1531497949-1766-1-git-send-email-tyhicks@canonical.com>
Subject: [Bridge] [PATCH net-next v2 3/7] kobject: kset_create_and_add() -
	fetch ownership info from parent
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

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

This change implements get_ownership() for ksets created with
kset_create_and_add() call by fetching ownership data from parent kobject.
This is done mostly for benefit of "queues" attribute of net devices so
that corresponding directory belongs to container's root instead of global
root for network devices in a container.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reviewed-by: Tyler Hicks <tyhicks@canonical.com>
---
 lib/kobject.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/kobject.c b/lib/kobject.c
index f2dc1f756007..389829d3a1d1 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -887,9 +887,16 @@ static void kset_release(struct kobject *kobj)
 	kfree(kset);
 }
 
+void kset_get_ownership(struct kobject *kobj, kuid_t *uid, kgid_t *gid)
+{
+	if (kobj->parent)
+		kobject_get_ownership(kobj->parent, uid, gid);
+}
+
 static struct kobj_type kset_ktype = {
 	.sysfs_ops	= &kobj_sysfs_ops,
-	.release = kset_release,
+	.release	= kset_release,
+	.get_ownership	= kset_get_ownership,
 };
 
 /**
-- 
2.7.4

