Return-Path: <davem@davemloft.net>
Date: Mon, 15 Apr 2013 14:05:04 -0400 (EDT)
Message-Id: <20130415.140504.612756635505590698.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20130413170607.2a9294f6@nehalam.linuxnetplumber.net>
References: <20130413170607.2a9294f6@nehalam.linuxnetplumber.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] bridge: make user modified path cost sticky
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

From: Stephen Hemminger <stephen@networkplumber.org>
Date: Sat, 13 Apr 2013 17:06:07 -0700

> Keep a STP port path cost value if it was set by a user.
> Don't replace it with the link-speed based path cost
> whenever the link goes down and comes back up.
> 
> Reported-by: Roopa Prabhu <roopa@cumulusnetworks.com>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Applied, thanks.
