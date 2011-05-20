Message-ID: <4DD5DAB4.2070709@redhat.com>
Date: Fri, 20 May 2011 11:06:28 +0800
From: Cong Wang <amwang@redhat.com>
MIME-Version: 1.0
References: <1305794393-20775-1-git-send-email-amwang@redhat.com>	<1305800661-4081-1-git-send-email-amwang@redhat.com>	<20110519081213.15c05da2@nehalam>
	<20110519090411.1f039a88@nehalam>
In-Reply-To: <20110519090411.1f039a88@nehalam>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
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
Cc: Neil Horman <nhorman@redhat.com>, Jay Vosburgh <fubar@us.ibm.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>

于 2011年05月20日 00:04, Stephen Hemminger 写道:
> On Thu, 19 May 2011 08:12:13 -0700
> Stephen Hemminger<shemminger@linux-foundation.org>  wrote:
>
>> On Thu, 19 May 2011 18:24:17 +0800
>> Amerigo Wang<amwang@redhat.com>  wrote:
>>
>>> In the previous patch I added NETDEV_ENSLAVE, now
>>> we can notify netconsole when adding a device to a bridge too.
>>>
>>> By the way, s/netdev_bonding_change/call_netdevice_notifiers/ in
>>> bond_main.c, since this is not bonding specific.
>>>
>>> Signed-off-by: WANG Cong<amwang@redhat.com>
>>> Cc: Neil Horman<nhorman@redhat.com>
>>>
>>
>> Is there a usage for this? What listens for this notification?
>
> Never mind it was in the first patch which you did not send.
> You should always put a number on group of patches and send
> to all parties.

Ah, sorry, my script simply run get_maintainers.pl to
get the Cc list, so bridge list was not in included in
the first patch.

>
> Also, sending networking patches to LKML is a waste of bandwidth
> please don't bother.

Ok, will fix my script.

Thanks.
