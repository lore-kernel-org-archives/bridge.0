From: Bart De Schuymer <bdschuym@pandora.be>
In-Reply-To: <BB501CE635E5144CA5E30956E5E32C52271F0F@exchange-be5.lancs.local>
References: <BB501CE635E5144CA5E30956E5E32C52271F0E@exchange-be5.lancs.local>
	<BB501CE635E5144CA5E30956E5E32C52271F0F@exchange-be5.lancs.local>
Content-Type: text/plain
Date: Sat, 07 Apr 2007 16:16:19 +0200
Message-Id: <1175955379.2974.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Performance loss with bridging+routing.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Egi, Norbert" <n.egi@lancaster.ac.uk>
Cc: bridge@lists.osdl.org

Op do, 15-03-2007 te 17:59 +0000, schreef Egi, Norbert:
> Sorry, it looks like the spaces have different sizes in my mailing
> system. I hope the graphs are more readable now.

The performance drop comes from the fact that your routed traffic is
buffered twice. The first time before the bridge code gets its hands on
it, the second time when the bridge code decides the packet is destined
for the bridge itself and sends it back to the buffer. I've at times
wondered if it were feasible and acceptable to get rid of this second
buffering... At first glance it seems quite feasible, but maybe it would
cause performance trouble elsewhere. Dunno...
You can probably circumvent the performance drop using the ebtables
brouting chain. See
http://ebtables.sourceforge.net/examples/example2.html

cheers,
Bart

PS: try to make your mailer cut lines @ 78 characters when sending
messages to Linux lists


