Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TQ8ypWdJowcw74MF0/KAtqjsmkhSXiLQiRMn+aGK1c=;
 b=PKXPNhHqq1bYgT3GgG7QzPE39uRdm20tPtYw1q676u87MYqKnUOM1tURsag1Ki72PjGIN/bWNiKgB1ZDMabqsdLZ7FXWE/mFteCdgaAockNbCsTjEDNEgtRcN43iibpL6EcE4BvjWJSr8J22XaghtDXKC4MZKkRr412lGwtKRcoJuTNi2wc+naxypLgKStwYY6kPWpSCtB7fspBS4uFlYP35V7Hbfts4jDt3cZo8AWYz2lk4BfT/PUBiM5o4P4/7DlW900LvdsBJuq8KJcxNrage8WIi8Qfdd0gRD35u3rkxOQoxgnTSQt4+zVFxQ5QL3Ku+OjxUZ7uwezPlHPpb8A==
Message-ID: <d4dc329f-ffcc-044f-01f7-5db2d0a69d92@nvidia.com>
Date: Thu, 23 Dec 2021 09:42:48 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20211222191320.17662-1-repk@triplefau.lt>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
In-Reply-To: <20211222191320.17662-1-repk@triplefau.lt>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] net: bridge: fix ioctl old_deviceless
	bridge argument
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Remi Pommarel <repk@triplefau.lt>, netdev@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>

On 22/12/2021 21:13, Remi Pommarel wrote:
> Commit 561d8352818f ("bridge: use ndo_siocdevprivate") changed the
> source and destination arguments of copy_{to,from}_user in bridge's
> old_deviceless() from args[1] to uarg breaking SIOC{G,S}IFBR ioctls.
> 
> Commit cbd7ad29a507 ("net: bridge: fix ioctl old_deviceless bridge
> argument") fixed only BRCTL_{ADD,DEL}_BRIDGES commands leaving
> BRCTL_GET_BRIDGES one untouched.
> 
> The fixes BRCTL_GET_BRIDGES as well
> 
> Fixes: 561d8352818f ("bridge: use ndo_siocdevprivate")
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> ---
>  net/bridge/br_ioctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_ioctl.c b/net/bridge/br_ioctl.c
> index db4ab2c2ce18..891cfcf45644 100644
> --- a/net/bridge/br_ioctl.c
> +++ b/net/bridge/br_ioctl.c
> @@ -337,7 +337,7 @@ static int old_deviceless(struct net *net, void __user *uarg)
>  
>  		args[2] = get_bridge_ifindices(net, indices, args[2]);
>  
> -		ret = copy_to_user(uarg, indices,
> +		ret = copy_to_user((void __user *)args[1], indices,
>  				   array_size(args[2], sizeof(int)))
>  			? -EFAULT : args[2];
>  
> 

Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>

