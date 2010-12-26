Message-ID: <4D1779B6.9050305@wanadoo.nl>
Date: Sun, 26 Dec 2010 18:21:58 +0100
From: Rolf Fokkens <rolf.fokkens@wanadoo.nl>
MIME-Version: 1.0
References: <4D0E868E.4010309@wanadoo.nl> <20101220103754.7d18de50@s6510>
	<4D0FB6AC.2020901@wanadoo.nl>
In-Reply-To: <4D0FB6AC.2020901@wanadoo.nl>
Content-Type: multipart/alternative;
	boundary="------------070502090209080704000109"
Subject: Re: [Bridge] Why should static MAC address match one of the port
 MAC addresses - bug?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org
Cc: Stephen Hemminger <shemminger@vyatta.com>

This is a multi-part message in MIME format.
--------------070502090209080704000109
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

In this particular situation it's not possible to do so as all 
interfaces are tap interfaces, with random generated MAC addresses. 
Changing the tap interface's MAC address results in this:

    [root@home01 ~]# ifconfig tap0 hw ether BA:B7:73:58:E6:E2
    SIOCSIFHWADDR: Device or resource busy
    [root@home01 ~]#

So that doen't work. I found a trick however: I added a dummy ethernet 
interface to the bridge, of which i can specify the MAC address, It 
works fine, but in syslog there's the following message:

    Dec 26 17:45:21 home01 kernel: [   29.316480] br0: new device dummy0
    does not support netpoll (disabling)

This means that the bridge won't use/support netpoll at all, which may 
mean there's an impact on performance. I'm not sure. I can imagine that 
a netpoll interface for a dummy interface shouldn't be hard to implement.

Attempting to summarize:

    * specifying the MAC address of a bridge interface can result in
      confusing results
    * Allowing the changing of tap interfaces' MAC addresses could be
      sensible
    * A netpoll interface for dummy ethernet might be usefull for bridge
      users


On Mon, 20 Dec 2010 Stephen Hemminger wrote:

>  Yes, that is a problem.
>  If address does not match any of the interfaces assigned to bridge,
>  then it won't be in the forwarding table.

>  But, fixing it would introduce more issues because the forwarding
>  table entry would match any port in bridge..  Therefore for sanity,
>  don't assign mac address to something not in the bridge.


