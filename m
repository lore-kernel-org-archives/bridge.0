Return-Path: <David.Laight@ACULAB.COM>
From: David Laight <David.Laight@ACULAB.COM>
Date: Fri, 6 Jun 2014 08:48:48 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1725853E@AcuExch.aculab.com>
References: <1401969212-19193-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
	<20140605.152151.1874961526019573838.davem@davemloft.net>
In-Reply-To: <20140605.152151.1874961526019573838.davem@davemloft.net>
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v2 net-next] bridge: Fix incorrect judgment of
	promisc
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: 'David Miller' <davem@davemloft.net>, "makita.toshiaki@lab.ntt.co.jp" <makita.toshiaki@lab.ntt.co.jp>
Cc: "stephen@networkplumber.org" <stephen@networkplumber.org>, "vyasevic@redhat.com" <vyasevic@redhat.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>

From: David Miller [mailto:davem@davemloft.net]
> > br_manage_promisc() incorrectly expects br_auto_port() to return only 0
> > or 1, while it actually returns flags, i.e., a subset of BR_AUTO_MASK.
> >
> > Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
>=20
> I'm applying this as-is for now, even though I saw the other
> suggestions in this thread (which BTW didn't get picked up by
> patchwork, maybe some of you dropped the Message-Id in your replies by
> accident).

I don't have a problem with that.
The condition looks odd, but it is enabling promiscuous mode
if any other ports are in 'auto' mode.
Possibly the comment above made that clear, but it was truncated
in the diffs.

	David



