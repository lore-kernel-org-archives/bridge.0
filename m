Message-ID: <40D193A7.2020805@phys.rug.nl>
Date: Thu, 17 Jun 2004 14:50:47 +0200
From: Maarten Hilgenga <M.L.Hilgenga@phys.rug.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] bridge only works from certain ip addresses
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Dear all,

after putting up a bridge to be used as a firewall with the following 
configuration:

linux 2.6.4-52-smp kernel
bridge-utils 0.9.6-121
Bridge is setup standard with 2 NIC's and STP off.

I noticed  a strange behaviour; when connecting from an outside machine 
with the same iprange as the inside machines (a.b.xxx.xxx) I could 
connect. When trying the same from a non-local machine(c.d.xxx.xxx), 
this didn't work. In both cases the first package arrives at the 
firewallmachine at the INPUT chain, and the destination MAC-address is 
correct in both cases. The package from a.b.xxx.xxx also enters the 
FORWARD chain, but this doesn't work for c.d.xxx.xxx. I'd really 
appreciate any help, if you need more info please tell me

Thanks in advance,

Maarten Hilgenga

