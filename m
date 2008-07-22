Sender: fulvio@zeroshell.net
From: "Fulvio Ricciardi" <fulvio.ricciardi@zeroshell.net>
Date: Tue, 22 Jul 2008 19:40:32 +0200
Message-id: <48861b90.378.7eff.1867149638@webmaildh6.aruba.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: Re: [Bridge] 802.1q packets
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Adam Osuchowski <Adam.Osuchowski@polsl.pl>, Fulvio Ricciardi <fulvio.ricciardi@zeroshell.net>
Cc: bridge@osdl.org


> Fulvio Ricciardi wrote:
> > I notice that with the Kernel 2.6.25.9 the 802.1q VLAN
> > tagged packets larger than 1470 bytes are not forwarded
> > at all by a bridge.
> > I think there is a bad interaction between bridge and
> > netfilter codes. Any chance to a have a patch to solve
> > this problem that limit the possibility to use the Linux
> > bridges in a environment with VLANs?
> 
> Is it maybe problem described here?
> 
>  
>
https://lists.linux-foundation.org/pipermail/bridge/2007-May/005436.html
> 
> If so, it was reported more than one year ago and still
> none of developers care about it.
> 

Yes, it is exactly the same problem. Thanks for the patch
that I hope developers will include it in the vanilla Kernel
as soon as possible.

Regards 
Fulvio Ricciardi


--------------------------------------------------------------------
Fulvio Ricciardi
web: http://www.zeroshell.net/eng/
skype: zeroshellnet
Phone: +3908321835630
