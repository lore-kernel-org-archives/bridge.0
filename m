Message-ID: <49F87D4E.4060705@gmail.com>
Date: Wed, 29 Apr 2009 18:16:14 +0200
From: Jochen Hebbrecht <jochenhebbrecht@gmail.com>
MIME-Version: 1.0
References: <db99f77d0904271413p1e807e52ue3d0ec41f62d7daf@mail.gmail.com>	
	<2e59e6970904271436nd66745cv1c64ba792cf76d2f@mail.gmail.com>	
	<db99f77d0904272344o43cec753t19a558ccaf3753ff@mail.gmail.com>	
	<20090428124009.GA26387@kallisti.us>	
	<db99f77d0904280552n5717cd86x6cc045a9f64e5a45@mail.gmail.com>	
	<20090428133702.GA26738@kallisti.us> <49F73E9A.7090706@gmail.com>	
	<2e59e6970904281200u44e3ebbfga0f074dfaa78c1ab@mail.gmail.com>	
	<49F77248.1050800@gmail.com>
	<2e59e6970904281600u42142392vb8e0eb45c4ede15c@mail.gmail.com>
In-Reply-To: <2e59e6970904281600u42142392vb8e0eb45c4ede15c@mail.gmail.com>
Content-Type: multipart/alternative;
	boundary="------------070203050402040901070602"
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
To: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Cc: bridge@lists.linux-foundation.org

This is a multi-part message in MIME format.
--------------070203050402040901070602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

No, the DHCP server gives addresses to every MAC address that is possible.

So this is the current situation:

jochus@Bacardi ~ $ sudo brctl show br0
bridge name     bridge id               STP enabled     interfaces
br0             8000.000ae4ae7e4c       no              eth0
                                                                           
eth1

jochus@Bacardi ~ $ route -n
Kernel IP routing table
Destination     Gateway         Genmask         Flags     Metric Ref    
Use Iface
169.254.0.0     0.0.0.0         255.255.0.0     U     0         0       
        0  br0
0.0.0.0             0.0.0.0             0.0.0.0         U     1000   
0               0  br0


I also found this thread: 
http://www.linuxquestions.org/questions/debian-26/howto-bridge-wireless-and-wired-network-interfaces-369455/, 
but that solution didn't work either. I'm not receiving any DHCP offers 
on eth1

I guess I'm stuck with it, and returning to windows is the best solution 
now :-)



