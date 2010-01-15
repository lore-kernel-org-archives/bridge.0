MIME-Version: 1.0
Date: Fri, 15 Jan 2010 09:16:41 +0100
Message-ID: <8cad0aa1001150016n46d622b4wd806440a84d91a54@mail.gmail.com>
From: Jean-Michel Hautbois <jhautbois@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bridge] [ebtables]Explanation of the packet flow...
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi everybody !

I am trying to understand the "PacketFlow.png" image from the website.
I have several misunderstanding, especially on the "Bridging Decision" circles.

I would like to understand which way a packet takes when the rule on
-A INPUT -j ACCEPT is on, for example. When looking at the packet
flow, I would say it is going to the "routing decision" circle, but, I
am not sure...

I would also like to understand what is necessary in order to have a
packet transparently directed from one interface to the other. I would
say that only the "-A FORWARD -j ACCEPT" rule is necessary, but
Wireshark doesn't agree with me...

Thanks in advance for your help.
Best Regards,
JM
