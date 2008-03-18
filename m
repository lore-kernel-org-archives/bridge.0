Message-ID: <47E01A5B.1070109@gmail.com>
Date: Tue, 18 Mar 2008 21:39:07 +0200
From: "Volodymyr G. Lukiianyk" <volodymyrgl@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060009040403040705010903"
Subject: [Bridge] [PATCH] bridge: fix error handling in br_add_if()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org, Stephen Hemminger <shemminger@linux-foundation.org>

This is a multi-part message in MIME format.
--------------060009040403040705010903
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

When device is added to bridge its refcnt is incremented (in new_nbp()), but if
error occurs during further br_add_if() operations this counter is not
decremented back. Fix it by adding dev_put() call in the error path.

Signed-off-by: Volodymyr G Lukiianyk <volodymyrgl@gmail.com>


--------------060009040403040705010903
Content-Type: text/x-patch;
 name="br_add_if_put_dev.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="br_add_if_put_dev.diff"

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 298e0f4..77a981a 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -411,9 +411,12 @@ err2:
 	br_fdb_delete_by_port(br, p, 1);
 err1:
 	kobject_del(&p->kobj);
-	return err;
+	goto put_back;
 err0:
 	kobject_put(&p->kobj);
+
+put_back:
+	dev_put(dev);
 	return err;
 }
 


--------------060009040403040705010903--
