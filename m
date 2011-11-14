Return-Path: <joe@perches.com>
Message-ID: <1321280870.2004.2.camel@Joe-Laptop>
From: Joe Perches <joe@perches.com>
Date: Mon, 14 Nov 2011 06:27:50 -0800
In-Reply-To: <20111114.020749.1176229013272872343.davem@davemloft.net>
References: <1320941934-3534-1-git-send-email-holger.brunck@keymile.com>
	<20111114.003702.1097206603722725705.davem@davemloft.net>
	<1321254211.4072.29.camel@pc005091.de.keymile.net>
	<20111114.020749.1176229013272872343.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
Subject: Re: [Bridge] [PATCH] net,
	bridge: print log message after state changed
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, shemminger@linux-foundation.org, bridge@lists.linux-foundation.org, holger.brunck@keymile.com, Wolfgang.Fritz@keymile.com

On Mon, 2011-11-14 at 02:07 -0500, David Miller wrote:
> I would never expect an "entering" message to print out after the event
> happens, and in fact I'd _always_ want to see it beforehand so that if
> the state change caused a crash or similar it'd be that much easier
> to pinpoint the proper location.
> 
> I'm still not applying this.  If the other log messages behave
> differently, they are broken, so go fix those instead.

Perhaps use "entered" after the transition or "entering" before.


