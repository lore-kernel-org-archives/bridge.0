From: anand@eis.iisc.ernet.in (SVR Anand)
Message-Id: <200311250639.MAA21483@eis.iisc.ernet.in>
Date: Tue, 25 Nov 2003 12:09:57 +0530 (GMT+05:30)
In-Reply-To: <20031124110939.1cb3f87c.shemminger@osdl.org> from "Stephen
	Hemminger" at Nov 24, 2003 11:09:39 AM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: 2.6.0-test9 : bridge freezes
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-net@vger.kernel.org, bridge@osdl.org, linux-kernel@vger.kernel.org

Hi,

To begin with, thanks a lot for the concern you all have shown to address my 
problem.

This morning I have put in test9-bk25 image to see if the problem disappears. 
The result should be out in the next few hours. I hope it is OK if I send you 
the slabinfo in case the problem persists. 

I plan to test in stages.

i) Just bridging, no iptables
ii) With iptables.

I have very limited set of iptables rules. In fact it is as simple as blocking
icmp. There are no errors reported by ethernet devices.

Anand

PS : The latest test10 stops at the booting stage while initialising my aic7xxx
     scsi. So, I had to use bk25. 
> 
> Linus is right, this is probably a memory leak issue.  There are several areas
> that could be the problem:
> 	- core networking 
> 	- iptables
> 		- iptables filter
> 	- ethernet bridging
> 	- ethernet driver (rtl8169)
> 
> To find/fix the problem, we need to narrow down the scope.  
> Things that would help are, what are the iptables rules you are using?
> Are there any errors showing up on the ethernet devices?
> Also what does the bridge forwarding table look like? are there lots of entries, are
> you running spanning tree?
> 
> 
> 

