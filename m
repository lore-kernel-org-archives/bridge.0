Date: Mon, 30 Apr 2007 12:53:30 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [Bridge] Linux Bridge + NAT + firewall
Message-ID: <20070430125330.7e2ef982@dxpl.pdx.osdl.net>
In-Reply-To: <283783.73484.qm@web36510.mail.mud.yahoo.com>
References: <283783.73484.qm@web36510.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Sebastian Tabarce <blue_moon_ro@yahoo.com>
Cc: bridge@lists.linux-foundation.org

On Mon, 30 Apr 2007 06:23:03 -0700 (PDT)
Sebastian Tabarce <blue_moon_ro@yahoo.com> wrote:

> Hello everybody!
> 
> I'm trying to setup at home a linux router for me and my 3 friends. Basically I had some spare network cards around and that is why I have not bought a switch or a router. Also all of us are rarely at home at the same time so bandwidth will not be a problem. And I thought it would be fun to try to make this work in linux. However, I've hit a dead end.
> 
> This is my problem:
> - I have a spare computer running CentOS 5 (RHEL 5 clone) with 5 network cards
> - we have an internet connection via a cable modem. The cable modem is linked at eth4 to the above computer that will be setup as router.
> - all the computers in the house are linked to the same above computer to eth0...eth3.
> I did the following:
> - I'm using dhclient to obtain an IP for eth4 via DHCP. The internet connection works on this computer, I am able to navigate, etc. I had to spoof the MAC address of eth4 since the MAC of one of the other computers was registered at our ISP. (Yes, I could have exchanged the network cards, if it wouldn't have been a laptop....)
> - I used bridge-utils to configure a bridge composed of eth0...eth3
> 
> my rc.local:
> 
> #create bridge
> 
> brctl addbr br0
> brctl stp br0 off
> brctl addif br0 eth0
> ....
> brctl addif br0 eth3
> ifconfig eth0 0.0.0.0
> ...
> ifconfig eth3 0.0.0.0
> ifconfig br0 192.168.0.1 netmask 255.255.255.0 up
> 
> #spoof MAC and get DHCP IP addres on eth4
> ifconfig eth4 down
> ifconfig eth4 hw ehter addr xx:xx:xx:xx:xx:xx:xx:xx
> ifconfig eth4 up
> dhclient eth4
> 
> #iptables 
>  iptables -t nat -A POSTROUTING -o eth4 -j MASQUERADE
> iptables -A INPUT -i eth4 -o br0 -m state --state ESTABLISHED,RELATED -j ACCEPT
> iptables -A FORWARD -i eth0 -o eth4 -j ACCEPT  
> 
> - the other computers also have IPs in the 192.168.0.xxx range with 192.168.0.1 set as gateway and DNS and are running Windows and linux.
> 
> My question is how do I masquerade all  4 computers linked to br0 and make them connect to the internet using my cable modem connection on eth4?
> I tried using iptables but could not obtained so far a result. IP forwarding is enabled in /etc/sysctl.conf.
> I'm thinking of refining afterwards the rules to have a true firewall, but first I need a working NAT.....


You need to setup NAT
