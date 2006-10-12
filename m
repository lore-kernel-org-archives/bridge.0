Message-ID: <452E6E26.5090009@cambridgebroadband.com>
Date: Thu, 12 Oct 2006 17:32:38 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
References: <cab05a880610090952g2e94b7aka84ccb0ef8fd8013@mail.gmail.com>	
	<452CB1E0.9020008@cambridgebroadband.com>	
	<cab05a880610110233u2d48c96ena9915cf2bb3cb682@mail.gmail.com>	
	<452CC60A.3090509@cambridgebroadband.com>
	<cab05a880610120915m69cbb6ffue54f364731c2b6d3@mail.gmail.com>
In-Reply-To: <cab05a880610120915m69cbb6ffue54f364731c2b6d3@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Link fail over - bridge slow learning !?!
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Alexander Indenbaum <alexander.indenbaum@gmail.com>
Cc: bridge@lists.osdl.org, shemminger@osdl.org

Alex,

I don't fully understand STP.  You can look it up in the RFCs if you like.

What I know is this:

  * With STP on you get (by default) 15 seconds in LISTENING mode, then
    15 seconds in LEARNING mode, before entering FORWARDING mode.

  * With STP off you would think you'd just start FORWARDING as soon as
    br0 is if-upped, however you still get 15 seconds delay.  This can
    be reduced to 1 second though with "brctl setfd br0 1".  (I haven't
    tried 0 seconds!)

And that is all I know.  Perhaps somebody else on this list can tell you
why you still get a delay when spanning tree is disabled!

Alex

Alexander Indenbaum wrote:
> On 10/11/06, Alex Zeffertt <ajz@cambridgebroadband.com> wrote:
>> It still uses a forwarding delay.  Try "brctl setfd br0 1" to set it to
>> 1 second.
> 
> Thanks Alex. It did the trick.
> Could you explain why?
> 
>>
>> Alexander Indenbaum wrote:
>> > Alex,
>> >
>> > That was my first thought too, but STP is disabled.
>> >
>> > On 10/11/06, Alex Zeffertt <ajz@cambridgebroadband.com> wrote:
>> >> Alexander Indenbaum wrote:
>> >> > Hello,
>> >> >
>> >> > I'm playing with dual-port NIC driver level link failover:
>> >> > * Driver exposes single network interface to the OS and operates 
>> both
>> >> > ports in active-passive failover mode.
>> >> > * Upon Link down event on active port, driver switches active and
>> >> > passive ports transparently for the OS.
>> >> >
>> >> > I'm testing the driver using Linux bridge module: "failover" 
>> dual-port
>> >> > NIC connected with two cables back-to-back to eth0 and eth1 which 
>> are
>> >> > part of br0 bridge.
>> >> >
>> >> > I simulate link fail with following scenario:
>> >> > * At t0 both eth0 and eth1 port links are UP, traffic is accepted by
>> >> > eth0 and forwarded to br0
>> >> > * At t1 I manually unplug eth0 cable, causing link to go down.
>> >> > "Failover" driver switches the traffic immediately from eth0 to 
>> eth1,
>> >> > while using the same MAC address.
>> >> > * From t1 till t1+12 secs packets are accepted by eth1 but 
>> dropped by
>> >> > bridge and not forwarded to br0.
>> >> > * At t1+12 secs bridge starts forwarding packets from eth1 to br0
>> >> >
>> >> > Hmm... I would expect that eth0 link down event would flush from
>> >> > bridge's table any MAC address associated with the port and that the
>> >> > bridge would start forwarding packets from eth1 to br0 immediately.
>> >> >
>> >> > Why does it take ~12 secs for bridge to learn that MAC address moved
>> >> > from eth0 to eth1 in the described scenario?
>> >> >
>> >>
>> >> It may be spanning tree, rather than MAC address learning that takes
>> >> so long.  Bridges spend a while just listening before forwarding, to
>> >> avoid becoming part of a bridging loop.
>> >>
>> >> Experiment with:
>> >>
>> >>    brctl showstp br0
>> >>    brctl stp br0 off
>> >>    brctl setfd br0 1
>> >>
>> >> Alex
>> >>
>> >>
>> >
>> >
>>
>>
> 
> 

