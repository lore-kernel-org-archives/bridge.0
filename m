Date: Thu, 17 Jun 2004 13:28:49 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Bridge code enhancement (link state detection) and bug
	fix. (patches included).
Message-Id: <20040617132849.0b64c799@dell_ss3.pdx.osdl.net>
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

Rather than add another state, it should just go to DISABLED state.


> To fix this I added link state monitoring to the code. This is only
> active when stp is turned on. When a link fails the bridge port goes to
> blocked and then to the new 'nolink' status. The bridge-utils patch
> makes it possible to see the status with brctl showstp.
> 
> I did encounter a second problem when writing the link monitoring code.
> When you add a vlan interface like eth0.10 then it's not possible to
> obtain link state information from this interface.


That is a VLAN problem, fix it there.  Sorry.


> The fix I wrote is that brctl now allows you to specify the interface
> that contains the link state.
> 
> Example : brctl addif NUM1 eth0.10 eth0

I prefer to eschew needless complexity.

That doesn't mean I won't consider adding it, but let me look at the problem
a little more before accepting your solution as is.
