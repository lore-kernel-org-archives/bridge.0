Message-ID: <10bc97fe0607131411i2dfa6578q8bafda2b26aac119@mail.gmail.com>
Date: Thu, 13 Jul 2006 16:11:54 -0500
From: "Ezsra McDonald" <ezsra.mcdonald@gmail.com>
In-Reply-To: <20060713132836.579c1ec2@dxpl.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <10bc97fe0607131210x55caeefbu7ff7ccbd92fda269@mail.gmail.com>
	<20060713125255.0fa4fa3a@localhost.localdomain>
	<10bc97fe0607131323ta6df9feka51f9bb97653915a@mail.gmail.com>
	<20060713132836.579c1ec2@dxpl.pdx.osdl.net>
Subject: Re: [Bridge] Bridge is not bridging.
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@lists.osdl.org

Doh!

Nice how just rebooting a server can fix things.

Case closed. Thanks for your help.



On 7/13/06, Stephen Hemminger <shemminger@osdl.org> wrote:
> On Thu, 13 Jul 2006 15:23:07 -0500
> "Ezsra McDonald" <ezsra.mcdonald@gmail.com> wrote:
>
> > On 7/13/06, Stephen Hemminger <shemminger@osdl.org> wrote:
> > > On Thu, 13 Jul 2006 14:10:57 -0500
> > > "Ezsra McDonald" <ezsra.mcdonald@gmail.com> wrote:
> > >
> > > > I have read several articles for setting up a network bridge.
> > > >
> > > > My configuration is:
> > > >
> > > > WorkStation --> Switch0:VLAN1  --> Switch1:VLAN1  -->  bridge -->
> > > > Switch1:VLAN45  --> Laptop
> > > >
> > > > I am running CentOS 4.3 on the bridge
> > > >
> > > >
> > > > #> brctl show
> > > > bridge name  bridge id          STP enabled  interfaces
> > > > br0          8000.0030843e5aa2  no           eth1
> > > >                                              eth2
> > > >
> > > > I followed the instructions at :
> > > >
> > > > http://www.linuxjournal.com/article/8172
> > > >
> > >
> > > Read the wiki
> > >         http://linux-net.osdl.org/index.php/Bridge
> >
> > Yep, read that one too.
> >
> > >
> > > > I can't ping the laptop nor can the laptop ping my workstation. I put
> > > > an IP on br0 and tried to ping out and got nothing. tcpdump shows no
> > > > traffic except for an arp request from the laptop.
> > > >
> > > > Was I supposed to recompile my kernel? I saw at least one article that
> > > > recommended recompilig the kernel with a couple of config changes. I
> > > > have the latest stock 2.6 kernel RPM installed.
> >
> > Do we need to do any kernel compilations? Are the stock kernels ok? I
> > do see the "bridge" module loaded with an lsmod.
> >
> > > >
> > > > Do I need to do any special configuration on the switches like setting
> > > > the port to do port monitoring or anything like that? Its a Cisco 2900
> > > > switch.
> >
> > Any suggestions here? Enable port monitoring or no?
> >
> > > >
> > > > Any help would be appreciated.
> > >
> > > Look at the status of the interfaces.
> > > # brctl showstp br0
> > >
> >
> > [root@staff-bridge ~]# brctl showstp br0
> > br0
> >  bridge id              8000.001346998d68
> >  designated root        8000.001346998d68
> >  root port                 0                    path cost                  0
> >  max age                  19.99                 bridge max age            19.99
> >  hello time                1.99                 bridge hello time          1.99
> >  forward delay            14.99                 bridge forward delay      14.99
> >  ageing time             299.95
> >  hello timer               1.14                 tcn timer                  0.00
> >  topology change timer     0.00                 gc timer                   0.00
> >  flags
> >
> >
> > eth1 (1)
> >  port id                8001                    state                  disabled
> >  designated root        8000.001346998d68       path cost                 19
> >  designated bridge      8000.001346998d68       message age timer          0.00
> >  designated port        8001                    forward delay timer        0.00
> >  designated cost           0                    hold timer                 0.00
> >  flags
> >
> > eth2 (2)
> >  port id                8002                    state                  disabled
> >  designated root        8000.001346998d68       path cost                 19
> >  designated bridge      8000.001346998d68       message age timer          0.00
> >  designated port        8002                    forward delay timer        0.00
> >  designated cost           0                    hold timer                 0.00
> >  flags
>
> Ports are disabled (so that means the carrier state is off).
>
>
> > > Perhaps one or more interfaces are not reporting carrier.
> > > Also, because the implementation of STP inside doesn't know about VLAN's
> > > other switches may turn off the port because of seeing STP packets.
> > >
> >
> > eth1      Link encap:Ethernet  HWaddr 00:13:46:99:8D:6A
> >           inet6 addr: fe80::213:46ff:fe99:8d6a/64 Scope:Link
> >           UP BROADCAST MULTICAST  MTU:1500  Metric:1
> >           RX packets:537728 errors:0 dropped:0 overruns:0 frame:0
> >           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
> >           collisions:0 txqueuelen:1000
> >           RX bytes:108031928 (103.0 MiB)  TX bytes:0 (0.0 b)
> >           Interrupt:3 Base address:0xe400
> >
> > eth2      Link encap:Ethernet  HWaddr 00:13:46:99:8D:68
> >           inet6 addr: fe80::213:46ff:fe99:8d68/64 Scope:Link
> >           UP BROADCAST MULTICAST  MTU:1500  Metric:1
> >           RX packets:115688 errors:0 dropped:0 overruns:0 frame:0
> >           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
> >           collisions:0 txqueuelen:1000
> >           RX bytes:8363266 (7.9 MiB)  TX bytes:0 (0.0 b)
> >           Interrupt:9 Base address:0x800
>
> You can check on carrier by doing:
> cat /sys/class/net/eth1/carrier
>
> The link detection is a function of the ethernet device driver (not the
> bridge). You may need to bring the devices up to start carrier detection/auto-negotiation.
>
> ifconfig eth1 up
>
> Also, sometimes the linux distributions network configuration (and hotplug) scripts
> can get in the way. Make sure and NOT list the devices you intend to use in any of
> the configuration info. Some distributions have ways to configure bridges in their
> boot scripts.
>
>
> --
> Stephen Hemminger <shemminger@osdl.org>
> "And in the Packet there writ down that doome"
>
