Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=ApEPfYLDkaftPbdGrgkwltjAOkRc+C1sr4uIvLIlPbI=;
	b=UkhvvGLmTZwuM/XOr2DMVT4r9W5ST4fy5Wc35J5kLQZCt99xKKYdPxJl5qj+0WVgmo
	wVvh03/l9DAPJ3C/g/Y78Ak+Z40x4j8vKMX2PzqkQa8LeBWIsu22QumMD+0GviObNLAn
	HAZa5GiU5ZW5FPzmGLGcRPtdP1n89RhDROE7KFnqSpX2UpqgtiWC0eiQKBeJ3BMYBFcn
	0NNcpB7KMNboscR4u8R25mMz3Cj1vhJf5eYXLhoQc2iANId6dwu8Q5xHH+3bCb7FYXKC
	qX/eKLZbDUkrlppDup7I7AZGHTEIYHHVCbrBng2rUIECZcMx/fbhe0H7EHr7073CfJ8K
	HVsw==
Date: Fri, 2 Aug 2019 08:35:19 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20190802083519.71cb4fa2@hermes.lan>
In-Reply-To: <20190802105736.26767-1-nikolay@cumulusnetworks.com>
References: <0a015a21-c1ae-e275-e675-431f08bece86@cumulusnetworks.com>
	<20190802105736.26767-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net v4] net: bridge: move default pvid
 init/deinit to NETDEV_REGISTER/UNREGISTER
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net, michael-dev <michael-dev@fami-braun.de>

On Fri,  2 Aug 2019 13:57:36 +0300
Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:

> +int br_vlan_bridge_event(struct net_device *dev, unsigned long event, void *ptr)
>  {
>  	struct netdev_notifier_changeupper_info *info;
> -	struct net_bridge *br;
> +	struct net_bridge *br = netdev_priv(dev);
> +	bool changed;
> +	int ret = 0;
>  
>  	switch (event) {
> +	case NETDEV_REGISTER:
> +		ret = br_vlan_add(br, br->default_pvid,
> +				  BRIDGE_VLAN_INFO_PVID |
> +				  BRIDGE_VLAN_INFO_UNTAGGED |
> +				  BRIDGE_VLAN_INFO_BRENTRY, &changed, NULL);
> +		break;

Looks good.

As minor optimization br_vlan_add could ignore changed pointer if NULL.
This would save places where you don't care.


Something like:
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 021cc9f66804..bacd3543b215 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -626,10 +626,11 @@ static int br_vlan_add_existing(struct net_bridge *br,
 		refcount_inc(&vlan->refcnt);
 		vlan->flags |= BRIDGE_VLAN_INFO_BRENTRY;
 		vg->num_vlans++;
-		*changed = true;
+		if (changed)
+			*changed = true;
 	}
 
-	if (__vlan_add_flags(vlan, flags))
+	if (__vlan_add_flags(vlan, flags) && changed)
 		*changed = true;
 
 	return 0;
@@ -653,7 +654,8 @@ int br_vlan_add(struct net_bridge *br, u16 vid, u16 flags, bool *changed,
 
 	ASSERT_RTNL();
 
-	*changed = false;
+	if (changed)
+		*changed = false;
 	vg = br_vlan_group(br);
 	vlan = br_vlan_find(vg, vid);
 	if (vlan)
@@ -679,7 +681,7 @@ int br_vlan_add(struct net_bridge *br, u16 vid, u16 flags, bool *changed,
 	if (ret) {
 		free_percpu(vlan->stats);
 		kfree(vlan);
-	} else {
+	} else if (changed) {
 		*changed = true;
 	}
 

