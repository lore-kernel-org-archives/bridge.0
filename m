Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <419221E9-C6B5-4538-ADA4-8B3E39D61E96@mac.com>
Content-Transfer-Encoding: 7bit
From: Jim Lloyd <jim.lloyd@mac.com>
Date: Wed, 31 May 2006 19:10:59 -0700
Subject: [Bridge] Minimal transparent bridge
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge <bridge@lists.osdl.org>
Cc: Nils.Radtke_@_Think-Future.de

Hi folks,

I have some ambitious plans to set up a Fedora Core 5 node as a  
transparent bridge between my host's gateway and the remainder of a  
rack of nodes colocated at the host that I share with some friends.  
I've had a hard time getting this working. I seem to be stuck at a  
pretty basic level, so I am hoping there is something obvious someone  
can point out for me. For example, I just noticed one warning against  
using 2.6 kernels. Is that still true, even for the most current 2.6  
kernels (2.6.16.1)?

I'd like to start with a very simple question: what is the minimal  
steps to set up a server with two ethernet interfaces (eth0 and eth1)  
as a transparent bridge?

I'm following the Nils Radtke's how-to here:
http://www.tldp.org/HOWTO/Ethernet-Bridge-netfilter-HOWTO.html

Assume I have a 3 node network:

L:eth0 <-> eth0:B:eth1 <-> eth0:R

B is my bridge. L and R are nodes on the same subnet that can ping  
each other if the bridge is replace by a hub.

 From what I know so far, I thought the following steps on the bridge  
should be enough:

1) remove all iptable rules.
2) do the following

     (ifdown eth0 1>/dev/null 2>&1;);
     (ifdown eth1 1>/dev/null 2>&1;);
     brctl addbr br0;
     brctl stp br0 on;
     brctl addif br0 eth0;
     brctl addif br0 eth1;
     ifconfig eth0 0.0.0.0 up;
     ifconfig eth1 0.0.0.0 up;
     ifconfig br0  up

The above commands are taken from <http://www.tldp.org/HOWTO/Ethernet- 
Bridge-netfilter-HOWTO-3.html#ss3.3>, but reordered and stripped  
down. Note in particular I don't assign the br0 interface an ip address.

After doing the above, should I be able to once again ping R from L  
and vice versa? Or is setting proxy_arp and forwarding required?

     for file in br0 eth0 eth1;
     do
       echo "1" > /proc/sys/net/ipv4/conf/${file}/proxy_arp;
       echo "1" > /proc/sys/net/ipv4/conf/${file}/forwarding;
     done;
     echo "1" > /proc/sys/net/ipv4/ip_forward;

 From reading Nils's how-to, these steps seem to be necessary.  
However, the bridge wiki page doesn't mention them <http://linux- 
net.osdl.org/index.php/Bridge>, and another page makes it seem like  
they might only be necessary for "pseduo-bridges": <http://lartc.org/ 
howto/lartc.bridging.proxy-arp.html>.

Thanks in advance for any answers.

Jim Lloyd

