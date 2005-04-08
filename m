Message-ID: <807abdd20504080632711e6232@mail.gmail.com>
Date: Fri, 8 Apr 2005 08:32:02 -0500
From: Rob Boucher <robsgreen325@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Bridge] PF_PACKET socket
Reply-To: Rob Boucher <robsgreen325@gmail.com>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

From the archives it looks like there may be some knowledge in this area... 
2.4.20 kernel

I have 2 network interfaces eth0 & eth1 connected via bridge br0. eth0
and eth1 do not have IPs, br0 may or may not have an IP. Not planning
on using ebtables package to solve this problem.....

Here is the first question...

If a user space process wants to intercept packets entering eth0 for a
specific protocol, ETH_P_802_2 for example, (basically any case where
a packet hander is installed into the ptype_base[] table in dev.c,
AFTER the bridge code entry point). How do I bind the user space
socket to guarantee that it will receive the ETH_P_802_2 frames
received/posted by eth0.

It looks to me like: if the socket is created and then bound to eth0
it will never see any frames of type ETH_P_802_2 when a bridge is
place. Is this correct?

What should happen when the PF_PACKET socket is bound to br0? Should I
expect to see 802.2 packets from the bridge? Will all the packets pass
by undetected? Will the bridge only pass the packets up if an IP
address is assigned to br0?
  
Another question, again w/o ebtables....
Is there a way with PF_PACKET to intercept a certain protocol type
before it enters the bridge, pass it to the PF_PACKET handler
completely consuming the frame. Thus, causing the frame to be consumed
by the localhost and not bridged?

Thanks!!
Rob
