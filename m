Message-ID: <41200E80.2000005@trash.net>
Date: Mon, 16 Aug 2004 03:31:44 +0200
From: Patrick McHardy <kaber@trash.net>
MIME-Version: 1.0
References: <411EAF08.3000401@shorewall.net> <411F5D5E.4000001@trash.net>
	<411F7B87.7060303@shorewall.net>
In-Reply-To: <411F7B87.7060303@shorewall.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: Policy match with a bridge
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Tom Eastep <teastep@shorewall.net>
Cc: netfilter-devel@lists.netfilter.org, bridge@osdl.org

Tom Eastep wrote:

> | Have you applied the ipsec+netfilter patches ? Without them, packets 
> are
> | only seen encrypted in the OUTPUT chain.
> |
> Yes -- the ipsec+netfilter patches are applied. Here is the same test
> with the bridge removed and the local ip address transfered to one of
> the network cards: 

The problem is ipv4_sabotage_out in the briding code. It prevents the
packet from hitting the LOCAL_OUT hook while it is still unencrypted.
When it hits the bridging code and its LOCAL_OUT hook it's too late.
Not sure how to handle it yet.

Regards
Patrick

