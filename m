Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651283198;
 bh=8kP/MRpm1KKd3Rl9molXNCPZpQsRev4DC366b3abSJg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=FHOkqeeY341VJtIRkHZ/wFD9kpmdQmlxFxvjQmxtTGNiHWWFY2WQDyFuUj7xUn0QX
 aa/G+NaZUzfDfYHjIAs+OSETdfW/RThbzraDlNwj81q9LCVO+Ees3IArkGIUur/1Vc
 mVVFGhaTZovAp7DMr+7+DBRXjNhZzbZI03Lwx6rbZQEBl938YpGI9ajnlftd03djV/
 i1xar24F3qGUJk01ngzu37vgE7T28CzHWhJCXc4Imryd5zQEAgwhY7J5nr9T2W3BFd
 IO/XANqI4YZfboz5VJuZFqcrpo+s0KS+9P6Rr9g2E3e5ycbVZseLZz2zFMvwdustxP
 EBzhOSMg3KlpA==
Date: Fri, 29 Apr 2022 18:46:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20220429184636.0b869ae7@kernel.org>
In-Reply-To: <26815b6deebef7f02e864ca41714533c7009e7b7.1651236082.git.eng.alaamohamedsoliman.am@gmail.com>
References: <cover.1651236081.git.eng.alaamohamedsoliman.am@gmail.com>
 <26815b6deebef7f02e864ca41714533c7009e7b7.1651236082.git.eng.alaamohamedsoliman.am@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v5 1/2] rtnetlink: add extack support
 in fdb del handlers
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

On Fri, 29 Apr 2022 14:49:06 +0200 Alaa Mohamed wrote:
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index fde839ef0613..3fccac358198 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -5678,7 +5678,7 @@ ice_fdb_add(struct ndmsg *ndm, struct nlattr __always_unused *tb[],
>  static int
>  ice_fdb_del(struct ndmsg *ndm, __always_unused struct nlattr *tb[],
>  	    struct net_device *dev, const unsigned char *addr,
> -	    __always_unused u16 vid)
> +	    __always_unused u16 vid, struct netlink_ext_ack *extack)

You need to update the kdoc on this one.
