Date: Mon, 28 Jun 2004 09:50:43 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-Id: <20040628095043.673526fa@dell_ss3.pdx.osdl.net>
In-Reply-To: <60214.202.63.115.3.1088434319.squirrel@rocsys.com>
References: <60214.202.63.115.3.1088434319.squirrel@rocsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: ethernet device xmit function is not gettting called
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: ravivsn@www.rocsys.com
Cc: linux-net@vger.kernel.org, bridge@osdl.org, ravivsn@rocsys.com

On Mon, 28 Jun 2004 20:21:59 +0530 (IST)
<ravivsn@www.rocsys.com> wrote:

> 
> Hi,
>  I wrote a module to create dummy ethernet device, the intention is to
> add it to a bridge and transmit modified packets. I get ethernet device
> created but its xmit function is not called when the bridge receives a
> packet.

The interface has to go through the Spanning Tree Protocol (STP) initialization
process to get into the forwarding state which takes a while
(and it has to be marked up).  Use 'brctl showstp br0' to see.

> I feel I have missed some information to register netdevice.
> 
> To add to bridge I did the following:
> brctl addbr br0
> brctl addif bro eth0
Typo, I assume you mean br0

> brctl addif br0 firsteth0
> ifconfig etho 0.0.0.0
Another typo. eth0

> ifconfig bro 172.16.2.100 up
> 
> When I try to add IP address to firsteth0, I get a kernel panic!!

Well since bridging is at the link, not network layer you shouldn't do that.
If it panic's send the console log (backtrace) and it will get fixed.

> Can we give IP to dummy ethernet device?

No, bridging is at layer 2 not layer 3. See the FAQ at http://bridge.sourceforge.net

> 
> Please help, I am given little time to complete this :( I am attaching
> the code for the dummy ethernet device.

How is this different from the existing dummy device which works fine
in a bridge?

