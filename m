Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=r3lGgRnicuPNFZr2O4ZtbEG+K1gZsD34WtCIEk2WtSk=;
	b=DG/iKCcta6FD6QtcOtoWdN2CfsoU+3XDeoI5rYX0407kk7AFVw6STuQStNtN+xdLKs
	yikrlqGHbJUvhnsCEnnoZd2pQFgzM4AkRYTZKdMStr23Mt9tYyrKQdyWYL7NU7fj0hZ0
	siyUiTLydRMLt9mItuGk+Tr7g6TOUNtNjMR9Q=
References: <1562224955-3979-1-git-send-email-wenxu@ucloud.cn>
	<1562224955-3979-7-git-send-email-wenxu@ucloud.cn>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <fb62760f-aa41-111a-c2a6-e66e099533c0@cumulusnetworks.com>
Date: Fri, 5 Jul 2019 11:34:13 +0300
MIME-Version: 1.0
In-Reply-To: <1562224955-3979-7-git-send-email-wenxu@ucloud.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 7/7 nf-next] netfilter:nft_meta: add
	NFT_META_VLAN support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: wenxu@ucloud.cn, pablo@netfilter.org
Cc: bridge@lists.linux-foundation.org, netfilter-devel@vger.kernel.org

On 04/07/2019 10:22, wenxu@ucloud.cn wrote:
> From: wenxu <wenxu@ucloud.cn>
> 
> This patch provide a meta vlan to set the vlan tag of the packet.
> 
> for q-in-q outer vlan id 20:
> meta vlan set 0x88a8:20
> 
> set the default 0x8100 vlan type with vlan id 20
> meta vlan set 20
> 
> Signed-off-by: wenxu <wenxu@ucloud.cn>
> ---
>  include/net/netfilter/nft_meta.h         |  5 ++++-
>  include/uapi/linux/netfilter/nf_tables.h |  4 ++++
>  net/netfilter/nft_meta.c                 | 22 ++++++++++++++++++++++
>  3 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/netfilter/nft_meta.h b/include/net/netfilter/nft_meta.h
> index 5c69e9b..cb0f1e8 100644
> --- a/include/net/netfilter/nft_meta.h
> +++ b/include/net/netfilter/nft_meta.h
> @@ -6,7 +6,10 @@ struct nft_meta {
>  	enum nft_meta_keys	key:8;
>  	union {
>  		enum nft_registers	dreg:8;
> -		enum nft_registers	sreg:8;
> +		struct {
> +			enum nft_registers	sreg:8;
> +			enum nft_registers	sreg2:8;
> +		};
>  	};
>  };
>  
> diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
> index a0d1dbd..699524a 100644
> --- a/include/uapi/linux/netfilter/nf_tables.h
> +++ b/include/uapi/linux/netfilter/nf_tables.h
> @@ -797,6 +797,7 @@ enum nft_exthdr_attributes {
>   * @NFT_META_OIFKIND: packet output interface kind name (dev->rtnl_link_ops->kind)
>   * @NFT_META_BRI_IIFPVID: packet input bridge port pvid
>   * @NFT_META_BRI_IIFVPROTO: packet input bridge vlan proto
> + * @NFT_META_VLAN: packet vlan metadata
>   */
>  enum nft_meta_keys {
>  	NFT_META_LEN,
> @@ -829,6 +830,7 @@ enum nft_meta_keys {
>  	NFT_META_OIFKIND,
>  	NFT_META_BRI_IIFPVID,
>  	NFT_META_BRI_IIFVPROTO,
> +	NFT_META_VLAN,
>  };
>  
>  /**
> @@ -895,12 +897,14 @@ enum nft_hash_attributes {
>   * @NFTA_META_DREG: destination register (NLA_U32)
>   * @NFTA_META_KEY: meta data item to load (NLA_U32: nft_meta_keys)
>   * @NFTA_META_SREG: source register (NLA_U32)
> + * @NFTA_META_SREG2: source register (NLA_U32)
>   */
>  enum nft_meta_attributes {
>  	NFTA_META_UNSPEC,
>  	NFTA_META_DREG,
>  	NFTA_META_KEY,
>  	NFTA_META_SREG,
> +	NFTA_META_SREG2,
>  	__NFTA_META_MAX
>  };
>  #define NFTA_META_MAX		(__NFTA_META_MAX - 1)
> diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
> index 18a848b..9303de3 100644
> --- a/net/netfilter/nft_meta.c
> +++ b/net/netfilter/nft_meta.c
> @@ -271,6 +271,17 @@ void nft_meta_set_eval(const struct nft_expr *expr,
>  		skb->secmark = value;
>  		break;
>  #endif
> +	case NFT_META_VLAN: {
> +		u32 *sreg2 = &regs->data[meta->sreg2];
> +		__be16 vlan_proto;
> +		u16 vlan_tci;
> +
> +		vlan_tci = nft_reg_load16(sreg);
> +		vlan_proto = nft_reg_load16(sreg2);

Is there supposed to be any validation of these values below
when they're being added by the user ?
Otherwise you could add any tag here, even invalid one.

> +
> +		__vlan_hwaccel_put_tag(skb, vlan_proto, vlan_tci);
> +		break;
> +	}
>  	default:
>  		WARN_ON(1);
>  	}
> @@ -281,6 +292,7 @@ void nft_meta_set_eval(const struct nft_expr *expr,
>  	[NFTA_META_DREG]	= { .type = NLA_U32 },
>  	[NFTA_META_KEY]		= { .type = NLA_U32 },
>  	[NFTA_META_SREG]	= { .type = NLA_U32 },
> +	[NFTA_META_SREG2]	= { .type = NLA_U32 },
>  };
>  EXPORT_SYMBOL_GPL(nft_meta_policy);
>  
> @@ -432,6 +444,13 @@ int nft_meta_set_init(const struct nft_ctx *ctx,
>  	case NFT_META_PKTTYPE:
>  		len = sizeof(u8);
>  		break;
> +	case NFT_META_VLAN:
> +		len = sizeof(u16);
> +		priv->sreg2 = nft_parse_register(tb[NFTA_META_SREG2]);
> +		err = nft_validate_register_load(priv->sreg2, len);
> +		if (err < 0)
> +			return err;
> +		break;
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> @@ -457,6 +476,9 @@ int nft_meta_get_dump(struct sk_buff *skb,
>  		goto nla_put_failure;
>  	if (nft_dump_register(skb, NFTA_META_DREG, priv->dreg))
>  		goto nla_put_failure;
> +	if (priv->key == NFT_META_VLAN &&
> +	    nft_dump_register(skb, NFTA_META_SREG2, priv->sreg2))
> +		goto nla_put_failure;
>  	return 0;
>  
>  nla_put_failure:
> 

