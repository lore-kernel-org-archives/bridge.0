Date: Wed, 27 Feb 2008 11:34:21 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20080227113421.75d8c520@extreme>
In-Reply-To: <BAY111-W5E4FBCA18E6CB1F20E641AC1A0@phx.gbl>
References: <BAY111-W5E4FBCA18E6CB1F20E641AC1A0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Bridging troubles
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: George - <giorger@hotmail.com>
Cc: bridge@lists.linux-foundation.org

On Wed, 27 Feb 2008 19:07:37 +0000
George - <giorger@hotmail.com> wrote:

> 
> Hallo.
> I am trying to establish a bridge on my debian linux box between an ethernet and a wireless interface, in order to be able to connect to the bridge via my laptop's wireless. My laptop has WinXP.
> 
> Well, i have a bridge which i created by
> 
> brctl addbr br0
> brctl addif eth1 (Ethernet controller: Intel Corporation 82562ET/EZ/GT/GZ - PRO/100 VE (LOM) Ethernet Controller (rev 03))
> brctl addif eth4 (Network controller: RaLink RT2500 802.11g Cardbus/mini-PCI (rev 01))
> 
> I am connected through eth1 to a router and I want to bridge this two connections in order to connect remotely from my laptop's wireless card which is an Intel(R) Wireless WiFi Link 4965 AGN.
> My last steps are to 
> 
> dhclient br0 
> echo "0"> /proc/sys/net/ipv4/ip_forward
> iptables -P FORWARD ACCEPT
> 
> I was able to connect from my laptop, and router's dhcp worked fine. But here my problems start. I tried to ping my linux box and i was successful. I captured arp, dhcp packets. But when I am trying to ping my router (from my laptop), I fail. I try to catch packets with tcpdump -i br0 -vvvv|grep laptop_ip but it seems as if packets never get to my linux box. I found out about some kind of shapping so i also tried the following
> 
> for f in `ls /proc/sys/net/bridge/`; do echo "0"> /proc/sys/net/bridge/$f ;cat /proc/sys/net/bridge/$f;done
> 
> but no good. My linux box can access Internet with no problem. My cards are ok, since the same configuration with a WinXP box (instead of debian) works.
> Are there any ideas?
> 
> Giwrgos
> _________________________________________________________________
> Express yourself instantly with MSN Messenger! Download today it's FREE!
> http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge

Forget the /proc futzing that isn't your problem.
  http://www.linux-foundation.org/en/Net:Bridge#FAQ

The problem is that wireless is not the same as Ethernet as far as bridging.
