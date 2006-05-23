Date: Tue, 23 May 2006 11:06:24 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Problem bridging frames with bridge and real interface
	MTU	> 1527
Message-ID: <20060523110624.2984f2d5@localhost.localdomain>
In-Reply-To: <a9a0929d0605221737r17af6c16sd32d5f6717d274c0@mail.gmail.com>
References: <a9a0929d0605221737r17af6c16sd32d5f6717d274c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Mark Zipp <mark.r.zipp@gmail.com>
Cc: bridge@osdl.org

On Tue, 23 May 2006 10:07:13 +0930
"Mark Zipp" <mark.r.zipp@gmail.com> wrote:

> Hi,
> 
> I'm doing some fault finding where we suspect that the (non-linux)
> device with the fault is generating frames with an MTU / maximum size
> greater than 1500 / 1518 bytes. This device is performing GRE
> tunneling, and it seems that it isn't performing fragmentation or
> PMTUD before it attempts to send a normal, 1500 byte IP packet with
> the GRE header out a GigE interface with a 1500 byte MTU.
> 
> I've been asked by the vendor of this device to perform some packet
> captures. As I have a Linux box with a couple of interfaces that
> support > 1500 byte MTUs (an Intel GigE, and a Netgear FA311 (that
> supports an MTU up to 2024 bytes)), I figured I could bridge this
> traffic through this Linux box, and then perform some packet captures
> on the bridge virtual interface.
> 
> I set that all up, and it seemed to all be ok. I set both the real
> interface MTUs to 2024 bytes, and when I added them into a bridge, the
> bridge inherited this MTU.
> 
> Unfortunately I found that when I attempted to forward frames through
> this bridge configuration, certain sized ones were silently dropped.
> As the devices attached to the bridge shouldn't be generating frames
> with an MTU larger than 1500 (this is our work around solution as a
> reference), it seems that with this 2024 bridge MTU, even normal 1500
> byte MTU frames are dropped.
> 
> Through experimentation, by sending packets  and changing the MTU of
> the real and bridge interfaces, it seems that the bridge will only
> forward frames up to 1527 bytes MTU. Fortunately I think this will be
> enough to diagnose the fault we are having.
> 
> Is this expected behaviour ? A maximum of 1527 bytes seems to be an
> unsual value for the maxiumum supported bridge MTU.

The only bridge related dropping is here in br_forward.c

int br_dev_queue_push_xmit(struct sk_buff *skb)
{
	/* drop mtu oversized packets except tso */
	if (packet_length(skb) > skb->dev->mtu && !skb_shinfo(skb)->tso_size)
		kfree_skb(skb);

Are you doing VLAN's?  There was a bug not fixed until 2.6.17 that didn't
account for VLAN header properly.

Are you doing filtering?  Some netfilter module might be dropping the packets.
