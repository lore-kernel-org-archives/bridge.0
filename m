Message-ID: <49F73E9A.7090706@gmail.com>
Date: Tue, 28 Apr 2009 19:36:26 +0200
From: Jochen Hebbrecht <jochenhebbrecht@gmail.com>
MIME-Version: 1.0
References: <db99f77d0904271413p1e807e52ue3d0ec41f62d7daf@mail.gmail.com>
	<2e59e6970904271436nd66745cv1c64ba792cf76d2f@mail.gmail.com>
	<db99f77d0904272344o43cec753t19a558ccaf3753ff@mail.gmail.com>
	<20090428124009.GA26387@kallisti.us>
	<db99f77d0904280552n5717cd86x6cc045a9f64e5a45@mail.gmail.com>
	<20090428133702.GA26738@kallisti.us>
In-Reply-To: <20090428133702.GA26738@kallisti.us>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Ubuntu: network bridging between wireless and wired
 connection fails
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ross Vandegrift <ross@kallisti.us>
Cc: bridge@lists.linux-foundation.org



Ross Vandegrift schreef:
> On Tue, Apr 28, 2009 at 02:52:10PM +0200, Jochen Hebbrecht wrote:
>   
>> Okay, thnx!
>> Just a small question, I think I need to configure eth0 and eth1 to
>> manual? And not to DHCP?
>>
>> Like this:
>> ----------------------------------------
>> auto eth0
>> iface eth0 inet manual
>>
>> auto eth1
>> iface eth1 inet manual
>> ----------------------------------------
>>     
>
> Ah - I missed that.  Yes, you definitely want to set the member
> interfaces to manual.
>  
>   
>> The thing I don't understand then: if you execute a dhclient on br0,
>> how does br0 know the configuration of eth1? Because there's a WPA2
>> configuration on it. Will it use that settings too while bridging?
>>     
>
> I'll be honest, I'm not sure - I've never done that with
> wpa_supplicant and the debian tools.  You might need to activate
> wpa_supplicant in the pre-up for br0.
>
> Check out the manpage for interfaces - it may have more details.
>   

Ok, I made it myself a little easier by temporarly switching from WPA2 
to unsecure wireless networking.

I'm having the following configuration:

Code:

to lo
iface lo inet loopback

auto eth0
iface eth0 inet manual

auto eth1
iface eth1 inet manual
wireless-essid ##MY-ESSID##
wireless-mode managed

auto br0
iface br0 inet dhcp
bridge_ports eth0, eth1

When I reboot, my interfaces are getting the following config:

Code:

br0       Link encap:Ethernet  HWaddr 00:0a:e4:ae:7e:4c  
          inet6 addr: fe80::20a:e4ff:feae:7e4c/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:87 errors:0 dropped:0 overruns:0 frame:0
          TX packets:23 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:17544 (17.1 KB)  TX bytes:3744 (3.6 KB)

br0:avahi Link encap:Ethernet  HWaddr 00:0a:e4:ae:7e:4c  
          inet addr:169.254.7.81  Bcast:169.254.255.255  Mask:255.255.0.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1

eth0      Link encap:Ethernet  HWaddr 00:0a:e4:ae:7e:4c  
          inet6 addr: fe80::20a:e4ff:feae:7e4c/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:3 errors:0 dropped:0 overruns:0 frame:0
          TX packets:89 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:1770 (1.7 KB)  TX bytes:23069 (22.5 KB)
          Interrupt:20 Base address:0xc000 

eth1      Link encap:Ethernet  HWaddr 00:15:00:1f:20:a6  
          inet addr:192.168.1.111  Bcast:192.168.1.255  Mask:255.255.255.0
          inet6 addr: fe80::215:ff:fe1f:20a6/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:223 errors:0 dropped:0 overruns:0 frame:0
          TX packets:99 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:18762 (18.3 KB)  TX bytes:8392 (8.1 KB)
          Interrupt:21 Base address:0xa000 Memory:c8006000-c8006fff 

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:1879 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1879 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:94956 (92.7 KB)  TX bytes:94956 (92.7 KB

The bridge looks ok:

Code:

jochus@Bacardi ~ $ sudo brctl show br0
[sudo] password for jochus: 
bridge name     bridge id               STP enabled     interfaces
br0             8000.000ae4ae7e4c       no              eth0
                                                        eth1

My routing table looks like this:

Code:

Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
192.168.1.0     0.0.0.0         255.255.255.0   U     0      0        0 eth1
169.254.0.0     0.0.0.0         255.255.0.0     U     0      0        0 br0
0.0.0.0         192.168.1.1     0.0.0.0         UG    0      0        0 eth1
0.0.0.0         0.0.0.0         0.0.0.0         U     1000   0        0 br0

But I'm not able to ping my router ...

Code:

PING 192.168.1.1 (192.168.1.1) 56(84) bytes of data.
From 192.168.1.111 icmp_seq=1 Destination Host Unreachable
From 192.168.1.111 icmp_seq=2 Destination Host Unreachable
From 192.168.1.111 icmp_seq=3 Destination Host Unreachable

--- 192.168.1.1 ping statistics ---
5 packets transmitted, 0 received, +3 errors, 100% packet loss, time 4018ms

I don't understand why eth1 is in my routing table. It shouldn't be I guess?
Anybody some idea's?
