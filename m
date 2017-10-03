Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=IL3mkcE2/gMZHS75TvjUZN9vR5d9Yu+oOOX8Tteul8E=;
	b=H+0DEgJ++2N2aWyipi1LiN5Q/b6rLi7av04uRA/zJniY85CZkEfWJiq+9+BEJH/vfd
	Hk+Cdc1Tb+M/8jeyREc0jDsMRz6H/LQp1sH6cOKi7VglthLMYXKh1+FhWc69Z2l4k18V
	csicIL4iys4faw6E22XyIEWlyFsz0CEnxSfCxPBcgRnq+gq3sPpWz3GZdY9nQgnMCQiH
	HRXXtmWPcIOuXKCivhoyDnaJYsZlziVgCGbmM4Ut81RKcXqGaMCb8H74cvBrXc/mYBNh
	e86j0mR4SuFpvUMyLBXEdzfl5INsNiMI6m/eIAlId73CgwnSborxKMvnqo5Z/uEQkx+H
	muSA==
Date: Tue, 3 Oct 2017 11:29:48 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20171003112948.44d9cc56@xeon-e3>
In-Reply-To: <1507054876-16746-2-git-send-email-roopa@cumulusnetworks.com>
References: <1507054876-16746-1-git-send-email-roopa@cumulusnetworks.com>
	<1507054876-16746-2-git-send-email-roopa@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 1/3] bridge: add new
 BR_NEIGH_SUPPRESS port flag to suppress arp and nd flood
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@cumulusnetworks.com>
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net

On Tue,  3 Oct 2017 11:21:14 -0700
Roopa Prabhu <roopa@cumulusnetworks.com> wrote:

> diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
> index 48fb174..7a50dc5 100644
> --- a/net/bridge/br_forward.c
> +++ b/net/bridge/br_forward.c
> @@ -204,7 +204,8 @@ void br_flood(struct net_bridge *br, struct sk_buff *skb,
>  		/* Do not flood to ports that enable proxy ARP */
>  		if (p->flags & BR_PROXYARP)
>  			continue;
> -		if ((p->flags & BR_PROXYARP_WIFI) &&
> +		if ((p->flags & BR_PROXYARP_WIFI ||
> +		     p->flags & BR_NEIGH_SUPPRESS) &&
>  		    BR_INPUT_SKB_CB(skb)->proxyarp_replied)
>  			continue;

Don;t you need additional paren here to avoid warnings.
Or do one mask:
		if ((p->flags & (BR_PROXYARP_WIFI | BR_NEIGH_SUPPRESS)) &&
 		    BR_INPUT_SKB_CB(skb)->proxyarp_replied)
  			continue;
