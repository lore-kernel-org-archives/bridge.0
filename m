Date: Thu, 19 May 2011 09:04:11 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20110519090411.1f039a88@nehalam>
In-Reply-To: <20110519081213.15c05da2@nehalam>
References: <1305794393-20775-1-git-send-email-amwang@redhat.com>
	<1305800661-4081-1-git-send-email-amwang@redhat.com>
	<20110519081213.15c05da2@nehalam>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [Patch] bridge: call NETDEV_ENSLAVE notifiers when
 adding a slave
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: Neil Horman <nhorman@redhat.com>, Jay Vosburgh <fubar@us.ibm.com>, Amerigo Wang <amwang@redhat.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>

On Thu, 19 May 2011 08:12:13 -0700
Stephen Hemminger <shemminger@linux-foundation.org> wrote:

> On Thu, 19 May 2011 18:24:17 +0800
> Amerigo Wang <amwang@redhat.com> wrote:
> 
> > In the previous patch I added NETDEV_ENSLAVE, now
> > we can notify netconsole when adding a device to a bridge too.
> > 
> > By the way, s/netdev_bonding_change/call_netdevice_notifiers/ in
> > bond_main.c, since this is not bonding specific.
> > 
> > Signed-off-by: WANG Cong <amwang@redhat.com>
> > Cc: Neil Horman <nhorman@redhat.com>
> > 
> 
> Is there a usage for this? What listens for this notification?

Never mind it was in the first patch which you did not send.
You should always put a number on group of patches and send
to all parties.

Also, sending networking patches to LKML is a waste of bandwidth
please don't bother.
