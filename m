Message-ID: <49E3CB7F.3080501@pacbell.net>
Date: Mon, 13 Apr 2009 16:32:15 -0700
From: Michael Boutte <maboutte@pacbell.net>
MIME-Version: 1.0
References: <49E03128.7080902@pacbell.net>
	<2e59e6970904131059k7721735fk670b41e50a91bda8@mail.gmail.com>
In-Reply-To: <2e59e6970904131059k7721735fk670b41e50a91bda8@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Building a Raw Bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Cc: bridge@lists.linux-foundation.org

Richard,
The diagram may be deceiving. The real physical hardware consists of a 
separate embedded computer that is part of each radio. Each has an 
Ethernet port (eth0) and a synchronous hdlc port (wan0) and part of its 
purpose is to translate between the two mediums. In this one network 
configuration we want to use one radio to transmit to all remotes and 
one radio receive for each incoming signal from the remotes. At the hub 
site all of the radios with their embedded Linux computers would most 
likely be fed by a single switch.

I can make this work setting each of the embedded computers as a router, 
but the configuration of all of the units and computers at the remote 
sites becomes significantly more complex than using a bridge, and 
requires changes each time the network is changed. A pseudo "raw" bridge 
would be ideal because it is then almost plug and play. I also don't 
need to worry about filtering the packets because there is a separate 
device before the bridge/radio that handle routing and other processing.

I was simply hoping that there was some relatively easy method setting 
this up, perhaps with ebtables, that had the benefits of bridging 
without the complexity of routing.

Mike Boutte

richardvoigt@gmail.com wrote:
> What you described is a different interface for tx and rx.  What 
> you've drawn is separate tx and rx radios which are melded in the 
> driver and expose a single interface "wan0".  Which is it?  (If the 
> drawing is correct, I don't think you have a problem at all, aside 
> from trying to use two bridges when you need only one)
>
> On Sat, Apr 11, 2009 at 12:56 AM, Michael Boutte <maboutte@pacbell.net 
> <mailto:maboutte@pacbell.net>> wrote:
>
>     I'm having trouble figuring out how to make a bridge that does not
>     block
>     forwarding of packets when there is no receive channel in the same
>     bridge. The reason I want to do this is that the return path is via
>     another circuit. The two directions are on two different radios. I
>     would
>     think this would be like the response given to someone in July 2007
>     about setting a "hub" mode by setting the aging timer to 0. I
>     tried that
>     and it did not work.
>
>     I also tried a few schemes with ebtables without success either. Is
>     there some relatively easy way to make the bridge forward
>     everything and
>     not cut off the transmit after a single packet?
>
>     / Here is what one end of the link looks like.
>     //
>     //                   +-------------+
>     // ///      /// + eth0 +---+   bridge 1  +---+ wan0 ---> Transmit
>     //        |          +-------------+
>     //        |
>     //switch--+
>     //        |          +-------------+
>     //        + eth0 +---+   bridge 2  +---+ wan0 <--- Receive
>     //                   +-------------+
>     /
>     The WAN side uses a synchronous serial interface to the radios for
>     satellite communications. The other end uses a single radio and
>     bridge.
>
>     Mike Boutte
>
>     _______________________________________________
>     Bridge mailing list
>     Bridge@lists.linux-foundation.org
>     <mailto:Bridge@lists.linux-foundation.org>
>     https://lists.linux-foundation.org/mailman/listinfo/bridge
>
>