richardvoigt@gmail.com schreef:
> Does your DHCP server only give out addresses to specific MAC 
> addresses?  Turning on bridge mode probably results in using the MAC 
> address of eth0, rather than eth1 which had been successfully getting 
> a DHCP assignment?
>
> I had actually meant for you to run packet capture from some other 
> node on the wireless, to make sure the DHCP discover actually went out 
> the radio.  But you clearly are joined properly.
>
> So check for any sort of MAC-based security in the DHCP server.
>
> On Tue, Apr 28, 2009 at 4:16 PM, Jochen Hebbrecht 
> <jochenhebbrecht@gmail.com <mailto:jochenhebbrecht@gmail.com>> wrote:
>
>     Richard,
>
>     After rebooting a second time, eth1 isn't appearing in the routing
>     tabel any longer. The bridge seems to be working perfectly now!
>     However, I'm not able to retreive any DHCP offers.
>
>     I did some packet monitoring:
>
>     br0
>
>     1	0.000000000	fe80::20a:e4ff:feae:7e4c	ff02::2	ICMPv6	Router solicitation
>     2	24.824098000	0.0.0.0	255.255.255.255	DHCP	DHCP Discover - Transaction ID 0xa117a72
>     3	28.824043000	0.0.0.0	255.255.255.255	DHCP	DHCP Discover - Transaction ID 0xa117a72
>     4	33.685106000	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1  
>     5	33.688946000	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1  
>     6	33.692700000	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1  
>     7	33.698081000	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1  
>     8	33.701656000	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1  
>     9	33.705492000	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1  
>     10	33.708885000	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1  
>     11	33.712502000	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1  
>     12	33.716242000	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1  
>     13	33.719929000	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1  
>     14	38.824050000	0.0.0.0	255.255.255.255	DHCP	DHCP Discover - Transaction ID 0xa117a72
>     15	48.824039000	0.0.0.0	255.255.255.255	DHCP	DHCP Discover - Transaction ID 0xa117a72
>     16	56.768033000	Wistron_ae:7e:4c	Broadcast	ARP	Who has 169.254.7.81?  Tell 0.0.0.0
>     17	57.992048000	Wistron_ae:7e:4c	Broadcast	ARP	Who has 169.254.7.81?  Tell 0.0.0.0
>     18	59.019954000	Wistron_ae:7e:4c	Broadcast	ARP	Who has 169.254.7.81?  Tell 0.0.0.0
>     19	61.020124000	Wistron_ae:7e:4c	Broadcast	ARP	Gratuitous ARP for 169.254.7.81 (Request)
>     20	62.004532000	169.254.7.81	169.254.255.255	NBNS	Registration NB BACARDI<20>
>     21	62.004582000	169.254.7.81	169.254.255.255	NBNS	Registration NB BACARDI<03>
>     22	62.004615000	169.254.7.81	169.254.255.255	NBNS	Registration NB BACARDI<00>
>     23	62.004647000	169.254.7.81	169.254.255.255	NBNS	Registration NB MSHOME<00>
>     24	62.004679000	169.254.7.81	169.254.255.255	NBNS	Registration NB MSHOME<1e>
>     25	62.004775000	169.254.7.81	169.254.255.255	BROWSER	Host Announcement BACARDI, Workstation, Server, Print Queue Server, Xenix Server, NT Workstation, NT Server, Potential Browser, Unknown server type:23
>     26	63.023921000	Wistron_ae:7e:4c	Broadcast	ARP	Gratuitous ARP for 169.254.7.81 (Request)
>     27	64.003996000	169.254.7.81	169.254.255.255	NBNS	Registration NB BACARDI<20>
>     28	64.004033000	169.254.7.81	169.254.255.255	NBNS	Registration NB BACARDI<03>
>     29	64.004054000	169.254.7.81	169.254.255.255	NBNS	Registration NB BACARDI<00>
>     30	64.004075000	169.254.7.81	169.254.255.255	NBNS	Registration NB MSHOME<00>
>     31	64.004097000	169.254.7.81	169.254.255.255	NBNS	Registration NB MSHOME<1e>
>     32	64.004156000	169.254.7.81	169.254.255.255	NBNS	Registration NB BACARDI<20>
>     33	64.004179000	169.254.7.81	169.254.255.255	NBNS	Registration NB BACARDI<03>
>     34	64.004200000	169.254.7.81	169.254.255.255	NBNS	Registration NB BACARDI<00>
>     35	64.004220000	169.254.7.81	169.254.255.255	NBNS	Registration NB MSHOME<00>
>     36	64.004240000	169.254.7.81	169.254.255.255	NBNS	Registration NB MSHOME<1e>
>     37	65.127895000	Wistron_ae:7e:4c	Broadcast	ARP	Who has 195.130.129.165?  Tell 169.254.7.81
>     38	66.004121000	169.254.7.81	169.254.255.255	NBNS	Registration NB BACARDI<20>
>     39	66.004177000	169.254.7.81	169.254.255.255	NBNS	Registration NB BACARDI<03>
>     40	66.004197000	169.254.7.81	169.254.255.255	NBNS	Registration NB BACARDI<00>
>     41	66.004219000	169.254.7.81	169.254.255.255	NBNS	Registration NB MSHOME<00>
>     42	66.004239000	169.254.7.81	169.254.255.255	NBNS	Registration NB MSHOME<1e>
>     43	66.127931000	Wistron_ae:7e:4c	Broadcast	ARP	Who has 195.130.129.165?  Tell 169.254.7.81
>     44	67.127989000	Wistron_ae:7e:4c	Broadcast	ARP	Who has 195.130.129.165?  Tell 169.254.7.81
>     45	70.127967000	Wistron_ae:7e:4c	Broadcast	ARP	Who has 195.130.130.165?  Tell 169.254.7.81
>     46	71.128025000	Wistron_ae:7e:4c	Broadcast	ARP	Who has 195.130.130.165?  Tell 169.254.7.81
>         
>
>
>
>     eth0
>
>     1	0.000000	Wistron_ae:7e:4c	Broadcast	ARP	Who has 192.168.1.1?  Tell 192.168.1.112
>     2	19.840146	0.0.0.0	255.255.255.255	DHCP	DHCP Discover - Transaction ID 0x8537ad48
>     3	24.840168	0.0.0.0	255.255.255.255	DHCP	DHCP Discover - Transaction ID 0x8537ad48
>     4	38.840099	0.0.0.0	255.255.255.255	DHCP	DHCP Discover - Transaction ID 0x8537ad48
>     5	45.513321	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1  
>     6	45.516537	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1  
>     7	45.520384	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1  
>     8	45.524058	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1  
>     9	45.527325	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1  
>     10	45.530872	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1  
>     11	45.534676	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1  
>     12	45.538019	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1  
>     13	45.541774	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1  
>     14	45.545417	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1  
>     15	45.549231	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1  
>     16	51.412036	Wistron_ae:7e:4c	Broadcast	ARP	Who has 169.254.7.81?  Tell 0.0.0.0
>     17	53.360036	Wistron_ae:7e:4c	Broadcast	ARP	Who has 169.254.7.81?  Tell 0.0.0.0
>     18	54.716034	Wistron_ae:7e:4c	Broadcast	ARP	Who has 169.254.7.81?  Tell 0.0.0.0
>     19	56.716135	Wistron_ae:7e:4c	Broadcast	ARP	Gratuitous ARP for 169.254.7.81 (Request)
>     20	58.716070	Wistron_ae:7e:4c	Broadcast	ARP	Gratuitous ARP for 169.254.7.81 (Request)
>     21	60.775980	Wistron_ae:7e:4c	Broadcast	ARP	Who has 195.130.129.165?  Tell 169.254.7.81
>
>
>
>     eth1
>
>     1	0.000000	fe80::215:ff:fe1f:20a6	ff02::2	ICMPv6	Router solicitation
>     2	25.983879	0.0.0.0	255.255.255.255	DHCP	DHCP Discover - Transaction ID 0xe2640e1c
>     3	30.983864	0.0.0.0	255.255.255.255	DHCP	DHCP Discover - Transaction ID 0xe2640e1c
>     4	32.949057	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1  
>     5	32.952404	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1  
>     6	32.957215	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1  
>     7	32.960893	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1  
>     8	32.964222	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1  
>     9	32.970023	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1  
>     10	32.973868	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1  
>     11	32.977056	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1  
>     12	32.981455	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1  
>     13	32.985056	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1  
>     14	32.988717	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1  
>     15	44.983895	0.0.0.0	255.255.255.255	DHCP	DHCP Discover - Transaction ID 0xe2640e1c
>     16	54.983846	0.0.0.0	255.255.255.255	DHCP	DHCP Discover - Transaction ID 0xe2640e1c
>     17	57.199856	Wistron_ae:7e:4c	Broadcast	ARP	Who has 169.254.7.81?  Tell 0.0.0.0
>     18	58.967801	Wistron_ae:7e:4c	Broadcast	ARP	Who has 169.254.7.81?  Tell 0.0.0.0
>     19	60.039785	Wistron_ae:7e:4c	Broadcast	ARP	Who has 169.254.7.81?  Tell 0.0.0.0
>     20	62.039897	Wistron_ae:7e:4c	Broadcast	ARP	Gratuitous ARP for 169.254.7.81 (Request)
>     21	64.039860	Wistron_ae:7e:4c	Broadcast	ARP	Gratuitous ARP for 169.254.7.81 (Request)
>     22	66.107737	Wistron_ae:7e:4c	Broadcast	ARP	Who has 195.130.129.165?  Tell 169.254.7.81
>     23	66.164183	169.254.7.81	169.254.255.255	NBNS	Registration NB BACARDI<20>
>     24	66.164203	169.254.7.81	169.254.255.255	NBNS	Registration NB BACARDI<03>
>     25	66.164222	169.254.7.81	169.254.255.255	NBNS	Registration NB BACARDI<00>
>     26	66.164241	169.254.7.81	169.254.255.255	NBNS	Registration NB MSHOME<00>
>     27	66.164258	169.254.7.81	169.254.255.255	NBNS	Registration NB MSHOME<1e>
>     28	66.164314	169.254.7.81	169.254.255.255	BROWSER	Host Announcement BACARDI, Workstation, Server, Print Queue Server, Xenix Server, NT Workstation, NT Server, Potential Browser, Unknown server type:23
>
>
>
>     You can see the DHCP discovers, but nobody's answering
>
>
>
>     richardvoigt@gmail.com <mailto:richardvoigt@gmail.com> schreef:
>>     Do some packet monitoring on your wireless network to see if the
>>     DHCP request is going out over the air... your problems stem from
>>     not getting a DHCP address.  At first I thought the address given
>>     to eth1 might be interfering with br0... but it seems not.
>>
>>     On Tue, Apr 28, 2009 at 12:36 PM, Jochen Hebbrecht
>>     <jochenhebbrecht@gmail.com <mailto:jochenhebbrecht@gmail.com>> wrote:
>>
>>
>>
>>         Ross Vandegrift schreef:
>>
>>             On Tue, Apr 28, 2009 at 02:52:10PM +0200, Jochen
>>             Hebbrecht wrote:
>>              
>>
>>                 Okay, thnx!
>>                 Just a small question, I think I need to configure
>>                 eth0 and eth1 to
>>                 manual? And not to DHCP?
>>
>>                 Like this:
>>                 ----------------------------------------
>>                 auto eth0
>>                 iface eth0 inet manual
>>
>>                 auto eth1
>>                 iface eth1 inet manual
>>                 ----------------------------------------
>>                    
>>
>>
>>             Ah - I missed that.  Yes, you definitely want to set the
>>             member
>>             interfaces to manual.
>>                
>>
>>                 The thing I don't understand then: if you execute a
>>                 dhclient on br0,
>>                 how does br0 know the configuration of eth1? Because
>>                 there's a WPA2
>>                 configuration on it. Will it use that settings too
>>                 while bridging?
>>                    
>>
>>
>>             I'll be honest, I'm not sure - I've never done that with
>>             wpa_supplicant and the debian tools.  You might need to
>>             activate
>>             wpa_supplicant in the pre-up for br0.
>>
>>             Check out the manpage for interfaces - it may have more
>>             details.
>>              
>>
>>
>>         Ok, I made it myself a little easier by temporarly switching
>>         from WPA2 to unsecure wireless networking.
>>
>>         I'm having the following configuration:
>>
>>         Code:
>>
>>
>>         to lo
>>         iface lo inet loopback
>>
>>         auto eth0
>>         iface eth0 inet manual
>>
>>         auto eth1
>>         iface eth1 inet manual
>>         wireless-essid ##MY-ESSID##
>>         wireless-mode managed
>>
>>         auto br0
>>
>>         iface br0 inet dhcp
>>         bridge_ports eth0, eth1
>>
>>         When I reboot, my interfaces are getting the following config:
>>
>>         Code:
>>
>>
>>         br0       Link encap:Ethernet  HWaddr 00:0a:e4:ae:7e:4c      
>>             inet6 addr: fe80::20a:e4ff:feae:7e4c/64 Scope:Link
>>                 UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>>                 RX packets:87 errors:0 dropped:0 overruns:0 frame:0
>>                 TX packets:23 errors:0 dropped:0 overruns:0 carrier:0
>>                 collisions:0 txqueuelen:0         RX bytes:17544
>>         (17.1 KB)  TX bytes:3744 (3.6 KB)
>>
>>
>>         br0:avahi Link encap:Ethernet  HWaddr 00:0a:e4:ae:7e:4c      
>>             inet addr:169.254.7.81  Bcast:169.254.255.255
>>          Mask:255.255.0.0
>>                 UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>>
>>         eth0      Link encap:Ethernet  HWaddr 00:0a:e4:ae:7e:4c      
>>             inet6 addr: fe80::20a:e4ff:feae:7e4c/64 Scope:Link
>>                 UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>>                 RX packets:3 errors:0 dropped:0 overruns:0 frame:0
>>                 TX packets:89 errors:0 dropped:0 overruns:0 carrier:0
>>                 collisions:0 txqueuelen:1000         RX bytes:1770
>>         (1.7 KB)  TX bytes:23069 (22.5 KB)
>>
>>                 Interrupt:20 Base address:0xc000
>>         eth1      Link encap:Ethernet  HWaddr 00:15:00:1f:20:a6      
>>             inet addr:192.168.1.111  Bcast:192.168.1.255
>>          Mask:255.255.255.0
>>
>>                 inet6 addr: fe80::215:ff:fe1f:20a6/64 Scope:Link
>>                 UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>>                 RX packets:223 errors:0 dropped:0 overruns:0 frame:0
>>                 TX packets:99 errors:0 dropped:0 overruns:0 carrier:0
>>                 collisions:0 txqueuelen:1000         RX bytes:18762
>>         (18.3 KB)  TX bytes:8392 (8.1 KB)
>>                 Interrupt:21 Base address:0xa000
>>         Memory:c8006000-c8006fff
>>         lo        Link encap:Local Loopback           inet
>>         addr:127.0.0.1  Mask:255.0.0.0
>>                 inet6 addr: ::1/128 Scope:Host
>>                 UP LOOPBACK RUNNING  MTU:16436  Metric:1
>>                 RX packets:1879 errors:0 dropped:0 overruns:0 frame:0
>>                 TX packets:1879 errors:0 dropped:0 overruns:0 carrier:0
>>                 collisions:0 txqueuelen:0         RX bytes:94956
>>         (92.7 KB)  TX bytes:94956 (92.7 KB
>>
>>         The bridge looks ok:
>>
>>         Code:
>>
>>         jochus@Bacardi ~ $ sudo brctl show br0
>>         [sudo] password for jochus: bridge name     bridge id        
>>               STP enabled     interfaces
>>         br0             8000.000ae4ae7e4c       no              eth0
>>                                                               eth1
>>
>>         My routing table looks like this:
>>
>>         Code:
>>
>>
>>         Kernel IP routing table
>>         Destination     Gateway         Genmask         Flags Metric
>>         Ref    Use Iface
>>         192.168.1.0     0.0.0.0         255.255.255.0   U     0    
>>          0        0 eth1
>>
>>         169.254.0.0     0.0.0.0         255.255.0.0     U     0    
>>          0        0 br0
>>         0.0.0.0         192.168.1.1     0.0.0.0         UG    0    
>>          0        0 eth1
>>         0.0.0.0         0.0.0.0         0.0.0.0         U     1000  
>>         0        0 br0
>>
>>         But I'm not able to ping my router ...
>>
>>         Code:
>>
>>         PING 192.168.1.1 (192.168.1.1) 56(84) bytes of data.
>>         From 192.168.1.111 icmp_seq=1 Destination Host Unreachable
>>         From 192.168.1.111 icmp_seq=2 Destination Host Unreachable
>>         From 192.168.1.111 icmp_seq=3 Destination Host Unreachable
>>
>>         --- 192.168.1.1 ping statistics ---
>>         5 packets transmitted, 0 received, +3 errors, 100% packet
>>         loss, time 4018ms
>>
>>         I don't understand why eth1 is in my routing table. It
>>         shouldn't be I guess?
>>         Anybody some idea's?
>>
>>
>

--------------070203050402040901070602
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
No, the DHCP server gives addresses to every MAC address that is
possible.<br>
<br>
So this is the current situation:<br>
<br>
jochus@Bacardi ~ $ sudo brctl show br0<br>
bridge name&nbsp;&nbsp;&nbsp;&nbsp; bridge id&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; STP enabled&nbsp;&nbsp;&nbsp;&nbsp; interfaces<br>
br0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8000.000ae4ae7e4c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; no&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eth0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
eth1<br>
<br>
jochus@Bacardi ~ $ route -n<br>
Kernel IP routing table<br>
Destination&nbsp;&nbsp;&nbsp;&nbsp; Gateway&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Genmask&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Flags &nbsp; &nbsp; Metric Ref&nbsp;&nbsp;&nbsp;
Use Iface<br>
169.254.0.0&nbsp;&nbsp;&nbsp;&nbsp; 0.0.0.0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 255.255.0.0&nbsp;&nbsp;&nbsp;&nbsp; U&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; 0&nbsp; br0<br>
0.0.0.0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.0.0.0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; 0.0.0.0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; U&nbsp;&nbsp;&nbsp;&nbsp; 1000&nbsp;&nbsp;
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp; br0<br>
<br>
<br>
I also found this thread:
<a class="moz-txt-link-freetext" href="http://www.linuxquestions.org/questions/debian-26/howto-bridge-wireless-and-wired-network-interfaces-369455/">http://www.linuxquestions.org/questions/debian-26/howto-bridge-wireless-and-wired-network-interfaces-369455/</a>,
but that solution didn't work either. I'm not receiving any DHCP offers
on eth1<br>
<br>
I guess I'm stuck with it, and returning to windows is the best
solution now :-)<br>
<br>
<br>
<br>
<a class="moz-txt-link-abbreviated" href="mailto:richardvoigt@gmail.com">richardvoigt@gmail.com</a> schreef:
<blockquote
 cite="mid:2e59e6970904281600u42142392vb8e0eb45c4ede15c@mail.gmail.com"
 type="cite">Does your DHCP server only give out addresses to specific
