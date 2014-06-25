Return-Path: <davem@davemloft.net>
Date: Wed, 25 Jun 2014 16:09:25 -0700 (PDT)
Message-Id: <20140625.160925.2125216104261498290.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1403534015-28496-1-git-send-email-mbizon@freebox.fr>
References: <1403534015-28496-1-git-send-email-mbizon@freebox.fr>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: mark packets sent to any local mac
 address as PACKET_HOST
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: mbizon@freebox.fr
Cc: stephen@networkplumber.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org

From: Maxime Bizon <mbizon@freebox.fr>
Date: Mon, 23 Jun 2014 16:33:35 +0200

> The bridge code only set PACKET_HOST on packets sent to the bridge mac
> address, packets sent to other local mac addresses are sent to upper
> layers, but ignored because they are marked as PACKET_OTHERHOST.
> 
> Signed-off-by: Maxime Bizon <mbizon@freebox.fr>

This looks fine to me, Stephen and other bridge hackers please review.
