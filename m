Date: Tue, 18 Nov 2003 18:57:26 -0800
From: pburr <pburr@interchange.ubc.ca>
Message-id: <3FBADC16.6020307@interchange.ubc.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
Subject: [Bridge] Problem Bridging VLANs
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

Hi bridge list:
Bart de Schuymer suggested that this question might be better placed on 
this list rather than in the ebtables area.  So here it is :
=================================================================
Hi listers:

    I am a relative Penquin Newcomer, and I am (therefore?) encountering 
problems trying to setup a simple bridge/firewall between two vlans 
sharing portions of the same subnet, x.y.z.0/24.  The VLANs are created 
and managed by a campus wide arrangement of Nortel Baystack 450's. The 
bridge machine has a "stock kernel" 2.6.0-test9, and two  3Com 905B  
nics enslaved to a single bridge.   There are no rules installed yet, in 
either ip- or ebtables.  The current network is on Port 1(eth0), and a 
portion is moved to the NewVLAN on Port 2 (eth1)

Extent Network Vlan -->  Port1(eth0)[BridgeMachine]Port2(eth1) --> 
NewVLAN network

    Problem:
    The firewalled side of the bridge (Port2, eth1) consistently moves 
from "listening state" to "blocking state" and stays there. No 
connections can be made across the bridge.  However, This seems to occur 
only when the nic is sharing an IRQ.  
    If the IRQ question is circumvented by fiddling with startup, a pair 
of unique IRQs can be obtained for the nics.  Then both Ports of the 
Bridge enter Forwarding state. 
    But even in this case, when the bridge appears to be forwarding 
traffic to both nics, (as seen by tcpdump), pings fail to reach across  
the bridge.  Pings succeed when both sending and receiving hosts are on 
the same side of bridge.   A SHOWMACs command shows primarily MACs on 
the original network side (Port 1).  Only the bridge  MAC for eth1 and 
the MAC of the 450 Switch show in the list,.  None of the MACS for the 
hosts moved into NewVLAN show up at all.

    What do I need to successfully move traffic across the bridge?

Thanks in advance

Patrick Burr
systems Administrator
604 822-8932
Woodward IRC, Room 109
College of Health Disciplines
UBC

Don't send me any attachment in Micro$oft (.DOC, .PPT) format please
 Read <http://www.fsf.org/philosophy/no-word-attachments.html>
Preferable attachments: .PDF, .HTML, .TXT
 Thanx for adding this text to Your signature


