Date: Mon, 20 Dec 2010 10:37:54 -0800
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20101220103754.7d18de50@s6510>
In-Reply-To: <4D0E868E.4010309@wanadoo.nl>
References: <4D0E868E.4010309@wanadoo.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Why should static MAC address match one of the port
 MAC addresses - bug?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Rolf Fokkens <rolf.fokkens@wanadoo.nl>
Cc: bridge@lists.linux-foundation.org

On Sun, 19 Dec 2010 23:26:22 +0100
Rolf Fokkens <rolf.fokkens@wanadoo.nl> wrote:

> Hi All,
> 
> Despite of what Stephen explains, I'm having the problem Michiel 
> describes as well. I have a bridge br2 containing 1 (but potentially 
> more) tap interface for kvm. Windows 7 VM doesn't like the bridge mac 
> address to change, so I try to make it fixed.
> 
> ifconfig br2 hw ether 02:00:00:00:01:02
> 
> Interface br2 becomes instantly unreachable from the VM (via the tap 
> interface). No arp response or anything else.
> 
> So, Michiel's claim seems to be true: the bridge mac address should 
> apparently be one of the bridge interfaces. But I don't see the logic, 
> this seems like a bug to me.
> 
> kernel is Fedora kernel-2.6.35.9-64.fc14.x86_64.
> 
> Cheers,
> 
> Rolf

The address you change the address, it is like you changed the MAC address
of a card on the network. Windows ARP cache is no longer valid and has
to time out. 

