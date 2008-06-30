Sender: fulvio@zeroshell.net
From: "Fulvio Ricciardi" <fulvio.ricciardi@zeroshell.net>
Date: Mon, 30 Jun 2008 18:58:14 +0200
Message-id: <486910a6.a6.28a8.1880481007@webmaildh3.aruba.it>
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
To: Leigh Sharpe <lsharpe@pacificwireless.com.au>, Fulvio Ricciardi <fulvio.ricciardi@zeroshell.net>, bridge@osdl.org


> I had a similar problem not long ago. Make sure that
> ip_conntrack is not loaded. In my case, it was
> re-assembling all fragmented packets passing through the
> bridge, and not fragmenting them again. The resulting
> large packet was too big for the interface, and it got
> dropped. 
> 

I use the modules nf_conntrack_ipv4 and nf_conntrack. I
can't remove them. Does exist a workaround if this is the
problem?

Thanks
Fulvio 

--------------------------------------------------------------------
Fulvio Ricciardi
web: http://www.zeroshell.net/eng/
skype: zeroshellnet
Phone: +3908321835630
