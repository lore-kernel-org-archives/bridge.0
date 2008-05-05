Message-ID: <481F4D82.3000804@trash.net>
Date: Mon, 05 May 2008 20:10:10 +0200
From: Patrick McHardy <kaber@trash.net>
MIME-Version: 1.0
References: <96CF49BD8B56384395D698BA99007FA32FA1E8@exchange.pacwire.local>
In-Reply-To: <96CF49BD8B56384395D698BA99007FA32FA1E8@exchange.pacwire.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Preventing packet reassembly
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Leigh Sharpe <lsharpe@pacificwireless.com.au>
Cc: Stephen Hemminger <shemminger@vyatta.com>, bridge@lists.linux-foundation.org

Leigh Sharpe wrote:
> I have iptables rules on the management interface of the box, but not on
> any of the ports which participate in bridging.
> By removing iptables from my bootup, I get a properly functioning
> bridge.

Connection tracking performs defragmentation for all packets,
independant of the ruleset. For briding the packets should get
re-fragmented when leaving the bridge device though.

Please try "iptables -t raw -I PREROUTING -i <br-dev> -j TRACE",

load the ipt_LOG module and post the output.

