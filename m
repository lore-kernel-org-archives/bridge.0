Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=qTyfpQS94qTqDH/wIYFRzTC9LrhG+MoloiFvya4SOJE=;
	b=LDlA5sRNIzSmKM3WWMAThQNokE0bHFPypA1i3Gxaae1uBJBZlkCY5xMQhXj7OFsFoK
	T15vXSAYUMXHkIhFUK0P4Y9sYPy9Tzb1CCCaQfZQRcKwmLH4orpWuJAeDMw2oSWRndVR
	5w4api2wTy4uv4MapfNHv2AJ3gH3sQc7L1Pys=
References: <20170605213030.GA6272@embeddedgus>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <840022de-3d31-4f62-aaaf-ba83d5c78ad7@cumulusnetworks.com>
Date: Tue, 6 Jun 2017 01:05:18 +0300
MIME-Version: 1.0
In-Reply-To: <20170605213030.GA6272@embeddedgus>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] net: bridge: fix potential NULL pointer
	dereference
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>, Stephen Hemminger <stephen@networkplumber.org>, "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, roopa <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org

On 06/06/17 00:30, Gustavo A. R. Silva wrote:
> Add NULL check before dereferencing pointer _p_ inside br_afspec().
> 
> Addresses-Coverity-ID: 1401872
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> ---
>  net/bridge/br_netlink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index 1e63ec4..ad85a9c 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -776,7 +776,7 @@ int br_setlink(struct net_device *dev, struct nlmsghdr *nlh, u16 flags)
>  			goto out;
>  	}
>  
> -	if (afspec) {
> +	if (p && afspec) {
>  		err = br_afspec((struct net_bridge *)netdev_priv(dev), p,
>  				afspec, RTM_SETLINK);
>  	}
> 

While I see a possible issue with the new bridge tunnel code (+CC Roopa), this is 
the wrong fix because there are legitimate use cases where p is null and br_afspec
is called.
We need to change the p->flags check in br_afspec()'s IFLA_BRIDGE_VLAN_TUNNEL_INFO case
to check for a NULL p first.

Thanks for the report!