MAC addresses?&nbsp; Turning on bridge mode probably results in using the
MAC address of eth0, rather than eth1 which had been successfully
getting a DHCP assignment?<br>
  <br>
I had actually meant for you to run packet capture from some other node
on the wireless, to make sure the DHCP discover actually went out the
radio.&nbsp; But you clearly are joined properly.<br>
  <br>
So check for any sort of MAC-based security in the DHCP server.<br>
  <br>
  <div class="gmail_quote">On Tue, Apr 28, 2009 at 4:16 PM, Jochen
Hebbrecht <span dir="ltr">&lt;<a moz-do-not-send="true"
 href="mailto:jochenhebbrecht@gmail.com">jochenhebbrecht@gmail.com</a>&gt;</span>
wrote:<br>
  <blockquote class="gmail_quote"
 style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
    <div bgcolor="#ffffff" text="#000000"><font size="-1"><font
 face="Verdana">Richard,<br>
    <br>
After rebooting a second time, eth1 isn't appearing in the routing
tabel any longer. The bridge seems to be working perfectly now!<br>
However, I'm not able to retreive any DHCP offers.<br>
    <br>
I did some packet monitoring:<br>
    <br>
br0<br>
    </font></font>
    <pre style="margin-top: 0pt; display: inline;">1	0.000000000	fe80::20a:e4ff:feae:7e4c	ff02::2	ICMPv6	Router solicitation
