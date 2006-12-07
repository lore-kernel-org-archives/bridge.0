Message-ID: <34d8b2fe0612070918k63845693hd57936ad17e2e53b@mail.gmail.com>
Date: Thu, 7 Dec 2006 18:18:12 +0100
From: "Louis Croisez" <louis.croisez@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Bridge] Help needed about IP class finding in a bridge netfilter
	module
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi,
i am currently trying to code a little netfilter plugin, to be placed
into the bridge forwarding path.
In such plugin, i would like to test if a packet is:
- unicast
- multicast
- broadcast

The starting condition is that the bridge has no knowledge of the IP
configuration of the sending and receiving stations. It does not know
about their netmask e.g.

I have tried the following function (from 2.6 kernel):
inet_addr_type(u32 addr), but it always return RTN_UNICAST, and never
RTN_MULTICAST, RTN_BROADCAST.
 For example, for this address: 10.255.255.255 it returns RTN_UNICAST.

How could the bridge decide in which class is the destination IP of a
skb, and what is my error?

Thx in advance.
LOUIS
