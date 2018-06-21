Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=KzHhBFRNexS9vHEkpQXOL5Nfy7fbIr6pAQnkT/S9/gU=;
	b=aK76BrRTUi8WX6THnrrhwI0rlClRuIpkew1/Ffju1Hj001Y+4t4NOLOPfYbreesJ6Q
	D9WwXqp/elZaVGoQCeSuwADpVkf5SLZypehesDj8jlVNSwVPLhaUbfQndN/a5HDrQKzg
	yW3rHSi/WezckBbhjiAP+jVlEPeQz9G7QdPqPyN4XSV6CFLIKnIaFL3qlDB3VR0XxXie
	L3Sgp5d5SFDPepW3bM8QLwAg/wUIDMEmNRCwkr+mr7QUfs5v1fzoznUGKXYrUtexKrHD
	9StzodvYTgJekg+0yNz5EE6UFAnbaKrHMJ5FEWwyRpB3JMaV0Ydp1DrSUXB9zuK1SIBO
	sFbg==
Date: Thu, 21 Jun 2018 16:21:16 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20180621162116.7f424648@xeon-e3>
In-Reply-To: <20180622.072056.1223319763674661318.davem@davemloft.net>
References: <20180621201427.4961-1-garrmcnu@gmail.com>
	<20180622.072056.1223319763674661318.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] net: bridge: fix potential null pointer
 dereference on return from br_port_get_rtnl()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: jiri@resnulli.us, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, garrmcnu@gmail.com

On Fri, 22 Jun 2018 07:20:56 +0900 (KST)
David Miller <davem@davemloft.net> wrote:

> From: Garry McNulty <garrmcnu@gmail.com>
> Date: Thu, 21 Jun 2018 21:14:27 +0100
> 
> > br_port_get_rtnl() can return NULL if the network device is not a bridge
> > port (IFF_BRIDGE_PORT flag not set). br_port_slave_changelink() and
> > br_port_fill_slave_info() callbacks dereference this pointer without
> > checking. Currently this is not a problem because slave devices always
> > set this flag. Add null check in case these conditions ever change.
> > 
> > Detected by CoverityScan, CID 1339613 ("Dereference null return value")
> > 
> > Signed-off-by: Garry McNulty <garrmcnu@gmail.com>  
> 
> I don't think this is reasonable.
> 
> The bridge code will never, ever, install a slave that doesn't have
> that bit set.  It's the most fundamental aspect of how these objects
> are managed.

Agree with dave. Workarounds for static tools are ok if they don't introduce
other paths. But if your fix introduces another error path which can never
be reached, it is hurting not helping.
