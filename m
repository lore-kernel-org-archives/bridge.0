Message-ID: <4D7A6853.3060000@gmail.com>
Date: Fri, 11 Mar 2011 19:22:11 +0100
From: =?UTF-8?B?Tmljb2xhcyBkZSBQZXNsb8O8YW4=?=
 <nicolas.2p.debian@gmail.com>
MIME-Version: 1.0
References: <1299788413.4801.20.camel@bordalnx> <4D793AB5.5030807@gmail.com>
	<1299800365.9834.10.camel@bordalnx>
In-Reply-To: <1299800365.9834.10.camel@bordalnx>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [Bonding-devel] bridge + bonding with arp monitoring
 enabled
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Leonardo Borda <leonardo.borda@canonical.com>
Cc: Zaid Al Hamami <zaid@canonical.com>, Bridge <bridge@lists.linux-foundation.org>, bonding-devel@lists.sourceforge.net

Le 11/03/2011 00:39, Leonardo Borda a écrit :
> Hi Nicolas,
>
> Thank you for your suggestion, it works.
> Actually I was thinking that in order to have arp monitoring
> (bond_arp_ip_target<ip>) enabled the bond0 interface had to have an ip
> address configured and as per tcpdump samples show that is not true.

We are working hard to keep even more complicated setups working properly.

For example, eth0 -> bond0 -> bond0.100, with the arp_ip_targets reachable through bond0.100 only.

	Nicolas.
