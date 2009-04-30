Message-Id: <01EC5FD1-5220-476A-AF32-31B097C3A514@gmail.com>
From: mopsosforum <mopsosforum@gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v930.3)
Date: Thu, 30 Apr 2009 16:20:54 +0100
Subject: [Bridge] bridge + multicast = broadcast
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hello,

I use the bridge tools on a debian with 5 interfaces.
I want to use the multicast protocol with it. But by default, the  
bridge broadcast the multicast packet.
Do you have any implementation of protocole like IGMP snooping or MGRP  
on bridge tools?

I would like something like that :

If nobody send a IGMP packet to join a multicast group, the multicast  
traffic is forbidden.
In the other case, the bridge allow the traffic on the port where it  
recieve the IGMP packet (JOIN).

Best Regards

