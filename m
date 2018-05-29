Return-Path: <dan.carpenter@oracle.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=date : from : to : cc
	: subject : message-id : references : mime-version : content-type :
	in-reply-to; s=corp-2017-10-26;
	bh=LxtC58tGkUVeclEA2DqSKyQT7kVJKfHunC6AiNqMkkQ=;
	b=k/Nn/v5zUKsyvh1IIxO7q99Mx5vwnlYyaPDRw73PQPIr1caG8ak5JDfHXCy1ylRxmRdA
	73a14Wq+P0H57QmK5TKFVICZOY/5T3nyW9Dcm46YfsBdz/e9QcLA/PrAQl+qq7usRiaV
	yQqkIRIGj5U4hibKhFwrsWhx0augle2s7tQjDFChJr/6fA+WXhetPaSL2S863TmAyFhg
	pJYe4L8x+eaJaM5dHTUSTcyYO3IIU5CKqZAlnkoPdZt1mDQU0ZnARZXrui2S5Ge4JvxD
	yDc5cuTtmO4syFd3QY+FV6SNiKPWuSi9FPYLqK14eryNijBDOccn5qm7s+yIHXeo5x7A
	xg== 
Date: Tue, 29 May 2018 13:55:35 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Message-ID: <20180529105535.fhap2w4tvj3tesei@mwanda>
References: <cover.1527519997.git.petrm@mellanox.com>
	<645c0bde19cffebb0dc603872ef6ab45e9fbf0b6.1527519997.git.petrm@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <645c0bde19cffebb0dc603872ef6ab45e9fbf0b6.1527519997.git.petrm@mellanox.com>
Subject: Re: [Bridge] [PATCH net-next v3 6/7] net: bridge: Notify about
	bridge VLANs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Petr Machata <petrm@mellanox.com>
Cc: devel@driverdev.osuosl.org, andrew@lunn.ch, f.fainelli@gmail.com, vivien.didelot@savoirfairelinux.com, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, idosch@mellanox.com, jiri@mellanox.com, razvan.stefanescu@nxp.com, gregkh@linuxfoundation.org, davem@davemloft.net

On Mon, May 28, 2018 at 05:11:04PM +0200, Petr Machata wrote:
> @@ -580,6 +591,9 @@ int br_vlan_add(struct net_bridge *br, u16 vid, u16 flags, bool *changed)
>  			vg->num_vlans++;
>  			*changed = true;
>  		}
> +		ret = br_switchdev_port_vlan_add(br->dev, vid, flags);
> +		if (ret && ret != -EOPNOTSUPP)
> +			return ret;

We should probably do some error handling instead of returning directly?

>  		if (__vlan_add_flags(vlan, flags))
>  			*changed = true;
>  

regards,
dan caprenter
