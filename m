Date: Thu, 23 Feb 2006 10:27:31 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] physical interface on a bridge
Message-ID: <20060223102731.5756f778@localhost.localdomain>
In-Reply-To: <005601c63854$a2fdace0$0f01a8c0@tungemaskin>
References: <01f701c63728$6203bef0$4a27b3d5@tungemaskin>
	<20060221141743.32d66879@localhost.localdomain>
	<003101c6378b$f5f65060$4a27b3d5@tungemaskin>
	<20060222080250.363d5e30@localhost.localdomain>
	<005601c63854$a2fdace0$0f01a8c0@tungemaskin>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: =?UTF-8?B?SsO4cmdlbg==?= Hovland <jorgen@hovland.cx>
Cc: bridge@lists.osdl.org

On Thu, 23 Feb 2006 09:39:18 +0100
Jørgen Hovland <jorgen@hovland.cx> wrote:

> (sorry about the empty last email)
> 
> ----- Original Message ----- 
> From: "Stephen Hemminger" <shemminger@osdl.org>
> 
> > On Wed, 22 Feb 2006 09:42:49 +0100
> > Jørgen Hovland <jorgen@hovland.cx> wrote:
> >
> >> So there is no way to get the physical interface from a mac address?
> >
> > You can read the forwarding database (see brctl sources for how).
> > But the value can change as result of traffic.
> >
> 
> 
> I did actually look at the code before I emailed the list. Sorry if I am 
> missing something, but a fdb_entry maps a hardware address to a port number. 
> This arbitary port number points to the port_info structure which seems to 
> only hold information about what bridge it belongs to. And the bridge_info 
> structure doesn't contain any information either.
> The only place I can find something that might be useful is in 
> linux/netdevice.h and the "struct net_bridge_port  *br_port" under the 
> net_device structure. This is inside the kernel as it needs __KERNEL__ 
> defined in order to use it, or is this what I am looking for?
> 
> Thank you once again
> 
> Joergen 

The old way is to do ioctl() SIOCDEV_PRIVATE with BRCTL_GET_BRIDGES
and that gives a table of ifindices, you can use that to map port -> ifindex -> etherdevice

Newer way is to look in directory:
	/sys/class/net/brX/brif
It has symlinks to the devices that are being bridged.
	/sys/class/net/eth0/brport/port_id
contains the portid of eth0 in what ever bridge it is in.
