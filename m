Return-Path: <vitas@nppfactor.kiev.ua>
From: Vitalii Demianets <vitas@nppfactor.kiev.ua>
Date: Thu, 1 Mar 2012 11:36:47 +0200
References: <1330454231-23852-1-git-send-email-Joakim.Tjernlund@transmode.se>
In-Reply-To: <1330454231-23852-1-git-send-email-Joakim.Tjernlund@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201203011136.48018.vitas@nppfactor.kiev.ua>
Subject: Re: [Bridge] [PATCH 1/2] bridge: Adjust min age inc for HZ > 256
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org
Cc: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>

On Tuesday 28 February 2012 20:37:10 Joakim Tjernlund wrote:
> min age increment needs to round up its min age tick for all
> HZ values to guarantee message age is increasing.
>
> Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> ---
>  net/bridge/br_stp.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/bridge/br_stp.c b/net/bridge/br_stp.c
> index a04eeb6..9a8aebd 100644
> --- a/net/bridge/br_stp.c
> +++ b/net/bridge/br_stp.c
> @@ -17,9 +17,9 @@
>  #include "br_private_stp.h"
>
>  /* since time values in bpdu are in jiffies and then scaled (1/256)
> - * before sending, make sure that is at least one.
> + * before sending, make sure that is at least one STP tick.
>   */
> -#define MESSAGE_AGE_INCR	((HZ < 256) ? 1 : (HZ/256))
> +#define MESSAGE_AGE_INCR	((HZ / 256) + 1)
>
>  static const char *const br_port_state_names[] = {
>  	[BR_STATE_DISABLED] = "disabled",

In general I can see the problem which is solved by your patches and it seems 
to me that solution is adequate.
Just a nitpick: I think the following is a little bit more accurate (take into 
account cases when HZ is multiple of 256, which is rare but possible):

-#define MESSAGE_AGE_INCR	((HZ < 256) ? 1 : (HZ/256))
+#define MESSAGE_AGE_INCR	((HZ / 256) + ((HZ % 256) ? 1 : 0))

Also I'd advice to send patches to the netdev list too, people there are much 
more responsive than at the bridge list.

NB: don't you want to try 802.1Q-2005 compatible user-space {m/r}stp 
implementation instead of rusty in-kernel 802.1D? You can find sources here: 
http://sourceforge.net/p/mstpd/code/28/tree/

-- 
Vitalii Demianets