On 12/20/2010 09:03 PM, Rolf Fokkens wrote:
> Hi,
>
> I think that the bridge interface no longer sees unicast messages 
> addressed to it, after changing the MAC address. I'll explain:
>
> I chose a different MAC address, 02:77:00:00:01:02. This MAC address 
> is absolutely not present on another interface. The MAC address of the 
> Windows XP client is 02:00:00:00:00:01. The bridge interface br2 now 
> only has one interface tap0 which links to the Windows XP client.
>
> [root@home01 ~]# brctl show
> bridge name    bridge id        STP enabled    interfaces
> br0        8000.002215b81084    no        eth0.3
> br1        8000.002215b81084    no        eth0.4
> br2        8000.027700000102    no        tap0
> br3        8000.002215b81084    no        eth0.1253
>
> The IP address of the Windows XP guest is 192.168.252.1, the IP 
> address of the bridge interface is 192.168.252.254, which is the 
> default gateway address of the Windows XP guest.
>
> Now let's look at the ARP entries. First the Windows XP guest:
>
> C:\>arp -a
>
> Interface 192.168.252.1 --- 0x2
>   Internet Address   Physical Address      Type
>   192.168.252.254   02-77-00-00-01-02   dynamic
>
> Next on the Linux host:
>
> [root@home01 ~]# arp -n
> Address                  HWtype  HWaddress           Flags 
> Mask            Iface
> 192.168.254.7            ether   00:18:f3:fd:09:7a   
> C                     br1
> 192.168.254.18           ether   00:16:e8:29:bc:e3   
> C                     br1
> 192.168.1.1              ether   00:0e:50:64:7f:74   
> C                     br0
> 192.168.254.16           ether   90:84:0d:6f:26:1c   
> C                     br1
> 192.168.1.128            ether   00:21:85:98:45:84   
> C                     br0
> 192.168.252.1                    
> (incomplete)                              br2
> 192.168.254.9            ether   18:a9:05:39:14:95   
> C                     br1
> [root@home01 ~]#
>
> So now we see that the Windows XP guest is aware of the new MAC 
> address of the bridge. However the Linux host is not aware of the 
> guest's MAC address! Time to see what's happening when we use tcpdump:
>
> [root@home01 ~]# tcpdump -n -e -i tap0 arp
> tcpdump: WARNING: tap0: no IPv4 address assigned
> tcpdump: verbose output suppressed, use -v or -vv for full protocol 
> decode
> listening on tap0, link-type EN10MB (Ethernet), capture size 65535 bytes
>
> 20:42:23.606319 02:00:00:00:00:01 > Broadcast, ethertype ARP (0x0806), 
> length 42: Request who-has 192.168.252.254 tell 192.168.252.1, length 28
> 20:42:23.606359 02:77:00:00:01:02 > 02:00:00:00:00:01, ethertype ARP 
> (0x0806), length 42: Reply 192.168.252.254 is-at 02:77:00:00:01:02, 
> length 28
>
> 20:47:42.503536 02:77:00:00:01:02 > Broadcast, ethertype ARP (0x0806), 
> length 42: Request who-has 192.168.252.1 tell 192.168.252.254, length 28
> 20:47:42.504039 02:00:00:00:00:01 > 02:77:00:00:01:02, ethertype ARP 
> (0x0806), length 42: Reply 192.168.252.1 is-at 02:00:00:00:00:01, 
> length 28
> 20:47:43.505541 02:77:00:00:01:02 > Broadcast, ethertype ARP (0x0806), 
> length 42: Request who-has 192.168.252.1 tell 192.168.252.254, length 28
> 20:47:43.506316 02:00:00:00:00:01 > 02:77:00:00:01:02, ethertype ARP 
> (0x0806), length 42: Reply 192.168.252.1 is-at 02:00:00:00:00:01, 
> length 28
> 20:47:44.507539 02:77:00:00:01:02 > Broadcast, ethertype ARP (0x0806), 
> length 42: Request who-has 192.168.252.1 tell 192.168.252.254, length 28
> 20:47:44.508319 02:00:00:00:00:01 > 02:77:00:00:01:02, ethertype ARP 
> (0x0806), length 42: Reply 192.168.252.1 is-at 02:00:00:00:00:01, 
> length 28
>
> First we see an ARP request from the Windows XP guest to find the 
> host's 192.168.252.254. There is a fast ARP response, so this is 
> consistent with the ARP table on the Windows XP guest.
>
> Next we see an ARP request from the Linux host to find the guest's 
> 192.168.252.1. This is followed by a fast ARP response. Despite the 
> response both the request and the response are repeated 3 times. This 
> is consistent with the fact that the ARP table on the Linux host is 
> missing the guest's MAC address.
>
> So, apparently both interfaces (br2 and tap0) see the ethernet 
> broadcast, but only the guest's interface (tap0) sees the unicast. 
> This is confirmed by brctl's output:
>
> [root@home01 ~]# brctl showmacs br2
> port no mac addr           is local? ageing timer
>   1     02:00:00:00:00:01  no        5.38
>   1     82:7a:bf:ee:e8:5e  yes       0.00
> [root@home01 ~]#
>
> We see two interresting MAC addresses. the first one is the MAC 
> address of the Windows XP guest, which indeed is not local. The second 
> one is the MAC address of the tap0 interface on the host side, which 
> apparently is local. But where's the mac address of br0 itself? It's 
> missing.
>
> This seems unintentional to me.
>
> Rolf
>


