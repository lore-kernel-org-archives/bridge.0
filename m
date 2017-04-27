Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=x9vIwKVAP4uzzQos/vcwPneJPAuiEmLMPPJGI+yocpc=;
	b=IVhbASHosX1y5V1UNrmLjsYOIVZ2R1nefultSQx+acuPjrN1qvvuxLdRUNVSi4wDRW
	AV5PaskLe5kdfLDieqxeq1S0QWLop6vMdF0GoK+5iyVvUixh1/UHYoQIyZCnMfj2A3UU
	1qdkEVOLk0xCKqDJSW9ynv1e9s+0p9/jOiI4Y=
References: <1493280485-37845-1-git-send-email-arkadis@mellanox.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <45eb4630-0d54-bff4-2288-cf73f9807a3d@cumulusnetworks.com>
Date: Thu, 27 Apr 2017 16:40:33 +0300
MIME-Version: 1.0
In-Reply-To: <1493280485-37845-1-git-send-email-arkadis@mellanox.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: Fix improper taking over
 HW learned FDB
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Arkadi Sharshevsky <arkadis@mellanox.com>, netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@mellanox.com>, bridge@lists.linux-foundation.org, davem@davemloft.net

On 27/04/17 11:08, Arkadi Sharshevsky wrote:
> Commit 7e26bf45e4cb ("net: bridge: allow SW learn to take over HW fdb
> entries") added the ability to "take over an entry which was previously
> learned via HW when it shows up from a SW port".
> 
> However, if an entry was learned via HW and then a control packet
> (e.g., ARP request) was trapped to the CPU, the bridge driver will
> update the entry and remove the externally learned flag, although the
> entry is still present in HW. Instead, only clear the externally learned
> flag in case of roaming.
> 
> Fixes: 7e26bf45e4cb ("net: bridge: allow SW learn to take over HW fdb entries")
> Signed-off-by: Ido Schimmel <idosch@mellanox.com>
> Signed-off-by: Arkadi Sharashevsky <arkadis@mellanox.com>
> Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> ---
>  net/bridge/br_fdb.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index 5a40a87..ab0c7cc 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -589,14 +589,14 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
>  			if (unlikely(source != fdb->dst)) {
>  				fdb->dst = source;
>  				fdb_modified = true;
> +				/* Take over HW learned entry */
> +				if (unlikely(fdb->added_by_external_learn))
> +					fdb->added_by_external_learn = 0;
>  			}
>  			if (now != fdb->updated)
>  				fdb->updated = now;
>  			if (unlikely(added_by_user))
>  				fdb->added_by_user = 1;
> -			/* Take over HW learned entry */
> -			if (unlikely(fdb->added_by_external_learn))
> -				fdb->added_by_external_learn = 0;
>  			if (unlikely(fdb_modified))
>  				fdb_notify(br, fdb, RTM_NEWNEIGH);
>  		}
> 

Wait, this won't apply to latest net-next due to my patch that added
fdb_modified when changing the ext learned flag. I think you'll have to
respin on top of latest net-next.



