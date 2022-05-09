Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652136365;
 bh=kUsp5ywapvjh+TIviLfPYdjLx8988YN+fB39xNMI1Hk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=uz2QlAxx3fLtTv+bya49kC8Eyu85O0tp7SNOppx3x1ZCgUqya39mLXLjHuMQTmFOT
 TFijgu0XUzs94vlLJ7K0fMLiAw4GecyQ4N83nQzZwS4LJNSW6Ci7D88yvimWgO7DKa
 QvZ9ejOgGfS2N6OSnSwRbDRWtDyOiP7SHR98x2OhSKcnVzgQ2unv4h0CiADObiyo+o
 JLH7OkFSQb3UEEda+Cv8r3+6ESFQS1cIy3gAPQW26b7aKBMvlDtio/LA+sutQF05DO
 YNAeOKuVg/U6FVngVsfXr/PNcRQllg64X5YRlh9zKz/PggoljrjiwMA3CMxuqQrG76
 z+UTXDvApWvXQ==
Date: Mon, 9 May 2022 15:46:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20220509154603.4a7b4243@kernel.org>
In-Reply-To: <ac4b6c650b6519cc56baa32ef20415460a5aa8ee.1651762830.git.eng.alaamohamedsoliman.am@gmail.com>
References: <cover.1651762829.git.eng.alaamohamedsoliman.am@gmail.com>
 <ac4b6c650b6519cc56baa32ef20415460a5aa8ee.1651762830.git.eng.alaamohamedsoliman.am@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v6 2/2] net: vxlan: Add extack support
 to vxlan_fdb_delete
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
Cc: shshaikh@marvell.com, jdenham@redhat.com, GR-Linux-NIC-Dev@marvell.com, manishc@marvell.com, alexandre.belloni@bootlin.com, outreachy@lists.linux.dev, netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, jesse.brandeburg@intel.com, linux-kernel@vger.kernel.org, vladimir.oltean@nxp.com, sbrivio@redhat.com, claudiu.manoil@nxp.com, anthony.l.nguyen@intel.com, roopa@nvidia.com, intel-wired-lan@lists.osuosl.org, pabeni@redhat.com, davem@davemloft.net, UNGLinuxDriver@microchip.com

On Thu,  5 May 2022 17:09:58 +0200 Alaa Mohamed wrote:
> +			NL_SET_ERR_MSG(extack,
> +						  "DST, VNI, ifindex and port are mutually exclusive with NH_ID");

This continuation line still does not align with the opening bracket.
Look here if your email client makes it hard to see:

https://lore.kernel.org/all/ac4b6c650b6519cc56baa32ef20415460a5aa8ee.1651762830.git.eng.alaamohamedsoliman.am@gmail.com/

Same story in patch 1:

>  static int ocelot_port_fdb_del(struct ndmsg *ndm, struct nlattr *tb[],
>  			       struct net_device *dev,
> -			       const unsigned char *addr, u16 vid)
> +			       const unsigned char *addr, u16 vid,
> +				   struct netlink_ext_ack *extack)

and here:

>  static int vxlan_fdb_delete(struct ndmsg *ndm, struct nlattr *tb[],
>  			    struct net_device *dev,
> -			    const unsigned char *addr, u16 vid)
> +			    const unsigned char *addr, u16 vid,
> +				struct netlink_ext_ack *extack)
