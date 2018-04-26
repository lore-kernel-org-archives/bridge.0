Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=jOErRyHrjsWpvYa6plYl7+ZuIpTnWoZMKY6pqlG98iQ=;
	b=IyVvZQYi9qoREf30qXu0JJHXxnYYgYUxUDgHNPBaXiAA7QkCvcl/onaN7dJ2mC/Ywv
	CcviXXEJ+NFK1tDzNHNZHPM0BtQBXT0Cf+2smxMhcOoTLPHASXcWvdXq4kkdeOIefmqh
	12usyS8bNL+7CTekqulfq5KVD/Qc6w29Y45VGIuQoF0fucPvQUAWHRc42uZH04UChK3x
	W8aAn2wlRGNOdFTAw5jmMpb+2A93vtPXJYwIY+jiiQgnJBnJcOKsCX7InlJCWpuwnR32
	99KbtbiSpwIBXjVBsI/KiorerFmWU7BQTGnc1qirO4j9tVQUMrUaCC8R90tQE87gA8ad
	6ivw==
Date: Thu, 26 Apr 2018 08:54:13 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20180426085413.53cad9ad@xeon-e3>
In-Reply-To: <20180426030705.6632-1-yuehaibing@huawei.com>
References: <20180426030705.6632-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: YueHaibing <yuehaibing@huawei.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net

On Thu, 26 Apr 2018 11:07:05 +0800
YueHaibing <yuehaibing@huawei.com> wrote:

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
>
  			port = lport;

Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
