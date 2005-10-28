From: "Josh Burke" <kernelbridgeissue@iokui.com>
Message-ID: <W4024930557309771130540874@webmail4>
Date: Fri, 28 Oct 2005 23:07:54 +0000
Subject: Re: [Bridge] slow network performance when using bridged interfaces 
	in 2.6.13 compared to 2.6.12.
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@osdl.org

> On Fri, 28 Oct 2005 21:33:39 +0000
> "Josh Burke" <kernelbridgeissue@iokui.com> wrote:
> 
> > (originally filed as a bug in Fedora's bugzilla, see  https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=171933)
> > 
> > Greetings,
> > 
> > Using Fedora Core 4 on a Dell PE 420sc.  Malfunctioning kernel is smp-2.6.13-1.1532_FC4.  Properly functioning kernels included smp-2.6.12-1.1456_FC4.
> > 
> > Network performance is extremely poor when using bridged network interfaces.  When not using brctl, the interface gives ~800kbps.  When using brctl to bridge two interfaces, the speed drops to ~1.0kbps.
> > 
> > Reverting to kernel-smp-2.6.12-1.1456_FC4 returns the speed to normal.
> > 
> > The two interfaces have IP addresses when not bridged.  They do not have IP addresses when they are bridged.  (As expected.)
> > 
> > No unusual output in dmesg.  
> > 
> > Traffic is not slowed that originates on a bridge interfaces and goes out a bridge interface, only traffic from the host that the bridge is on, is slowed.
> > 
> > Making these connections unbridged returns normal traffic performance.  Reverting to 2.6.12 also returns normal performance.
> > 
> > Tcpdump indicates increasing pauses returning packets. (From bridge host to the outside.  Bridge host is a web server, though even SSH connections are slow.)
> > 
> > For example:
> > 14:25:53.387001 IP 192.168.0.1.https > 10.0.0.1.32752: tcp 1260
> > 14:25:53.648768 IP 10.0.0.1.32752 > 192.168.0.1.https: tcp 0
> > 14:25:53.648817 IP 192.168.0.1.https > 10.0.0.1.32752: tcp 1260
> > 14:25:53.648859 IP 192.168.0.1.https > 10.0.0.1.32752: tcp 1260
> > 14:25:53.770239 IP 10.0.0.1.32752 > 192.168.0.1.https: tcp 0
> > 14:26:03.242674 IP 192.168.0.1.https > 10.0.0.1.32752: tcp 1260
> > 14:26:03.462594 IP 10.0.0.1.32752 > 192.168.0.1.https: tcp 0
> > 14:26:03.462675 IP 192.168.0.1.https > 10.0.0.1.32752: tcp 1260
> > 14:26:03.462714 IP 192.168.0.1.https > 10.0.0.1.32752: tcp 1260
> > 14:26:03.581169 IP 10.0.0.1.32752 > 192.168.0.1.https: tcp 0
> > 14:26:22.526025 IP 192.168.0.1.https > 10.0.0.1.32752: tcp 1260
> > 14:26:22.784218 IP 10.0.0.1.32752 > 192.168.0.1.https: tcp 0
> > 14:26:22.784325 IP 192.168.0.1.https > 10.0.0.1.32752: tcp 1260
> > 14:26:22.784379 IP 192.168.0.1.https > 10.0.0.1.32752: tcp 1260
> > 14:26:22.895638 IP 10.0.0.1.32752 > 192.168.0.1.https: tcp 0
> > 14:27:00.780762 IP 192.168.0.1.https > 10.0.0.1.32752: tcp 1260
> > 14:27:01.045112 IP 10.0.0.1.32752 > 192.168.0.1.https: tcp 0
> > 14:27:01.045209 IP 192.168.0.1.https > 10.0.0.1.32752: tcp 1260
> > 14:27:01.045263 IP 192.168.0.1.https > 10.0.0.1.32752: tcp 1260
> > 14:27:01.160083 IP 10.0.0.1.32752 > 192.168.0.1.https: tcp 0
> > (192.168.0.1 = bridge host, 10.0.0.1 = external host.  This happened while trying to download a text file.)
> > 
> > Any suggestions, or places to look for information, is appreciated.
> 
> What kind of ethernet interfaces. The bridge code changes have been very
> small.  I would suspect the TSO changes in the base stack are causing
> problems.  Try turning TSO off on the interfaces.
> 
> Another possibility is netfilter.


Stephen,

Thank you for your message.  The interfaces involved are a Sangoma S518 ADSL card, a Intel Pro/100 card, and a built-in ethernet (Tigon3 [partno(BCM95751) rev 4001 PHY(5750)] (PCIX:100MHz:32-bit) 10/100/1000BaseT Ethernet).  I have experienced the problem when the tg3 and intel cards are put togther, right now the problem is happening with the S518 and the Intel card.

The S518 and intel cards do not appear to support TSO:
/sbin/ethtool -K eth1 tso off
Cannot set device tcp segmentation offload settings: Operation not supported

/sbin/ethtool -k eth1
Offload parameters for eth1:
Cannot get device rx csum settings: Operation not supported
Cannot get device tx csum settings: Operation not supported
Cannot get device scatter-gather settings: Operation not supported
Cannot get device tcp segmentation offload settings: Operation not supported
no offload info available

(I could be doing this command wrong.)

Removing TSO from eth0 (the tg3 int, not part of the bridge) did not help.

I do not know how to check if it is netfilter, beyond dropping the iptables rules and setting the policy to "ACCEPT".  That did not fix anything.

Thanks for your help,
Josh



