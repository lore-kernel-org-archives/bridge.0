Return-Path: <stephen@networkplumber.org>
Date: Mon, 4 May 2015 09:10:31 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20150504091031.1ff55398@urahara>
In-Reply-To: <1430568067-6912-2-git-send-email-linus.luessing@c0d3.blue>
References: <1430568067-6912-1-git-send-email-linus.luessing@c0d3.blue>
	<1430568067-6912-2-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCHv3 net-next 1/2] bridge: multicast: call
 skb_checksum_{simple_, }validate
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Linus =?UTF-8?B?TMO8c3Npbmc=?= <linus.luessing@c0d3.blue>
Cc: bridge@lists.linux-foundation.org, Herbert Xu <herbert@gondor.apana.org.au>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, Tom Herbert <tom@herbertland.com>, "David S.
	Miller" <davem@davemloft.net>

On Sat,  2 May 2015 14:01:06 +0200
Linus L=C3=BCssing <linus.luessing@c0d3.blue> wrote:

> Let's use these new, neat helpers.
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>

Acked-by: Stephen Hemminger <stephen@networkplumber.org>

