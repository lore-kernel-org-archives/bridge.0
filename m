Message-ID: <82b0add70802061207r1fe5780cp142a6afcfb5a1548@mail.gmail.com>
Date: Wed, 6 Feb 2008 15:07:26 -0500
From: "Joubert Berger" <joubertb@gmail.com>
Sender: joubert@berger-family.org
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_6876_5885252.1202328446385"
Subject: [Bridge] interaction of bridge with netfilter
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.osdl.org

------=_Part_6876_5885252.1202328446385
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I am seeing some strange behavior and was hoping someone might be able to
shed some light
on what I am seeing.

First my setup:
Running rhel4 (2.6.9-42-EL kernel)

----> (eth1) Linux Bridge (eth2) -->  10.10.3.101

I only have one machine sitting off of eth2.

I have the iptables rule:

iptables -A FORWARD -j LOG

So, I am logging everything that goes over the bridge.  I
am expecting to see all traffic to 10.10.3.101 and anything that
is broadcast address. (Is that a correct assumption?)

I was looking at http://ebtables.sourceforge.net/br_fw_ia/PacketFlow.png,
and if I read it correctly, the bridge decision is being done before the
packet reaches the FORWARD chain of the filter table.

The problem is that I am seeing SYN packets for machines that are
not on the eth2 segment of the bridge.  Is this correct behavior?  I am
seeing
the packet in the LOG output as well as running ethereal on eth2 shows these
packets.

Anyone have any ideas why this is happening?  Or is it working as expected?

--joubert

------=_Part_6876_5885252.1202328446385
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I am seeing some strange behavior and was hoping someone might be able to shed some light<br>on what I am seeing.<br><br>First my setup:<br>Running rhel4 (2.6.9-42-EL kernel)<br><br>----&gt; (eth1) Linux Bridge (eth2) --&gt;&nbsp; <a href="http://10.10.3.101">10.10.3.101</a><br>
<br>I only have one machine sitting off of eth2.<br><br>I have the iptables rule:<br><br>iptables -A FORWARD -j LOG<br><br>So, I am logging everything that goes over the bridge.&nbsp; I <br>am expecting to see all traffic to <a href="http://10.10.3.101">10.10.3.101</a> and anything that<br>
is broadcast address. (Is that a correct assumption?)<br><br>I was looking at <a href="http://ebtables.sourceforge.net/br_fw_ia/PacketFlow.png">http://ebtables.sourceforge.net/br_fw_ia/PacketFlow.png</a>,<br>and if I read it correctly, the bridge decision is being done before the<br>
packet reaches the FORWARD chain of the filter table.<br><br>The problem is that I am seeing SYN packets for machines that are <br>
not on the eth2 segment of the bridge.&nbsp; Is this correct behavior?&nbsp; I am seeing<br>the packet in the LOG output as well as running ethereal on eth2 shows these packets.<br><br>Anyone have any ideas why this is happening?&nbsp; Or is it working as expected?<br>
<br>--joubert<br>
<br>

------=_Part_6876_5885252.1202328446385--
