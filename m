Message-ID: <b53e36d60610050205g1db0bc8bs75a2a544a6991282@mail.gmail.com>
Date: Thu, 5 Oct 2006 14:35:15 +0530
From: "Jothis T.V" <jothistv@gmail.com>
In-Reply-To: <4c9f8dc30610050139s57c4ee9wdddf90bd2485a881@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_140353_29683537.1160039115300"
References: <4c9f8dc30610042120o3089cbf6yaaa00728b271953f@mail.gmail.com>
	<4524BFD5.4080203@cambridgebroadband.com>
	<4c9f8dc30610050139s57c4ee9wdddf90bd2485a881@mail.gmail.com>
Subject: Re: [Bridge] Bridge Woes...
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Chris U <chris.uyehara@gmail.com>
Cc: bridge@lists.osdl.org

This is a multi-part message in MIME format...

------=_Part_140353_29683537.1160039115300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Chris,

"UP BROADCAST RUNNING *PROMISC* MULTICAST  MTU:1500  Metric:1"
Your ifconfig output does show the interfaces to be running in promiscous
mode.

The best method forward from here would be to sniff the packets on the
interfaces using tools like ethereal and analyse them.

regards,
Jothis


On 10/5/06, Chris U <chris.uyehara@gmail.com> wrote:
>
> Hi Alex,
>
> In the case you mentioned previously, does ifconfig show the interface in
> promisc mode? I have tried further investigating whether or not the
> interface is in promisc mode by using ethtool, a soft tool, however
> unsuccessful. I also attempted to use a hub on eth0 to see if tcpdump would
> pick up the packets in promisc mode; the packets are successfully captured
> on the hub. [I did not test eth1, but I shall tomorrow morning.] Both
> network interfaces are the same model/brand. Listed below is a snapshot of
> my ifconfig and a snippet from my lspci.
>
> This list is pretty responsive - I just wanted to say thanks to everyone
> for taking time to help me out. ;)
>
> Mahalo,
> Chris
>
> eth0      Link encap:Ethernet  HWaddr 00:13:72:FC:84:36
>           inet6 addr: fe80::213:72ff:fefc:8436/64 Scope:Link
>           UP BROADCAST RUNNING PROMISC MULTICAST  MTU:1500  Metric:1
>           RX packets:7792 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:9417 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:1000
>           RX bytes:699418 (683.0 KiB)  TX bytes:1846522 (1.7 MiB)
>           Interrupt:169
>
> eth1      Link encap:Ethernet  HWaddr 00:13:72:FC:84:37
>           inet6 addr: fe80::213:72ff:fefc:8437/64 Scope:Link
>           UP BROADCAST RUNNING PROMISC MULTICAST  MTU:1500  Metric:1
>           RX packets:318 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:165 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:1000
>           RX bytes:34204 (33.4 KiB)  TX bytes:10886 (10.6 KiB)
>           Interrupt:225
>
> 04:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5721
> Gigabit Ethernet PCI Express (rev 11)
>         Subsystem: Dell: Unknown device 01b6
>         Flags: bus master, fast devsel, latency 0, IRQ 169
>         Memory at fe6f0000 (64-bit, non-prefetchable) [size=64K]
>         Capabilities: [48] Power Management version 2
>         Capabilities: [50] Vital Product Data
>         Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3
> Enable-
>         Capabilities: [d0] Express Endpoint IRQ 0
>         Capabilities: [100] Advanced Error Reporting
>         Capabilities: [13c] Virtual Channel
>
> 05:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5721
> Gigabit Ethernet PCI Express (rev 11)
>         Subsystem: Dell: Unknown device 01b6
>         Flags: bus master, fast devsel, latency 0, IRQ 225
>         Memory at fe4f0000 (64-bit, non-prefetchable) [size=64K]
>         Capabilities: [48] Power Management version 2
>         Capabilities: [50] Vital Product Data
>         Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3
> Enable-
>         Capabilities: [d0] Express Endpoint IRQ 0
>         Capabilities: [100] Advanced Error Reporting
>         Capabilities: [13c] Virtual Channel

