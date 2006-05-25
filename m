Date: Thu, 25 May 2006 09:14:44 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20060525091444.46634df8@localhost.localdomain>
In-Reply-To: <c49421c50605250704w2b1c2d52v19d809fa104a3999@mail.gmail.com>
References: <c49421c50605250704w2b1c2d52v19d809fa104a3999@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] loosing network connectivity
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Loreno Oliveira <lorenooliveira@gmail.com>
Cc: bridge@lists.osdl.org

On Thu, 25 May 2006 11:04:39 -0300
"Loreno Oliveira" <lorenooliveira@gmail.com> wrote:

> Hi folks,
> 
> I'm new on brctl and didn't find the archive of this list, so, sorry if my
> question was previously answered.
> 
> Well, my problem is: when I run "brctl addif pan0 eth0" my network
> connection is lost. If I execute "brctl delif pan0 eth0" the connection is
> restablished.

Looks like dhcp changes the address during your script.
Before putting eth0 in bridge it stands alone. Afterwards,
it is doing NAT.

> Does anyone knows what is missing here??
> My full script is typed bellow.
> 
> Thanks in advance for any help
> 
> Loreno
> 
> --------------------------------------------------------------------
> 
> # Make a Bridge
> brctl addbr pan0
> 
> # Assign IP address
> ifconfig pan0 192.168.10.1
This is silly because you run dhcp below.


> # Disable Listening and learning states
> brctl setfd pan0 0
> 
> # Disable Spanning Tree Protocol
> brctl stp pan0 off
> 
> # Adding pan0 to gateway
> brctl addif pan0 eth0
> 
> # Flush all the rules in filter and nat tables
> /sbin/iptables --flush
> /sbin/iptables --table nat --flush
> 
> # Delete all chains that are not in default filter and nat table
> /sbin/iptables --delete-chain
> /sbin/iptables --table nat --delete-chain
> 
> # Set up IP Forwarding and Masquerading
> /sbin/iptables --table nat --append POSTROUTING --out-interface eth0 -j
> MASQUERADE
> 
> # Assuming one NIC to local LAN
> /sbin/iptables --append FORWARD --in-interface pan0 -j ACCEPT
> 
> # Enables packet forwarding by kernel
> 
> echo 1 > /proc/sys/net/ipv4/ip_forward
> 
> # Setting bluetooth AP
> 
> /usr/bin/pand --listen --role NAP
> 
> # Starting DHCP
> 
> dhcpd3 pan0
