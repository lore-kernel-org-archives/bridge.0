Date: Wed, 30 Jun 2004 15:53:06 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Non-forwarding bridge
Message-Id: <20040630155306.0c43b5fd@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040630222436.GA14452@imladris>
References: <20040630222436.GA14452@imladris>
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
To: Cameron Hutchison <camh+lbr@xdna.net>
Cc: bridge@lists.osdl.org

On Thu, 1 Jul 2004 08:24:36 +1000
Cameron Hutchison <camh+lbr@xdna.net> wrote:

> Is it possible to set up a non-forwarding bridge? I have two interfaces
> that I'd like to combine, where one is a fast main link and the other is
> a slower backup. I'd like traffic to go out the fast link only, if it is
> available, and failover to the backup if it is not available. I never
> want to forward packets between the interfaces.

You want bonding not bridging.


> One issue may be the 802.11g card on the laptop - a broadcom card
> running with ndiswrapper (0.8). I'm not sure if this configuration
> supports promiscuous mode and whether or not that is the cause of my
> problem.

Wise to suspect that, easy to test though. Just run your favorite
packet sniffer (tcpdump, ethereal).

> However, back to the original question: Can you setup a non-forwarding
> bridge? My problem would go away if you could. Or is there another way
> to configure networking to achieve the same functional result?

Then it isn't a bridge, it is bonding.