2	24.824098000	0.0.0.0	255.255.255.255	DHCP	DHCP Discover - Transaction ID 0xa117a72
3	28.824043000	0.0.0.0	255.255.255.255	DHCP	DHCP Discover - Transaction ID 0xa117a72
4	33.685106000	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1&nbsp; 
5	33.688946000	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1&nbsp; 
6	33.692700000	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1&nbsp; 
7	33.698081000	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1&nbsp; 
8	33.701656000	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1&nbsp; 
9	33.705492000	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1&nbsp; 
10	33.708885000	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1&nbsp; 
11	33.712502000	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1&nbsp; 
12	33.716242000	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1&nbsp; 
13	33.719929000	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1&nbsp; 
14	38.824050000	0.0.0.0	255.255.255.255	DHCP	DHCP Discover - Transaction ID 0xa117a72
15	48.824039000	0.0.0.0	255.255.255.255	DHCP	DHCP Discover - Transaction ID 0xa117a72
16	56.768033000	Wistron_ae:7e:4c	Broadcast	ARP	Who has 169.254.7.81?&nbsp; Tell 0.0.0.0
17	57.992048000	Wistron_ae:7e:4c	Broadcast	ARP	Who has 169.254.7.81?&nbsp; Tell 0.0.0.0
18	59.019954000	Wistron_ae:7e:4c	Broadcast	ARP	Who has 169.254.7.81?&nbsp; Tell 0.0.0.0
19	61.020124000	Wistron_ae:7e:4c	Broadcast	ARP	Gratuitous ARP for 169.254.7.81 (Request)
20	62.004532000	169.254.7.81	169.254.255.255	NBNS	Registration NB BACARDI&lt;20&gt;
21	62.004582000	169.254.7.81	169.254.255.255	NBNS	Registration NB BACARDI&lt;03&gt;
22	62.004615000	169.254.7.81	169.254.255.255	NBNS	Registration NB BACARDI&lt;00&gt;
23	62.004647000	169.254.7.81	169.254.255.255	NBNS	Registration NB MSHOME&lt;00&gt;
24	62.004679000	169.254.7.81	169.254.255.255	NBNS	Registration NB MSHOME&lt;1e&gt;
25	62.004775000	169.254.7.81	169.254.255.255	BROWSER	Host Announcement BACARDI, Workstation, Server, Print Queue Server, Xenix Server, NT Workstation, NT Server, Potential Browser, Unknown server type:23
26	63.023921000	Wistron_ae:7e:4c	Broadcast	ARP	Gratuitous ARP for 169.254.7.81 (Request)
27	64.003996000	169.254.7.81	169.254.255.255	NBNS	Registration NB BACARDI&lt;20&gt;
28	64.004033000	169.254.7.81	169.254.255.255	NBNS	Registration NB BACARDI&lt;03&gt;
29	64.004054000	169.254.7.81	169.254.255.255	NBNS	Registration NB BACARDI&lt;00&gt;
30	64.004075000	169.254.7.81	169.254.255.255	NBNS	Registration NB MSHOME&lt;00&gt;
31	64.004097000	169.254.7.81	169.254.255.255	NBNS	Registration NB MSHOME&lt;1e&gt;
32	64.004156000	169.254.7.81	169.254.255.255	NBNS	Registration NB BACARDI&lt;20&gt;
33	64.004179000	169.254.7.81	169.254.255.255	NBNS	Registration NB BACARDI&lt;03&gt;
34	64.004200000	169.254.7.81	169.254.255.255	NBNS	Registration NB BACARDI&lt;00&gt;
35	64.004220000	169.254.7.81	169.254.255.255	NBNS	Registration NB MSHOME&lt;00&gt;
36	64.004240000	169.254.7.81	169.254.255.255	NBNS	Registration NB MSHOME&lt;1e&gt;
37	65.127895000	Wistron_ae:7e:4c	Broadcast	ARP	Who has 195.130.129.165?&nbsp; Tell 169.254.7.81
38	66.004121000	169.254.7.81	169.254.255.255	NBNS	Registration NB BACARDI&lt;20&gt;
39	66.004177000	169.254.7.81	169.254.255.255	NBNS	Registration NB BACARDI&lt;03&gt;
40	66.004197000	169.254.7.81	169.254.255.255	NBNS	Registration NB BACARDI&lt;00&gt;
41	66.004219000	169.254.7.81	169.254.255.255	NBNS	Registration NB MSHOME&lt;00&gt;
42	66.004239000	169.254.7.81	169.254.255.255	NBNS	Registration NB MSHOME&lt;1e&gt;
43	66.127931000	Wistron_ae:7e:4c	Broadcast	ARP	Who has 195.130.129.165?&nbsp; Tell 169.254.7.81
44	67.127989000	Wistron_ae:7e:4c	Broadcast	ARP	Who has 195.130.129.165?&nbsp; Tell 169.254.7.81
45	70.127967000	Wistron_ae:7e:4c	Broadcast	ARP	Who has 195.130.130.165?&nbsp; Tell 169.254.7.81
46	71.128025000	Wistron_ae:7e:4c	Broadcast	ARP	Who has 195.130.130.165?&nbsp; Tell 169.254.7.81
    </pre>
    <br>
    <font size="-1"><font face="Verdana"><br>
