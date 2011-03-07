Date: Sun, 6 Mar 2011 22:41:14 -0800 (PST)
From: Stephen Hemminger <stephen.hemminger@vyatta.com>
Message-ID: <1649722795.14144.1299480074110.JavaMail.root@tahiti.vyatta.com>
In-Reply-To: <20110307002543.GA4242@mira.lan.galacticasoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 1/2] Issue NETDEV_CHANGE notification when
 bridge changes state
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Adam Majer <adamm@zombino.com>
Cc: "Pekka Savola (ipv6)" <pekkas@netcore.fi>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, James Morris <jmorris@namei.org>, "David S. Miller" <davem@davemloft.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>


> On Sun, Mar 06, 2011 at 09:45:41AM -0800, Stephen Hemminger wrote:
> > Since this a generic problem, it needs a better solution.
> > Sending NETDEV_CHANGE impacts lots of other pieces, and even
> > user space has similar problems.
> 
> It does seem a little broad notification type. I've checked over
> all the currently defined NETDEV notifiers, and it seems that
> NETDEV_NOTIFY_PEERS may be a better option to use when bridge
> has a potential topology change.
> 
> Currently it is only used in ipv4/devinet.c: where it is used to issue
> a gratuitous ARP.

I was thinking of fixing bridge to not actually bring the link
up until in forwarding mode. Other applications (DHCP, etc)
see the link up and really don't like being in half duplex
during that period. 
