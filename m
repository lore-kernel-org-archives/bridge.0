Message-ID: <49D0C1E5.6080906@trash.net>
Date: Mon, 30 Mar 2009 14:58:13 +0200
From: Patrick McHardy <kaber@trash.net>
MIME-Version: 1.0
References: <20090326155205.GA28868@psychotron.englab.brq.redhat.com>
	<20090327.003819.234492275.davem@davemloft.net>
	<49CC85E9.7070903@trash.net>
	<20090329.135355.109115565.davem@davemloft.net>
	<49D0B549.3050900@trash.net>
	<20090330124049.GD3438@psychotron.englab.brq.redhat.com>
	<49D0BF7F.1060305@trash.net>
	<20090330125156.GE3438@psychotron.englab.brq.redhat.com>
In-Reply-To: <20090330125156.GE3438@psychotron.englab.brq.redhat.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bonding: allow bond in mode balance-alb to
 work	properly in bridge -try4
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jiri Pirko <jpirko@redhat.com>
Cc: fubar@us.ibm.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mschmidt@redhat.com, bonding-devel@lists.sourceforge.net, jgarzik@pobox.com, dada1@cosmosbay.com, David Miller <davem@davemloft.net>

Jiri Pirko wrote:
> Mon, Mar 30, 2009 at 02:47:59PM CEST, kaber@trash.net wrote:
>> Jiri Pirko wrote:
>>> Currently I'm thinking the way. What I have on mind:
>>> I would like to add a list into struct net_device to contain all mac addresses
>>> of the device. I would also like to use similar interface to handle them as
>>> currently is for uc_list and mc_list. However I do not like that these lists are
>>> not using standard list_head but they are propriate lists only for this purpose.
>>> I'm thinking about converting them to use list_head first. Or maybe ignore them
>>> and do the new list for macs in parallel?
>> Using list_heads in the address lists would require some pretty large
>> amount of work since you'd need to convert all the drivers. 
> 
> Yes, I'm aware of it...
>> I'm all
>> in favour of doing this, but I wouldn't make the fix depend on that
>> work.
> 
> ok so you are suggesting to use the current list struct?

Whatever will make this easier :) You could of course already add the
new structure and use it for your new list and do the conversion of
the existing structures on top of that.
