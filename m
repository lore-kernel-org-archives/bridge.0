Date: Thu, 31 Aug 2006 10:03:42 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20060831100342.4f4b3b21@localhost.localdomain>
In-Reply-To: <131411580608310945p1dd9bbe4jcb7468adc43196dc@mail.gmail.com>
References: <131411580608310945p1dd9bbe4jcb7468adc43196dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] Trouble with ARP traffic
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Raffaele Carla <raffaele.carla@gmail.com>
Cc: bridge@lists.osdl.org

On Thu, 31 Aug 2006 12:45:44 -0400
"Raffaele Carla" <raffaele.carla@gmail.com> wrote:

> Hi,
> 
> I've setup a Linux (SUSE v. 2.6.16.13-4-smp) in bridging mode. The br0
> interface has two physical: eth0 and  eth1.
> 
> The eth0 interface is connected to  our LAN, the eth1 is connected to a
> SONICWALL firewall. STP is turned off, since  it's the only bridge
> connecting the two areas. The bridge is also filtering  some traffic via
> iptables.
> 
> All is working fine, but when I use  tcpdump on the eth1 interface, I see
> all the ARP requests of the LAN. In other  words, the entirely ARP
> broadcasts (that will be resolved internally) are  passing the bridge and
> reaching the firewall.
> 
> As a bridge, the Linux box should be  aware where every machine is located
> and separate logically the two segments,  shouldn't it?
> 

The bridge is at lower level, and only looks at the Ethernet header and
those packets are broadcast's so they have to be flood routed. You could
run a proxy arp daemon and filter out arp with ebtables.

> Also, the command "arp –a" shows  only one address, wether the "brctl
> showmacs br0"  shows all the addresses  correctly. Is this a normal
> behaviour?
> 
> Thank you for any advice,
> 
> Raffaele
> 
> 
> Output of brctl showstp  br0
> ---------------------------------------
> 
> br0
>  bridge id                8000.001560a34be7
>  designated root         8000.001560a34be7
>  root port                  0                    path cost
> 0
>  max age                   20.00                 bridge max age
> 50.00
>  hello time                 2.00                 bridge hello
> time           5.00
>  forward delay             37.50                 bridge forward delay
> 15.00
>  ageing time              300.01
>  hello timer               1.39                  tcn timer
> 0.00
>  topology change timer      0.00                 gc
> timer                    0.05
>  flags
> 
> eth0  (1)
>  port id                 8001
> state                 forwarding
>  designated root         8000.001560a34be7       path
> cost                  19
>  designated bridge       8000.001560a34be7        message age
> timer           0.00
>  designated port         8001                    forward delay
> timer         0.00
>  designated cost            0                    hold
> timer                  0.39
>  flags
> 
> eth1  (2)
>  port id                 8002
> state                 forwarding
>  designated root         8000.001560a34be7       path
> cost                 100
>  designated bridge       8000.001560a34be7       message age
> timer           0.00
>  designated port         8002                    forward delay
> timer         0.00
>  designated cost            0                    hold
> timer                   0.39
>  flags
> 
> Output of brctl showmacs  br0
> ------------------------------------------
> 1     00:04:23:0a:a6:13        no                86.16
>   1     00:04:75:4c:d7:03        no                 5.06
>   1     00:04:75:87:bd:a9        no               138.51
>   1     00:04:76:a3:c9:b8        no               100.12
>   2     00:06:b1:11:8d:a4        no                 0.07
>   1     00:0f:20:3b:8e:4e        no                41.11
>   1      00:0f:20:3b:fe:57       no                60.78
>   1     00:14:69:b4:49:84        no                 0.14
>   1     00:15:60:a3:4b:e7        yes                0.00
>   1     00:30:c1:5f:24:56        no                28.16
>   1     00:30:c1:8c:e7:61        no                39.05
>   2     00:c0:f0:56:51:c6        yes                0.00