eth0<br>
    </font></font>
    <pre style="margin-top: 0pt; display: inline;">1	0.000000	Wistron_ae:7e:4c	Broadcast	ARP	Who has 192.168.1.1?&nbsp; Tell 192.168.1.112
2	19.840146	0.0.0.0	255.255.255.255	DHCP	DHCP Discover - Transaction ID 0x8537ad48
3	24.840168	0.0.0.0	255.255.255.255	DHCP	DHCP Discover - Transaction ID 0x8537ad48
4	38.840099	0.0.0.0	255.255.255.255	DHCP	DHCP Discover - Transaction ID 0x8537ad48
5	45.513321	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1&nbsp; 
6	45.516537	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1&nbsp; 
7	45.520384	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1&nbsp; 
8	45.524058	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1&nbsp; 
9	45.527325	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1&nbsp; 
10	45.530872	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1&nbsp; 
11	45.534676	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1&nbsp; 
12	45.538019	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1&nbsp; 
13	45.541774	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1&nbsp; 
14	45.545417	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1&nbsp; 
15	45.549231	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1&nbsp; 
16	51.412036	Wistron_ae:7e:4c	Broadcast	ARP	Who has 169.254.7.81?&nbsp; Tell 0.0.0.0
17	53.360036	Wistron_ae:7e:4c	Broadcast	ARP	Who has 169.254.7.81?&nbsp; Tell 0.0.0.0
18	54.716034	Wistron_ae:7e:4c	Broadcast	ARP	Who has 169.254.7.81?&nbsp; Tell 0.0.0.0
19	56.716135	Wistron_ae:7e:4c	Broadcast	ARP	Gratuitous ARP for 169.254.7.81 (Request)
20	58.716070	Wistron_ae:7e:4c	Broadcast	ARP	Gratuitous ARP for 169.254.7.81 (Request)
21	60.775980	Wistron_ae:7e:4c	Broadcast	ARP	Who has 195.130.129.165?&nbsp; Tell 169.254.7.81</pre>
    <br>
    <font size="-1"><font face="Verdana"><br>
