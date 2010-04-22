Date: Thu, 22 Apr 2010 13:09:19 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20100422130919.70206765@nehalam>
In-Reply-To: <m2nbc9320b91004211748o5548f351z646076fab6744cca@mail.gmail.com>
References: <m2nbc9320b91004211748o5548f351z646076fab6744cca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Bridge blocking network traffic
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: benno joy <bennojoy@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Thu, 22 Apr 2010 10:48:09 +1000
benno joy <bennojoy@gmail.com> wrote:

> Dear Team,
> 
> I have a strange problem...... This is my problem i have a linux box running
> Xen kernel (2.2). and i have the a bonding interface called bond0.497(eth0
> and eth1 and also des Vlan tagging).
> the bond0.497 is part of the bridge "xenbrv497", the issue is as soon as i
> make the bond a part of the bridge my network traffic stops to work.
> I did some prelimanary tests and found the following:
> 1) if i assighn an ip to the bond and do a ping to the gateway it works
> (provided it is not part of bridge xenbrv497)
> 2) if i add the bondig interface to the brodge xenbrv497 (brclt addif
> xenbrv497 bond0.497) the ping tests fails.
> 3) i did a tcpdump and found that arp requests are going out of the
> interface and we are getting response also. but soemhow
> the arp entries are not gettign registered. i did some googling and found it
> may be because of filtering so i disabled it by
> echo 0 > in /proc/sys/net/bridge/bridge-nf-*.
> But even this did not help still the arp entries are not getting registered
> due to which my network traffic is gettign dropped.
> This problem can be resolved by a reboot. but i would like to troubleshoot
> it.
> Could you please let me know how i can get more debugging message from the
> bridge calls so i can figure out what exactly is happening.
> 
> # uname -a
> Linux vmclkxstgh04.espdev.aurdev.national.com.au 2.6.18-128.2.1.4.13.el5xen
> #1 SMP Mon Dec 7 14:34:40 EST 2009 i686 i686 i386 GNU/Linux
> 
> [root@vmclkxstgh04 ~]# brctl show
> bridge name     bridge id               STP enabled     interfaces
> vlan441         8000.0017a4770470       no              bond0.441
> xenbrv205               8000.0017a477046c       no              bond1.205
> xenbrv208               8000.0017a477046c       no              bond1.208
> xenbrv220               8000.000000000000       no
> xenbrv221               8000.000000000000       no
> xenbrv226               8000.0017a477046c       no              vif40.1
>                                                         vif39.1
>                                                         vif37.1
>                                                         vif26.1
>                                                         vif25.1
>                                                         vif24.1
>                                                         vif13.1
>                                                         bond1.226
> xenbrv227               8000.0017a4770470       no              vif40.0
>                                                         vif39.0
>                                                         vif37.0
>                                                         vif26.0
>                                                         vif25.0
>                                                         vif24.0
>                                                         vif13.0
>                                                         bond0.227
> xenbrv420               8000.0017a4770470       no              bond0.420
> xenbrv422               8000.0017a4770470       no              vif35.0
>                                                         vif7.0
>                                                         vif6.0
>                                                         vif4.0
>                                                         vif3.0
>                                                         vif2.0
>                                                         tap2.0
>                                                         bond0.422
> xenbrv425               8000.0017a4770470       no              bond0.425
> xenbrv450               8000.0017a4770470       no              bond0.450
> xenbrv492               8000.0017a4770470       no              bond0.492
> xenbrv493               8000.0017a4770470       no              bond0.493
> xenbrv494               8000.0017a4770470       no              bond0.494
> xenbrv495               8000.0017a4770470       no              bond0.495
> xenbrv496               8000.0017a4770470       no              bond0.496
> xenbrv497               8000.0017a4770470       no              bond0.497
> xenbrv701               8000.0017a477046c       no              vif44.1
>                                                         bond1.701
> 
> bond0.497 Link encap:Ethernet  HWaddr 00:17:A4:77:04:70
>           inet addr:10.12.166.231  Bcast:10.12.166.255  Mask:255.255.255.224
>           UP BROADCAST RUNNING MASTER MULTICAST  MTU:1500  Metric:1
>           RX packets:3807595 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:3304 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:0
>           RX bytes:188847200 (180.0 MiB)  TX bytes:138768 (135.5 KiB)

You are supposed to assign IP address to bridge not the member of the bridge.


-- 
