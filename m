Date: Fri, 29 Apr 2011 09:48:54 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20110429094854.360b9746@nehalam>
In-Reply-To: <4DBAE90C.8030808@dogpad.net>
References: <4DBAE90C.8030808@dogpad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] no wireless interfaces?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "jharvell+lists.bridge@dogpad.net" <jharvell+lists.bridge@dogpad.net>
Cc: "Bridge@lists.linux-foundation.org" <Bridge@lists.linux-foundation.org>

On Fri, 29 Apr 2011 11:36:28 -0500
"jharvell+lists.bridge@dogpad.net" <jharvell+lists.bridge@dogpad.net> wrote:

> I tried to bridge a wireless interface to a wired Ethernet interface,
> and it failed with "Operation not supported."
> 
> Looking at the kernel code, it seems like this is intentional.  I
> noticed the following in br_add_if:
> 
>         /* No bridging devices that dislike that (e.g. wireless) */
>         if (dev->priv_flags & IFF_DONT_BRIDGE)
>                 return -EOPNOTSUPP;
> 
> I'm curious to know why this is not supported.

See discussion on netdev. Basically without some form of MAC spoofing
(NAT at level 2); it is not possible to bridge in station mode.

-- 
