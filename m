Date: Wed, 8 Oct 2003 09:33:54 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: [Bridge] RE: [VLAN] Re: [PATCH/RFC] Let {ip, arp}tables "see"
	bridged VLAN tagged{I,AR}P packets
Message-Id: <20031008093354.265b34a5.davem@redhat.com>
In-Reply-To: <3F843C8C.4030100@candelatech.com>
References: <5B537508CDBED3118403009027745A210B8C14A1@knant18.kna.flextronics.com>
	<3F843C8C.4030100@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Ben Greear <greearb@candelatech.com>
Cc: netdev@oss.sgi.com, vlan@wanfear.com, bridge@osdl.org, tommy.christensen@tpack.net

On Wed, 08 Oct 2003 09:34:20 -0700
Ben Greear <greearb@candelatech.com> wrote:

> So, what good is skb_share_check then?
> Maybe we should have a skb_share_or_cloned_check() ?

What input handlers are supposed to do is first:

	skb = skb_share_check(...);


then look at packet contents etc., then if they need to write
to the header do something like skb_cow().

The best example, as usual, is ipv4 input.  Look at how ip_rcv()
makes sure it can safely get at the packet header parts it needs
to parse, then look at ip_forward and how it cows the IPV4 header
so it can modify the TTL field.
