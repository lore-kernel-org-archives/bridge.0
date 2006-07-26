Date: Wed, 26 Jul 2006 08:31:49 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20060726083149.552d9e57@localhost.localdomain>
In-Reply-To: <714D3CA502C1D21199DD0004ACD9DEAF0391FC97@starcase_nt.starcase.com.hk>
References: <714D3CA502C1D21199DD0004ACD9DEAF0391FC97@starcase_nt.starcase.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] NIC's binding order
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "Jason Chan <MIS>" <jsonchan@ebhk.com.hk>
Cc: bridge@lists.osdl.org

On Wed, 26 Jul 2006 18:22:37 +0800
"Jason Chan <MIS>" <jsonchan@ebhk.com.hk> wrote:

> Hi Folk,
>  
> My BOX is running Debian Sarge. i recently setup a bridge with two NIC's for
> transparent proxy. However something weird i found as listed below when i
> run ifconfig. So just curious to ask why the hardware address of "br0" is
> the same as "eth1", it's supposed to be the same as "eth0"...normally.
> Should this cause a probelm with the bridge?? If so how can i correct the
> binding order?

The MAC address of the bridge pseudo-device is the minimum of the addresses
of the connected interfaces. This is part of the 802.1d spec probably to prevent
possible loops.

You can change address of bridge on recent kernels to be any of the addresses
of the interfaces.  As I remember, Debian Sarge kernel is ancient so you may
need to run a newer kernel.

> Best regards
> Jason
>  
> root@bridge:~> ifconfig
> 
> br0       Link encap:Ethernet  HWaddr 00:04:75:81:D2:1D
> 
>           inet addr:10.0.3.129  Bcast:195.30.198.255  Mask:255.255.255.128
> 
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
> 
>           RX packets:826 errors:0 dropped:0 overruns:0 frame:0
> 
>           TX packets:737 errors:0 dropped:0 overruns:0 carrier:0
> 
>           collisions:0 txqueuelen:0
> 
>           RX bytes:161180 (157.4 Kb)  TX bytes:66708 (65.1 Kb)
> 
> 
> 
> eth0      Link encap:Ethernet  HWaddr 00:04:75:81:ED:B7
> 
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
> 
>           RX packets:5729 errors:0 dropped:0 overruns:0 frame:0
> 
>           TX packets:3115 errors:0 dropped:0 overruns:0 carrier:656
> 
>           collisions:0 txqueuelen:100
> 
>           RX bytes:1922290 (1.8 Mb)  TX bytes:298837 (291.8 Kb)
> 
>           Interrupt:11 Base address:0xe400
> 
> 
> 
> eth1      Link encap:Ethernet  HWaddr 00:04:75:81:D2:1D
> 
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
> 
>           RX packets:0 errors:0 dropped:0 overruns:1 frame:0
> 
>           TX packets:243 errors:0 dropped:0 overruns:0 carrier:0
> 
>           collisions:0 txqueuelen:100
> 
>           RX bytes:342 (342.0 b)  TX bytes:48379 (47.2 Kb)
> 
>           Interrupt:7 Base address:0xe800
> 
> 
> 
> lo        Link encap:Local Loopback
> 
>           inet addr:127.0.0.1  Mask:255.0.0.0
> 
>           UP LOOPBACK RUNNING  MTU:16436  Metric:1
> 
>           RX packets:1034 errors:0 dropped:0 overruns:0 frame:0
> 
>           TX packets:1034 errors:0 dropped:0 overruns:0 carrier:0
> 
>           collisions:0 txqueuelen:0
> 
>           RX bytes:82068 (80.1 Kb)  TX bytes:82068 (80.1 Kb)
> 
>         
