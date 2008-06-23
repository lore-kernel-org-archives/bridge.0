Message-ID: <485FA8D4.5020007@navigue.com>
Date: Mon, 23 Jun 2008 09:44:52 -0400
From: Jonathan Thibault <jonathan@navigue.com>
MIME-Version: 1.0
References: <20080622140530.2091.qmail@f4mail-235-239.rediffmail.com>
In-Reply-To: <20080622140530.2091.qmail@f4mail-235-239.rediffmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Queries about Bridging
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.osdl.org

You normally should not assign an IP address (or dhcp) to the member 
interfaces, only the bridge interface.

Sibu Thomas Mathew wrote:
>
> Sir,
> I shared internet on a LAN using my machine. It has got two ethernet 
> cards. I installed Ubuntu 8.04. I did the bridging using 
> "bridge-utils". Even though it turned out to be successful, I came 
> across certain other problems:
> 1) I couldn't use the internet using my machine.
> 2) After every restart, I had to redo the whole bridging configuration.
>
> This is how i configured.
> The two ethernet cards are eth0 and eth1. eth1 is the one connected to 
> the internet. This is what I typed:
>     brctl addbr br0
>     brctl addif br0 eth0
>     brctl addif br0 eth1
>     ifconfig br0 up
> Then i edited the /etc/network/interfaces as follows:
>     auto lo
>     iface lo inet loopback
>
>     iface eth0 inet dhcp
>
>     auto eth1
>     iface eth1 inet dhcp
>
>     auto br0
>     iface br0 inet dhcp
>
> After that i restarted the service by typing
>         /etc/init.d/networking restart
> The bridging worked. The client machine could access the internet 
> except mine i.e. the server. Where did I go wrong? What can I do to 
> solve this.
>
> Looking forward for a solution.
> Thanking you.
>
> Yours sincerely,
> Sibu Thomas Mathew
>
>
>
> ------------------------------------------------------------------------
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge

