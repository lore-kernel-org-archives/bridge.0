Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=J8Pn8rUD1/67P2tIwIl9jn0IKf5NiUvBQMzixzEqf/Q=;
 b=B+CHHscwnn2+GacbCaiG+xNaVwl86dTG9X33TRd5Haj/UzFu/OV15iRoZllAENs/fn
 5XstadFRJB3u1VfDeP+s3zylVwkFvGzVU3svaIoI/BMK831NIwb+J4/jvC2EnJgtYjuE
 u3RJnmV6ZgpYlM3CDwblSTZnb31nQSo+Zc4t1lb7/h+mWIHZaaY7ICn8yJRS2PuiGcG4
 tBjaxKYkOyhllGC+0Do+fYZuG0jXcZxdQQUuRl6hQvVKeNdY0rVejVCNvpW1PFpyrvuX
 CNylqIrGqgLLsfAIdw4NI898sqFykbiuymAcEhsfEYtnf1AgsTVfSyQysnsa7tZhz4Bi
 4T3A==
Message-ID: <c945ebff-02fe-f2d5-656f-6bdfc46416f1@blackwall.org>
Date: Thu, 21 Apr 2022 13:17:51 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20220421101247.121896-1-clement.leger@bootlin.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20220421101247.121896-1-clement.leger@bootlin.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: switchdev: check
 br_vlan_group() return value
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Tobias Waldekranz <tobias@waldekranz.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org

On 21/04/2022 13:12, Clément Léger wrote:
> br_vlan_group() can return NULL and thus return value must be checked
> to avoid dereferencing a NULL pointer.
> 
> Fixes: 6284c723d9b9 ("net: bridge: mst: Notify switchdev drivers of VLAN MSTI migrations")
> Signed-off-by: Clément Léger <clement.leger@bootlin.com>
> ---
>  net/bridge/br_switchdev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
> index 81400e0b26ac..8f3d76c751dd 100644
> --- a/net/bridge/br_switchdev.c
> +++ b/net/bridge/br_switchdev.c
> @@ -354,6 +354,8 @@ static int br_switchdev_vlan_attr_replay(struct net_device *br_dev,
>  	attr.orig_dev = br_dev;
>  
>  	vg = br_vlan_group(br);
> +	if (!vg)
> +		return 0;
>  
>  	list_for_each_entry(v, &vg->vlan_list, vlist) {
>  		if (v->msti) {


Good catch.
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
