Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=yPv2rhpzzDjziFVMLLuApOCSrtVCE+dprevKYftyJio=;
	b=fPgeRGMwcODw1h9Y3ZZZ6c5TjK1vIO2ArgQuHfE9KzRmbtDgTy2M4ON66Lqdju3ubw
	+Gc8oJUyEl7dusY4WDjeU8hR1YdMLEdiY1hjoimoYOlg7w2zpL8jPM4ondANdSDKnT+/
	36FiKYIYaYGaXmKY44VcBSA0HSiPIauASvd+0=
References: <20180426030705.6632-1-yuehaibing@huawei.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <426b1ae6-9fd8-a07b-790e-d01eb25a3990@cumulusnetworks.com>
Date: Thu, 26 Apr 2018 17:44:09 +0300
MIME-Version: 1.0
In-Reply-To: <20180426030705.6632-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] bridge: use hlist_entry_safe
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: YueHaibing <yuehaibing@huawei.com>, stephen@networkplumber.org, davem@davemloft.net
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

On 26/04/18 06:07, YueHaibing wrote:
> Use hlist_entry_safe() instead of open-coding it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  net/bridge/br_forward.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
> index b4eed11..7a7fd67 100644
> --- a/net/bridge/br_forward.c
> +++ b/net/bridge/br_forward.c
> @@ -274,8 +274,7 @@ void br_multicast_flood(struct net_bridge_mdb_entry *mdst,
>  		struct net_bridge_port *port, *lport, *rport;
>  
>  		lport = p ? p->port : NULL;
> -		rport = rp ? hlist_entry(rp, struct net_bridge_port, rlist) :
> -			     NULL;
> +		rport = hlist_entry_safe(rp, struct net_bridge_port, rlist);
>  
>  		if ((unsigned long)lport > (unsigned long)rport) {
>  			port = lport;
> 

Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

