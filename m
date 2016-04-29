Return-Path: <ser@man.szczecin.pl>
References: <571F6F45.7070000@man.szczecin.pl>
	<CAOaVG17inj4fb8R42q5PTMPUtgS0SQHErZmoNEUGFsJeXFdB=A@mail.gmail.com>
	<5720BBCD.2070009@man.szczecin.pl> <20160427123726.65ce2ecb@samsung9>
From: Seweryn Niemiec <ser@man.szczecin.pl>
Message-ID: <57234D9C.3030509@man.szczecin.pl>
Date: Fri, 29 Apr 2016 14:03:40 +0200
MIME-Version: 1.0
In-Reply-To: <20160427123726.65ce2ecb@samsung9>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PROBLEM] mac address learned on wrong port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Cc: bridge <bridge@lists.linux-foundation.org>

On 27.04.2016 21:37, Stephen Hemminger wrote:
> On Wed, 27 Apr 2016 15:17:01 +0200
> Seweryn Niemiec <ser@man.szczecin.pl> wrote:
>
>> On 26.04.2016 18:49, Stephen Hemminger wrote:
>>> This usualy happens when you either have a loop or packet leaks in from other port.
>>
>> Yeah, it looks like a loop, but p2p1 is connected to a production network with
>> running MSTP, so I was sure there is no loop, but I have double checked it today
>> and I'm still sure there is no loop in the net outside of the server. To make it
>> super sure I have connected p2p1 to a dead end port (vlan with this one port
>> only) on a switch and the effect was the same - container's mac is learned on p2p1.
>>
>
> But you are not running Spanning Tree on your bridge.

After two more days of tests :)

Now I'm running stp on my bridge too and it doesn't change anything. Booth ports 
are in forwarding state. This is freshly installed Ubuntu 14.04.3. There is only 
one bridge configured and two ports in the bridge. For me, it's impossible to 
have a loop there.

To make sure it's not a problem with the switch I have connected p2p1 port to 
powered on but unbootable server (just to keep link up) and the problem still 
exists.

The other test I have made was to remove p2p1 from the bridge and add some other 
physical port. The results was:
  - other port with same drive (p2p2) - problem exists
  - other port and other driver (em2) - problem does not exist

p2pX are Intel X710 with i40e driver
emX are Broadcom BCM5720 with tg3 driver

Any ideas where to look further?

-- 
Sew
