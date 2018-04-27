Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=BQC151qMgbm2foEHQsDVMHt7WAnmq4AtxpTXYJKl3MA=;
	b=c9Y1dmiuojTvDEmvIXY9ZWRCz7iYf0iUCmwD7r8RZ06hjPz0LCzwDQgsirmMYd8CUO
	oXHjrXRI4BKTj95C3XTFtU7juA1ZzMtcrQHojSnxcEhi1GB7VJRKYXOVFfBqLTs+5o5C
	6+q3zokh/N7VB0aPzbVORo/N3bTFMNY8N7eQp2slR2FTVRGUEsvE0ZqQ1T341Y3aSB3q
	t/nM2/5mwwNSV87jSAJmJP0tvCfmbn9/X6TdpRM4YVWsv1nUr6PFZ+0PnhDj61dEjKZZ
	89Gb+2i7smKlf+N2KzMOyV6HCTwPPAtK7in5stxcYqWm3i5XawLYuIjT3tfsWZz6BTKi
	fcBg==
Date: Fri, 27 Apr 2018 09:28:29 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20180427092829.1673ed74@xeon-e3>
In-Reply-To: <20180427151111.22099-2-idosch@mellanox.com>
References: <20180427151111.22099-1-idosch@mellanox.com>
	<20180427151111.22099-2-idosch@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 1/6] net: bridge: Publish bridge
 accessor functions
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@mellanox.com>
Cc: mlxsw@mellanox.com, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, jiri@mellanox.com, petrm@mellanox.com, davem@davemloft.net

On Fri, 27 Apr 2018 18:11:06 +0300
Ido Schimmel <idosch@mellanox.com> wrote:

> +int br_vlan_pvid_rtnl(const struct net_device *dev, u16 *p_pvid)
> +{
> +	struct net_bridge_vlan_group *vg;
> +
> +	ASSERT_RTNL();
> +	if (netif_is_bridge_master(dev))
> +		vg = br_vlan_group(netdev_priv(dev));
> +	else
> +		return -EINVAL;
> +
> +	*p_pvid = br_get_pvid(vg);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(br_vlan_pvid_rtnl);


Unless there is a RCU version, no need for _rtnl suffix.

Minor style issue, why not make error then go on and return -1 on error.



int br_vlan_pvid(const struct net_device *dev)
{
	const struct net_bridge_vlan_group *vg;

	ASSERT_RTNL();

	if (!netif_is_bridge_master(dev))
		return -1;

	vg = br_vlan_group(netdev_priv(dev));
	return br_get_pvid(vg);
}
