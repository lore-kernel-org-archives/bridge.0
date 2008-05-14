Message-ID: <482A9459.1010409@sysnetsistemi.it>
Date: Wed, 14 May 2008 09:27:21 +0200
From: Francesco Dolcini <fdolcini@sysnetsistemi.it>
MIME-Version: 1.0
References: <1210152122.32216.95.camel@gentoo-jocke.transmode.se>	<2e59e6970805071916r701987fdx49bab341420ba2d@mail.gmail.com>	<1210233718.32216.121.camel@gentoo-jocke.transmode.se>	<2e59e6970805122010v50dcd5al101ae3466b897ad6@mail.gmail.com>	<m3abiua957.fsf@ursa.amorsen.dk>
	<1210717793.5774.10.camel@collymore.citylink.co.nz>
In-Reply-To: <1210717793.5774.10.camel@collymore.citylink.co.nz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] STP bug, loop not detetcted
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Dylan Hall <dylan@citylink.co.nz>
Cc: bridge@osdl.org

Dylan Hall wrote:
> Most Cisco switches will generate a loopback packet (ethertype 0x9000)
> at fairly regular intervals.  Both the src and dst mac addresses are set
> to the interface mac of the port emitting the packets.  In the event a
> loop exists in the network that hasn't been dealt with by (R)STP the
> switch will receive the packet back on another of it's interfaces.  In
> the event one of the loopback packets does make it back to the switch
> the port is error-disabled (I can't remember if it's the sending or
> receiving port that is disabled).  This mechanism is independent of
> STP. 
> 
> UDLD also seems to have a mechanism to detect a port that is looped back
> on itself.  Again, independent of STP.
> 
you can also add cisco loop guard to the list, but this is an 
improvement to standard STP, not a different protocol

> Rather than modifying STP would it not be better to implement something
> like the above as a standalone daemon? 
I agree, but it is also true that if we can improve STP without breaking 
compatibility there is no reason to not do it.
