Message-ID: <4D8DDA06.4040704@gmail.com>
Date: Sat, 26 Mar 2011 13:20:22 +0100
From: =?UTF-8?B?Tmljb2xhcyBkZSBQZXNsb8O8YW4=?=
 <nicolas.2p.debian@gmail.com>
MIME-Version: 1.0
References: <1300302933.1462.5.camel@bordalnx> <4D8121EF.3030200@free.fr>
	<1300914794.32252.68.camel@bordalnx>
In-Reply-To: <1300914794.32252.68.camel@bordalnx>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [Bonding-devel] bonding inside a bridge does not work
 when using arp monitoring
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Leonardo Borda <leonardo.borda@canonical.com>
Cc: Jiri Pirko <jpirko@redhat.com>, Bridge <bridge@lists.linux-foundation.org>, bonding-devel@lists.sourceforge.net, "netdev@vger.kernel.org" <netdev@vger.kernel.org>

Le 23/03/2011 22:13, Leonardo Borda a écrit :
> Hi Nicolas,
>
> Thank you for answering my question.
> Actually this is what I want to achieve:
>
> eth0----+               +----bond0.100----br0-100---{+virtual machines
>            |             |
>            +----bond0----+----br0---(LAN)
>            |             |
> eth1----+               +----bond0.200----br0-200---{+virtual machines

Hi Leonardo,

I'm not sure recent kernels allow for a given interface to be a port for a bridge and the base 
interface for vlan interfaces at the same time. This might be particularly true for 2.6.38 or 
2.6.38+, because of the new rx_handler usage.

cc: netdev and Jiri Pirko, for advices. For the history of the thread, see:

http://sourceforge.net/mailarchive/forum.php?thread_name=1300914794.32252.68.camel%40bordalnx&
forum_name=bonding-devel

> br0 -->  br0 in my understanding is an untagged vlan therefore it
> provides access to my LAN. So i am able to access that server from my
> internal network.
> br0-100 and br0-200 ->  Vlans over a bridged interface will allow me to
> have many virtual machines in the same vlan on each bridged interface.
>
> I am misunderstanding concepts, maybe?
> If you need to do further tests I have a test environment ready for use.
>
> Leonardo
