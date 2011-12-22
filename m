Return-Path: <shemminger@vyatta.com>
Date: Thu, 22 Dec 2011 08:45:21 -0800
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20111222084521.579beeae@nehalam.linuxnetplumber.net>
In-Reply-To: <b8003b95089e177b00bc7db44700757a@pl1.haspere.com>
References: <b8003b95089e177b00bc7db44700757a@pl1.haspere.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Invalid Argument when adding a bond to a bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: xmCM8KtKk25K@dyweni.com
Cc: NetDev <netdev@vger.kernel.org>, Bridge <bridge@lists.linux-foundation.org>, Bonding Devel <bonding-devel@lists.sourceforge.net>

On Thu, 22 Dec 2011 08:25:54 -0600
Dyweni - NetDev <xmCM8KtKk25K@dyweni.com> wrote:

>  Hi All,
> 
>  I need some help figuring this one out... Whenever I try to add a bond 
>  to a
>  bridge, I get back an invalid argument error. I've confirmed this on
>  3.2-rc6, 3.1.5, 3.0.13, and 2.6.39.4 (haven't checked earlier kernels).
> 
>  Here's my setup: 32bit KVM virtual machine with no network cards (... 
>  -net
>  none ... ).
> 
>  I created the bond with: echo "+x" > /sys/class/net/bonding_masters
> 
>  I created the bridge with: brctl addbr b
> 
>  I try to add the bond to the bridge with: brctl addif b x
> 

The bonding device inherits its MAC address from the slave
devices. Therefore until the you add a slave to the bonding device
it's MAC address isn't set (all zeros). Bridging is not allowed
without a valid MAC address.

The solution is to fully configure the bonding device before adding
to the bridge.
