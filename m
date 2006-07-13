Date: Thu, 13 Jul 2006 12:52:55 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20060713125255.0fa4fa3a@localhost.localdomain>
In-Reply-To: <10bc97fe0607131210x55caeefbu7ff7ccbd92fda269@mail.gmail.com>
References: <10bc97fe0607131210x55caeefbu7ff7ccbd92fda269@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Bridge is not bridging.
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Ezsra McDonald <ezsra.mcdonald@gmail.com>
Cc: bridge@lists.osdl.org

On Thu, 13 Jul 2006 14:10:57 -0500
"Ezsra McDonald" <ezsra.mcdonald@gmail.com> wrote:

> I have read several articles for setting up a network bridge.
> 
> My configuration is:
> 
> WorkStation --> Switch0:VLAN1  --> Switch1:VLAN1  -->  bridge -->
> Switch1:VLAN45  --> Laptop
> 
> I am running CentOS 4.3 on the bridge
> 
> 
> #> brctl show
> bridge name  bridge id          STP enabled  interfaces
> br0          8000.0030843e5aa2  no           eth1
>                                              eth2
> 
> I followed the instructions at :
> 
> http://www.linuxjournal.com/article/8172
>

Read the wiki
	http://linux-net.osdl.org/index.php/Bridge

> I can't ping the laptop nor can the laptop ping my workstation. I put
> an IP on br0 and tried to ping out and got nothing. tcpdump shows no
> traffic except for an arp request from the laptop.
> 
> Was I supposed to recompile my kernel? I saw at least one article that
> recommended recompilig the kernel with a couple of config changes. I
> have the latest stock 2.6 kernel RPM installed.
> 
> Do I need to do any special configuration on the switches like setting
> the port to do port monitoring or anything like that? Its a Cisco 2900
> switch.
> 
> Any help would be appreciated.

Look at the status of the interfaces.
# brctl showstp br0

Perhaps one or more interfaces are not reporting carrier.
Also, because the implementation of STP inside doesn't know about VLAN's
other switches may turn off the port because of seeing STP packets.
