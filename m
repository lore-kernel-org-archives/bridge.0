Date: Fri, 2 May 2008 12:24:27 -0700
From: Jason Lunz <lunz@acm.org>
Message-ID: <20080502192425.GA32302@falooley.org>
References: <96CF49BD8B56384395D698BA99007FA32FA1E8@exchange.pacwire.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96CF49BD8B56384395D698BA99007FA32FA1E8@exchange.pacwire.local>
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

In gmane.linux.network.bridge, you wrote:
> I have iptables rules on the management interface of the box, but not on
> any of the ports which participate in bridging.
> By removing iptables from my bootup, I get a properly functioning
> bridge.
>
> Why would iptables rules on one interface affect traffic bridged on
> other interfaces? I'm presuming it's some kind of interaction with the
> ip_conntrack module? Any way to stop it from loading?

You might find the iptables NOTRACK target helpful.

Jason
