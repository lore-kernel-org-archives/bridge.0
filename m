Return-Path: <gustavo@embeddedor.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nOm3cT2EI0nT8+C3V1J7uHhdzivtBVpP5E91dQPGljo=; b=z3Btq0dUhw3yVPSTkGqN5Qi5Vv
 LbPaFSlB+OSKkji0pd3h7Vb4TtTZnlIalSuG9KOXrEFMTdpB+0wfbMVaKKMOT54IqaB2GovYNhw+m
 cLVL2zif0TVZIbKkel8HUhngO8V2ISm0t6+/9THOvT/sOxE4hmy8w4mIaCibPj7qbREN0MrhN4JB9
 52KcsLqN+vZ1HztFvGNROUzwiKsK7dx5CLSJ8jae71DgtAUqKDfdcGKLvPXTKpEzNUChmPuFUXKTD
 WryOTjlut3IdJ+zvx6jJvWiOTqTIf9Au27TaTWKVuSo9A/nhzL9Ra2Bzb+BaUTV6qG3V4iknO1JW3
 hR9YtGhA==;
References: <cover.1605896059.git.gustavoars@kernel.org>
 <44b2e50d345f1319071a53fb191ac0a0cf3fcf37.1605896060.git.gustavoars@kernel.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <456cb178-5a6a-ab3b-3cc9-16ca84b5a251@embeddedor.com>
Date: Tue, 2 Feb 2021 08:07:38 -0600
MIME-Version: 1.0
In-Reply-To: <44b2e50d345f1319071a53fb191ac0a0cf3fcf37.1605896060.git.gustavoars@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 106/141] net: bridge: Fix fall-through warnings
	for Clang
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org

Hi all,

Who can take this? :)

Thanks
--
Gustavo

On 11/20/20 12:37, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a break statement instead of letting the code fall
> through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  net/bridge/br_input.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index 59a318b9f646..8db219d979c5 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -148,6 +148,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
>  		break;
>  	case BR_PKT_UNICAST:
>  		dst = br_fdb_find_rcu(br, eth_hdr(skb)->h_dest, vid);
> +		break;
>  	default:
>  		break;
>  	}
> 
