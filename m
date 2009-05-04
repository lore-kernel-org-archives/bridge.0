MIME-Version: 1.0
In-Reply-To: <49FF58EC.2090902@gmail.com>
References: <20090428124009.GA26387@kallisti.us> <49F8C4C3.9020504@gmail.com>
	<2e59e6970904292118u71ff441ft19448f753c1b6dd9@mail.gmail.com>
	<db99f77d0904292330n4c460ccbv45e60f06bfa49c4@mail.gmail.com>
	<49FA1E28.5020604@free.fr> <49FC4764.3030707@gmail.com>
	<49FDD890.1090302@free.fr> <49FF41C4.4090404@gmail.com>
	<49FF4AF8.1050801@free.fr> <49FF58EC.2090902@gmail.com>
Date: Mon, 4 May 2009 18:33:18 -0500
Message-ID: <2e59e6970905041633u57678f2dn4e433ec417475927@mail.gmail.com>
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Content-Type: multipart/alternative; boundary=001485f64b484a1c3904691e967e
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
To: Jochen Hebbrecht <jochenhebbrecht@gmail.com>
Cc: bridge@lists.linux-foundation.org

--001485f64b484a1c3904691e967e
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2009 at 4:06 PM, Jochen Hebbrecht
<jochenhebbrecht@gmail.com>wrote:

> Nicolas de Peslo=FCan schreef:
> >
> > I think that the "Destination Host Unreachable" is caused by some sort
> > of "down link", because wpa_supplicant failed to establish the wifi
> > link. When eth1 is part of the br0, packets received on eth1 is
> > "forwarded" to br0 and not available on eth1. So wpa_supplicant must
> > be instructed to listen for incoming packets on br0, not on eth1.
> >
> > Can you try the exact same configuration, adding wpa-bridge br0 in the
> > eth1 stanza, to inform wpa_supplicant where to listen from ?
> >
> > auto lo
> > iface lo inet loopback
> >
> > auto eth1
> > iface eth1 inet manual
> > wpa-driver wext
> > wpa-ssid ##SSID##
> > wpa-ap-scan 1
> > wpa-proto RSN
> > wpa-pairwise CCMP
> > wpa-group CCMP
> > wpa-key-mgmt WPA-PSK
> > wpa-psk ##PSK KEY##
> > wpa-bridge br0          <--- HERE.
> >
> > auto br0
> > iface br0 inet static
> > bridge_ports eth1
> > address 192.168.1.111
> > netmask 255.255.255.0
> > gateway 192.168.1.1
> I changed the configuration and restarted the networking daemon. I'm
> getting this output
>
> jochus@Bacardi ~ $ sudo /etc/init.d/networking restart
>  * Reconfiguring network
> interfaces...
> ioctl[SIOCGIFINDEX]: No such device
> Failed to open l2_packet connection for the bridge interface 'br0'
> wpa_supplicant: /sbin/wpa_supplicant daemon failed to start
> run-parts: /etc/network/if-pre-up.d/wpasupplicant exited with return code=
 1
>
> Waiting for br0 to get ready (MAXWAIT is 32 seconds).
>

Surely things are getting run in the wrong order.

First, the bridge should be created.
Then, the interfaces should be configured, joined to the bridge, and brough=
t
up.
Then wpa_supplicant should run.
After wpa_supplicant associates to the wireless access point, then dhcp
should succeed.

It seems like ubuntu's network scripts don't create the bridge until too
late.