------=_Part_140353_29683537.1160039115300
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<p>Hi Chris,</p>
<p>&quot;UP BROADCAST RUNNING <strong>PROMISC</strong> MULTICAST&nbsp; MTU:1500&nbsp; Metric:1&quot;</p>
<div>Your ifconfig output does show the interfaces to be running in promiscous mode. </div>
<div>&nbsp;</div>
<div>The best method forward from here would be to sniff the packets on the interfaces using tools like ethereal and analyse them.</div>
<div>&nbsp;</div>
<div>regards,</div>
<div>Jothis<br><br>&nbsp;</div>
<div><span class="gmail_quote">On 10/5/06, <b class="gmail_sendername">Chris U</b> &lt;<a href="mailto:chris.uyehara@gmail.com">chris.uyehara@gmail.com</a>&gt; wrote:</span>
<blockquote class="gmail_quote" DEFANGED_style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hi Alex,<br><br>In the case you mentioned previously, does ifconfig show the interface in promisc mode? I have tried further investigating whether or not the interface is in promisc mode by using ethtool, a soft tool, however unsuccessful. I also attempted to use a hub on eth0 to see if tcpdump would pick up the packets in promisc mode; the packets are successfully captured on the hub. [I did not test eth1, but I shall tomorrow morning.] Both network interfaces are the same model/brand. Listed below is a snapshot of my ifconfig and a snippet from my lspci. 
<br><br>This list is pretty responsive - I just wanted to say thanks to everyone for taking time to help me out. ;)<br><br>Mahalo,<br>Chris<br><br>eth0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link encap:Ethernet&nbsp; HWaddr 00:13:72:FC:84:36<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; inet6 addr: fe80::213:72ff:fefc:8436/64 Scope:Link 
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP BROADCAST RUNNING PROMISC MULTICAST&nbsp; MTU:1500&nbsp; Metric:1<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX packets:7792 errors:0 dropped:0 overruns:0 frame:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX packets:9417 errors:0 dropped:0 overruns:0 carrier:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; collisions:0 txqueuelen:1000 
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:699418 (683.0 KiB)&nbsp; TX bytes:1846522 (1.7 MiB)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Interrupt:169<br><br>eth1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link encap:Ethernet&nbsp; HWaddr 00:13:72:FC:84:37<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; inet6 addr: fe80::213:72ff:fefc:8437/64 Scope:Link 
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP BROADCAST RUNNING PROMISC MULTICAST&nbsp; MTU:1500&nbsp; Metric:1<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX packets:318 errors:0 dropped:0 overruns:0 frame:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX packets:165 errors:0 dropped:0 overruns:0 carrier:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; collisions:0 txqueuelen:1000 
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:34204 (33.4 KiB)&nbsp; TX bytes:10886 (10.6 KiB)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Interrupt:225<br><br>04:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5721 Gigabit Ethernet PCI Express (rev 11)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subsystem: Dell: Unknown device 01b6 
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Flags: bus master, fast devsel, latency 0, IRQ 169<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory at fe6f0000 (64-bit, non-prefetchable) [size=64K]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [48] Power Management version 2<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [50] Vital Product Data 
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [d0] Express Endpoint IRQ 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [100] Advanced Error Reporting<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [13c] Virtual Channel 
<br><br>05:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5721 Gigabit Ethernet PCI Express (rev 11)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subsystem: Dell: Unknown device 01b6<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Flags: bus master, fast devsel, latency 0, IRQ 225 
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory at fe4f0000 (64-bit, non-prefetchable) [size=64K]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [48] Power Management version 2<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [50] Vital Product Data<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable- 
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [d0] Express Endpoint IRQ 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [100] Advanced Error Reporting<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [13c] Virtual Channel </blockquote></div>

------=_Part_140353_29683537.1160039115300--
