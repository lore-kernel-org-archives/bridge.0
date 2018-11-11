Return-Path: <mirq-linux@rere.qmqm.pl>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
	t=1541952710; bh=/hN1ne/NQSsiwK6RceAe88zu9SWZXJ5X130eXob5NQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LjrAJ+UD91pEzin78LONnAzrTzZkIAaof6Uv/w8yomznoB/MNF9mgD3HybrMLwjlN
	XL0meXD+UVe6dnKy3X76Gl4NTd3uHRanHjBqwzIzhviaxxPqOxfcPQTVQY016yblnW
	CZAyhsxDWDfdQBkcbOLuOMrDTkRQxcFeEIAcIY6+eYhBRiw78a3y1oL086TYgBQCCg
	Uys5pGySSXdjZqVJkK83iuVrLd+RqZ4ZfZ6umkPfMqU2XN73q8w9D3FsBX2lkEyGqs
	zw3SpzlFbOR8bsYfVCFshUxW0WSPfFlN3Zrcmqg4EN+WPhWciDCWv6D9u2GanTvNpJ
	gMNaF9sOUy9JA==
Date: Sun, 11 Nov 2018 17:12:43 +0100
From: "mirq-linux@rere.qmqm.pl" <mirq-linux@rere.qmqm.pl>
Message-ID: <20181111161243.GA12849@qmqm.qmqm.pl>
References: <cover.1541718583.git.mirq-linux@rere.qmqm.pl>
	<20181108.204523.1353698272847299871.davem@davemloft.net>
	<28a275b4-4fd5-2c00-217a-c6ab69fb2ad9@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <28a275b4-4fd5-2c00-217a-c6ab69fb2ad9@mellanox.com>
Subject: Re: [Bridge] [PATCH net-next 0/9] Use __vlan_hwaccel_*() helpers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tariq Toukan <tariqt@mellanox.com>
Cc: "ajit.khaparde@broadcom.com" <ajit.khaparde@broadcom.com>, "somnath.kotur@broadcom.com" <somnath.kotur@broadcom.com>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "coreteam@netfilter.org" <coreteam@netfilter.org>, "kadlec@blackhole.kfki.hu" <kadlec@blackhole.kfki.hu>, "kuznet@ms2.inr.ac.ru" <kuznet@ms2.inr.ac.ru>, "pablo@netfilter.org" <pablo@netfilter.org>, "jiri@resnulli.us" <jiri@resnulli.us>, "swise@chelsio.com" <swise@chelsio.com>, "nikolay@cumulusnetworks.com" <nikolay@cumulusnetworks.com>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, "jhs@mojatatu.com" <jhs@mojatatu.com>, "sathya.perla@broadcom.com" <sathya.perla@broadcom.com>, "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "mlindner@marvell.com" <mlindner@marvell.com>, "sriharsha.basavapatna@broadcom.com" <sriharsha.basavapatna@broadcom.com>, "yoshfuji@linux-ipv6.org" <yoshfuji@linux-ipv6.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "fw@strlen.de" <fw@strlen.de>, "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>, David Miller <davem@davemloft.net>

On Sun, Nov 11, 2018 at 03:26:29PM +0000, Tariq Toukan wrote:
>=20
>=20
> On 09/11/2018 6:45 AM, David Miller wrote:
> > From: Micha=B3 Miros=B3aw <mirq-linux@rere.qmqm.pl>
> > Date: Fri, 09 Nov 2018 00:17:58 +0100
> >=20
> >> This series removes from networking core and driver code an assumption
> >> about how VLAN tag presence is stored in an skb. This will allow to fr=
ee
> >> up overloading of VLAN.CFI bit to incidate tag's presence.
> >=20
> > This looks good, series applied.
> >=20
> > Thanks.
> >=20
>=20
> Hi Michal,
>=20
> We started seeing the compilation errors below, they look related to=20
> this series.

Do you have the previous series applied that introduced __vlan_hwaccel_clea=
r_tag()?
It was applied to net-next before I sent this series.

I did a allmodconfig build of net-next and saw no failures (apart from
OVS that is fixed already).

Best Regards,
Micha=B3 Miros=B3aw
