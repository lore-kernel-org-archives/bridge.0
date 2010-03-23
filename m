Message-ID: <4BA823D7.4010106@redhat.com>
Date: Tue, 23 Mar 2010 10:13:43 +0800
From: Cong Wang <amwang@redhat.com>
MIME-Version: 1.0
References: <20100322082059.4967.63492.sendpatchset@localhost.localdomain>
	<1269297081.3552.19.camel@calx>
In-Reply-To: <1269297081.3552.19.camel@calx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC Patch 1/3] netpoll: add generic support for
 bridge and bonding devices
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Matt Mackall <mpm@selenic.com>
Cc: Jay Vosburgh <fubar@us.ibm.com>, Neil Horman <nhorman@tuxdriver.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Jeff Moyer <jmoyer@redhat.com>, Andy Gospodarek <gospo@redhat.com>, bonding-devel@lists.sourceforge.net

Matt Mackall wrote:
> On Mon, 2010-03-22 at 04:17 -0400, Amerigo Wang wrote:
>> This whole patchset is for adding netpoll support to bridge and bonding
>> devices. I already tested it for bridge, bonding, bridge over bonding,
>> and bonding over bridge. It looks fine now.
> 
> Ages ago, Jeff Moyer took a run at this, added him to the cc: on the off
> chance he still cares.
> 
>> Please comment.
>>
>>
>> To make bridge and bonding support netpoll, we need to adjust
>> some netpoll generic code. This patch does the following things:
>>
>> 1) introduce two new priv_flags for struct net_device:
>>    IFF_IN_NETPOLL which identifies we are processing a netpoll;
>>    IFF_DISABLE_NETPOLL is used to disable netpoll support for a device
>>    at run-time;
> 
> This one is a little worrisome. I've tried to keep the netpoll code
> restricted to as tight an area as possible. Adding new flags like these
> that random drivers might try to fiddle with seems like a good way for a
> driver writer to get in trouble. Also flag space is filling up.


Somewhat, but currently I don't have other way to replace this.
Any suggestions?

> 
>> 2) introduce three new methods for netdev_ops:
>>    ->ndo_netpoll_setup() is used to setup netpoll for a device;
>>    ->ndo_netpoll_xmit() is used to transmit netpoll requests;
>>    ->ndo_netpoll_cleanup() is used to clean up netpoll when a device is
>>      removed.
> 
> Seems like a lot of interface for something to be used by only a couple
> core drivers. Hopefully Dave has an opinion here.
> 

Yeah, I worry about this too, maybe we can group those methods
for netpoll together into another struct, and just put a pointer
here?

Thanks!
