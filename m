Message-ID: <20050901135348.10868.qmail@webmaild.fe1.aruba.it>
From: overet@securitydate.it
Date: Thu, 01 Sep 2005 15:53:48 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [Bridge] rcu_dereference() error in coldfire arch
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi,
i'm trying to develop an embedded system with ColdFire architecture (similar 
at m68k) and i have some problems. 

The bridge module is loaded properly in the kernel. When an ARP packet is 
sent to the port of the bridge there are 2 situations: 

 - If destination MAC address is FF:FF:FF:FF:FF:FF the packet is forwarded.
 - If destination MAC address is not a broadcast address the packet is 
droped. 

Then, if i send an ICMP packet whit static ARP entries on the two hosts the 
packet are droped. 


So, i look in the source tree to search the bug and i can see that in the 
handle_bridge() function in net/core/dev.c at this point:
 ---------------------------------------------------------------------
       if ((*pskb)->pkt_type == PACKET_LOOPBACK ||
           (port = rcu_dereference((*pskb)->dev->br_port)) == NULL)
               return 0;
 ---------------------------------------------------------------------
the condition if () succeded whit port == NULL (but it shouldn't) and the 
packet are droped. 

How can i do to resolv this problem in m68k compliant architecture? 

Best regards,
oveRet 

