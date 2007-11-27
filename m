Date: Tue, 27 Nov 2007 08:19:56 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [PATCH][BRIDGE] Lost call to br_fdb_fini() in br_init() error path
Message-ID: <20071127081956.0dd3df4f@freepuppy.rosehill>
In-Reply-To: <474C2C2E.7050001@openvz.org>
References: <474C2C2E.7050001@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Pavel Emelyanov <xemul@openvz.org>
Cc: Linux Netdev List <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, Herbert Xu <herbert@gondor.apana.org.au>, devel@openvz.org

On Tue, 27 Nov 2007 17:39:42 +0300
Pavel Emelyanov <xemul@openvz.org> wrote:

> In case the br_netfilter_init() (or any subsequent call) 
> fails, the br_fdb_fini() must be called to free the allocated
> in br_fdb_init() br_fdb_cache kmem cache.
> 
> Signed-off-by: Pavel Emelyanov <xemul@openvz.org>
> 
> ---
> 
> diff --git a/net/bridge/br.c b/net/bridge/br.c
> index 93867bb..a901828 100644
> --- a/net/bridge/br.c
> +++ b/net/bridge/br.c
> @@ -39,7 +39,7 @@ static int __init br_init(void)
>  
>  	err = br_fdb_init();
>  	if (err)
> -		goto err_out1;
> +		goto err_out;
>  
>  	err = br_netfilter_init();
>  	if (err)
> @@ -65,6 +65,8 @@ err_out3:
>  err_out2:
>  	br_netfilter_fini();
>  err_out1:
> +	br_fdb_fini();
> +err_out:
>  	llc_sap_put(br_stp_sap);
>  	return err;
>  }

Good catch, thanks I hope you didn't find this in live system.

-- 
Stephen Hemminger <shemminger@linux-foundation.org>
