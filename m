Subject: Re: [Bridge] bridge in 'hub' mode possible?
References: <87d5xw4uui.fsf@aka.i.naked.iki.fi>
	<20041129102432.24888dad@zqx3.pdx.osdl.net>
	<87ekic1p6w.fsf@aka.i.naked.iki.fi>
	<20041202112002.444fdff0@dxpl.pdx.osdl.net>
From: Nuutti Kotivuori <naked@iki.fi>
Date: Thu, 02 Dec 2004 22:29:53 +0200
In-Reply-To: <20041202112002.444fdff0@dxpl.pdx.osdl.net> (Stephen
	Hemminger's message of "Thu, 2 Dec 2004 11:20:02 -0800")
Message-ID: <87mzwwxx32.fsf@aka.i.naked.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@osdl.org

Stephen Hemminger wrote:
> Have you tried "brctl setageingtime br0 0" to turn off 
> forwarding table?

Actually, yes, it works.

I started digging into the code soon after my inquiry and determined
that if I do:

  brctl stp br0 off
  brctl setageing br0 0
  brctl setfd br0 0

I get it to behave as wanted. The last setting is just paranoia, in
case the bridge decided it was reconfiguring itself for some odd
reason.

Ofcourse the bridge still learns the MAC addresses, but since it
always considers them expired, it is just wasted effort.

So, thanks for your assistance, problem resolved.

-- Naked



