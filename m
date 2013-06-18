Return-Path: <davem@davemloft.net>
Date: Mon, 17 Jun 2013 17:11:41 -0700 (PDT)
Message-Id: <20130617.171141.1129703356005827268.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1371417634-29803-1-git-send-email-linus.luessing@web.de>
References: <1371417634-29803-1-git-send-email-linus.luessing@web.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH] bridge: fix switched interval for MLD Query
	types
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linus.luessing@web.de
Cc: stephen@networkplumber.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org

From: Linus L=FCssing <linus.luessing@web.de>
Date: Sun, 16 Jun 2013 23:20:34 +0200

> General Queries (the one with the Multicast Address field
> set to zero / '::') are supposed to have a Maximum Response Delay
> of [Query Response Interval], while for Multicast-Address-Specific
> Queries it is [Last Listener Query Interval] - not the other way
> round. (see RFC2710, section 7.3+7.8)
> =

> Signed-off-by: Linus L=FCssing <linus.luessing@web.de>

Applied, thanks.
