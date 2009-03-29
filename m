Date: Sun, 29 Mar 2009 13:53:55 -0700 (PDT)
Message-Id: <20090329.135355.109115565.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <49CC85E9.7070903@trash.net>
References: <20090326155205.GA28868@psychotron.englab.brq.redhat.com>
	<20090327.003819.234492275.davem@davemloft.net>
	<49CC85E9.7070903@trash.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bonding: allow bond in mode balance-alb to
 work properly in bridge -try4
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: kaber@trash.net
Cc: fubar@us.ibm.com, jpirko@redhat.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mschmidt@redhat.com, dada1@cosmosbay.com, jgarzik@pobox.com, bonding-devel@lists.sourceforge.net

From: Patrick McHardy <kaber@trash.net>
Date: Fri, 27 Mar 2009 08:53:13 +0100

> David Miller wrote:
> > I don't like the hook, but if that's how it's best done....
> > Patrick, please review this.
> 
> Me neither, but I don't think this approach can be done without the
> hook. While I still find it questionable whether this mode really
> needs to be supported for a bridge at all, an alternative approach
> would be to have bonding add FDB entries for all secondary MACs to
> make bridging treat them as local.

Do you guys foresee any possibility of an alternative implementation
any time soon?

Otherwise we're just stalling by not putting something into the tree,
and as far as I can tell this patch here might as well be it.
