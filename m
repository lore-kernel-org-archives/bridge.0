Subject: Re: [Bridge] bridging bluetooth bnep devices with kernel 2.6.6-*
From: Diego Liziero <diego.liziero@unimore.it>
In-Reply-To: <20040518153310.6ca39ef5@dell_ss3.pdx.osdl.net>
References: <1084467136.3083.27.camel@igno>
	<20040513102829.5d5e1484@dell_ss3.pdx.osdl.net>
	<1084472140.3354.9.camel@igno> <1084788177.21864.54.camel@igno>
	<20040518153310.6ca39ef5@dell_ss3.pdx.osdl.net>
Content-Type: text/plain
Message-Id: <1084959245.6454.34.camel@igno>
Mime-Version: 1.0
Date: Wed, 19 May 2004 11:34:05 +0200
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bluez-devel@lists.sourceforge.net, bridge@lists.osdl.org, Diego Liziero <liziero.diego@unimore.it>

Thanks for your help.

I forgot to mention the steps I did to setup the bridge.

I have 2 ethernet cards, eth0->to internet,
eth1->192.168.* natted lan.

I'm using a Debian with hotplug and in
/etc/network/interfaces I have the following lines:

iface pan0 inet static
        pre-up brctl addbr pan0
        pre-up brctl addif pan0 eth1
        pre-up ifconfig eth1 0.0.0.0
        address 192.168.111.1
        netmask 255.255.255.0
        up brctl setfd pan0 0
        up brctl stp pan0 disable
        up /etc/init.d/dhcp3-server restart
        post-down brctl delbr pan0
        post-down ifconfig eth1 192.168.111.1 netmask 255.255.255.0
        post-down /etc/init.d/dhcp3-server restart
                                                                                                                             iface bnep0 inet static
        address 192.168.111.70
        netmask 255.255.255.0
        pre-up brctl addif pan0 $IFACE
        up ifconfig $IFACE 0.0.0.0
        down brctl delif pan0 $IFACE

iface bnep1 inet static
        address 192.168.111.71
        netmask 255.255.255.0
        pre-up brctl addif pan0 $IFACE
        up ifconfig $IFACE 0.0.0.0
        down brctl delif pan0 $IFACE

When the first PDA is connected I get the following in the syslog:

net.agent[7222]: invoke ifup bnep0=hotplug
kernel: device bnep0 entered promiscuous mode
pand[7220]: New connection from 00:80:C8:1F:E3:77 bnep0
kernel: pan0: port 2(bnep0) entering learning state
kernel: pan0: topology change detected, propgating
kernel: pan0: port 2(bnep0) entering forwarding state
dhcpd: DHCPREQUEST for 192.168.111.171 from 00:80:c8:1f:e3:77 via pan0
dhcpd: DHCPACK on 192.168.111.171 to 00:80:c8:1f:e3:77 via pan0

When I connect the second one:

net.agent[7271]: invoke ifup bnep1=hotplug
pand[7269]: New connection from 00:40:05:60:5A:14 bnep1
kernel: device bnep1 entered promiscuous mode
kernel: pan0: port 3(bnep1) entering learning state
kernel: pan0: topology change detected, propgating
kernel: pan0: port 3(bnep1) entering forwarding state
dhcpd: DHCPDISCOVER from 00:40:05:60:5a:14 via pan0
dhcpd: DHCPOFFER on 192.168.111.172 to 00:40:05:60:5a:14 via pan0
dhcpd: DHCPREQUEST for 192.168.111.172 (192.168.111.1) from
00:40:05:60:5a:14 via pan0
dhcpd: DHCPACK on 192.168.111.172 to 00:40:05:60:5a:14 via pan0

When I disconnect the first one (bnep0) first:

net.agent[7299]: invoke ifdown bnep0
kernel: pan0: port 2(bnep0) entering disabled state
kernel: pan0: port 2(bnep0) entering disabled state
kernel: device bnep0 left promiscuous mode
  
# brctl showstp pan0
pan0
 STP is disabled for this interface

When I disconnect also the second one (bnep1): 

kernel: pan0: port 3(bnep1) entering disabled state
kernel: pan0: port 3(bnep1) entering disabled state
kernel: device bnep1 left promiscuous mode
net.agent[7319]: invoke ifdown bnep1

Regards,
Diego

On Wed, 2004-05-19 at 00:33, Stephen Hemminger wrote:
> Sounds like an issue with how the bnep does promiscious mode.
> Do you see messages on the console like:
> 	device bnep0 left promiscious mode
> 
> Also, the bnep driver seems to need BT_BNEP_MC_FILTER enabled
> to do multicast.  
> 
> When you remove bnep0 first, what does "brctl showstp pan0" show?