--------------070502090209080704000109
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#ffffff">
    In this particular situation it's not possible to do so as all
    interfaces are tap interfaces, with random generated MAC addresses.
    Changing the tap interface's MAC address results in this:<br>
    <blockquote><tt>[root@home01 ~]# ifconfig tap0 hw ether
        BA:B7:73:58:E6:E2</tt><br>
      <tt>SIOCSIFHWADDR: Device or resource busy</tt><br>
      <tt>[root@home01 ~]#</tt><br>
    </blockquote>
    So that doen't work. I found a trick however: I added a dummy
    ethernet interface to the bridge, of which i can specify the MAC
    address, It works fine, but in syslog there's the following message:<br>
    <blockquote><tt>Dec 26 17:45:21 home01 kernel: [&nbsp;&nbsp; 29.316480] br0:
        new device dummy0 does not support netpoll (disabling)</tt><br>
    </blockquote>
    This means that the bridge won't use/support netpoll at all, which
    may mean there's an impact on performance. I'm not sure. I can
    imagine that a netpoll interface for a dummy interface shouldn't be
    hard to implement.<br>
    <br>
    Attempting to summarize:<br>
    <ul>
      <li>specifying the MAC address of a bridge interface can result in
        confusing results</li>
      <li>Allowing the changing of tap interfaces' MAC addresses could
        be sensible</li>
      <li>A netpoll interface for dummy ethernet might be usefull for
        bridge users<br>
      </li>
    </ul>
    <br>
    On Mon, 20 Dec 2010 Stephen Hemminger wrote:<br>
    <pre>&gt; Yes, that is a problem.
&gt; If address does not match any of the interfaces assigned to bridge,
&gt; then it won't be in the forwarding table.

