Message-ID: <33159.199.107.159.238.1091683285.squirrel@www.osdl.org>
In-Reply-To: <Pine.LNX.4.44.0408042300540.18907-100000@filer.marasystems.com>
References: <200408042254.41978.bdschuym@pandora.be>
	<Pine.LNX.4.44.0408042300540.18907-100000@filer.marasystems.com>
Date: Wed, 4 Aug 2004 22:21:25 -0700 (PDT)
From: shemminger@osdl.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [Bridge] Re: Any way of knowing a packet's been defragmented
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Henrik Nordstrom <hno@marasystems.com>
Cc: bridge <bridge@osdl.org>, netfilter-devel <netfilter-devel@lists.netfilter.org>, Bart De Schuymer <bdschuym@pandora.be>

> On Wed, 4 Aug 2004, Bart De Schuymer wrote:
>
>> Due to a recent change in the bridge code, we now need a way of knowing
>> if
>> a packet has been defragmented. The bridge code now checks on the packet
>> size and drops packets that are too big for the output port.
>> Defragmented
>> packets will get refragmented later, so they shouldn't be dropped.
>
> Well.. iptables does not really care why the packet is oversized. It
> fragments any oversized packets.
>
> Why does the bridge need to?
>

The bridge doesn't even know it's IP.  The there appears to be some
ebtables code path that defragments packets, and in the process can
decide to send a skb greater than the MTU of the device. Because of
recent changes to allow bridging of an MTU size (previous limit was always
1500), the bridge now drops skb if skb->len > dev->mtu.

Perhaps the problem is that ebtables filter is defragments because it
is looking at the mtu of the incoming interface?
