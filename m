Date: Thu, 27 Jul 2006 10:39:46 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20060727103946.16a2d467@localhost.localdomain>
In-Reply-To: <44C8843A.4010200@seskion.de>
References: <44C77FD2.2030208@seskion.de>
	<20060726083455.08989fc6@localhost.localdomain>
	<44C7979B.7040906@seskion.de> <20060726101335.67406ee8@localhost>
	<44C8843A.4010200@seskion.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Is bridgeing possible with kernel 2.6.10
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Juergen Pfeiffer <j.pfeiffer@seskion.de>
Cc: bridge@lists.osdl.org

> Hi
> Here is the trace of my test:
> After the output of "now do pings!", i started to ping on computer 
> 192.168.1.1 (MAC=00:50:fc:93:e0:9c), connected to eth1 of my bridge to 
> computer 192.168.1.33 (MAC=00:14:22:f2:5d:70), connected to eth0 of my 
> bridge.
> => No Responses! May it be a problem of my ethernet driver 
> (drivers/net/fec.c for Freescale ColdFire 5485) ??

Perhaps you have a switch or driver issue that is preventing promiscuous
mode from working.  You can test this without bridging by running
tcpdump on the interface and seeing if the packets are coming in.
