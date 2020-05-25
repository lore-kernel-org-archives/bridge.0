Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xsaSOL3nxn5UWojYLGHf0GidZv1f0eBsy1Kan4mSPis=;
 b=WiBv6JwgwoGFabLxJtlkNV2QTT18NNEhPH3iMNUS8TNvE4V38+UFSMP4ahMe76Z26m
 3WZNnG0LPNH7VrsaC39jgTQrROurGyfDpKw9DM/HRotlOw/dSjLuFAmFmcccTchAX/FM
 JBqeHfDHPNhynj+Szb4t+GSyQIGsQ902ccVIA=
References: <20200525095541.46673-1-horatiu.vultur@microchip.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <a44f412e-dbde-93e9-be72-78515fa5b9d4@cumulusnetworks.com>
Date: Mon, 25 May 2020 11:34:17 +0300
MIME-Version: 1.0
In-Reply-To: <20200525095541.46673-1-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: mrp: Fix out-of-bounds read in
	br_mrp_parse
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>, roopa@cumulusnetworks.com, davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch, UNGLinuxDriver@microchip.com, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: syzbot+9c6f0f1f8e32223df9a4@syzkaller.appspotmail.com

On 25/05/2020 12:55, Horatiu Vultur wrote:
> The issue was reported by syzbot. When the function br_mrp_parse was
> called with a valid net_bridge_port, the net_bridge was an invalid
> pointer. Therefore the check br->stp_enabled could pass/fail
> depending where it was pointing in memory.
> The fix consists of setting the net_bridge pointer if the port is a
> valid pointer.
> 
> Reported-by: syzbot+9c6f0f1f8e32223df9a4@syzkaller.appspotmail.com
> Fixes: 6536993371fa ("bridge: mrp: Integrate MRP into the bridge")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  net/bridge/br_mrp_netlink.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/net/bridge/br_mrp_netlink.c b/net/bridge/br_mrp_netlink.c
> index 397e7f710772a..4a08a99519b04 100644
> --- a/net/bridge/br_mrp_netlink.c
> +++ b/net/bridge/br_mrp_netlink.c
> @@ -27,6 +27,12 @@ int br_mrp_parse(struct net_bridge *br, struct net_bridge_port *p,
>  	struct nlattr *tb[IFLA_BRIDGE_MRP_MAX + 1];
>  	int err;
>  
> +	/* When this function is called for a port then the br pointer is
> +	 * invalid, therefor set the br to point correctly
> +	 */
> +	if (p)
> +		br = p->br;
> +
>  	if (br->stp_enabled != BR_NO_STP) {
>  		NL_SET_ERR_MSG_MOD(extack, "MRP can't be enabled if STP is already enabled");
>  		return -EINVAL;
> 

You should tag the fix for net-next when it's intended for it.

Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
