Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=E4cbnT6iD9NKF/pSlrfjp2r6UpANFg0iv/kYrzOZLes=;
 b=Sr+iKy2By/lSo0Y94e7vCAmXPlw3o+frOpginSSqvNVDZKz+8JKWDI9IEMVKNbDKin
 sURo8CzDQuMEUkRmGLUfCdMh3p8Feax72WCiViNKCpYXaXN6nP/Q8a/3i5Z03Dn5R5kO
 JQyEN1R+eU3eC5UtW4Hy4qrr2u7VxIL7zpjkM=
References: <20200422161833.1123-1-horatiu.vultur@microchip.com>
 <20200422161833.1123-12-horatiu.vultur@microchip.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <2d97fea6-8f24-89ba-a97b-99a12cf41b09@cumulusnetworks.com>
Date: Fri, 24 Apr 2020 16:20:35 +0300
MIME-Version: 1.0
In-Reply-To: <20200422161833.1123-12-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v3 11/11] net: bridge: Add checks for
 enabling the STP.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>, davem@davemloft.net, jiri@resnulli.us, ivecera@redhat.com, kuba@kernel.org, roopa@cumulusnetworks.com, olteanv@gmail.com, andrew@lunn.ch, UNGLinuxDriver@microchip.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org

On 22/04/2020 19:18, Horatiu Vultur wrote:
> It is not possible to have the MRP and STP running at the same time on the
> bridge, therefore add check when enabling the STP to check if MRP is already
> enabled. In that case return error.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  net/bridge/br_ioctl.c    |  3 +--
>  net/bridge/br_netlink.c  |  4 +++-
>  net/bridge/br_private.h  |  3 ++-
>  net/bridge/br_stp.c      |  6 ++++++
>  net/bridge/br_stp_if.c   | 11 ++++++++++-
>  net/bridge/br_sysfs_br.c |  4 +---
>  6 files changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/net/bridge/br_ioctl.c b/net/bridge/br_ioctl.c
> index ae22d784b88a..5e71fc8b826f 100644
> --- a/net/bridge/br_ioctl.c
> +++ b/net/bridge/br_ioctl.c
> @@ -242,8 +242,7 @@ static int old_dev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
>  		if (!ns_capable(dev_net(dev)->user_ns, CAP_NET_ADMIN))
>  			return -EPERM;
>  
> -		br_stp_set_enabled(br, args[1]);
> -		ret = 0;
> +		ret = br_stp_set_enabled(br, args[1], NULL);
>  		break;
>  
>  	case BRCTL_SET_BRIDGE_PRIORITY:
> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index 1a5e681a626a..a774e19c41bb 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -1109,7 +1109,9 @@ static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
>  	if (data[IFLA_BR_STP_STATE]) {
>  		u32 stp_enabled = nla_get_u32(data[IFLA_BR_STP_STATE]);
>  
> -		br_stp_set_enabled(br, stp_enabled);
> +		err = br_stp_set_enabled(br, stp_enabled, extack);
> +		if (err)
> +			return err;
>  	}
>  
>  	if (data[IFLA_BR_PRIORITY]) {
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 5835828320b6..c35647cb138a 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -1283,7 +1283,8 @@ int br_set_ageing_time(struct net_bridge *br, clock_t ageing_time);
>  /* br_stp_if.c */
>  void br_stp_enable_bridge(struct net_bridge *br);
>  void br_stp_disable_bridge(struct net_bridge *br);
> -void br_stp_set_enabled(struct net_bridge *br, unsigned long val);
> +int br_stp_set_enabled(struct net_bridge *br, unsigned long val,
> +		       struct netlink_ext_ack *extack);
>  void br_stp_enable_port(struct net_bridge_port *p);
>  void br_stp_disable_port(struct net_bridge_port *p);
>  bool br_stp_recalculate_bridge_id(struct net_bridge *br);
> diff --git a/net/bridge/br_stp.c b/net/bridge/br_stp.c
> index 1f14b8455345..3e88be7aa269 100644
> --- a/net/bridge/br_stp.c
> +++ b/net/bridge/br_stp.c
> @@ -36,6 +36,12 @@ void br_set_state(struct net_bridge_port *p, unsigned int state)
>  	};
>  	int err;
>  
> +	/* Don't change the state of the ports if they are driven by a different
> +	 * protocol.
> +	 */
> +	if (p->flags & BR_MRP_AWARE)
> +		return;
> +
>  	p->state = state;
>  	err = switchdev_port_attr_set(p->dev, &attr);
>  	if (err && err != -EOPNOTSUPP)
> diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
> index d174d3a566aa..a42850b7eb9a 100644
> --- a/net/bridge/br_stp_if.c
> +++ b/net/bridge/br_stp_if.c
> @@ -196,10 +196,17 @@ static void br_stp_stop(struct net_bridge *br)
>  	br->stp_enabled = BR_NO_STP;
>  }
>  
> -void br_stp_set_enabled(struct net_bridge *br, unsigned long val)
> +int br_stp_set_enabled(struct net_bridge *br, unsigned long val,
> +		       struct netlink_ext_ack *extack)
>  {
>  	ASSERT_RTNL();
>  
> +	if (br_mrp_enabled(br)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "STP can't be enabled if MRP is already enabled\n");

The operation could be disable (noop in case it's already disabled) and this will still
return an error.

> +		return -EINVAL;
> +	}
> +
>  	if (val) {
>  		if (br->stp_enabled == BR_NO_STP)
>  			br_stp_start(br);
> @@ -207,6 +214,8 @@ void br_stp_set_enabled(struct net_bridge *br, unsigned long val)
>  		if (br->stp_enabled != BR_NO_STP)
>  			br_stp_stop(br);
>  	}
> +
> +	return 0;
>  }
>  
>  /* called under bridge lock */
> diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
> index 9ab0f00b1081..7db06e3f642a 100644
> --- a/net/bridge/br_sysfs_br.c
> +++ b/net/bridge/br_sysfs_br.c
> @@ -126,9 +126,7 @@ static ssize_t stp_state_show(struct device *d,
>  
>  static int set_stp_state(struct net_bridge *br, unsigned long val)
>  {
> -	br_stp_set_enabled(br, val);
> -
> -	return 0;
> +	return br_stp_set_enabled(br, val, NULL);
>  }
>  
>  static ssize_t stp_state_store(struct device *d,
> 

