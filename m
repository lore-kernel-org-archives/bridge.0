From: Thomas Mueller <thomas@chaschperli.ch>
Date: Tue, 25 Nov 2008 07:21:33 +0000 (UTC)
Message-ID: <ggg91t$jtk$1@ger.gmane.org>
References: <492A8A22.1090509@gmxpro.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: news <news@ger.gmane.org>
Subject: Re: [Bridge] Using 2 Bridges Simultaneously for "Load Balancing"
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@osdl.org



> 
> Now I thought it was possible to create to of those bridges, each one
> with one physical NIC. Then I could assign two virtual machines to each
> bridge/NIC in order to balance or distribute the load.

if you just want load balancing/distribute the load on the two NIC's: why 
dont you create a bond (some people/manufacturers  call it also "trunk" 
or "LAG" ) out of physical NIC's and then bridge the bond?

http://www.mjmwired.net/kernel/Documentation/networking/bonding.txt
http://www.debianhelp.co.uk/bonding.htm

- Thomas


