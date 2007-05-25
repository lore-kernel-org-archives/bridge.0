Date: Fri, 25 May 2007 09:05:11 -0700 (PDT)
From: Swedo Rama <swedorama@yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-671219066-1180109111=:994"
Content-Transfer-Encoding: 8bit
Message-ID: <325018.994.qm@web37001.mail.mud.yahoo.com>
Subject: [Bridge] My bridge is broken
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--0-671219066-1180109111=:994
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,

I'm not sure if requests for help are appropriate for this list. If not, I apologize.

My ISP (bredbandsbolaget) here in Sweden delivers my broadband by ethernet. I get up to five IP:s through DHCP. I figured it would be a good idea to actually use these IP:s instead of going for a NAT/PAT/masquerading thing. So, bridging firewall, right?

I can't seem to get it to work. Worse, I'm too much of a newbie to even diagnose the problem.

Here's my setup:

|ISP    |    | firewall |
|DHCP|----|eth1  eth2|----|switch|----|computers|

The switch is a cheapo 3com 3CGSU05-ME gigabit thing.

Here's the firewall box:

aker:~# lspci | grep Eth
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 7c)
04:04.0 Ethernet Controller: Intel Corporation 82541PI Gigabit Ethernet Controller (rev 05)
04:05:0 Ethernet  Controller: Intel Corporation 82541PI Gigabit Ethernet Controller

I want to use the two Intel PRO/1000 GT NICs for the bridge.

aker:~# uname -sr
Linux 2.6.18-4-486

It's Debian Etch with a standard kernel.

aker:~# brctl --version
bridge-utils, 1.2

I did this:

aker:~# ifconfig eth1 promisc up
device eth1 entered promiscuous mode
audit(1180131751.392.2): dev=eth1 prom=256 old_prom=0 auid=4294967295
e1000: eth1: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex

aker:~# ifconfig eth2 promisc up
device eth2 entered promiscuous mode
audit(1180131923.963.3): dev=eth2 prom=256 old_prom=0 auid=4294967295
e1000: eth2: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex

aker:~# brctl addbr br0
Bridge firewalling registered

aker:~# brctl addif br0 eth1
aker:~# brctl addif br0 eth2

aker:~# brctl setfd br0 0

aker:~#  echo "1" > /proc/sys/net/ipv4/ip_forward

aker:~# brctl show br0
bridge name    bridge id                        STP enabled      interfaces
br0                 8000.000e0cdd3b12       no                       eth1
                                                                                   eth2

Both NICs have links. eth2 has a 100 mbit FD link to ISP. eth1 a gig FD link to the switch.

Now I figure I should be ready to run my DHCP client on one of the computers, but that doesn't work. if I run "brctl showmacs br0" afterwards it only lists the MACs of the two NICs in the bridge. Seems like no traffic has gone through.

I tried setting all the /proc/sys/net/bridge/bridge-nf* values to 0. No difference.

I'm pretty new to linux, and to networking, and I don't really know how to figure out what I'm doing wrong. Any help would be greatly appreciated. And again, sorry if this is off-topic (is there somewhere else more appropriate for this kind of question?)

/Swedo
       
---------------------------------
Take the Internet to Go: Yahoo!Go puts the Internet in your pocket: mail, news, photos & more. 
--0-671219066-1180109111=:994
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,<br><br>I'm not sure if requests for help are appropriate for this list. If not, I apologize.<br><br>My ISP (bredbandsbolaget) here in <span style="border-bottom: 1px dashed rgb(0, 102, 204); cursor: pointer; height: 1em;" id="lw_1180108940_0">Sweden</span> delivers my broadband by ethernet. I get up to five IP:s through DHCP. I figured it would be a good idea to actually use these IP:s instead of going for a NAT/PAT/masquerading thing. So, bridging firewall, right?<br><br>I can't seem to get it to work. Worse, I'm too much of a newbie to even diagnose the problem.<br><br>Here's my setup:<br><br>|ISP&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; | firewall |<br>|DHCP|----|eth1&nbsp; eth2|----|switch|----|computers|<br><br>The switch is a cheapo 3com <span id="LabelShortDescription" class="detailsheader">3CGSU05-ME</span> gigabit thing.<br><br>Here's the firewall box:<br><br>aker:~# lspci | grep Eth<br>00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev
 7c)<br>04:04.0 Ethernet Controller: Intel Corporation 82541PI Gigabit Ethernet Controller (rev 05)<br>04:05:0 Ethernet  Controller: Intel Corporation 82541PI Gigabit Ethernet Controller<br><br>I want to use the two <span id="LabelShortDescription" class="detailsheader"><span style="border-bottom: 1px dashed rgb(0, 102, 204); cursor: pointer; height: 1em;" id="lw_1180108940_1">Intel</span> PRO/1000 GT NICs for the bridge.<br><br>aker:~# uname -sr<br><span style="border-bottom: 1px dashed rgb(0, 102, 204); cursor: pointer; height: 1em;" id="lw_1180108940_2">Linux</span> 2.6.18-4-486<br><br>It's Debian Etch with a standard kernel.<br><br>aker:~# brctl --version<br>bridge-utils, 1.2<br><br>I did this:<br><br>aker:~# ifconfig eth1 promisc up<br>device eth1 entered promiscuous mode<br>audit(1180131751.392.2): dev=eth1 prom=256 old_prom=0 auid=4294967295<br>e1000: eth1: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex<br><br>aker:~# ifconfig eth2 promisc up<br>device eth2
 entered promiscuous mode<br>audit(1180131923.963.3): dev=eth2 prom=256 old_prom=0 auid=4294967295<br>e1000: eth2: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex<br><br>aker:~# brctl addbr br0<br>Bridge firewalling registered<br><br>aker:~# brctl addif br0 eth1<br>aker:~# brctl addif br0 eth2<br><br>aker:~# brctl setfd br0 0<br><br></span>aker:~#  echo "1" &gt; /proc/sys/net/ipv4/ip_forward<br><br>aker:~# brctl show br0<br>bridge name&nbsp;&nbsp;&nbsp; bridge id&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; STP enabled&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interfaces<br>br0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8000.000e0cdd3b12&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; no&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
 eth1<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eth2<br><br>Both NICs have links. eth2 has a 100 mbit FD link to ISP. eth1 a gig FD link to the switch.<br><br>Now I figure I should be ready to run my DHCP client on one of the computers, but that doesn't work. if I run "brctl showmacs br0" afterwards it only lists the MACs of the two NICs in the bridge. Seems like no traffic has gone through.<br><br>I tried setting all the /proc/sys/net/bridge/bridge-nf* values to 0. No difference.<br><br>I'm pretty new to linux, and to
 networking, and I don't really know how to figure out what I'm doing wrong. Any help would be greatly appreciated. And again, sorry if this is off-topic (is there somewhere else more appropriate for this kind of question?)<br><br>/Swedo<p>&#32;
      <hr size=1>Take the Internet to Go: Yahoo!Go puts the <a href="http://us.rd.yahoo.com/evt=48253/*http://mobile.yahoo.com/go?refer=1GNXIC">Internet in your pocket:</a> mail, news, photos & more. 
--0-671219066-1180109111=:994--