>
>
> I'm worried about the wpa_supplicant error. The file is present:
>
> jochus@Bacardi ~ $ ls -al /sbin/wpa_supplicant
> -rwxr-xr-x 1 root root 319812 2008-03-12 22:28 /sbin/wpa_supplicant
>
> The output of ifconfig:
>
> jochus@Bacardi ~ $ route -n
> Kernel IP routing table
> Destination     Gateway         Genmask         Flags Metric Ref    Use
> Iface
> 192.168.1.0     0.0.0.0         255.255.255.0   U     0      0        0 b=
r0
> 169.254.0.0     0.0.0.0         255.255.0.0     U     1000   0        0 b=
r0
> 0.0.0.0         192.168.1.1     0.0.0.0         UG    100    0        0 b=
r0
>
> jochus@Bacardi ~ $ ifconfig
> br0       Link encap:Ethernet  HWaddr 00:15:00:1f:20:a6
>          inet addr:192.168.1.111  Bcast:192.168.1.255  Mask:255.255.255.0
>          inet6 addr: fe80::215:ff:fe1f:20a6/64 Scope:Link
>          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:12 errors:0 dropped:0 overruns:0 carrier:0
>          collisions:0 txqueuelen:0
>          RX bytes:0 (0.0 B)  TX bytes:720 (720.0 B)
>
> eth0      Link encap:Ethernet  HWaddr 00:0a:e4:ae:7e:4c
>           UP BROADCAST MULTICAST  MTU:1500  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>          collisions:0 txqueuelen:1000
>          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
>           Interrupt:20 Base address:0xc000
>
> eth1      Link encap:Ethernet  HWaddr 00:15:00:1f:20:a6
>           UP BROADCAST MULTICAST  MTU:1500  Metric:1
>           RX packets:5255 errors:12 dropped:12 overruns:0 frame:0
>          TX packets:466 errors:0 dropped:0 overruns:0 carrier:0
>          collisions:0 txqueuelen:1000
>          RX bytes:912108 (890.7 KB)  TX bytes:113643 (110.9 KB)
>          Interrupt:21 Memory:c8006000-c8006fff
>
> lo        Link encap:Local Loopback
>          inet addr:127.0.0.1  Mask:255.0.0.0
>          inet6 addr: ::1/128 Scope:Host
>          UP LOOPBACK RUNNING  MTU:16436  Metric:1
>           RX packets:1974 errors:0 dropped:0 overruns:0 frame:0
>          TX packets:1974 errors:0 dropped:0 overruns:0 carrier:0
>          collisions:0 txqueuelen:0
>          RX bytes:101385 (99.0 KB)  TX bytes:101385 (99.0 KB)
>
> The output of iwconfig of eth1
>
> jochus@Bacardi ~ $ iwconfig eth1
> eth1      unassociated  ESSID:"Jochus"
>          Mode:Managed  Frequency=3D2.462 GHz  Access Point: Not-Associate=
d
>          Bit Rate:0 kb/s   Tx-Power=3D20 dBm   Sensitivity=3D8/0
>          Retry limit:7   RTS thr:off   Fragment thr:off
>          Power Management:off
>          Link Quality:0  Signal level:0  Noise level:0
>          Rx invalid nwid:0  Rx invalid crypt:146  Rx invalid frag:0
>          Tx excessive retries:0  Invalid misc:0   Missed beacon:0
>
> The output of arp -an:
>
> jochus@Bacardi ~ $ arp -an
> ? (192.168.1.1) at <incomplete> on br0
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>

--001485f64b484a1c3904691e967e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Mon, May 4, 2009 at 4:06 PM, Jochen H=
ebbrecht <span dir=3D"ltr">&lt;<a href=3D"mailto:jochenhebbrecht@gmail.com"=
>jochenhebbrecht@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt =
0pt 0pt 0.8ex; padding-left: 1ex;">
Nicolas de Peslo=FCan schreef:<br>
<div><div></div><div class=3D"h5">&gt;<br>
&gt; I think that the &quot;Destination Host Unreachable&quot; is caused by=
 some sort<br>
