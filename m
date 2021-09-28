Return-Path: <gustavoars@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632859717;
 bh=iGeBtWmkRfAzSRTb77ICIIphC0rlNZhpBjX8dqGzNdE=;
 h=Date:From:To:Cc:Subject:From;
 b=QSz+7uuGhjxu5ImIZDs39zDTwyBDTiFHsi1eRagbHh6ByUCOO2mPsQUxgrEenKiAt
 B4aiqepgKIVeEeiai4Sjb+z7aN5rLt2Q/iDTcXC3+dw8jDRSdS6djC2vgsnP6K1pae
 jByhOq3eFccW+h7ol0y5x6IoyZZaHoTqfVdc6Jbcp8pBjYr9KTYic09JTBHS36yOS0
 iF8zDfOU9YzJ0uLSiB/6NVZ6MCA/pt3tXQJ+KkPRZV1FBcca3BTugcf0RPzSbZGMNR
 jahze2rOThLQIVYyKSCdBBF9Merdt1Ax0+h5xbxWFk/h8pbgjydpLXIoAmrCs+4ea6
 WztIrCREd/tUw==
Date: Tue, 28 Sep 2021 15:12:39 -0500
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Message-ID: <20210928201239.GA267176@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Bridge] [PATCH][net-next] net: bridge: Use array_size() helper in
 copy_to_user()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>

Use array_size() helper instead of the open-coded version in
copy_to_user(). These sorts of multiplication factors need
to be wrapped in array_size().

Link: https://github.com/KSPP/linux/issues/160
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 net/bridge/br_ioctl.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_ioctl.c b/net/bridge/br_ioctl.c
index 793b0db9d9a3..49c268871fc1 100644
--- a/net/bridge/br_ioctl.c
+++ b/net/bridge/br_ioctl.c
@@ -71,7 +71,8 @@ static int get_fdb_entries(struct net_bridge *br, void __user *userbuf,
 
 	num = br_fdb_fillbuf(br, buf, maxnum, offset);
 	if (num > 0) {
-		if (copy_to_user(userbuf, buf, num*sizeof(struct __fdb_entry)))
+		if (copy_to_user(userbuf, buf,
+				 array_size(num, sizeof(struct __fdb_entry))))
 			num = -EFAULT;
 	}
 	kfree(buf);
@@ -188,7 +189,7 @@ int br_dev_siocdevprivate(struct net_device *dev, struct ifreq *rq, void __user
 			return -ENOMEM;
 
 		get_port_ifindices(br, indices, num);
-		if (copy_to_user(argp, indices, num * sizeof(int)))
+		if (copy_to_user(argp, indices, array_size(num, sizeof(int))))
 			num =  -EFAULT;
 		kfree(indices);
 		return num;
@@ -336,7 +337,8 @@ static int old_deviceless(struct net *net, void __user *uarg)
 
 		args[2] = get_bridge_ifindices(net, indices, args[2]);
 
-		ret = copy_to_user(uarg, indices, args[2]*sizeof(int))
+		ret = copy_to_user(uarg, indices,
+				   array_size(args[2], sizeof(int)))
 			? -EFAULT : args[2];
 
 		kfree(indices);
-- 
2.27.0

