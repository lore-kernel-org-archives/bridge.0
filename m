Date: Thu, 9 Dec 2010 08:29:24 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20101209082924.6d797871@nehalam>
In-Reply-To: <1291903356-30618-1-git-send-email-tklauser@distanz.ch>
References: <1291903356-30618-1-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: Fix return value of
	br_multicast_add_group()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tobias Klauser <tklauser@distanz.ch>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>

On Thu,  9 Dec 2010 15:02:36 +0100
Tobias Klauser <tklauser@distanz.ch> wrote:

> If br_multicast_new_group returns NULL, we would return 0 (no error) to
> the caller, which is not what we want. Instead we should return -ENOMEM
> in this case.
> 
> Also replace IS_ERR(x) || !x by IS_ERR_OR_NULL(x)
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
>  net/bridge/br_multicast.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 326e599..d4e1e81 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -713,8 +713,11 @@ static int br_multicast_add_group(struct net_bridge *br,
>  
>  	mp = br_multicast_new_group(br, port, group);
>  	err = PTR_ERR(mp);
> -	if (unlikely(IS_ERR(mp) || !mp))
> +	if (IS_ERR_OR_NULL(mp)) {
> +		if (!mp)
> +			err = -ENOMEM;
>  		goto err;
> +	}
>  
>  	if (!port) {
>  		hlist_add_head(&mp->mglist, &br->mglist);

I would rather fix br_multicast_new_group so it never returns
NULL. Instead return PTR_ERR(-ENOMEM) on out of memory.

-- 
