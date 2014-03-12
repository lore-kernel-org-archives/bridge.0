Return-Path: <davem@davemloft.net>
Date: Tue, 11 Mar 2014 23:23:31 -0400 (EDT)
Message-Id: <20140311.232331.953854418721439734.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1394486725-4992-2-git-send-email-linus.luessing@web.de>
References: <1394486725-4992-1-git-send-email-linus.luessing@web.de>
	<1394486725-4992-2-git-send-email-linus.luessing@web.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCHv2 2/2] bridge: multicast: enable snooping on
 general queries only
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linus.luessing@web.de
Cc: netdev@vger.kernel.org, fwestpha@redhat.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, stephen@networkplumber.org, jstancek@redhat.com

From: Linus L=FCssing <linus.luessing@web.de>
Date: Mon, 10 Mar 2014 22:25:25 +0100

> Without this check someone could easily create a denial of service
> by injecting multicast-specific queries to enable the bridge
> snooping part if no real querier issuing periodic general queries
> is present on the link which would result in the bridge wrongly
> shutting down ports for multicast traffic as the bridge did not learn=

> about these listeners.
> =

> With this patch the snooping code is enabled upon receiving valid,
> general queries only.
> =

> Signed-off-by: Linus L=FCssing <linus.luessing@web.de>

Applied.
