Date: Fri, 16 Jul 2004 16:28:55 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Bridge code enhancement (link state detection) and bug
	fix. (patches included).
Message-Id: <20040716162855.52d91672@dell_ss3.pdx.osdl.net>
In-Reply-To: <40D1E993.3060801@siennax.com>
References: <40D1E993.3060801@siennax.com>
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
To: Mark Ruijter <bridge@siennax.com>
Cc: bridge@lists.osdl.org

On Thu, 17 Jun 2004 20:57:23 +0200
Mark Ruijter <bridge@siennax.com> wrote:

> 
> 1. Link state monitoring added.
> We discovered the following problem with the existing bridge code.
> The code doesn't monitor the link state of the interfaces. When using
> two cisco switches with two Linux bridging firewalls the following
> problem exists. When the Cisco switch that has the blocking (stp) Linux
> bridge attached dies, the Linux bridge no longer receives stp packets
> and changes it's state from blocking to forwarding. As soon as the Cisco
> switch comes back alive a loop is created in the network for a short but
> long enough period of time. :-(
> 
> To fix this I added link state monitoring to the code. This is only
> active when stp is turned on. When a link fails the bridge port goes to
> blocked and then to the new 'nolink' status. The bridge-utils patch
> makes it possible to see the status with brctl showstp.
> 

Could you split out the link state monitoring, and look at bonding to see
how they are doing it?

I have a fix for vlan code that passes MII and ethtool requests from the virtual
to physical device, so the bridge code wouldn't need to the hack about root device.

