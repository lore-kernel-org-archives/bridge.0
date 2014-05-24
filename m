Return-Path: <davem@davemloft.net>
Date: Fri, 23 May 2014 23:36:37 -0400 (EDT)
Message-Id: <20140523.233637.1826798421419100755.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1400662742-31999-3-git-send-email-linus.luessing@web.de>
References: <1400662742-31999-1-git-send-email-linus.luessing@web.de>
	<1400662742-31999-3-git-send-email-linus.luessing@web.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH net-next 2/4] bridge: adhere to querier
 election mechanism specified by RFCs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linus.luessing@web.de
Cc: stephen@networkplumber.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Linus L=FCssing <linus.luessing@web.de>
Date: Wed, 21 May 2014 10:59:00 +0200

> +	if (saddr <=3D br->ip4_querier.addr.u.ip4)
> +		goto update;

It is clear to me that you should be making these comparisons in cpu
endianness.

Otherwise the code will handle the same situations differently
on big-endian vs. little-endian machines.

