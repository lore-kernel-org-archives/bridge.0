Return-Path: <huangruippp@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=DSm60fsRvigZ9rO9v9GaStHi5ZcMD+nYH04YGyKBRU0=;
	b=fjESDrfL/POOG9UqFWuFRcxAKL0/LNLBZjmpbvCmJaBFkiRaJQuFHi/WWdPIBaUCBp
	oqBobw8ztH7yVJZw8kKSc7f8otXSgM7xKMVvvVKBLgcfshZHPzCJhkvQdTAFDFWREV/Q
	ToQOSvl+QbC//HEf2cj+u+Y3sk/KHJnc/mYYFVRrVtgX4n3B9Ox3RcnJWozk7nuIRKv4
	PDSpX5SGQco+nZhdUaKo3UprRRoV+2O/fYO+uaEjIwaOUf52BgNsD6keJEquyTrOuelJ
	Uhl3r/3/n1MAk+p3uRja4ztVajwqKiqUH1a/+BrXb+VK8M6ruWlEwZH7XQL5Zt7lZRJC
	EHMQ==
From: Huang Rui <huangruippp@gmail.com>
Date: Wed, 10 Apr 2019 02:32:08 +0000
Message-Id: <20190410023208.25435-1-huangruiPPP@gmail.com>
Subject: [Bridge] [PATCH] net:bridge:always disable auto-tuning when the
	user specified MTU
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net
Cc: songliubraving@fb.com, jakub.kicinski@netronome.com, ast@kernel.org, ecree@solarflare.com, xdp-newbies@vger.kernel.org, daniel@iogearbox.net, bridge@lists.linux-foundation.org, john.fastabend@gmail.com, lirongqing@baidu.com, huangruiPPP@gmail.com, yhs@fb.com, alexander.h.duyck@intel.com, hawk@kernel.org, nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, idosch@mellanox.com, jiri@mellanox.com, amritha.nambiar@intel.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kafai@fb.com

For example.
My purpose is to create a bridge br0 and join eth0 into br0.
if we use this following way, the auto-tuning flag will not be disabled.

If eth0's mtu is 1200
step 1.brctl addbr br0
step 2.brctl addif br0 eth0
step 3.ifconfig br0 mtu 1200
step 4.ifconfig eth0 mtu 1500

Result:
br0's MTU: 1500, eth0's MTU: 1500

Expected:
br0's MTU: 1200, eth0's MTU: 1500

I have specified br0's MTU,  but auto-min policy works. So the MTU is
not the result what we expected.
As expected, if i have specified bridge's MTU, it will set the flag:
BROPT_MTU_SET_BY_USER in net_bridge_opts disabled and auto-min/max
policy will not work.But in this case, because the dev_set_mtu return
early, the BROPT_MTU_SET_BY_USER flag will not be disabled and
auto-min/max policy will still work.

Signed-off-by: Huang Rui <huangruiPPP@gmail.com>
---
 net/core/dev.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 2b67f2aa59dd..ba410d76bb49 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -7670,8 +7670,12 @@ int dev_set_mtu_ext(struct net_device *dev, int new_mtu,
 {
 	int err, orig_mtu;
 
-	if (new_mtu == dev->mtu)
-		return 0;
+	if (new_mtu == dev->mtu) {
+		if (dev->priv_flags & IFF_EBRIDGE)
+			return __dev_set_mtu(dev, new_mtu);
+		else
+			return 0;
+	}
 
 	/* MTU must be positive, and in range */
 	if (new_mtu < 0 || new_mtu < dev->min_mtu) {
-- 
2.11.0

