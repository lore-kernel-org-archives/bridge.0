Sender: fulvio@zeroshell.net
From: "Fulvio Ricciardi" <fulvio.ricciardi@zeroshell.net>
Date: Mon, 30 Jun 2008 19:07:51 +0200
Message-id: <486912e7.a6.3013.6700211@webmaildh6.aruba.it>
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
To: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Cc: Stephen Hemminger <shemminger@vyatta.com>, bridge@linuxfoundation.org


> 
> That mostly rules out other devices in the path as the
> cause of the problem.  There's just one chance of a
> netfilter interaction that I can think of: netfilter may
> cause fragments to be recombined, without netfilter the
> fragments could be bridged.  Are you running the ping
> command from the bridge itself, or across the bridge? (I
> presume across the bridge because you are discussing the
> FORWARD chain only)

I ping across the bridge. If instead a ping from the bridge
itself, all works right.

> 
> Do the large ping requests show up in the iptables
> counters?

Yes, in any case (either ping -s 1472 and ping -s 1473) the
packets are counted in the FORWARD chain.

> 
> What happens if you set no fragmentation when you run
> ping?

it's the same

Thanks
Fulvio

--------------------------------------------------------------------
Fulvio Ricciardi
web: http://www.zeroshell.net/eng/
skype: zeroshellnet
Phone: +3908321835630
