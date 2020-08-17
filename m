Return-Path: <davem@davemloft.net>
Date: Sun, 16 Aug 2020 21:10:02 -0700 (PDT)
Message-Id: <20200816.211002.1955628031429504263.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200816202424.3526-1-linus.luessing@c0d3.blue>
References: <20200816202424.3526-1-linus.luessing@c0d3.blue>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [RFC PATCH net-next] bridge: Implement MLD Querier
 wake-up calls / Android bug workaround
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linus.luessing@c0d3.blue
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, gluon@luebeck.freifunk.net, openwrt-devel@lists.openwrt.org

From: Linus L=FCssing <linus.luessing@c0d3.blue>
Date: Sun, 16 Aug 2020 22:24:24 +0200

> I'm aware that this is quite a hack, so I'm unsure if this is suitabl=
e
> for upstream. On the other hand, the Android ticket isn't moving
> anywhere and even if it were fixed in Android, I'd expect it to take
> years until that fix would propagate or unpatched Android devices to
> vanish. So I'm wondering if it should be treated like a hardware bug
> workaround and by that should be suitable for applying it upstream in=

> the Linux kernel?

Long after those Android devices are deprecated and no longer used, we
will still have this ugly hack in the tree.

Sorry, we're not doing this.
