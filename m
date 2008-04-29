Message-ID: <1150.85.216.121.168.1209491243.squirrel@postamt.eit.uni-kl.de>
In-Reply-To: <alpine.DEB.1.10.0804282057310.5194@callisto.moose.malc.org.uk>
References: <2327.91.89.6.59.1209015008.squirrel@postamt.eit.uni-kl.de>
	<alpine.DEB.1.10.0804282057310.5194@callisto.moose.malc.org.uk>
Date: Tue, 29 Apr 2008 19:47:23 +0200 (CEST)
From: "Faruk Keskin" <faruk@eit.uni-kl.de>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] Access the bridge through the userspace (Rx/Tx)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Malcolm Scott  Andy Gospodarek <andy@greyhouse.net>
Cc: Faruk Keskin <faruk@eit.uni-kl.de>, bridge@lists.linux-foundation.org

First of all,

Thanks for the quick response, Andy and Malcolm. Looking at the the last
sentence below, I recognize how much I like conditional expressions - it
makes you look into specifics.

To be honest with you - I'm kind of stuck with the socket approach (using
the standard Linux Socket Filter). Because, with a socket, I either get
packets of a specific protocol type (I would like to have any/several
types of control packets) or all packets it seems. Right ?

At the current stage, I hope to find something else that possibly is more
suited to my application, as specified below.

I'm trying to find a socket type of a tools which offers the possibility
to selectively pass packets from the bridge to the desired host
application running in the userspace.

In particular, I only want to receive packets that are send to host(bridge
MAC), multicast, broadcast or to unknown destinations (no FDB entry). I
would also be nice to exclusively filter control packets, if possible.

The packet flow of common data traffic should be preserved, as I don't
want my userspace application (doing network management) to have a
remarkable effect on the data links.



At the moment I would just like to now, if the desired configuration is
not  possible with the socket approach. Actually, I'm hoping it does ...

But if not, can ebtables solve the issue ? (never had a look into it)

Or, as a more preferable alternative, do I need to extend the current
handle_bridge function and its hooks within the bridge implementation?
(I probably don't want to do that)


Anyway, thanks to everybody who's on the list for sharing your experience.

Faruk Keskin



> On Thu, 24 Apr 2008, Faruk Keskin wrote:
>
>> I'm trying to implement Layer 2 packet processing, where I need  to
>> transfer packets arriving at the Linux Bridge to a dedicated userspace
>> application. So my very basic question would be whether you could
>> recommend a strategy to achieve this.
>>
>> Can I use TUN/TAP or do I need to implement specific code around a
>> socket?
>
> You could alternatively use libpcap, if I understand your requirements
> properly.
>
> --
> Malcolm Scott
> Research Assistant
> University of Cambridge Computer Laboratory
>
>
>


