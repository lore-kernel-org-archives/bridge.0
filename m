Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=content-type:mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=eKKxoV1yCUkPr6iykISnf9nx4d2E+OpGOETnrdyalFE=;
	b=RcSGdKFs7ahdB2bIuXpXaZ4D0VVQlKl/9ZVej/rU05qcsuRaYZrsUlkRbTYeWbg3P9
	ffyr6N5fNAUBV+4yMjdaAG2G0XtqR34SwrbGiKkxe46Wrq6g5ovwagr029zji8MzlrkX
	aC8tE6RN9Jk8TNqG4YA0bLmocZCK16sx6ePK8=
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
In-Reply-To: <1440655205-14247-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
Date: Thu, 27 Aug 2015 08:48:09 -0700
Content-Transfer-Encoding: quoted-printable
Message-Id: <63AC6A69-F9A1-4A83-8EF7-D897243743B4@cumulusnetworks.com>
References: <1440655205-14247-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
Subject: Re: [Bridge] [PATCH net-next] bridge: Add netlink support for
	vlan_protocol attribute
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, "David S . Miller" <davem@davemloft.net>


> On Aug 26, 2015, at 11:00 PM, Toshiaki Makita =
<makita.toshiaki@lab.ntt.co.jp> wrote:
>=20
> This enables bridge vlan_protocol to be configured through netlink.
>=20
> When CONFIG_BRIDGE_VLAN_FILTERING is disabled, kernel behaves the
> same way as this feature is not implemented.
>=20
> Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
> ---
> include/uapi/linux/if_link.h |  1 +
> net/bridge/br_netlink.c      | 34 ++++++++++++++++++++++++++++++++++
> net/bridge/br_private.h      |  1 +
> net/bridge/br_vlan.c         | 35 +++++++++++++++++++++--------------
> 4 files changed, 57 insertions(+), 14 deletions(-)
>=20

Nice, looks good. I have a similar patch as well and was going to ask =
wouldn=E2=80=99t it be
better to make empty stubs which return an error when vlan filtering =
isn=E2=80=99t configured
and drop the ifdefs in the netlink handling code ?
Similar to how vlan_filtering netlink attribute is handled in commit:
a7854037da00 ("bridge: netlink: add support for vlan_filtering =
attribute=E2=80=9D)

Potential problem would be the return of the protocol, but I think if 0 =
is returned that
can be handled.

Cheers,
 Nik

