Message-Id: <1150887156.13125.264319106@webmail.messagingengine.com>
From: paul05@mailsent.net
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
Date: Wed, 21 Jun 2006 22:52:36 +1200
Subject: [Bridge] bridge and transparent squid proxy
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi all,

This is my first post to this list. I hope someone can help me, I have
been getting grey hairs trying to make this work!

I have a bridge setup on a debian sarge box. The bridge is called br0
and sits between my cable modem and a non-name brand router/switch:

[cable modem]----[eth1]---[br0]----[eth2]-----[no-name brand router]

I have squid setup on the linux box and it works, I have tested it.

This is how I setup the bridge:

ifconfig eth1 0.0.0.0 promisc up
ifconfig eth2 0.0.0.0 promisc up
brctl addbr br0
brctl addif br0 eth1
brctl addif br0 eth2
ifconfig br0 192.168.0.88 netmask 255.255.255.0 up
route add default gw 192.168.0.1 dev br0


The output of uname -a:

Linux sarge 2.6.8-2-386 #1 Tue Aug 16 12:46:35 UTC 2005 i686 GNU/Linux

I have one other nic in the sarge box, eth0, which has the ip
192.168.0.2

My gateway (the no-name brand router), has the IP address 192.168.0.1

I have tried every howto I can find to setup squid as a transparent
proxy but have not had any luck (including
http://freshmeat.net/articles/view/1433/ and
http://www.tldp.org/HOWTO/TransparentProxy.html). Every time I try these
I have to reboot because I cannot get the bridge to act as normal, all
web traffic does not go through. 

Can anyone tell me the ip/ebtables commands I need to get this working?
Also, if there is a way to avoid rebooting if it does not work can you
please tell me that as well.

Thank you *very* much.

Cheers

Paul
