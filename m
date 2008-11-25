Message-ID: <492BB5DF.3020100@gmxpro.de>
Date: Tue, 25 Nov 2008 09:22:55 +0100
From: Andre iosT <andre.iost@gmxpro.de>
MIME-Version: 1.0
References: <492A8A22.1090509@gmxpro.de> <ggg91t$jtk$1@ger.gmane.org>
In-Reply-To: <ggg91t$jtk$1@ger.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Using 2 Bridges Simultaneously for "Load Balancing"
Reply-To: andre.iost@gmxpro.de
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Thomas Mueller <thomas@chaschperli.ch>, Bridge@lists.linux-foundation.org

That was my first thought, but one of the two NICs doesn't seem to 
support that properly. I got the bond (without the bridge) up and 
running, but the additional (cheap) NIC wasn't used at all (I monitored 
the traffic via gkrellm). Pulling the plug out of the internal NIC 
resulted in the total loss of connectivity. That's not supposed to 
happen with a bond. I would have thought that the other NIC, in that 
case the additional one, would still provide network connection, albeit 
with reduced bandwidth.

Anyway, the proposal from Dietmar works perfectly now.



Thomas Mueller schrieb:
> 
>> Now I thought it was possible to create to of those bridges, each one
>> with one physical NIC. Then I could assign two virtual machines to each
>> bridge/NIC in order to balance or distribute the load.
> 
> if you just want load balancing/distribute the load on the two NIC's: why 
> dont you create a bond (some people/manufacturers  call it also "trunk" 
> or "LAG" ) out of physical NIC's and then bridge the bond?
> 
> http://www.mjmwired.net/kernel/Documentation/networking/bonding.txt
> http://www.debianhelp.co.uk/bonding.htm
> 
> - Thomas
> 
> 
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
