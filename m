Date: Fri, 27 Feb 2009 21:54:40 +0100
From: Udo Hortian <udo_hortian@web.de>
Message-ID: <20090227205440.GA31504@an>
References: <20090222123249.GA21690@an>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090222123249.GA21690@an>
Sender: udo_hortian@web.de
Subject: Re: [Bridge] Bridging problems after Upgrade to Debian Lenny
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

On Sun, Feb 22, 2009 at 01:32:49PM +0100, Udo Hortian wrote:
> Hello all,
> 
> I subscribed newly to this list, since I got an bridging problem after an
> upgrade from Debian etch to Debian lenny (before everything worked fine).
> 
> The situation is as follows:
> 
> # brctl show
> bridge name     bridge id               STP enabled     interfaces
> br0             8000.000347729835       no              eth0
>                                                         tap0
> 
> tap0 is associated with an OpenVPN tunnel.
> 
> The strange thing now is the following:
> 
> Packets from eth0 to IP addresses within tap0 pass the bridge and reach
> the destination (the other side of an OpenVPN tunnel).
> 
> But packets from the other side of the OpenVPN tunnel do not reach
> destinations behind eth0. I think this is not an OpenVPN problem, since
> I can see packets, as described here, using "tcpdump -i tap0" and also
> using "tcpdump -i br0". But I do not see them using "tcpdump -i eth0".
> 
> The only thing which happens is that there are sometimes packets like
> this on eth0: "igmp v3 report, 1 group record(s)" (from tcpdump) with
> source address the one from the OpenVPN client. I do now know where
> these packets come from.
> 
> There is now firewall activated.
> 
> Here are a few informations about my system:
> Debian lenny
> Linux 2.6.18-6-686 (Debian Kernel)
> bridge-utils 1.4-5 (Debian packet)
> 
> Any ideas what might be the reason for this and how to solve it?
I found the problem:

There was a config line 

push "route 10.0.0.0 255.255.255.0"

in the OpenVPN configuration. This caused dos routing table entries at
the client side (the other side of the OpenVPN tunnel):

route -n
10.0.0.0        10.0.0.1        255.255.255.0   UG    0      0        0 tap0
10.0.0.0        0.0.0.0         255.255.255.0   U     0      0        0 tap0
[...]

Since we do bridging we do not want the route containing the gateway
10.0.0.1 (which is the OpenVPN Server running the bridge).

Deleting this route solves the problem and deleting the line mentioned
above in the configuration file solves the problem (without it, this
route entry will not be generated).

Udo
