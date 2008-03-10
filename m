Date: Mon, 10 Mar 2008 08:26:55 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20080310082655.2f9cd485@extreme>
In-Reply-To: <47D3ED21.6050903@operations.com>
References: <47D05B55.404@operations.com>
	<2e59e6970803082338n20c9037p6ccae93654c58a69@mail.gmail.com>
	<47D3ED21.6050903@operations.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] bridge-utils and ppp
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Lou Steinberg <lspam5@operations.com>
Cc: bridge@lists.linux-foundation.org

On Sun, 09 Mar 2008 09:58:57 -0400
Lou Steinberg <lspam5@operations.com> wrote:

> Hi Richard-
> 
> [snip]
> > 
> > Does a bridge "test" exist?  What is the output of brctl show?
> > 
> [snip]
> 
> Yes, the bridge exists.  brctl shows:
> 
>  > root@wan-bridge:~$ brctl addif test ppp0
>  > can't add ppp0 to bridge test: Invalid argument
>  > root@wan-bridge:~$ echo $?
>  > 1
>  > root@wan-bridge:~$ brctl show
>  > bridge name     bridge id               STP enabled     interfaces
>  > test            8000.000000000000       no
> 

The bridging code only works for devices that have Ethernet headers.
That is the way the bridging 802.2 standard works, it is a Layer 2 bridge
and it uses the address information from Ethernet to do routing.

PPP does not use Ethernet level framing so it can't be bridged.
What were you trying to do? there are plenty of other ways to get the
same effect.
