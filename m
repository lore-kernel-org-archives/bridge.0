Date: Fri, 28 Jan 2005 09:37:33 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Benchmarking bridging vs. routing on same
	hardware/network
Message-ID: <20050128093733.09d44e2e@dxpl.pdx.osdl.net>
In-Reply-To: <200501280417.j0S4HjTV020778@fire-1.osdl.org>
References: <20050126130903.02aaea4a@dxpl.pdx.osdl.net>
	<200501280417.j0S4HjTV020778@fire-1.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: dan-linuxbridge@unpossible.com
Cc: bridge@lists.osdl.org

How are you testing?
Remember how bridging learns about systems on the network, it works by
listing to incoming packets. So if you force one way only traffic or send to
random targets and the target never sends anything; then the bridge 
forwarding table would never get seeded. This would make every look
up miss, and hurt performance.

You could check by dumping the forwarding table with 'br showmacs br0'

