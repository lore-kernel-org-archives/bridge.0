Return-Path: <roopa@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXe/f0oHEeb8HobsPk+TQC3/YWtSFLlymmz7AE3bqnE=;
 b=RXcNkVdy5SoyP/lCRaq8p4E0ZNz97Ezes8ZvnYCdwaUC+h5HgA55H5BBwVMoMsv/nVjbPYMush/03XEAzzrrYF2jzOv448fpkExSonqFxjvznDadPYbMnMCukd3bisWSQFon+Sk9fUDUrs9eHG8hoBiCG5GNw3t195JuLVJ+cGCRUuOc2t5onKzRWF4HBZHbFwUWB7S/iFT3cSPBxH4YvFwaSOmoL8uGY7tzjH/V+JNIkW66K2y1kL9BSMYSqLX+9AOgHwQfgHOzWHdkAcCQTwIZJaNuKsaradYm0WZQIBpMAobScb0C4IE4HWlZ3wCWS47gbZqh6T/rpuHHylUb6g==
Message-ID: <c5ec2677-3047-8a70-9769-d48a79703220@nvidia.com>
Date: Thu, 12 May 2022 09:22:17 -0700
Content-Language: en-US
References: <cover.1652348961.git.eng.alaamohamedsoliman.am@gmail.com>
 <c6069fb695b25dc2f33e8017023ddd47c58caa8d.1652348962.git.eng.alaamohamedsoliman.am@gmail.com>
From: Roopa Prabhu <roopa@nvidia.com>
In-Reply-To: <c6069fb695b25dc2f33e8017023ddd47c58caa8d.1652348962.git.eng.alaamohamedsoliman.am@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v7 2/2] net: vxlan: Add extack support
 to vxlan_fdb_delete
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>, netdev@vger.kernel.org
Cc: shshaikh@marvell.com, jdenham@redhat.com, GR-Linux-NIC-Dev@marvell.com, manishc@marvell.com, alexandre.belloni@bootlin.com, outreachy@lists.linux.dev, vladimir.oltean@nxp.com, razor@blackwall.org, bridge@lists.linux-foundation.org, jesse.brandeburg@intel.com, linux-kernel@vger.kernel.org, sbrivio@redhat.com, claudiu.manoil@nxp.com, anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, UNGLinuxDriver@microchip.com


On 5/12/22 02:55, Alaa Mohamed wrote:
> This patch adds extack msg support to vxlan_fdb_delete and vxlan_fdb_parse.
> extack is used to propagate meaningful error msgs to the user of vxlan
> fdb netlink api
>
> Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
> ---
> changes in V2:
>          - fix spelling vxlan_fdb_delete
>          - add missing braces
>          - edit error message
> ---
> changes in V3:
>          fix errors reported by checkpatch.pl
> ---
> changes in V4:
>          - fix errors reported by checkpatch.pl
>          - edit commit message.
> ---
> changes in V5:
> 	- edit commit message
> ---
> changes in V7:
>          fix checkpatch issue:
> 		CHECK:Alignment should match open parenthesis
> ---
>   drivers/net/vxlan/vxlan_core.c | 38 ++++++++++++++++++++++++----------
>   1 file changed, 27 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index c58c48de4cf4..cb955bd79cb1 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -1129,19 +1129,25 @@ static void vxlan_fdb_dst_destroy(struct vxlan_dev *vxlan, struct vxlan_fdb *f,
>
>   static int vxlan_fdb_parse(struct nlattr *tb[], struct vxlan_dev *vxlan,
>   			   union vxlan_addr *ip, __be16 *port, __be32 *src_vni,
> -			   __be32 *vni, u32 *ifindex, u32 *nhid)
> +			   __be32 *vni, u32 *ifindex, u32 *nhid,
> +			   struct netlink_ext_ack *extack)
>   {
>   	struct net *net = dev_net(vxlan->dev);
>   	int err;
>
>   	if (tb[NDA_NH_ID] && (tb[NDA_DST] || tb[NDA_VNI] || tb[NDA_IFINDEX] ||
> -	    tb[NDA_PORT]))
> -		return -EINVAL;
> +	    tb[NDA_PORT])) {
> +			NL_SET_ERR_MSG(extack,
> +				       "DST, VNI, ifindex and port are mutually exclusive with NH_ID");
> +			return -EINVAL;
> +		}


