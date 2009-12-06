MIME-Version: 1.0
Date: Sun, 06 Dec 2009 21:14:11 +0100
From: Sander Klein <roedie@roedie.nl>
In-Reply-To: <2e59e6970912060917j4790f521i6e50b17f92e9daff@mail.gmail.com>
References: <7a0b4b1b5dc484f5e0c2f619d4bfb804@localhost>
	<2e59e6970912060917j4790f521i6e50b17f92e9daff@mail.gmail.com>
Message-ID: <890fdfae46cdf0cb9e62134adfde677a@localhost>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Bridge] Bridge - vlan - bond
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: richardvoigt@gmail.com
Cc: Bridge <bridge@lists.linux-foundation.org>

Hi,

On Sun, 6 Dec 2009 11:17:56 -0600, "richardvoigt@gmail.com"
<richardvoigt@gmail.com> wrote:
> Are any of your VLANs transparently bridged together elsewhere in the
> network?

No.
 
> When you see the arp packet twice in wireshark, is it in the same VLAN
> both times?

I see the packet twice in the bridge interface which is on top of the
bond0.101 interface. When sniffing the bond0.101 interface I only see the
packet once. Sniffing the bond0 interface doesn't show anything and
sniffing eth0 show the arp traffic only once, which I'm not sure if this is
normal. Sniffing on eth1 shows no traffic at all which is to be expected
since it is in backup state.

> I believe you can also use some of the logging actions in iptables to
> list which physical port (of the bonding members) a particular packet
> arrived on.

I'll have a look at this. But since I do not think the packet comes from
the network. I really think the bridge has something to do with it.

Greets,

Sander