&gt; of &quot;down link&quot;, because wpa_supplicant failed to establish t=
he wifi<br>
&gt; link. When eth1 is part of the br0, packets received on eth1 is<br>
&gt; &quot;forwarded&quot; to br0 and not available on eth1. So wpa_supplic=
ant must<br>
&gt; be instructed to listen for incoming packets on br0, not on eth1.<br>
&gt;<br>
&gt; Can you try the exact same configuration, adding wpa-bridge br0 in the=
<br>
&gt; eth1 stanza, to inform wpa_supplicant where to listen from ?<br>
&gt;<br>
&gt; auto lo<br>
&gt; iface lo inet loopback<br>
&gt;<br>
&gt; auto eth1<br>
&gt; iface eth1 inet manual<br>
&gt; wpa-driver wext<br>
&gt; wpa-ssid ##SSID##<br>
&gt; wpa-ap-scan 1<br>
&gt; wpa-proto RSN<br>
&gt; wpa-pairwise CCMP<br>
&gt; wpa-group CCMP<br>
&gt; wpa-key-mgmt WPA-PSK<br>
&gt; wpa-psk ##PSK KEY##<br>
&gt; wpa-bridge br0 =A0 =A0 =A0 =A0 =A0&lt;--- HERE.<br>
&gt;<br>
&gt; auto br0<br>
&gt; iface br0 inet static<br>
&gt; bridge_ports eth1<br>
&gt; address 192.168.1.111<br>
&gt; netmask 255.255.255.0<br>
&gt; gateway 192.168.1.1<br>
</div></div>I changed the configuration and restarted the networking daemon=
. I&#39;m<br>
getting this output<br>
<br>
jochus@Bacardi ~ $ sudo /etc/init.d/networking restart<br>
=A0* Reconfiguring network<br>
interfaces...<br>
ioctl[SIOCGIFINDEX]: No such device<br>
Failed to open l2_packet connection for the bridge interface &#39;br0&#39;<=
br>
wpa_supplicant: /sbin/wpa_supplicant daemon failed to start<br>
run-parts: /etc/network/if-pre-up.d/wpasupplicant exited with return code 1=
<br>
<div class=3D"im"><br>
Waiting for br0 to get ready (MAXWAIT is 32 seconds).<br>
</div></blockquote><div><br>Surely things are getting run in the wrong orde=
r.<br><br>First, the bridge should be created.<br>Then, the interfaces shou=
ld be configured, joined to the bridge, and brought up.<br>Then wpa_supplic=
ant should run.<br>
After wpa_supplicant associates to the wireless access point, then dhcp sho=
uld succeed.<br><br>It seems like ubuntu&#39;s network scripts don&#39;t cr=
eate the bridge until too late.<br>=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt =
0.8ex; padding-left: 1ex;">
<div class=3D"im"><br>
<br>
</div>I&#39;m worried about the wpa_supplicant error. The file is present:<=
br>
<br>
jochus@Bacardi ~ $ ls -al /sbin/wpa_supplicant<br>
-rwxr-xr-x 1 root root 319812 2008-03-12 22:28 /sbin/wpa_supplicant<br>
<br>
The output of ifconfig:<br>
<br>
jochus@Bacardi ~ $ route -n<br>
<div class=3D"im">Kernel IP routing table<br>
Destination =A0 =A0 Gateway =A0 =A0 =A0 =A0 Genmask =A0 =A0 =A0 =A0 Flags M=
etric Ref =A0 =A0Use<br>
Iface<br>
192.168.1.0 =A0 =A0 0.0.0.0 =A0 =A0 =A0 =A0 255.255.255.0 =A0 U =A0 =A0 0 =
=A0 =A0 =A00 =A0 =A0 =A0 =A00 br0<br>
169.254.0.0 =A0 =A0 0.0.0.0 =A0 =A0 =A0 =A0 255.255.0.0 =A0 =A0 U =A0 =A0 1=
000 =A0 0 =A0 =A0 =A0 =A00 br0<br>
0.0.0.0 =A0 =A0 =A0 =A0 192.168.1.1 =A0 =A0 0.0.0.0 =A0 =A0 =A0 =A0 UG =A0 =
=A0100 =A0 =A00 =A0 =A0 =A0 =A00 br0<br>
<br>
</div>jochus@Bacardi ~ $ ifconfig<br>
<div class=3D"im">br0 =A0 =A0 =A0 Link encap:Ethernet =A0HWaddr 00:15:00:1f=
:20:a6<br>
 =A0 =A0 =A0 =A0 =A0inet addr:192.168.1.111 =A0Bcast:192.168.1.255 =A0Mask:=
255.255.255.0<br>
 =A0 =A0 =A0 =A0 =A0inet6 addr: fe80::215:ff:fe1f:20a6/64 Scope:Link<br>
 =A0 =A0 =A0 =A0 =A0UP BROADCAST RUNNING MULTICAST =A0MTU:1500 =A0Metric:1<=
br>
 =A0 =A0 =A0 =A0 =A0RX packets:0 errors:0 dropped:0 overruns:0 frame:0<br>
</div> =A0 =A0 =A0 =A0 =A0TX packets:12 errors:0 dropped:0 overruns:0 carri=
er:0<br>
 =A0 =A0 =A0 =A0 =A0collisions:0 txqueuelen:0<br>
 =A0 =A0 =A0 =A0 =A0RX bytes:0 (0.0 B) =A0TX bytes:720 (720.0 B)<br>
<br>
eth0 =A0 =A0 =A0Link encap:Ethernet =A0HWaddr 00:0a:e4:ae:7e:4c<br>
<div class=3D"im"> =A0 =A0 =A0 =A0 =A0UP BROADCAST MULTICAST =A0MTU:1500 =
=A0Metric:1<br>
</div><div class=3D"im"> =A0 =A0 =A0 =A0 =A0RX packets:0 errors:0 dropped:0=
 overruns:0 frame:0<br>
