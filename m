Date: Wed, 28 Jul 2004 16:28:02 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Assertion failed in bridge code on 2.4.27-rc3
Message-Id: <20040728162802.6a297248@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040728222722.GA2688@man.manty.net>
References: <20040728195957.GA2621@man.manty.net>
	<20040728132128.22bed751@dell_ss3.pdx.osdl.net>
	<20040728222722.GA2688@man.manty.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Santiago Garcia Mantinan <manty@manty.net>, "David S. Miller" <davem@redhat.com>
Cc: bridge@lists.osdl.org

The code path for some ioctl's is different in 2.4 than 2.6 (it goes
through IP in 2.4).  Therefore the following is needed.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

diff -Nru a/net/bridge/br_ioctl.c b/net/bridge/br_ioctl.c
--- a/net/bridge/br_ioctl.c	2004-07-28 16:28:49 -07:00
+++ b/net/bridge/br_ioctl.c	2004-07-28 16:28:49 -07:00
@@ -234,6 +234,7 @@
 int br_ioctl_deviceless_stub(unsigned long arg)
 {
 	unsigned long i[3];
+	int err;
 
 	if (!capable(CAP_NET_ADMIN))
 		return -EPERM;
@@ -241,8 +242,10 @@
 	if (copy_from_user(i, (void *)arg, 3*sizeof(unsigned long)))
 		return -EFAULT;
 
-	ASSERT_RTNL();
-	return  br_ioctl_deviceless(i[0], i[1], i[2]);
+	rtnl_lock();
+	err =  br_ioctl_deviceless(i[0], i[1], i[2]);
+	rtnl_unlock();
+	return err;
 }
 
 int br_ioctl(struct net_bridge *br, unsigned int cmd, unsigned long arg0, unsigned long arg1, unsigned long arg2)
