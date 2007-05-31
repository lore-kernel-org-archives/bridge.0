Message-ID: <BAY109-F2557BB29373E21AABDBC46A82D0@phx.gbl>
In-Reply-To: <20070530222848.3af6b9c8@localhost>
From: "Fabio Costa Flores" <binhocf@hotmail.com>
Subject: Re: [Bridge] bridge with ipw2200 wireless card
Date: Thu, 31 May 2007 14:01:38 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: shemminger@linux-foundation.org
Cc: bridge@lists.linux-foundation.org

I found this website  http://sourceforge.net/projects/ipw2200-ap but its 
down at the moment, not sure if this is it.

Unfortunatly im not able to use NAT with Xen, only bridge.


>From: Stephen Hemminger <shemminger@linux-foundation.org>
>To: "Fabio Costa Flores" <binhocf@hotmail.com>
>CC: bridge@lists.linux-foundation.org
>Subject: Re: [Bridge] bridge with ipw2200 wireless card
>Date: Wed, 30 May 2007 22:28:48 -0700
>
>On Thu, 31 May 2007 03:23:41 +0000
>"Fabio Costa Flores" <binhocf@hotmail.com> wrote:
>
> > Im trying to setup xen hypervisor with my ipw2200 wireless card. Xen 
>uses
> > Linux bridge and Im aware that its not easy to get it running with a
> > wireless card.
> >
> > Im not sure where to go from now, any help would be apreciated.
> >
>
>Gross oversimplification:
>Wireless is point-to-point (sort of) and doesn't work with normal bridging.
>You need a driver than can act as an access point.
>
>http://linux-net.osdl.org/index.php/bridge

_________________________________________________________________
MSN Messenger: instale gr�tis e converse com seus amigos. 
http://messenger.msn.com.br

