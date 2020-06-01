Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=c+QoV/HcMCTMVpf40QgOdghuE0cBC54AdoG6hgzUvEU=;
 b=bXNGLd36g19lQhm9wc2ucAu6ZWWI/gszeaBbB1NS+obGicxXFoHjlU2iinmTbvKo70
 Id6xXBUi/krErs7Q6DieEbq471E+GLthmwz5o/nNEmXxiyGvqE4VogS/eEnUeMnD5Th6
 pcrcl+e6USCW+qGg58swXjw+R6EjNCNcgQ5kY=
References: <20200601125855.1751343-1-idosch@idosch.org>
 <20200601125855.1751343-3-idosch@idosch.org>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <b0466e34-47a5-b71f-58bd-321955fdb9aa@cumulusnetworks.com>
Date: Mon, 1 Jun 2020 16:02:49 +0300
MIME-Version: 1.0
In-Reply-To: <20200601125855.1751343-3-idosch@idosch.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net 2/2] vxlan: Avoid infinite loop when
 suppressing NS messages with invalid options
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@idosch.org>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: mlxsw@mellanox.com, roopa@cumulusnetworks.com, dlstevens@us.ibm.com, Ido Schimmel <idosch@mellanox.com>, allas@mellanox.com, kuba@kernel.org, davem@davemloft.net

On 01/06/2020 15:58, Ido Schimmel wrote:
> From: Ido Schimmel <idosch@mellanox.com>
> 
> When proxy mode is enabled the vxlan device might reply to Neighbor
> Solicitation (NS) messages on behalf of remote hosts.
> 
> In case the NS message includes the "Source link-layer address" option
> [1], the vxlan device will use the specified address as the link-layer
> destination address in its reply.
> 
> To avoid an infinite loop, break out of the options parsing loop when
> encountering an option with length zero and disregard the NS message.
> 
> This is consistent with the IPv6 ndisc code and RFC 4886 which states
> that "Nodes MUST silently discard an ND packet that contains an option
> with length zero" [2].
> 
> [1] https://tools.ietf.org/html/rfc4861#section-4.3
> [2] https://tools.ietf.org/html/rfc4861#section-4.6
> 
> Fixes: 4b29dba9c085 ("vxlan: fix nonfunctional neigh_reduce()")
> Signed-off-by: Ido Schimmel <idosch@mellanox.com>
> ---
>  drivers/net/vxlan.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
> index a5b415fed11e..779e56c43d27 100644
> --- a/drivers/net/vxlan.c
> +++ b/drivers/net/vxlan.c
> @@ -1924,6 +1924,10 @@ static struct sk_buff *vxlan_na_create(struct sk_buff *request,
>  	ns_olen = request->len - skb_network_offset(request) -
>  		sizeof(struct ipv6hdr) - sizeof(*ns);
>  	for (i = 0; i < ns_olen-1; i += (ns->opt[i+1]<<3)) {
> +		if (!ns->opt[i + 1]) {
> +			kfree_skb(reply);
> +			return NULL;
> +		}
>  		if (ns->opt[i] == ND_OPT_SOURCE_LL_ADDR) {
>  			daddr = ns->opt + i + sizeof(struct nd_opt_hdr);
>  			break;
> 

Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
