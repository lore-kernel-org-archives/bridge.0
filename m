Date: Sat, 26 Mar 2011 15:01:16 +0100
From: Jiri Pirko <jpirko@redhat.com>
Message-ID: <20110326140115.GA2882@psychotron.redhat.com>
References: <1300302933.1462.5.camel@bordalnx> <4D8121EF.3030200@free.fr>
	<1300914794.32252.68.camel@bordalnx> <4D8DDA06.4040704@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4D8DDA06.4040704@gmail.com>
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
To: Nicolas de =?iso-8859-1?Q?Peslo=FCan?= <nicolas.2p.debian@gmail.com>
Cc: Bridge <bridge@lists.linux-foundation.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, bonding-devel@lists.sourceforge.net

Sat, Mar 26, 2011 at 01:20:22PM CET, nicolas.2p.debian@gmail.com wrote:
>Le 23/03/2011 22:13, Leonardo Borda a =E9crit :
>>Hi Nicolas,
>>
>>Thank you for answering my question.
>>Actually this is what I want to achieve:
>>
>>eth0----+               +----bond0.100----br0-100---{+virtual machines
>>           |             |
>>           +----bond0----+----br0---(LAN)
>>           |             |
>>eth1----+               +----bond0.200----br0-200---{+virtual machines
>
>Hi Leonardo,
>
>I'm not sure recent kernels allow for a given interface to be a port
>for a bridge and the base interface for vlan interfaces at the same
>time. This might be particularly true for 2.6.38 or 2.6.38+, because
>of the new rx_handler usage.

This topology is not legit and should/will be prohibited.

Only consider that you have + br0.100 device on top of br0. Where should
the packet go?

I suggest to consider topology change.

>
>cc: netdev and Jiri Pirko, for advices. For the history of the thread, see:
>
>http://sourceforge.net/mailarchive/forum.php?thread_name=3D1300914794.3225=
2.68.camel%40bordalnx&
>forum_name=3Dbonding-devel
>
>>br0 -->  br0 in my understanding is an untagged vlan therefore it
>>provides access to my LAN. So i am able to access that server from my
>>internal network.
>>br0-100 and br0-200 ->  Vlans over a bridged interface will allow me to
>>have many virtual machines in the same vlan on each bridged interface.
>>
>>I am misunderstanding concepts, maybe?
>>If you need to do further tests I have a test environment ready for use.
>>
>>Leonardo
