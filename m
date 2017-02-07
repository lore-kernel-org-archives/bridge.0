Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=dx2GBEFC9mq5K6ySGQw1MAoUdFvf+ox+Er9yAgQyuyI=;
	b=LQ4zkfOY6vKSvgj9ueq+39sDg/g07OwoCcSbDo6jTMCU+cShGXzmfTHVE+IexnjVhJ
	RVjcDYdNMI3v+m7JDj1jTisiJOXf4M9ZvVeECdQRHIdvhbhr8uVlf+nqxd27b8C8SykF
	KlmLubGZQhgvyuwIlTWuSVVeiyBtSZywk8Bzc=
References: <20170207105638.17918-1-colin.king@canonical.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <d92d3afc-140f-8959-c6ea-9758eb1aa539@cumulusnetworks.com>
Date: Tue, 7 Feb 2017 12:30:17 +0100
MIME-Version: 1.0
In-Reply-To: <20170207105638.17918-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH][net-next] net: bridge: remove redundant check
 to see if err is set
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Colin King <colin.king@canonical.com>, Stephen Hemminger <stephen@networkplumber.org>, "David S . Miller" <davem@davemloft.net>, bridge@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

On 07/02/17 11:56, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The error check on err is redundant as it is being checked
> previously each time it has been updated.  Remove this redundant
> check.
> 
> Detected with CoverityScan, CID#140030("Logically dead code")
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  net/bridge/br_netlink.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index fc5d885..cdc4e2a 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -612,9 +612,6 @@ static int br_afspec(struct net_bridge *br,
>  				return err;
>  			break;
>  		}
> -
> -		if (err)
> -			return err;
>  	}
>  
>  	return err;
> 

Actually that code can be reduced further, I'll follow up with a patch later.

Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

