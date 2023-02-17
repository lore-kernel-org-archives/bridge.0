Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D8EA060608
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6C1A960009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/QW0mj2OAwfXeURyYtHmXL5vROau39LeBC17qnk7LD0=;
 b=bCo4B0Q5rTWvnptIaqqrFHU0ozKR8b6G2NtIoKP/rXOM5kYGhY/9MgG+9Dk5ob5X1x
 uP8SxSMwBE9MEAa1nMLnlVfdVrkLMXfqvEa+hLxmkLNrUprgDi4i9V6TZhEM4uZcddVN
 qmvutDpS3yBHWXzzom6bp6mo8zrhq1q65Zb9JQuTIYMeq6/3WKvsDG9VgVew99q+iAL3
 aH3r9lG39mpvX2gL5x2UPttzDH3jP8pFTX61xxSWsFFfSNgjRjwfPsBDaayFh54Zam2Q
 U3ArUvoMZKzdh1XqQMv1YnXa1vqrfVH4ddkWU/bUDMamoRg6xvRa+PqpfnppxqVnUMKc
 xXpg==
Message-ID: <a7cef78d-81fb-7de6-1f6e-a948cca1b46b@blackwall.org>
Date: Fri, 17 Feb 2023 15:53:43 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20230217131657.12649-1-alsp705@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230217131657.12649-1-alsp705@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] net-bridge: fix unsafe dereference of
 potential null ptr in __vlan_del()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Alexander Sapozhnikov <alsp705@gmail.com>, Roopa Prabhu <roopa@nvidia.com>
Cc: lvc-project@linuxtesting.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On 17/02/2023 15:16, Alexander Sapozhnikov wrote:
> After having been compared to NULL value at br_vlan.c:399,
> pointer 'p' is passed as 1st parameter in call to function
> 'nbp_vlan_set_vlan_dev_state' at br_vlan.c:420, 
> where it is dereferenced at br_vlan.c:1722.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Alexander Sapozhnikov <alsp705@gmail.com>
> ---
>  net/bridge/br_vlan.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
> index bc75fa1e4666..87091e270adf 100644
> --- a/net/bridge/br_vlan.c
> +++ b/net/bridge/br_vlan.c
> @@ -417,7 +417,8 @@ static int __vlan_del(struct net_bridge_vlan *v)
>  		rhashtable_remove_fast(&vg->vlan_hash, &v->vnode,
>  				       br_vlan_rht_params);
>  		__vlan_del_list(v);
> -		nbp_vlan_set_vlan_dev_state(p, v->vid);
> +		if (p)
> +			nbp_vlan_set_vlan_dev_state(p, v->vid);
>  		br_multicast_toggle_one_vlan(v, false);
>  		br_multicast_port_ctx_deinit(&v->port_mcast_ctx);
>  		call_rcu(&v->rcu, nbp_vlan_rcu_free);

This cannot happen, read the code more carefully.
If you have a trace or have hit a bug, please provide the log.
Thanks,

Nacked-by: Nikolay Aleksandrov <razor@blackwall.org>


