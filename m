From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 19 Nov 2009 12:44:43 +0100
References: <1258497551-25959-1-git-send-email-arnd@arndb.de>
	<200911182332.56309.arnd@arndb.de>
	<m1bpiz8k1x.fsf@fess.ebiederm.org>
In-Reply-To: <m1bpiz8k1x.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200911191244.43916.arnd@arndb.de>
Subject: Re: [Bridge] [PATCH 1/3] macvlan: Reflect macvlan packets meant for
	other macvlan devices
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: virtualization@linux-foundation.com, Herbert Xu <herbert@gondor.apana.org.au>, Eric Dumazet <eric.dumazet@gmail.com>, Anna Fischer <anna.fischer@hp.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Gerhard Stenzel <gerhard.stenzel@de.ibm.com>, Jens Osterkamp <jens@linux.vnet.ibm.com>, Patrick Mullaney <pmullaney@novell.com>, Stephen Hemminger <shemminger@vyatta.com>, Edge Virtual Bridging <evb@yahoogroups.com>, David Miller <davem@davemloft.net>

On Thursday 19 November 2009, Eric W. Biederman wrote:
> > It seems that we should never drop dst then. We either forward the frame to
> > netif_rx or to dev_queue_xmit, and from how I read it now, we want to keep
> > the dst in both cases.
> 
> When we loop back on our selves we certainly need to have dst clear because
> we don't know how to cache routes through multiple network namespaces.

Ah, right. So should I add the explicit dst_drop to the new dev_forward_skb()
then? The veth driver doesn't need it, but it also looks like it won't hurt.

	Arnd <><
