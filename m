Message-ID: <4D748CC3.8060603@gmail.com>
Date: Mon, 07 Mar 2011 08:44:03 +0100
From: =?UTF-8?B?Tmljb2xhcyBkZSBQZXNsb8O8YW4=?=
 <nicolas.2p.debian@gmail.com>
MIME-Version: 1.0
References: <1649722795.14144.1299480074110.JavaMail.root@tahiti.vyatta.com>
In-Reply-To: <1649722795.14144.1299480074110.JavaMail.root@tahiti.vyatta.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH 1/2] Issue NETDEV_CHANGE notification when
 bridge changes state
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen.hemminger@vyatta.com>
Cc: Jay Vosburgh <fubar@us.ibm.com>, "Pekka Savola (ipv6)" <pekkas@netcore.fi>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, James Morris <jmorris@namei.org>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, "David S. Miller" <davem@davemloft.net>, Adam Majer <adamm@zombino.com>

Le 07/03/2011 07:41, Stephen Hemminger a écrit :
>
>> On Sun, Mar 06, 2011 at 09:45:41AM -0800, Stephen Hemminger wrote:
>>> Since this a generic problem, it needs a better solution.
>>> Sending NETDEV_CHANGE impacts lots of other pieces, and even
>>> user space has similar problems.
>>
>> It does seem a little broad notification type. I've checked over
>> all the currently defined NETDEV notifiers, and it seems that
>> NETDEV_NOTIFY_PEERS may be a better option to use when bridge
>> has a potential topology change.
>>
>> Currently it is only used in ipv4/devinet.c: where it is used to issue
>> a gratuitous ARP.
>
> I was thinking of fixing bridge to not actually bring the link
> up until in forwarding mode. Other applications (DHCP, etc)
> see the link up and really don't like being in half duplex
> during that period.

I think it is the right way to manage this situation. And bonding should behave the same, if not 
already true.

	Nicolas.
