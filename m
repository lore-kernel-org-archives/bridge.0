Message-ID: <449B4D3D.9070703@gac.edu>
Date: Thu, 22 Jun 2006 21:09:01 -0500
From: Ethan Sommer <sommere@gac.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Performance problems on vlan bridge
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

We have been having some performance problems with our linux bridge. I 
have no idea where to look to start diagnosing the problem, so I'll 
explain what we've done and hope that you might tell me where to start 
looking. Almost everything appears to work fine, but when I try to 
stream music using WMP or mp3 streaming, I can only stream about 30 
seconds before it cuts out. I used to be able to stream for hours.


We used to have a firewall which seperated our wireless network from the 
rest of the network. It is a dual 2.8ghz xeon with two Intel GB network 
cards. It used to have two interfaces, eth0 which was the default 
gateway and eth1 which was the wireless subnet.


The Problem:
We had a large amount of broadcast traffic on the network (often about 
1Mpbs), and occasionally would have network storms where we would have 
50-60Mbps of broadcast traffic (clearly not desirable for a network 
specifically for wireless clients.) We considered subnetting the 
network, but we'd like to allow people to register once with our 
wireless network and be able to roam anywhere we have wireless APs.

Our solution (well, if we can get it to work):

One day I had an epiphany: we could use a linux bridge and use iptables 
to block unwanted broadcast packets from going between buildings.

So I started setting up one vlan per building specifically for wireless 
and added them to br0. (I only got 2 buildings done before I noticed the 
problems though)

now the firewall has eth0 pointing to the internet and brctl show looks 
like this:
bridge name     bridge id               STP enabled     interfaces
br0             8000.00e0812a0540       no              eth1.307
                                                        eth1.336
                                                        eth1.6
where eth1.6 is everything I haven't done yet, and 307 and 336 are the 
buildings I separated off. I haven't added any iptables rules to block 
anything yet.

So, as I said in the beginning, everything but streaming music seems to 
work. The load average on the router/bridge is very low (ususally below 
.03) as is the cpu percentage. There isn't a lot of traffic this time of 
year, so I expect that the problem will get worse if we keep things as 
they are when students return in the fall.

The number of conntracks isn't anywhere near the limit we set. There is 
plenty of memory free...

Any ideas about how to find the problem would be appreciated.


Ethan Sommer
UNIX Systems Administrator
Gustavus Adolphus College
