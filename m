Date: Tue, 15 Feb 2011 15:41:28 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20110215154128.2a28632c@nehalam>
In-Reply-To: <1297811961-19249-1-git-send-email-linus.luessing@web.de>
References: <1297811961-19249-1-git-send-email-linus.luessing@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Multicast snooping fixes and suggestions
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Linus =?ISO-8859-1?B?TPxzc2luZw==?= <linus.luessing@web.de>, Herbert Xu <herbert@gondor.hengli.com.au>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org

On Wed, 16 Feb 2011 00:19:16 +0100
Linus L=FCssing <linus.luessing@web.de> wrote:

> Hello everyone,
>=20
> While testing the (very awesome!) bridge igmp/mld snooping support I came=
 across
> two issues which are breaking IPv6 multicast snooping and IPv6
> non-link-local multicast on bridges with multicast snooping support enabl=
ed
> in general. The first two patches shall fix these issues.
>=20
> The third one addresses a potential bug on little endian machines which I=
 noticed
> during this little code reviewing. This patch is untested though, feedbac=
k welcome.
>=20
> The fourth and fifth patch are a suggestion to also permit using the brid=
ge multicast
> snooping feature for link local multimedia multicast traffic. Therefore
> using the transient multicast flag instead of the non-link-local scope cr=
iteria
> seems to be a suitable solution at least for IPv6, in my opinion. Let me =
know what
> you think about it.
>=20
> Thanks for reviewing these patches.
>=20
> Cheers,
> Linus

These look correct. Did you test them with real traffic?
