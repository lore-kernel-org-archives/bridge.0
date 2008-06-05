Date: Thu, 5 Jun 2008 14:29:24 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20080605142924.4be9c391@extreme>
In-Reply-To: <3357.78.42.24.243.1212696483.squirrel@postamt.eit.uni-kl.de>
References: <3357.78.42.24.243.1212696483.squirrel@postamt.eit.uni-kl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] VLAN-aware bridge : [PATCH] Add vlan id to bridge
 forward database
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Faruk Keskin <faruk@eit.uni-kl.de>
Cc: jaime.medrano@gmail.com, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>

On Thu, 5 Jun 2008 22:08:03 +0200 (CEST)
"Faruk Keskin" <faruk@eit.uni-kl.de> wrote:

> Hello everybody, hi Jaime,
> 
> I'm mailing to get more information about whether your patch
> [PATCH] Add vlan id to bridge forward database
> has been accepted so far.
> I couldn't find the patched version yet - could you please tell me where I
> can get the latest version of the patch or point out a reference to it ?

This only applys to bridge that is blindly bridging without any knowledge
of vlan's. You can already handle the case of bridging selected vlan's
if you tell the kernel about them. 

> Has the vlan-aware bridge forwarding already been tested ?

People do it all the time without patch by configuring the vlan's
first then bridging the vlan's.

> And how about forwarding tagged packets ?
> Until now, the bridge always stripped off the tag if present.

Not if you bridge the vlan's

> I'm currently thinking about extending the sk_buff data structure to
> incorporate the vlan tag - to keep the VLAN information present when
> exchanging packets from or to the bridge with the 8021q module and also
> when a socket is bind to a interface (extending the sockaddr_ll struct in
> that case).
> 
> Do you think thats's a sane approach ?

Only for other uses like sniffing
