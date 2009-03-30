Message-ID: <49D0B549.3050900@trash.net>
Date: Mon, 30 Mar 2009 14:04:25 +0200
From: Patrick McHardy <kaber@trash.net>
MIME-Version: 1.0
References: <20090326155205.GA28868@psychotron.englab.brq.redhat.com>	<20090327.003819.234492275.davem@davemloft.net>	<49CC85E9.7070903@trash.net>
	<20090329.135355.109115565.davem@davemloft.net>
In-Reply-To: <20090329.135355.109115565.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
To: David Miller <davem@davemloft.net>
Cc: fubar@us.ibm.com, jpirko@redhat.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mschmidt@redhat.com, dada1@cosmosbay.com, jgarzik@pobox.com, bonding-devel@lists.sourceforge.net

David Miller wrote:
> From: Patrick McHardy <kaber@trash.net>
> Date: Fri, 27 Mar 2009 08:53:13 +0100
> 
>> ... an alternative approach
>> would be to have bonding add FDB entries for all secondary MACs to
>> make bridging treat them as local.
> 
> Do you guys foresee any possibility of an alternative implementation
> any time soon?
> 
> Otherwise we're just stalling by not putting something into the tree,
> and as far as I can tell this patch here might as well be it.

Adding bridge FDB entries seems like the best fix. It might
need some minor ugliness to avoid new dependencies between
bonding and bridging, but it definitely beats having new hooks
in the core in my opinion.

But I have no idea whether Jiri is actually implementing this.
