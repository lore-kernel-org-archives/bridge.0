Date: Fri, 30 Apr 2004 09:16:46 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] FW: [Openvpn-users] linux bridge is bad
Message-Id: <20040430091646.0251ae07@dell_ss3.pdx.osdl.net>
In-Reply-To: <BAY16-F92EuW6qVKUyg000109ae@hotmail.com>
References: <BAY16-F92EuW6qVKUyg000109ae@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: herwam herwam <dedmoroz3000@hotmail.com>
Cc: bridge@osdl.org

On Thu, 29 Apr 2004 17:20:29 +0200
"herwam herwam" <dedmoroz3000@hotmail.com> wrote:

> 
> 
>  
> Hi All,
> I am using a bridge with openvpn .Linux Server with dhcp and a debian client .With Windows Client evrything looks great i have 2 Ip opne
> public from provider other private from dhcp one from vpn.
> With Linux Client i have problem with this setup: up.sh
> >
> >#!/bin/sh
> >/sbin/modprobe tun
> >/sbin/modprobe bridge
> >ifconfig eth0 down
> >/usr/sbin/openvpn --mktun --dev tap0
> >/usr/sbin/brctl addbr br0
> >/usr/sbin/brctl addif br0 tap0
> >/usr/sbin/brctl addif br0 eth0
> >/sbin/ifconfig tap0 0.0.0.0 promisc up
> >/sbin/ifconfig eth0 0.0.0.0 promisc up
Turning on promiscious here is not necessary.  addif does it already.
You probably want to do:

 modprobe tun
 modprobe bridge
 ifconfig eth0 0.0.0.0
 openvpn --mktun --dev tap0
 ifconfig tap0 0.0.0.0
 brctl addbr br0
 brctl addif br0 tap0
 brctl addif br0 eth0
 ifconfig br0 xxx.xxx.xxx.240 netmask 255.255.0.0 broadcast xxx.xxx.255.255  

Since bridging is at link level (2) not network level (3), you should have an IP
for the bridge and none for eth0 and tap0.  If you need to forward packets but
have separate IP subnets, than you want to use IP forwarding not bridging.
