Date: Sun, 28 Oct 2007 22:12:28 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [Bridge] Small packets
Message-ID: <20071028221228.3b0fc91a@shemminger-desktop>
In-Reply-To: <96CF49BD8B56384395D698BA99007FA32D05@exchange.pacwire.local>
References: <96CF49BD8B56384395D698BA99007FA32D05@exchange.pacwire.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Leigh Sharpe <lsharpe@pacificwireless.com.au>
Cc: bridge@lists.linux-foundation.org

On Mon, 29 Oct 2007 15:37:52 +1100
"Leigh Sharpe" <lsharpe@pacificwireless.com.au> wrote:

> Hi All,
>  I have a bridge set up thusly:
>  
>  
> brctl addbr br0                                 # Create the bridge.
> 
> brctl addif br0 eth2                            # Add eth2
> brctl addif br0 eth3                            # And eth3
> 
> brctl setfd br0 0                               # Forward immediately.
> 
> brctl stp br0 off                               # Turn off Spanning
> Tree.
> 
> ifconfig eth2 up                                # bring up eth2
> ifconfig eth3 up                                # Bring up eth3
> ifconfig br0 up                                 # Bring up the bridge.
> 
> Which seems to bridge OK. However, I have noticed that the bridge
> appears to be truncating some packets. In particular, I am worried
> about packets such as IP ACK's, which are entering the bridge as
> 64-byte packets, but coming out the other side as 60-byte packets.
> As I recall, the smallest valid ehternet packet is 64 bytes. The
> bridge seems to be removing any padding in the packet and sending it
> on it's way as a packet smaller than the minimum ethernet packet
> size. Looking at the packet distribution on other devices connected
> to the bridge, it seems to be doing the same to lots of other
> packets, too. Anybody got any idea why the bridge might be truncating
> packets? Any idea why it's sending 60-byte packets, when the minimu
> should be 64? Or where to tell it to pad all packets out to 64 bytes?
>  
>  
> Leigh.
>  
>  
>  
>  
> Regards,
>              Leigh
>  
> Leigh Sharpe
> Network Systems Engineer
> Pacific Wireless
> Ph +61 3 9584 8966
> Mob 0408 009 502
> Helpdesk 1300 300 616
> email lsharpe@pacificwireless.com.au
> <blocked::mailto:lsharpe@pacificwireless.com.au> 
> web www.pacificwireless.com.au
> <blocked::http://www.pacificwireless.com.au/> 
>  

What hardware? It could be a driver bug.
Also if you use VLAN's then the driver may send 60 byte packet (because
of the 4 byte VLAN tag).
