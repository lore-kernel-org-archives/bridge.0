Date: Tue, 10 Mar 2009 10:26:48 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20090310102648.125aa7e5@nehalam>
In-Reply-To: <74b87ec3359e6e65d59cd6fb62a83fb469e6c8ae.1236702228.git.scott@canonical.com>
References: <cover.1236702228.git.scott@canonical.com>
	<74b87ec3359e6e65d59cd6fb62a83fb469e6c8ae.1236702228.git.scott@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 01/31] bridge: Auto-load bridge module when
 socket opened.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Scott James Remnant <scott@canonical.com>
Cc: bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org

On Mon, 2 Mar 2009 16:40:10 +0000
Scott James Remnant <scott@canonical.com> wrote:

> The bridge module is missing the net-pf-7 alias that would cause it to
> be auto-loaded when a socket of that type is opened.  This patch adds
> the alias.
> 
> Signed-off-by: Scott James Remnant <scott@canonical.com>
> Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
> ---
>  net/bridge/br.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/net/bridge/br.c b/net/bridge/br.c
> index 4d2c1f1..229daee 100644
> --- a/net/bridge/br.c
> +++ b/net/bridge/br.c
> @@ -16,6 +16,7 @@
>  #include <linux/netdevice.h>
>  #include <linux/etherdevice.h>
>  #include <linux/init.h>
> +#include <linux/net.h>
>  #include <linux/llc.h>
>  #include <net/llc.h>
>  #include <net/stp.h>
> @@ -108,3 +109,4 @@ module_init(br_init)
>  module_exit(br_deinit)
>  MODULE_LICENSE("GPL");
>  MODULE_VERSION(BR_VERSION);
> +MODULE_ALIAS_NETPROTO(PF_BRIDGE);

Hmm. It looks okay, but there is not real direct socket interface
for PF_BRIDGE/AF_BRIDGE.
