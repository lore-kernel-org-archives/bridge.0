DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
	bh=X6DTdXvhxSZYri4VqxtChVybtk7BfqlJeGkTNDNpdOI=;
	b=BZZQTmtQFTKc0KvqKsCWbF/RxgXKqy5pc55KCa9D0PQVM7eAORDnOAEIHaYPXMqJyLd8jjsC0qhzcmsk++APyVqLBXGGkAZtEVpbsYCwoloI7ipuaY89fxo8P/cbo1z9kRQ9RgkB0BynmvXpSXS1oUj52YMuj0PRIOUQIVLp7uU=
Message-ID: <81c11a560711270149r3f21151qe5097180fe986723@mail.gmail.com>
Date: Tue, 27 Nov 2007 10:49:14 +0100
From: "Edouard Thuleau" <doudouyam@gmail.com>
Subject: Re: [Bridge] Conflict between net/if.h and linux/if.h
In-Reply-To: <20071126090154.10c8ec1e@freepuppy.rosehill.pdx.hemminger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <81c11a560711220316n60921656md0aaefd95a82e63a@mail.gmail.com>
	<20071126090154.10c8ec1e@freepuppy.rosehill.pdx.hemminger.net>
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: bridge@lists.linux-foundation.org

Ok,

Thanks for your solution, it works nicely.

On Nov 26, 2007 6:01 PM, Stephen Hemminger
<shemminger@linux-foundation.org> wrote:
> I fixed the problem differently because I don't want more conditional
> compilation.  The ideal fix would be to get glibc
> to the headers fixed to be compatible.
>
>  Use linux/if.h rather than net/if.h for compatiablity with
>  other headers.
>
> Signed-off-by: Stephen Hemminger <shemminger@linux-foundation.org>
> ---
>  libbridge/libbridge.h |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
>
> diff --git a/libbridge/libbridge.h b/libbridge/libbridge.h
> index 20d5bb5..016acea 100644
> --- a/libbridge/libbridge.h
> +++ b/libbridge/libbridge.h
> @@ -19,9 +19,15 @@
>  #ifndef _LIBBRIDGE_H
>  #define _LIBBRIDGE_H
>
> -#include <net/if.h>
> +#include <sys/socket.h>
> +#include <linux/if.h>
>  #include <linux/if_bridge.h>
>
> +/* defined in net/if.h but that conflicts with linux/if.h... */
> +extern unsigned int if_nametoindex (const char *__ifname);
> +extern char *if_indextoname (unsigned int __ifindex, char *__ifname);
> +
> +
>  struct bridge_id
>  {
>         unsigned char prio[2];
> --
> 1.5.3.4
>
>
