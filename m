Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=8kSV/6xrwwjNSFQrCuVyTCNIgWF9ceUqx7m70tscaqM=;
	b=N+Z0Cjc9gUdM2cs3ow1hGmctJ+mjJx80LS7su+yFJSW9FK92Z4eeXQMOyF2/UhYMxY
	jiSXoQjat4A5fI5iQIceI656Hmk6dQ605tPhXMZpiQHBeM8cVtUKXkL8s8p9seuqDfcJ
	g2GDJCowBnEvY5TgvBGmRg6Rodn7eBYwnFktA=
References: <1517480728-5580-1-git-send-email-geert@linux-m68k.org>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <657a050a-444d-2ad3-17fb-e855f5c54ea9@cumulusnetworks.com>
Date: Thu, 1 Feb 2018 13:28:58 +0200
MIME-Version: 1.0
In-Reply-To: <1517480728-5580-1-git-send-email-geert@linux-m68k.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH] net: bridge: Fix uninitialized error in
 br_fdb_sync_static()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Geert Uytterhoeven <geert@linux-m68k.org>, "David S . Miller" <davem@davemloft.net>, Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

On 01/02/18 12:25, Geert Uytterhoeven wrote:
> With gcc-4.1.2.:
> 
>     net/bridge/br_fdb.c: In function ‘br_fdb_sync_static’:
>     net/bridge/br_fdb.c:996: warning: ‘err’ may be used uninitialized in this function
> 
> Indeed, if the list is empty, err will be uninitialized, and will be
> propagated up as the function return value.
> 
> Fix this by preinitializing err to zero.
> 
> Fixes: eb7935830d00b9e0 ("net: bridge: use rhashtable for fdbs")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  net/bridge/br_fdb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index dc87fbc9a23b04e6..d9e69e4514beb20d 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -993,7 +993,7 @@ int br_fdb_delete(struct ndmsg *ndm, struct nlattr *tb[],
>  int br_fdb_sync_static(struct net_bridge *br, struct net_bridge_port *p)
>  {
>  	struct net_bridge_fdb_entry *f, *tmp;
> -	int err;
> +	int err = 0;
>  
>  	ASSERT_RTNL();
>  
> 

Thanks,
Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

