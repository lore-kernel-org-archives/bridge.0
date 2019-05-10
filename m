Return-Path: <tobin@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:date:from
	:message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=MB29zTtGAQv18AoG4
	ME820wBqkJjcLFJN7yVzkW2rFI=; b=WN4qWqK/yNR+uhX+KfAFdDO6WybPAxf+U
	UpZUGZhBWZGrbdMgbmOlC9F5Fxzb+xpT9ou2mOlO3jVeM7lOiUL/zkC8+shshAaq
	nvtfW81iY22TiRQKjeLa6CWWk20VqgiALYxv84eEUL0kREiMzVpnqQnJghSAsmSZ
	Zzl9EjFKSLsrzDQjwRtEsVUcpradsChjgrvtIIgIvqbAVBTbWGyP1LWo6EH/Zn1S
	w8dPhluv6MkKAL38YAiC3iqO2ZXABYc3NfYdt+QqPAmjx4PhwFIn01FFOtqhFA1c
	4nW3p6MBk7NhtqP1n24Nnn41ZHey1m4Ls1YdPmCYvolkej90nWJ6Q==
From: "Tobin C. Harding" <tobin@kernel.org>
Date: Fri, 10 May 2019 12:52:12 +1000
Message-Id: <20190510025212.10109-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v2] bridge: Fix error path for
	kobject_init_and_add()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "David S. Miller" <davem@davemloft.net>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Tyler Hicks <tyhicks@canonical.com>, "Tobin C. Harding" <tobin@kernel.org>, netdev@vger.kernel.org

Currently error return from kobject_init_and_add() is not followed by a
call to kobject_put().  This means there is a memory leak.  We currently
set p to NULL so that kfree() may be called on it as a noop, the code is
arguably clearer if we move the kfree() up closer to where it is
called (instead of after goto jump).

Remove a goto label 'err1' and jump to call to kobject_put() in error
return from kobject_init_and_add() fixing the memory leak.  Re-name goto
label 'put_back' to 'err1' now that we don't use err1, following current
nomenclature (err1, err2 ...).  Move call to kfree out of the error
code at bottom of function up to closer to where memory was allocated.
Add comment to clarify call to kfree().

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---

v1 was a part of a set.  I have dropped the other patch until I can work
out a correct solution.

 net/bridge/br_if.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 41f0a696a65f..0cb0aa0313a8 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -602,13 +602,15 @@ int br_add_if(struct net_bridge *br, struct net_device *dev,
 	call_netdevice_notifiers(NETDEV_JOIN, dev);
 
 	err = dev_set_allmulti(dev, 1);
-	if (err)
-		goto put_back;
+	if (err) {
+		kfree(p);	/* kobject not yet init'd, manually free */
+		goto err1;
+	}
 
 	err = kobject_init_and_add(&p->kobj, &brport_ktype, &(dev->dev.kobj),
 				   SYSFS_BRIDGE_PORT_ATTR);
 	if (err)
-		goto err1;
+		goto err2;
 
 	err = br_sysfs_addif(p);
 	if (err)
@@ -700,12 +702,9 @@ int br_add_if(struct net_bridge *br, struct net_device *dev,
 	sysfs_remove_link(br->ifobj, p->dev->name);
 err2:
 	kobject_put(&p->kobj);
-	p = NULL; /* kobject_put frees */
-err1:
 	dev_set_allmulti(dev, -1);
-put_back:
+err1:
 	dev_put(dev);
-	kfree(p);
 	return err;
 }
 
-- 
2.21.0

