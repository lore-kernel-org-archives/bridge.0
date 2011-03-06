Date: Sun, 6 Mar 2011 02:03:28 -0600
From: Adam Majer <adamm@zombino.com>
Message-ID: <20110306080328.GA3850@mira.lan.galacticasoftware.com>
References: <20110306051833.GA3098@mira.lan.galacticasoftware.com>
	<1154832100.13939.1299393783798.JavaMail.root@tahiti.vyatta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154832100.13939.1299393783798.JavaMail.root@tahiti.vyatta.com>
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
To: Stephen Hemminger <stephen.hemminger@vyatta.com>
Cc: "Pekka Savola (ipv6)" <pekkas@netcore.fi>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, James Morris <jmorris@namei.org>, "David S. Miller" <davem@davemloft.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>

On Sat, Mar 05, 2011 at 10:43:03PM -0800, Stephen Hemminger wrote:
> Why not set forwarding delay to zero? I don't think you are using STP?
> 
> P.s: removing linux-kernel mailing list, since there is no point
> in copying the whole world on this thread.

I just sent patches where MAINTAINERS file told me to send it. ;)

No, I'm not relying on STP. I think setting learning->forwarding delay
to 0 could cause problems with STP like loops until the loop is
detected.

There may be a better spot where to insert the notification that the
bridge is forwarding data, though I'm not exactly certain where. The
patch will cause bridge to issue NETDEV_CHANGE notification for all
topology changes. This may or may not be useful but shouldn't be
harmful (I can't imagine these occur very often?) The IPv6 autoconf
patch will only act on this if it doesn't have IPv6 address configured
manually or via autoconf.

-- 
Adam Majer
adamm@zombino.com