eth1<br>
    </font></font>
    <pre style="margin-top: 0pt; display: inline;">1	0.000000	fe80::215:ff:fe1f:20a6	ff02::2	ICMPv6	Router solicitation
2	25.983879	0.0.0.0	255.255.255.255	DHCP	DHCP Discover - Transaction ID 0xe2640e1c
3	30.983864	0.0.0.0	255.255.255.255	DHCP	DHCP Discover - Transaction ID 0xe2640e1c
4	32.949057	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1&nbsp; 
5	32.952404	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1&nbsp; 
6	32.957215	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1&nbsp; 
7	32.960893	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1&nbsp; 
8	32.964222	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1&nbsp; 
9	32.970023	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1&nbsp; 
10	32.973868	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1&nbsp; 
11	32.977056	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1&nbsp; 
12	32.981455	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1&nbsp; 
13	32.985056	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1&nbsp; 
14	32.988717	192.168.1.1	239.255.255.250	SSDP	NOTIFY * HTTP/1.1&nbsp; 
15	44.983895	0.0.0.0	255.255.255.255	DHCP	DHCP Discover - Transaction ID 0xe2640e1c
16	54.983846	0.0.0.0	255.255.255.255	DHCP	DHCP Discover - Transaction ID 0xe2640e1c
17	57.199856	Wistron_ae:7e:4c	Broadcast	ARP	Who has 169.254.7.81?&nbsp; Tell 0.0.0.0
18	58.967801	Wistron_ae:7e:4c	Broadcast	ARP	Who has 169.254.7.81?&nbsp; Tell 0.0.0.0
19	60.039785	Wistron_ae:7e:4c	Broadcast	ARP	Who has 169.254.7.81?&nbsp; Tell 0.0.0.0
20	62.039897	Wistron_ae:7e:4c	Broadcast	ARP	Gratuitous ARP for 169.254.7.81 (Request)
21	64.039860	Wistron_ae:7e:4c	Broadcast	ARP	Gratuitous ARP for 169.254.7.81 (Request)
22	66.107737	Wistron_ae:7e:4c	Broadcast	ARP	Who has 195.130.129.165?&nbsp; Tell 169.254.7.81
23	66.164183	169.254.7.81	169.254.255.255	NBNS	Registration NB BACARDI&lt;20&gt;
24	66.164203	169.254.7.81	169.254.255.255	NBNS	Registration NB BACARDI&lt;03&gt;
25	66.164222	169.254.7.81	169.254.255.255	NBNS	Registration NB BACARDI&lt;00&gt;
26	66.164241	169.254.7.81	169.254.255.255	NBNS	Registration NB MSHOME&lt;00&gt;
27	66.164258	169.254.7.81	169.254.255.255	NBNS	Registration NB MSHOME&lt;1e&gt;
28	66.164314	169.254.7.81	169.254.255.255	BROWSER	Host Announcement BACARDI, Workstation, Server, Print Queue Server, Xenix Server, NT Workstation, NT Server, Potential Browser, Unknown server type:23</pre>
    <br>
    <font size="-1"><font face="Verdana"><br>
You can see the DHCP discovers, but nobody's answering<br>
    <br>
    <br>
    </font></font><br>
    <a moz-do-not-send="true" href="mailto:richardvoigt@gmail.com"
 target="_blank">richardvoigt@gmail.com</a> schreef:
    <div>
    <div class="h5">
    <blockquote type="cite">Do some packet monitoring on your wireless
