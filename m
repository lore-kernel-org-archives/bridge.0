Message-ID: <bdfc5d6e0804241117w43c9a1c0p6d11272899de5946@mail.gmail.com>
Date: Thu, 24 Apr 2008 14:17:36 -0400
From: "Andy Gospodarek" <andy@greyhouse.net>
Sender: adgospod@gmail.com
In-Reply-To: <2327.91.89.6.59.1209015008.squirrel@postamt.eit.uni-kl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2327.91.89.6.59.1209015008.squirrel@postamt.eit.uni-kl.de>
Subject: Re: [Bridge] Access the bridge through the userspace (Rx/Tx)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Faruk Keskin <faruk@eit.uni-kl.de>
Cc: bridge@lists.linux-foundation.org

On Thu, Apr 24, 2008 at 1:30 AM, Faruk Keskin <faruk@eit.uni-kl.de> wrote:
> Hello everybody,
>
>  I'm trying to implement Layer 2 packet processing, where I need  to
>  transfer packets arriving at the Linux Bridge to a dedicated userspace
>  application. So my very basic question would be whether you could
>  recommend a strategy to achieve this.
>
>  Can I use TUN/TAP or do I need to implement specific code around a socket?
>
>  Thanks in advance,
>  Faruk
>

Yes that would work fine.  I've seen userspace apps that handle frames
work well with the tap driver.  I've also seen vpn clients in
userspace that do the same and successfully forward traffic.
