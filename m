Message-ID: <1bde01c45e35$79cb70f0$8805640a@internal.watertech.com>
From: "Chris Shaw" <chriss@watertech.com>
Date: Tue, 29 Jun 2004 17:02:03 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [Bridge] MTU Question
Reply-To: Chris Shaw <chriss@watertech.com>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

I have a bridge that has gigabit interfaces. The machine in question has the
fun job of being a Bridge, Firewall and SMB server. Both of the Gigabit
interfaces are connected to workstations directly via Xover cable (well
MDI-X to be exact). My question is, if I enable jumbo frames on the gigabit
interfaces will that make any difference in overall transfer rate of the
bridge? I was thinking it might because even though the NIC is enslaved, it
IS the device that the workstations communicate to. But also it might not
because when applications talk to the network they're using BR(n) at
1500bytes.. can a bridging guru shed some light on this for me?

-Thank you in advance
Chris

