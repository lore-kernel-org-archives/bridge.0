Date: Wed, 11 Aug 2004 09:28:51 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] eth1394 interface support?
Message-Id: <20040811092851.43c57af7@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040811151631.GA12305@woobling.org>
References: <20040811151631.GA12305@woobling.org>
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
To: Yuval Kogman <nothingmuch@woobling.org>
Cc: bridge@lists.osdl.org

On Wed, 11 Aug 2004 18:16:31 +0300
Yuval Kogman <nothingmuch@woobling.org> wrote:

> I have a linux box which sits in the living room and plays
> ti^H^Hfreevo.
> 
> Among other things it also talks to the cable modem via interface
> eth0, and does NAT transformations for eth1.
> 
> Yesterday i was sitting in the living room with my laptop, thinking
> about the fact that my wireless access point will only arrive next
> week, and then remembered they both the laptop and the linux boxhave
> firewire. The plot thickens.
> 
> I enabled bridging support in the kernel, and i got to
> 
> 	brctl addbr br0
> 	brctl addif br0 eth1 # LAN interface
> 	brctl addif br0 eth2 # firewire interface
> 	br_add_interface: Invalid argument
> 
> I reckon eth1394 is at fault, but I'd like to know what the bridge
> code expects from it.

It must use ethernet link encapsulation: 6 byte dst, 6 byte src, 2 byte type.
But 1394 uses 8 byte dst, 2 byte type.  Obviously this can't be bridged.


The bridge checks this by looking at the device type (dev->type) to
check if it is ARPHD_ETHER.  For 1394 this is set to ARPHRD_IEEE1394.
