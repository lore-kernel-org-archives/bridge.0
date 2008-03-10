Message-ID: <47D55F3E.4030603@operations.com>
Date: Mon, 10 Mar 2008 12:18:06 -0400
From: Lou Steinberg <lspam5@operations.com>
MIME-Version: 1.0
References: <47D05B55.404@operations.com>	<2e59e6970803082338n20c9037p6ccae93654c58a69@mail.gmail.com>	<47D3ED21.6050903@operations.com>
	<20080310082655.2f9cd485@extreme>
In-Reply-To: <20080310082655.2f9cd485@extreme>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] bridge-utils and ppp
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: bridge@lists.linux-foundation.org

Stephen-

Stephen Hemminger wrote:

> 
> The bridging code only works for devices that have Ethernet headers.
> That is the way the bridging 802.2 standard works, it is a Layer 2 bridge
> and it uses the address information from Ethernet to do routing.
> 
> PPP does not use Ethernet level framing so it can't be bridged.
> What were you trying to do? there are plenty of other ways to get the
> same effect.

Makes sense, I suppose (The forwarding is complicated by a p-p link 
without a destination mac addr that looks like ethernet).  I expected 
that someone had built a table to do the mappings because the docs I 
referenced in the original post specifically say that ppp can be bridged.

What I'm trying to do is a simple/low latency forward from a vpn 
concentrator/firewall/router out to a cellular WAN modem that attaches 
to a USB.  My firewall lacks the USB interface so I simply need to 
forward packets between the USB and ethernet.  Am doing it now at layer 
3 (using iptables to do NAT) but that adds a lot of complexity and my 
firewall already does NAT (so it's happening twice).    I haven't yet 
tested an ipsec tunnel over the link, but am concerned that I may also 
need to add ipsec passthrough if I do this at layer 3.

All in all, a simple layer 2 forward between eth0 and ttyUSB0 is what I 
really need.

/Lou