Alaa, the closing brace should align with the if.

>
>   	if (tb[NDA_DST]) {
>   		err = vxlan_nla_get_addr(ip, tb[NDA_DST]);
> -		if (err)
> +		if (err) {
> +			NL_SET_ERR_MSG(extack, "Unsupported address family");
>   			return err;
> +		}
>   	} else {
>   		union vxlan_addr *remote = &vxlan->default_dst.remote_ip;
>
> @@ -1157,24 +1163,30 @@ static int vxlan_fdb_parse(struct nlattr *tb[], struct vxlan_dev *vxlan,
>   	}
>
>   	if (tb[NDA_PORT]) {
> -		if (nla_len(tb[NDA_PORT]) != sizeof(__be16))
> +		if (nla_len(tb[NDA_PORT]) != sizeof(__be16)) {
> +			NL_SET_ERR_MSG(extack, "Invalid vxlan port");
>   			return -EINVAL;
> +		}
>   		*port = nla_get_be16(tb[NDA_PORT]);
>   	} else {
>   		*port = vxlan->cfg.dst_port;
>   	}
>
>   	if (tb[NDA_VNI]) {
> -		if (nla_len(tb[NDA_VNI]) != sizeof(u32))
> +		if (nla_len(tb[NDA_VNI]) != sizeof(u32)) {
> +			NL_SET_ERR_MSG(extack, "Invalid vni");
>   			return -EINVAL;
> +		}
>   		*vni = cpu_to_be32(nla_get_u32(tb[NDA_VNI]));
>   	} else {
>   		*vni = vxlan->default_dst.remote_vni;
>   	}
>
>   	if (tb[NDA_SRC_VNI]) {
> -		if (nla_len(tb[NDA_SRC_VNI]) != sizeof(u32))
> +		if (nla_len(tb[NDA_SRC_VNI]) != sizeof(u32)) {
> +			NL_SET_ERR_MSG(extack, "Invalid src vni");
>   			return -EINVAL;
> +		}
>   		*src_vni = cpu_to_be32(nla_get_u32(tb[NDA_SRC_VNI]));
>   	} else {
>   		*src_vni = vxlan->default_dst.remote_vni;
> @@ -1183,12 +1195,16 @@ static int vxlan_fdb_parse(struct nlattr *tb[], struct vxlan_dev *vxlan,
>   	if (tb[NDA_IFINDEX]) {
>   		struct net_device *tdev;
>
> -		if (nla_len(tb[NDA_IFINDEX]) != sizeof(u32))
> +		if (nla_len(tb[NDA_IFINDEX]) != sizeof(u32)) {
> +			NL_SET_ERR_MSG(extack, "Invalid ifindex");
>   			return -EINVAL;
> +		}
>   		*ifindex = nla_get_u32(tb[NDA_IFINDEX]);
>   		tdev = __dev_get_by_index(net, *ifindex);
> -		if (!tdev)
> +		if (!tdev) {
> +			NL_SET_ERR_MSG(extack, "Device not found");
>   			return -EADDRNOTAVAIL;
> +		}
>   	} else {
>   		*ifindex = 0;
>   	}
> @@ -1226,7 +1242,7 @@ static int vxlan_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
>   		return -EINVAL;
>
>   	err = vxlan_fdb_parse(tb, vxlan, &ip, &port, &src_vni, &vni, &ifindex,
> -			      &nhid);
> +			      &nhid, extack);
>   	if (err)
>   		return err;
>
> @@ -1292,7 +1308,7 @@ static int vxlan_fdb_delete(struct ndmsg *ndm, struct nlattr *tb[],
>   	int err;
>
>   	err = vxlan_fdb_parse(tb, vxlan, &ip, &port, &src_vni, &vni, &ifindex,
> -			      &nhid);
> +			      &nhid, extack);
>   	if (err)
>   		return err;
>
> --
> 2.36.1
>