&gt; But, fixing it would introduce more issues because the forwarding
&gt; table entry would match any port in bridge..  Therefore for sanity,
&gt; don't assign mac address to something not in the bridge.
</pre>
    <br>
    On 12/20/2010 09:03 PM, Rolf Fokkens wrote:
    <blockquote cite="mid:4D0FB6AC.2020901@wanadoo.nl" type="cite">Hi,
      <br>
      <br>
      I think that the bridge interface no longer sees unicast messages
      addressed to it, after changing the MAC address. I'll explain:
      <br>
      <br>
      I chose a different MAC address, 02:77:00:00:01:02. This MAC
      address is absolutely not present on another interface. The MAC
      address of the Windows XP client is 02:00:00:00:00:01. The bridge
      interface br2 now only has one interface tap0 which links to the
      Windows XP client.
      <br>
      <br>
      [root@home01 ~]# brctl show
      <br>
      bridge name&nbsp;&nbsp;&nbsp; bridge id&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; STP enabled&nbsp;&nbsp;&nbsp; interfaces
      <br>
      br0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8000.002215b81084&nbsp;&nbsp;&nbsp; no&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eth0.3
      <br>
      br1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8000.002215b81084&nbsp;&nbsp;&nbsp; no&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eth0.4
      <br>
      br2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8000.027700000102&nbsp;&nbsp;&nbsp; no&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tap0
      <br>
      br3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8000.002215b81084&nbsp;&nbsp;&nbsp; no&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eth0.1253
      <br>
      <br>
      The IP address of the Windows XP guest is 192.168.252.1, the IP
      address of the bridge interface is 192.168.252.254, which is the
      default gateway address of the Windows XP guest.
      <br>
      <br>
      Now let's look at the ARP entries. First the Windows XP guest:
      <br>
      <br>
      C:\&gt;arp -a
      <br>
      <br>
      Interface 192.168.252.1 --- 0x2
      <br>
      &nbsp; Internet Address&nbsp;&nbsp; Physical Address&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Type
      <br>
      &nbsp; 192.168.252.254&nbsp;&nbsp; 02-77-00-00-01-02&nbsp;&nbsp; dynamic
      <br>
      <br>
      Next on the Linux host:
      <br>
      <br>
      [root@home01 ~]# arp -n
      <br>
      Address&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HWtype&nbsp; HWaddress&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Flags
      Mask&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Iface
      <br>
      192.168.254.7&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ether&nbsp;&nbsp; 00:18:f3:fd:09:7a&nbsp;&nbsp;
      C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; br1
      <br>
      192.168.254.18&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ether&nbsp;&nbsp; 00:16:e8:29:bc:e3&nbsp;&nbsp;
      C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; br1
      <br>
      192.168.1.1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ether&nbsp;&nbsp; 00:0e:50:64:7f:74&nbsp;&nbsp;
      C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; br0
      <br>
      192.168.254.16&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ether&nbsp;&nbsp; 90:84:0d:6f:26:1c&nbsp;&nbsp;
      C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; br1
      <br>
      192.168.1.128&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ether&nbsp;&nbsp; 00:21:85:98:45:84&nbsp;&nbsp;
      C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; br0
      <br>
      192.168.252.1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      (incomplete)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; br2
      <br>
      192.168.254.9&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ether&nbsp;&nbsp; 18:a9:05:39:14:95&nbsp;&nbsp;
      C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; br1
      <br>
      [root@home01 ~]#
      <br>
      <br>
      So now we see that the Windows XP guest is aware of the new MAC
      address of the bridge. However the Linux host is not aware of the
      guest's MAC address! Time to see what's happening when we use
      tcpdump:
      <br>
      <br>
      [root@home01 ~]# tcpdump -n -e -i tap0 arp
      <br>
      tcpdump: WARNING: tap0: no IPv4 address assigned
      <br>
      tcpdump: verbose output suppressed, use -v or -vv for full
      protocol decode
      <br>
      listening on tap0, link-type EN10MB (Ethernet), capture size 65535
      bytes
      <br>
      <br>
      20:42:23.606319 02:00:00:00:00:01 &gt; Broadcast, ethertype ARP
      (0x0806), length 42: Request who-has 192.168.252.254 tell
      192.168.252.1, length 28
      <br>
      20:42:23.606359 02:77:00:00:01:02 &gt; 02:00:00:00:00:01,
      ethertype ARP (0x0806), length 42: Reply 192.168.252.254 is-at
      02:77:00:00:01:02, length 28
      <br>
      <br>
      20:47:42.503536 02:77:00:00:01:02 &gt; Broadcast, ethertype ARP
      (0x0806), length 42: Request who-has 192.168.252.1 tell
      192.168.252.254, length 28
      <br>
      20:47:42.504039 02:00:00:00:00:01 &gt; 02:77:00:00:01:02,
      ethertype ARP (0x0806), length 42: Reply 192.168.252.1 is-at
      02:00:00:00:00:01, length 28
      <br>
      20:47:43.505541 02:77:00:00:01:02 &gt; Broadcast, ethertype ARP
      (0x0806), length 42: Request who-has 192.168.252.1 tell
      192.168.252.254, length 28
      <br>
      20:47:43.506316 02:00:00:00:00:01 &gt; 02:77:00:00:01:02,
      ethertype ARP (0x0806), length 42: Reply 192.168.252.1 is-at
      02:00:00:00:00:01, length 28
      <br>
      20:47:44.507539 02:77:00:00:01:02 &gt; Broadcast, ethertype ARP
      (0x0806), length 42: Request who-has 192.168.252.1 tell
      192.168.252.254, length 28
      <br>
      20:47:44.508319 02:00:00:00:00:01 &gt; 02:77:00:00:01:02,
      ethertype ARP (0x0806), length 42: Reply 192.168.252.1 is-at
      02:00:00:00:00:01, length 28
      <br>
      <br>
      First we see an ARP request from the Windows XP guest to find the
      host's 192.168.252.254. There is a fast ARP response, so this is
      consistent with the ARP table on the Windows XP guest.
      <br>
      <br>
      Next we see an ARP request from the Linux host to find the guest's
      192.168.252.1. This is followed by a fast ARP response. Despite
      the response both the request and the response are repeated 3
      times. This is consistent with the fact that the ARP table on the
      Linux host is missing the guest's MAC address.
      <br>
      <br>
      So, apparently both interfaces (br2 and tap0) see the ethernet
      broadcast, but only the guest's interface (tap0) sees the unicast.
      This is confirmed by brctl's output:
      <br>
      <br>
      [root@home01 ~]# brctl showmacs br2
      <br>
      port no mac addr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; is local? ageing timer
      <br>
      &nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp; 02:00:00:00:00:01&nbsp; no&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5.38
      <br>
      &nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp; 82:7a:bf:ee:e8:5e&nbsp; yes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.00
      <br>
      [root@home01 ~]#
      <br>
      <br>
      We see two interresting MAC addresses. the first one is the MAC
      address of the Windows XP guest, which indeed is not local. The
      second one is the MAC address of the tap0 interface on the host
      side, which apparently is local. But where's the mac address of
      br0 itself? It's missing.
      <br>
      <br>
      This seems unintentional to me.
      <br>
      <br>
      Rolf
      <br>
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------070502090209080704000109--
