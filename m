Return-Path: <igor.mitsyanko.os@quantenna.com>
References: <20180310030308.12947-1-igor.mitsyanko.os@quantenna.com>
	<20180310030308.12947-4-igor.mitsyanko.os@quantenna.com>
	<20180310165540.GH29174@lunn.ch>
From: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
Message-ID: <c22c1758-e383-2930-34c8-8c8c7b8455c1@quantenna.com>
Date: Mon, 12 Mar 2018 16:00:14 -0700
MIME-Version: 1.0
In-Reply-To: <20180310165540.GH29174@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC PATCH net-next 3/5] bridge: allow switchdev port
 to handle flooding by itself
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: ivecera@redhat.com, jiri@resnulli.us, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, sergey.matyukevich.os@quantenna.com, ashevchenko@quantenna.com, smaksimenko@quantenna.com, dlebed@quantenna.com

On 03/10/2018 08:55 AM, Andrew Lunn wrote:
> Is this sufficiently granular? There are a few different use cases for
> flooding:
> 
> There is no fdb entry in the software switch for the destination MAC
> address, so flood the packet out all ports of the bridge. The hardware
> switch might have an entry in its fdb to the destination switch, so it
> could unicast out the correct hardware port. If not, it should flood
> the packet.
> 
> A point to remember here, the software switch and the hardware switch
> can have different forwarding data bases.
> 
> A broadcast packet. Send it out all ports.
> 
> A multicast packet. If the hardware switch is capable of IGMP
> snooping, it could have FDB entries indicating which ports it should
> send the frame out of, and which is should not. Otherwise it needs to
> flood.
> 
> Is one flag sufficient for all of these, and any other use cases i
> might of missed?
> 
> As far as DSA switches go, i don't know of any of them which could
> implement anything like this, so BR_FLOOD_OFFLOAD will never be
> set. But maybe some of the TOR switches supported by switchdev can do
> some of these, and not others....
> 
>       Andrew
> 


The flag was introduced to enable hardware switch capabilities of 
drivers/net/wireless/quantenna/qtnfmac wifi driver. It does not have any 
switchdev functionality in upstream tree at this moment, and this 
patchset was intended as a preparatory change.

qtnfmac driver provides several physical radios (5 GHz and 2.4 GHz), 
each can have up to 8 virtual network interfaces. These interfaces can 
be bridged together in various configurations, and I'm trying to figure 
out what is the most efficient way to handle it from bridging perspective.
My assumption was that software FDB and hardware FDB should always be in 
sync with each other. I guess it is a safe assumption if handled 
correctly? Hardware should send a notification for each new FDB it has 
learned, and switchdev driver should process FDB notifications from 
software bridge.

qtnfmac hardware has its own memory and maintains FWT table, so for the 
best efficiency forwarding between virtual interfaces should be handled 
locally. Qtnfmac can handle all the mentioned flooding by itself:
- unknown unicasts
- broadcast and unknown multicast
- known multicasts (does have IGMP snooping)
- can do multicast-to-unicast translation if required.

The most important usecase IMO is a muticast transmission, specific 
example being:
- 2.4GHz x 8 and 5GHz x 8 virtual wifi interfaces, bridged with backbone 
ethernet interface in Linux
- multicast video streaming from a server behind ethernet
- multicast clients connected to some wifi interfaces

Best way to process this should be to handle multicasting locally in 
wifi firmware:
- SW bridge in Linux will send a multicast frame to a single virtual 
WiFi interface.
- WiFi firmware will forward/flood frames to all intended recipients 
locally.

BR_FLOOD_OFFLOAD flag is intended to address this case in particular, 
perhaps there are better ways to do that?
In a broader sense it is a way for hardware to tell that it will handle 
all flooding by itself, so there is no granularity in this. I'm not sure 
granularity is needed though, as there may not be much sense to do only 
some types of flooding and not to do others?
