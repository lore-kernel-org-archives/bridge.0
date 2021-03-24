Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MK89RJtp8YZiyl9VQsSyxLdwQRMKymm3CVtjYw8/0v0=;
 b=cc6RsBOmBfo1Lrkgwurx6qoujvWHnQeISzEJMq8BcLBeWcM7KlfMOxGJE4PIK861ZdzANMKDkjibbsY+e2OieXiNJCoAhGtaoDFDDtkguiomT5vEN7eceTGh4cgpKa7OZ4uQzHo7aCqXBKvNmKH8tRFVY6boorrsA0ulfSJOhwzvZWY0VoKfzSlYk0ELlVnXWQUidtowMVknUMWgZULnfHrulYWvTDGo/vdpkSe1ExSxyDoyUWZlUc2M4OsB+ThklfDZtpmbQTCkkyOL5pf4O5CeQ9mlSKa6m7ZJMMDUSI3tNl8ooMfWGeD5GpGHEN2QwxYiZUlS4Oz6ABaBq+LB1A==
References: <20210324150950.253698-1-colin.king@canonical.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <db4c13bf-e32a-d59a-a491-9a81ca292e59@nvidia.com>
Date: Wed, 24 Mar 2021 20:50:43 +0200
In-Reply-To: <20210324150950.253698-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH][next] net: bridge: Fix missing return
 assignment from br_vlan_replay_one call
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Colin King <colin.king@canonical.com>, Roopa Prabhu <roopa@nvidia.com>, "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, bridge@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

On 24/03/2021 17:09, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The call to br_vlan_replay_one is returning an error return value but
> this is not being assigned to err and the following check on err is
> currently always false because err was initialized to zero. Fix this
> by assigning err.
> 
> Addresses-Coverity: ("'Constant' variable guards dead code")
> Fixes: 22f67cdfae6a ("net: bridge: add helper to replay VLANs installed on port")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  net/bridge/br_vlan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
> index ca8daccff217..7422691230b1 100644
> --- a/net/bridge/br_vlan.c
> +++ b/net/bridge/br_vlan.c
> @@ -1815,7 +1815,7 @@ int br_vlan_replay(struct net_device *br_dev, struct net_device *dev,
>  		if (!br_vlan_should_use(v))
>  			continue;
>  
> -		br_vlan_replay_one(nb, dev, &vlan, extack);
> +		err = br_vlan_replay_one(nb, dev, &vlan, extack);
>  		if (err)
>  			return err;
>  	}
> 

Thanks,
Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>

