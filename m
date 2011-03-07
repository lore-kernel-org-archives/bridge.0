Date: Sun, 6 Mar 2011 18:25:43 -0600
From: Adam Majer <adamm@zombino.com>
Message-ID: <20110307002543.GA4242@mira.lan.galacticasoftware.com>
References: <20110306051833.GA3098@mira.lan.galacticasoftware.com>
	<1154832100.13939.1299393783798.JavaMail.root@tahiti.vyatta.com>
	<20110306080328.GA3850@mira.lan.galacticasoftware.com>
	<20110306094541.53390b55@nehalam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110306094541.53390b55@nehalam>
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
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: "Pekka Savola (ipv6)" <pekkas@netcore.fi>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, James Morris <jmorris@namei.org>, "David S. Miller" <davem@davemloft.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>

On Sun, Mar 06, 2011 at 09:45:41AM -0800, Stephen Hemminger wrote:
> Since this a generic problem, it needs a better solution.
> Sending NETDEV_CHANGE impacts lots of other pieces, and even
> user space has similar problems.

It does seem a little broad notification type. I've checked over
all the currently defined NETDEV notifiers, and it seems that
NETDEV_NOTIFY_PEERS may be a better option to use when bridge
has a potential topology change.

Currently it is only used in ipv4/devinet.c: where it is used to issue
a gratuitous ARP.


-- 
Adam Majer
adamm@zombino.com
