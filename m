Message-ID: <85c88fd30804090151g7b626ecalbc26a75a5a362704@mail.gmail.com>
Date: Wed, 9 Apr 2008 10:51:26 +0200
From: "=?ISO-8859-1?Q?S=E9bastien_JEFFROY?=" <sebastien.jeffroy.cxr@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_6502_9524243.1207731087135"
Subject: [Bridge] STP on hardware switch
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

------=_Part_6502_9524243.1207731087135
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,
I work on a SOC based on Micrel/Kendin KS8695 based on ARM9. (
http://micrel.com/page.do?page=product-info/sys_on_chip.jsp)
This component has 2 network interfaces. One is connected to a 5 ports
switch.

eth0
eth1 => switch port1,2,3,4

I want to make a bridge with these 5 ports but my problem is that the
network driver only install 2 interfaces.
The KS8695 network switch can be configured to tag ingress packet (such as
BPDU) so I can know where come from packets.

So my problem is that I will modify the driver to have 5 network interfaces
instead of 2 and filter BPDU packets with hardware.
But I can't find how bridge layer tells the network driver to change his
state. I explain myself : the KS8695 switch can be configured in disabled,
listening, learning, forwarding and blocking states ; so I want bridge layer
to inform my driver, so I will be able to change the hardware state of each
port.
If I well understood bridge layer only do software filtering, but is there a
way to configure my switch with ioctls or something like this ?
Or do I have to implement spanning tree directly in my driver ? I don't
think this is the good way because bridge protocol is already implemented
and I don't want to rewrite it.

Thanks,
Sebastien

------=_Part_6502_9524243.1207731087135
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,<br>I work on a SOC based on Micrel/Kendin KS8695 based on ARM9. (<a href="http://micrel.com/page.do?page=product-info/sys_on_chip.jsp">http://micrel.com/page.do?page=product-info/sys_on_chip.jsp</a>)<br>This component has 2 network interfaces. One is connected to a 5 ports switch.<br>
<br>eth0<br>eth1 =&gt; switch port1,2,3,4<br><br>I want to make a bridge with these 5 ports but my problem is that the network driver only install 2 interfaces.<br>The KS8695 network switch can be configured to tag ingress packet (such as BPDU) so I can know where come from packets.<br>
<br>So my problem is that I will modify the driver to have 5 network interfaces instead of 2 and filter BPDU packets with hardware.<br>But I can&#39;t find how bridge layer tells the network driver to change his state. I explain myself : the KS8695 switch can be configured in disabled, listening, learning, forwarding and blocking states ; so I want bridge layer to inform my driver, so I will be able to change the hardware state of each port.<br>
If I well understood bridge layer only do software filtering, but is there a way to configure my switch with ioctls or something like this ?<br>Or do I have to implement spanning tree directly in my driver ? I don&#39;t think this is the good way because bridge protocol is already implemented and I don&#39;t want to rewrite it.<br>
<br>Thanks,<br>Sebastien<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>

------=_Part_6502_9524243.1207731087135--
