Date: Mon, 2 Aug 2004 15:42:21 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Bridge not bridging NFS fragments?
Message-Id: <20040802154221.5c6a59de@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040802223329.GA21577@merlin.emma.line.org>
References: <20040801124629.GA11603@merlin.emma.line.org>
	<200408022322.00768.bdschuym@pandora.be>
	<20040802152516.7a76bb63@dell_ss3.pdx.osdl.net>
	<20040802223329.GA21577@merlin.emma.line.org>
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
To: Matthias Andree <matthias.andree@gmx.de>
Cc: bridge@osdl.org, Matthias Andree <matthias.andree@gmx.de>, Bart De Schuymer <bdschuym@pandora.be>

On Tue, 3 Aug 2004 00:33:29 +0200
Matthias Andree <matthias.andree@gmx.de> wrote:

> On Mon, 02 Aug 2004, Stephen Hemminger wrote:
> 
> > I am worried what happens if you bridge a 4K mtu lan to a 1500 mtu lan..
> > It is likely that the ethernet driver of the smaller mtu lan will oops or
> > hang while trying to send the huge skb. No other code path would hand
> > a huge mtu to a device.
> 
> Is this something that can be simulated in ethernet, by setting one
> net's MTU to 500 or something?

You could set the mtu smaller, but the hardware still would accept
bigger packets. A simple test would be to setup something like a tun or tap
connection bridged to an ethernet device.
