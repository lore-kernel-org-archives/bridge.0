Message-ID: <402190E4.1080506@fastwebnet.it>
Date: Thu, 05 Feb 2004 01:40:04 +0100
From: Sergio Tota <sergio.tota@fastwebnet.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Bridge, NAT and Multicast traffic
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

Hi all.

I write this mail to understand if someone can help me.

I configured a linux bridge and it works perfectly.
I applied the patch to make filtering on the traffic and it also works.
My problem are in natting(DNAT) multicast traffic (UDP stream packets).
Netfilter doesn't see multicast traffic at all when a NAT must be executed.
For what I read this is due the need of netfilter of connections track.
Multicast traffic has not connection track so netfilter can't act at 
all(only filtering,no natting).
Can you help me?

If not, do you know a way to make DNAT on multicast traffic with a 
trasparent linux bridge?

Thanks a lot!

Sergio Tota