network to see
if the DHCP request is going out over the air... your problems stem
from not getting a DHCP address.&nbsp; At first I thought the address given
to eth1 might be interfering with br0... but it seems not.<br>
      <br>
      <div class="gmail_quote">On Tue, Apr 28, 2009 at 12:36 PM, Jochen
Hebbrecht <span dir="ltr">&lt;<a moz-do-not-send="true"
 href="mailto:jochenhebbrecht@gmail.com" target="_blank">jochenhebbrecht@gmail.com</a>&gt;</span>
wrote:<br>
      <blockquote class="gmail_quote"
 style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
        <br>
Ross Vandegrift schreef:<br>
        <blockquote class="gmail_quote"
 style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
          <div>On Tue, Apr 28, 2009 at 02:52:10PM +0200, Jochen
Hebbrecht wrote:<br>
&nbsp;<br>
          </div>
          <div>
          <blockquote class="gmail_quote"
 style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Okay,
thnx!<br>
Just a small question, I think I need to configure eth0 and eth1 to<br>
manual? And not to DHCP?<br>
            <br>
Like this:<br>
----------------------------------------<br>
auto eth0<br>
iface eth0 inet manual<br>
            <br>
auto eth1<br>
iface eth1 inet manual<br>
----------------------------------------<br>
&nbsp; &nbsp;<br>
          </blockquote>
          <br>
Ah - I missed that. &nbsp;Yes, you definitely want to set the member<br>
interfaces to manual.<br>
&nbsp; &nbsp;<br>
          <blockquote class="gmail_quote"
 style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">The
thing I don't understand then: if you execute a dhclient on br0,<br>
how does br0 know the configuration of eth1? Because there's a WPA2<br>
configuration on it. Will it use that settings too while bridging?<br>
&nbsp; &nbsp;<br>
          </blockquote>
          <br>
I'll be honest, I'm not sure - I've never done that with<br>
wpa_supplicant and the debian tools. &nbsp;You might need to activate<br>
wpa_supplicant in the pre-up for br0.<br>
          <br>
Check out the manpage for interfaces - it may have more details.<br>
&nbsp;<br>
          </div>
        </blockquote>
        <br>
Ok, I made it myself a little easier by temporarly switching from WPA2
to unsecure wireless networking.<br>
        <br>
I'm having the following configuration:<br>
        <br>
Code:
        <div><br>
        <br>
to lo<br>
iface lo inet loopback<br>
        <br>
        </div>
        <div>auto eth0<br>
iface eth0 inet manual<br>
        <br>
auto eth1<br>
iface eth1 inet manual<br>
        </div>
wireless-essid ##MY-ESSID##<br>
wireless-mode managed<br>
        <br>
auto br0
        <div><br>
iface br0 inet dhcp<br>
bridge_ports eth0, eth1<br>
        <br>
        </div>
When I reboot, my interfaces are getting the following config:<br>
        <br>
Code:
        <div><br>
        <br>
br0 &nbsp; &nbsp; &nbsp; Link encap:Ethernet &nbsp;HWaddr 00:0a:e4:ae:7e:4c &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; inet6
addr: fe80::20a:e4ff:feae:7e4c/64 Scope:Link<br>
&nbsp; &nbsp; &nbsp; &nbsp; UP BROADCAST RUNNING MULTICAST &nbsp;MTU:1500 &nbsp;Metric:1<br>
        </div>
&nbsp; &nbsp; &nbsp; &nbsp; RX packets:87 errors:0 dropped:0 overruns:0 frame:0<br>
&nbsp; &nbsp; &nbsp; &nbsp; TX packets:23 errors:0 dropped:0 overruns:0 carrier:0<br>
&nbsp; &nbsp; &nbsp; &nbsp; collisions:0 txqueuelen:0 &nbsp; &nbsp; &nbsp; &nbsp; RX bytes:17544 (17.1 KB) &nbsp;TX
bytes:3744 (3.6 KB)
        <div><br>
        <br>
br0:avahi Link encap:Ethernet &nbsp;HWaddr 00:0a:e4:ae:7e:4c &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; inet
addr:169.254.7.81 &nbsp;Bcast:169.254.255.255 &nbsp;Mask:255.255.0.0<br>
&nbsp; &nbsp; &nbsp; &nbsp; UP BROADCAST RUNNING MULTICAST &nbsp;MTU:1500 &nbsp;Metric:1<br>
        <br>
eth0 &nbsp; &nbsp; &nbsp;Link encap:Ethernet &nbsp;HWaddr 00:0a:e4:ae:7e:4c &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; inet6
addr: fe80::20a:e4ff:feae:7e4c/64 Scope:Link<br>
&nbsp; &nbsp; &nbsp; &nbsp; UP BROADCAST RUNNING MULTICAST &nbsp;MTU:1500 &nbsp;Metric:1<br>
        </div>
&nbsp; &nbsp; &nbsp; &nbsp; RX packets:3 errors:0 dropped:0 overruns:0 frame:0<br>
&nbsp; &nbsp; &nbsp; &nbsp; TX packets:89 errors:0 dropped:0 overruns:0 carrier:0<br>
&nbsp; &nbsp; &nbsp; &nbsp; collisions:0 txqueuelen:1000 &nbsp; &nbsp; &nbsp; &nbsp; RX bytes:1770 (1.7 KB) &nbsp;TX
bytes:23069 (22.5 KB)
        <div><br>
&nbsp; &nbsp; &nbsp; &nbsp; Interrupt:20 Base address:0xc000 <br>
        </div>
