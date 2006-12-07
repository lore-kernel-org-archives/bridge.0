Message-ID: <ec7cefb0612071133r8117db8m1db014f1e2783f6e@mail.gmail.com>
Date: Thu, 7 Dec 2006 11:33:08 -0800
From: "Eric Brower" <ebrower@gmail.com>
In-Reply-To: <34d8b2fe0612070918k63845693hd57936ad17e2e53b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <34d8b2fe0612070918k63845693hd57936ad17e2e53b@mail.gmail.com>
Subject: Re: [Bridge] Help needed about IP class finding in a bridge
	netfilter module
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Louis Croisez <louis.croisez@gmail.com>
Cc: bridge@lists.osdl.org

On 12/7/06, Louis Croisez <louis.croisez@gmail.com> wrote:
> Hi,
> i am currently trying to code a little netfilter plugin, to be placed
> into the bridge forwarding path.
> In such plugin, i would like to test if a packet is:
> - unicast
> - multicast
> - broadcast
>
> The starting condition is that the bridge has no knowledge of the IP
> configuration of the sending and receiving stations. It does not know
> about their netmask e.g.
>
> I have tried the following function (from 2.6 kernel):
> inet_addr_type(u32 addr), but it always return RTN_UNICAST, and never
> RTN_MULTICAST, RTN_BROADCAST.
>  For example, for this address: 10.255.255.255 it returns RTN_UNICAST.
>
> How could the bridge decide in which class is the destination IP of a
> skb, and what is my error?

The bridge can't discriminate between broadcast and unicast because
you have no routing table entries (netmasks) to associate with the
destination address.  You could hack-in a class A/B/C match yourself,
but with CIDR (RFC 1519) the world does not work that way any longer.

Based on the code I would suggest multicast addresses would be matched
(have you tried to ping 224.0.0.1 [all hosts mcast] to see if it is
properly classified?).  For the locally-destined packets you could
maintain static routing table entries on your system, if that is
tenable in your environment.

You might be able to obtain this information via RMON from your
routers, if this is not a science project.

-- 
E
