From: Bart De Schuymer <bdschuym@pandora.be>
Date: Thu, 5 Aug 2004 08:12:45 +0200
References: <200408042254.41978.bdschuym@pandora.be>
	<Pine.LNX.4.44.0408042300540.18907-100000@filer.marasystems.com>
	<33159.199.107.159.238.1091683285.squirrel@www.osdl.org>
In-Reply-To: <33159.199.107.159.238.1091683285.squirrel@www.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408050812.45887.bdschuym@pandora.be>
Subject: [Bridge] Re: Any way of knowing a packet's been defragmented
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: shemminger@osdl.org, Henrik Nordstrom <hno@marasystems.com>
Cc: netfilter-devel <netfilter-devel@lists.netfilter.org>, bridge <bridge@osdl.org>

On Thursday 05 August 2004 07:21, shemminger@osdl.org wrote:
> > Well.. iptables does not really care why the packet is oversized. It
> > fragments any oversized packets.
> >
> > Why does the bridge need to?
>
> The bridge doesn't even know it's IP.  The there appears to be some
> ebtables code path that defragments packets, and in the process can
> decide to send a skb greater than the MTU of the device. Because of
> recent changes to allow bridging of an MTU size (previous limit was always
> 1500), the bridge now drops skb if skb->len > dev->mtu.
>
> Perhaps the problem is that ebtables filter is defragments because it
> is looking at the mtu of the incoming interface?

It has nothing to do with ebtables. It's all about connection tracking of ipv4 
packets on a transparent bridging firewall. Ct defragments packets, on the 
ipv4 PREROUTING hook, because it makes things easier. Ct on a transparent 
bridge is something people need.

cheers,
Bart

