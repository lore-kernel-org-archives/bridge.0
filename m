Return-Path: <stephen@networkplumber.org>
Date: Fri, 19 Apr 2013 13:55:33 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20130419135533.34e5e7f5@nehalam.linuxnetplumber.net>
In-Reply-To: <1366404770-28523-3-git-send-email-vyasevic@redhat.com>
References: <1366404770-28523-1-git-send-email-vyasevic@redhat.com>
	<1366404770-28523-3-git-send-email-vyasevic@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v2 net-next 2/6] bridge: make flags sysfs
 interface a little bit more extensible
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vlad Yasevich <vyasevic@redhat.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, mst@redhat.com

On Fri, 19 Apr 2013 16:52:46 -0400
Vlad Yasevich <vyasevic@redhat.com> wrote:

> +
> +static int store_flag(struct net_bridge_port *p, unsigned long v,
> +		     unsigned long mask)
> +{
> +	unsigned long flags = p->flags;
> +
> +	if (v)
> +		flags |= mask;
> +	else
> +		flags &= ~mask;
> +
> +	if (flags != p->flags) {
> +		p->flags = flags;
> +		br_ifinfo_notify(RTM_NEWLINK, p);
> +	}
> +	return 0;
> +}

I don't want to allow arbitrary flag stores (and shows).
It exposes kernel bits to user space and creates an unintended ABI.
