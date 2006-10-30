Message-ID: <20061030113826.89160.qmail@web56910.mail.re3.yahoo.com>
Date: Mon, 30 Oct 2006 03:38:26 -0800 (PST)
From: Douglas Chen <g5ranger@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: 8bit
Subject: [Bridge] problem with bridge on soho router, when lan interface down,
	all go down
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi, 

I am using Linux 2.6.9 kernel on my soho router right now hoping to link the WAN and the LAN (4-port switch) ports together as the same network.  I am actually using two routers , connecting the wan port to each other, but this problem should apply to just one.

Ok, here's the problem.  The WAN port is eth0 and the LAN ports is eth1.  Assuming I have all 4 LAN ports connected to PCs.  When I remove any one of the connections, the bridge (or precisely eth1) enters the disabled state as normal.  However, since all 4 ports share the same eth1 interface, this also takes down the whole thing down and hence disables all other active connections.  I have to re-plug the cable back into the port to initiate a learning state -> forward state to bring the connections back or keep at least one connection constantly transmitting packets.  However, there is still like 20-30 seconds of disruption before recovery.  

I was wondering if anyone has experienced this before and appreciate for any solutions!!
Can bridge recognize these ports separately so it doesn't take down everything as a whole?

Thanks,
Douglas



