Return-Path: <BATV+d5af59120f6e5838f71b+3386+infradead.org+tgraf@casper.srs.infradead.org>
Date: Fri, 30 Nov 2012 10:18:14 +0000
From: Thomas Graf <tgraf@suug.ch>
Message-ID: <20121130101814.GD30697@casper.infradead.org>
References: <1354269514-1863-1-git-send-email-amwang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1354269514-1863-1-git-send-email-amwang@redhat.com>
Sender: Thomas Graf <tgr@infradead.org>
Subject: Re: [Bridge] [PATCH net-next v1 1/2] bridge: export port_no and
 port_id via IFA_INFO_DATA
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Cong Wang <amwang@redhat.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Herbert Xu <herbert@gondor.hengli.com.au>, Jesper Dangaard Brouer <brouer@redhat.com>, Stephen Hemminger <shemminger@vyatta.com>, "David S. Miller" <davem@davemloft.net>

On 11/30/12 at 05:58pm, Cong Wang wrote:
> @@ -168,6 +172,8 @@ static const struct nla_policy ifla_brport_policy[IFLA_BRPORT_MAX + 1] = {
>  	[IFLA_BRPORT_MODE]	= { .type = NLA_U8 },
>  	[IFLA_BRPORT_GUARD]	= { .type = NLA_U8 },
>  	[IFLA_BRPORT_PROTECT]	= { .type = NLA_U8 },
> +	[IFLA_BRPORT_NO]	= { .type = NLA_U16 },
> +	[IFLA_BRPORT_ID]	= { .type = NLA_U16 },
>  };
>  
>  /* Change the state of the port and notify spanning tree */

I missed this in the first round. Not much of a point in adding policy
entries if the attributes are read-only as in this case.
