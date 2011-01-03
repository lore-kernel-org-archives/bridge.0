Date: Mon, 3 Jan 2011 10:15:33 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20110103101533.3f98b311@nehalam>
In-Reply-To: <20110103.092214.193706896.davem@davemloft.net>
References: <1293284490-17114-1-git-send-email-xiaosuo@gmail.com>
	<20101231.111003.48499853.davem@davemloft.net>
	<AANLkTingFk8qJ8tBwSRCxD=9k-0O3GnTv9V9TbF4N=bg@mail.gmail.com>
	<20110103.092214.193706896.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] net: bridge: check the length of skb after
 nf_bridge_maybe_copy_header()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, xiaosuo@gmail.com

On Mon, 03 Jan 2011 09:22:14 -0800 (PST)
David Miller <davem@davemloft.net> wrote:

> From: Changli Gao <xiaosuo@gmail.com>
> Date: Mon, 3 Jan 2011 18:44:59 +0800
> 
> > On Sat, Jan 1, 2011 at 3:10 AM, David Miller <davem@davemloft.net> wrote:
> >> From: Changli Gao <xiaosuo@gmail.com>
> >> Date: Sat, 25 Dec 2010 21:41:30 +0800
> >>
> >>> Since nf_bridge_maybe_copy_header() may change the length of skb,
> >>> we should check the length of skb after it to handle the ppoe skbs.
> >>>
> >>> Signed-off-by: Changli Gao <xiaosuo@gmail.com>
> >>
> >> This is really strange.
> >>
> >> packet_length() subtracts VLAN_HLEN from the value it returns, so the
> >> correct fix seems to be to make this function handle the PPPOE case
> >> too.
> >>
> > 
> > It is correct. The actual MTU of 802.1q frame is 4 bytes larger. For
> > example, the MTU of ethernet is normally 1500, however the actual MTU
> > of the 802.1Q is 1504.
> 
> Yes, I understand this, but I don't see why packet_length() cannot
> simply account for PPPOE's encapsulation overhead just as it does for
> VLAN's special MTU considerations.

Because PPPOE happens afterwards and is not part the calculation.
The check should be moved until after skb has reached final form.

-- 