</div> =A0 =A0 =A0 =A0 =A0TX packets:0 errors:0 dropped:0 overruns:0 carrie=
r:0<br>
 =A0 =A0 =A0 =A0 =A0collisions:0 txqueuelen:1000<br>
 =A0 =A0 =A0 =A0 =A0RX bytes:0 (0.0 B) =A0TX bytes:0 (0.0 B)<br>
<div class=3D"im"> =A0 =A0 =A0 =A0 =A0Interrupt:20 Base address:0xc000<br>
<br>
</div><div class=3D"im">eth1 =A0 =A0 =A0Link encap:Ethernet =A0HWaddr 00:15=
:00:1f:20:a6<br>
</div><div class=3D"im"> =A0 =A0 =A0 =A0 =A0UP BROADCAST MULTICAST =A0MTU:1=
500 =A0Metric:1<br>
</div> =A0 =A0 =A0 =A0 =A0RX packets:5255 errors:12 dropped:12 overruns:0 f=
rame:0<br>
 =A0 =A0 =A0 =A0 =A0TX packets:466 errors:0 dropped:0 overruns:0 carrier:0<=
br>
 =A0 =A0 =A0 =A0 =A0collisions:0 txqueuelen:1000<br>
 =A0 =A0 =A0 =A0 =A0RX bytes:912108 (890.7 KB) =A0TX bytes:113643 (110.9 KB=
)<br>
 =A0 =A0 =A0 =A0 =A0Interrupt:21 Memory:c8006000-c8006fff<br>
<div class=3D"im"><br>
lo =A0 =A0 =A0 =A0Link encap:Local Loopback<br>
 =A0 =A0 =A0 =A0 =A0inet addr:127.0.0.1 =A0Mask:255.0.0.0<br>
 =A0 =A0 =A0 =A0 =A0inet6 addr: ::1/128 Scope:Host<br>
 =A0 =A0 =A0 =A0 =A0UP LOOPBACK RUNNING =A0MTU:16436 =A0Metric:1<br>
</div> =A0 =A0 =A0 =A0 =A0RX packets:1974 errors:0 dropped:0 overruns:0 fra=
me:0<br>
 =A0 =A0 =A0 =A0 =A0TX packets:1974 errors:0 dropped:0 overruns:0 carrier:0=
<br>
 =A0 =A0 =A0 =A0 =A0collisions:0 txqueuelen:0<br>
 =A0 =A0 =A0 =A0 =A0RX bytes:101385 (99.0 KB) =A0TX bytes:101385 (99.0 KB)<=
br>
<br>
The output of iwconfig of eth1<br>
<br>
jochus@Bacardi ~ $ iwconfig eth1<br>
eth1 =A0 =A0 =A0unassociated =A0ESSID:&quot;Jochus&quot;<br>
 =A0 =A0 =A0 =A0 =A0Mode:Managed =A0Frequency=3D2.462 GHz =A0Access Point: =
Not-Associated<br>
 =A0 =A0 =A0 =A0 =A0Bit Rate:0 kb/s =A0 Tx-Power=3D20 dBm =A0 Sensitivity=
=3D8/0<br>
 =A0 =A0 =A0 =A0 =A0Retry limit:7 =A0 RTS thr:off =A0 Fragment thr:off<br>
 =A0 =A0 =A0 =A0 =A0Power Management:off<br>
 =A0 =A0 =A0 =A0 =A0Link Quality:0 =A0Signal level:0 =A0Noise level:0<br>
 =A0 =A0 =A0 =A0 =A0Rx invalid nwid:0 =A0Rx invalid crypt:146 =A0Rx invalid=
 frag:0<br>
 =A0 =A0 =A0 =A0 =A0Tx excessive retries:0 =A0Invalid misc:0 =A0 Missed bea=
con:0<br>
<br>
The output of arp -an:<br>
<br>
jochus@Bacardi ~ $ arp -an<br>
? (192.168.1.1) at &lt;incomplete&gt; on br0<br>
<div><div></div><div class=3D"h5"><br>
_______________________________________________<br>
Bridge mailing list<br>
<a href=3D"mailto:Bridge@lists.linux-foundation.org">Bridge@lists.linux-fou=
ndation.org</a><br>
<a href=3D"https://lists.linux-foundation.org/mailman/listinfo/bridge" targ=
et=3D"_blank">https://lists.linux-foundation.org/mailman/listinfo/bridge</a=
><br>
</div></div></blockquote></div><br>

--001485f64b484a1c3904691e967e--