eth1 &nbsp; &nbsp; &nbsp;Link encap:Ethernet &nbsp;HWaddr 00:15:00:1f:20:a6 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; inet
addr:192.168.1.111 &nbsp;Bcast:192.168.1.255 &nbsp;Mask:255.255.255.0
        <div><br>
&nbsp; &nbsp; &nbsp; &nbsp; inet6 addr: fe80::215:ff:fe1f:20a6/64 Scope:Link<br>
&nbsp; &nbsp; &nbsp; &nbsp; UP BROADCAST RUNNING MULTICAST &nbsp;MTU:1500 &nbsp;Metric:1<br>
        </div>
&nbsp; &nbsp; &nbsp; &nbsp; RX packets:223 errors:0 dropped:0 overruns:0 frame:0<br>
&nbsp; &nbsp; &nbsp; &nbsp; TX packets:99 errors:0 dropped:0 overruns:0 carrier:0<br>
&nbsp; &nbsp; &nbsp; &nbsp; collisions:0 txqueuelen:1000 &nbsp; &nbsp; &nbsp; &nbsp; RX bytes:18762 (18.3 KB)
&nbsp;TX bytes:8392 (8.1 KB)<br>
&nbsp; &nbsp; &nbsp; &nbsp; Interrupt:21 Base address:0xa000 Memory:c8006000-c8006fff <br>
        <div>lo &nbsp; &nbsp; &nbsp; &nbsp;Link encap:Local Loopback &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; inet
addr:127.0.0.1 &nbsp;Mask:255.0.0.0<br>
&nbsp; &nbsp; &nbsp; &nbsp; inet6 addr: ::1/128 Scope:Host<br>
&nbsp; &nbsp; &nbsp; &nbsp; UP LOOPBACK RUNNING &nbsp;MTU:16436 &nbsp;Metric:1<br>
        </div>
&nbsp; &nbsp; &nbsp; &nbsp; RX packets:1879 errors:0 dropped:0 overruns:0 frame:0<br>
&nbsp; &nbsp; &nbsp; &nbsp; TX packets:1879 errors:0 dropped:0 overruns:0 carrier:0<br>
&nbsp; &nbsp; &nbsp; &nbsp; collisions:0 txqueuelen:0 &nbsp; &nbsp; &nbsp; &nbsp; RX bytes:94956 (92.7 KB) &nbsp;TX
bytes:94956 (92.7 KB<br>
        <br>
The bridge looks ok:<br>
        <br>
Code:<br>
        <br>
jochus@Bacardi ~ $ sudo brctl show br0<br>
[sudo] password for jochus: bridge name &nbsp; &nbsp; bridge id &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; STP
enabled &nbsp; &nbsp; interfaces<br>
br0 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 8000.000ae4ae7e4c &nbsp; &nbsp; &nbsp; no &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;eth0<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; eth1<br>
        <br>
My routing table looks like this:<br>
        <br>
Code:
        <div><br>
        <br>
Kernel IP routing table<br>
Destination &nbsp; &nbsp; Gateway &nbsp; &nbsp; &nbsp; &nbsp; Genmask &nbsp; &nbsp; &nbsp; &nbsp; Flags Metric Ref &nbsp; &nbsp;Use
Iface<br>
        </div>
192.168.1.0 &nbsp; &nbsp; 0.0.0.0 &nbsp; &nbsp; &nbsp; &nbsp; 255.255.255.0 &nbsp; U &nbsp; &nbsp; 0 &nbsp; &nbsp; &nbsp;0 &nbsp; &nbsp; &nbsp; &nbsp;0
eth1
        <div><br>
169.254.0.0 &nbsp; &nbsp; 0.0.0.0 &nbsp; &nbsp; &nbsp; &nbsp; 255.255.0.0 &nbsp; &nbsp; U &nbsp; &nbsp; 0 &nbsp; &nbsp; &nbsp;0 &nbsp; &nbsp; &nbsp; &nbsp;0
br0<br>
        </div>
0.0.0.0 &nbsp; &nbsp; &nbsp; &nbsp; 192.168.1.1 &nbsp; &nbsp; 0.0.0.0 &nbsp; &nbsp; &nbsp; &nbsp; UG &nbsp; &nbsp;0 &nbsp; &nbsp; &nbsp;0 &nbsp; &nbsp; &nbsp; &nbsp;0
eth1<br>
0.0.0.0 &nbsp; &nbsp; &nbsp; &nbsp; 0.0.0.0 &nbsp; &nbsp; &nbsp; &nbsp; 0.0.0.0 &nbsp; &nbsp; &nbsp; &nbsp; U &nbsp; &nbsp; 1000 &nbsp; 0 &nbsp; &nbsp; &nbsp; &nbsp;0
br0<br>
        <br>
But I'm not able to ping my router ...<br>
        <br>
Code:<br>
        <br>
PING 192.168.1.1 (192.168.1.1) 56(84) bytes of data.<br>
From 192.168.1.111 icmp_seq=1 Destination Host Unreachable<br>
From 192.168.1.111 icmp_seq=2 Destination Host Unreachable<br>
From 192.168.1.111 icmp_seq=3 Destination Host Unreachable<br>
        <br>
--- 192.168.1.1 ping statistics ---<br>
5 packets transmitted, 0 received, +3 errors, 100% packet loss, time
4018ms<br>
        <br>
I don't understand why eth1 is in my routing table. It shouldn't be I
guess?<br>
Anybody some idea's?<br>
      </blockquote>
      </div>
      <br>
    </blockquote>
    </div>
    </div>
    </div>
  </blockquote>
  </div>
  <br>
</blockquote>
</body>
</html>

--------------070203050402040901070602--
