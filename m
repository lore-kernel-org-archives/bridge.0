Return-Path: <linus.luessing@web.de>
Date: Mon, 22 Jul 2013 22:05:11 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20130722200511.GA5852@Linus-Debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1371815638-5618-1-git-send-email-linus.luessing@web.de>
Subject: Re: [Bridge] [PATCH] bridge: prevent flooding IPv6 packets that do
 not have a listener
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>, Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>, "David S. Miller" <davem@davemloft.net>

Hi Herbert,

Were there any reasons I might not be aware of which prevented you
from adding the same change you introduced in
"bridge: Only flood unregistered groups to routers" for IPv6, too?

If not and if no one else comes up with any objection, then I'd
still be happy if this patch could find its way upstream :).

Cheers, Linus
