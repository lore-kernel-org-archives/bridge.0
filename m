Return-Path: <vivien.didelot@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:message-id:from:to:cc:subject:in-reply-to:references
	:mime-version:content-disposition:content-transfer-encoding;
	bh=sJY6SozMeweLkOESTHv5iTZYjJjXNBDdJF8oG18/R1U=;
	b=X57ZZSFwiaJVl+HqDuB3rf6KN3lt+A8nQfl+l+FH+iMoMBFB0G3WKCwUvrY1iCC0e1
	ASQL0F86v22n1YoTAZfE4QsEQAdCpffTeEWxWv2QFs2iDGLRC2NUfmMIWjB+lO2nnwVp
	m/DeJS0jAkhZCFLplthhzVkfJg8PKAFn42aaCmaKB007YWAVk9cogIMwxUurFuJXJ4tV
	ME8nJDNOHv109sL1lX9lLcc1OvrbpnN+FPobuQUDAGJTvheV9zd2uVO6K1zcl9F4eGUZ
	4bq3/hRl5DIw0yPZi+HQ4Rlnmiz/qQ9DnZo1Xyjan7cU+KHCy7McAluxHZ5lN4o5UH7B
	r/sA==
Date: Wed, 6 Feb 2019 13:21:18 -0500
Message-ID: <20190206132118.GD9278@t480s.localdomain>
From: Vivien Didelot <vivien.didelot@gmail.com>
In-Reply-To: <20190205235326.14600-12-f.fainelli@gmail.com>
References: <20190205235326.14600-1-f.fainelli@gmail.com>
	<20190205235326.14600-12-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH net-next v3 11/12] net: dsa: Implement
 ndo_get_port_parent_id()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, Florian Fainelli <f.fainelli@gmail.com>, "open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>, netdev@vger.kernel.org, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>, Ido Schimmel <idosch@mellanox.com>, "open list:NETRONOME ETHERNET DRIVERS" <oss-drivers@netronome.com>, "David S. Miller" <davem@davemloft.net>

Hi Florian,

On Tue,  5 Feb 2019 15:53:25 -0800, Florian Fainelli <f.fainelli@gmail.com> wrote:
> DSA implements SWITCHDEV_ATTR_ID_PORT_PARENT_ID and we want to get rid
> of switchdev_ops eventually, ease that migration by implementing a
> ndo_get_port_parent_id() function which returns what
> switchdev_port_attr_get() would do.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  net/dsa/slave.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/net/dsa/slave.c b/net/dsa/slave.c
> index 91de3a663226..70395a0ae52e 100644
> --- a/net/dsa/slave.c
> +++ b/net/dsa/slave.c
> @@ -362,18 +362,23 @@ static int dsa_slave_port_obj_del(struct net_device *dev,
>  	return err;
>  }
>  
> -static int dsa_slave_port_attr_get(struct net_device *dev,
> -				   struct switchdev_attr *attr)
> +static int dsa_slave_get_port_parent_id(struct net_device *dev,
> +					struct netdev_phys_item_id *ppid)
>  {
>  	struct dsa_port *dp = dsa_slave_to_port(dev);
>  	struct dsa_switch *ds = dp->ds;
>  	struct dsa_switch_tree *dst = ds->dst;
>  
> +	ppid->id_len = sizeof(dst->index);
> +	memcpy(&ppid->id, &dst->index, ppid->id_len);
> +
> +	return 0;
> +}

Finally this will give us a way to distinguish two ports with the same switch
and port IDs on a system with two disjoint switch trees, thanks!

Reviewed-by: Vivien Didelot <vivien.didelot@gmail.com>
