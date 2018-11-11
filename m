Return-Path: <mirq-linux@rere.qmqm.pl>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
	t=1541952919; bh=4xX2Wv8koA022+QCKuflclgcJcxlyWYKZPLiC/rV7lY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OHQB/PrmI/Q8wikevlSR8D+I0AzDFHDfOVHcU6Yo7XE/qUu5wgQlFWGHxzEdiOR+f
	Fwh/BZcLJ0VAJ8NdtVTylk7WzsPsFDJkKhmbf5wq+7VEQrpT2Y8hceVJiM1qWxxx8n
	4ahj+z6EPWZRMxMd4v5e+sKiYWVzIHOJ2ROxvNAKpwapIJ2hpsttICsQh9Po4Oveqv
	L3nrLwqfSzXwpk0CdJrhJ9+48fnqTS4It/d47j4H7Yx14oexHApMvF83GSfADF+S39
	C9CSJ7ueuPw3aojx3G92QfBIqya2KrrYeErFK/JJtaxTz6qiKZLNmvLPiLmijhhy/l
	IjrRVgRqhl9Xw==
Date: Sun, 11 Nov 2018 17:16:17 +0100
From: "mirq-linux@rere.qmqm.pl" <mirq-linux@rere.qmqm.pl>
Message-ID: <20181111161617.GB12849@qmqm.qmqm.pl>
References: <cover.1541718583.git.mirq-linux@rere.qmqm.pl>
	<20181108.204523.1353698272847299871.davem@davemloft.net>
	<28a275b4-4fd5-2c00-217a-c6ab69fb2ad9@mellanox.com>
	<20181111161243.GA12849@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181111161243.GA12849@qmqm.qmqm.pl>
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

On Sun, Nov 11, 2018 at 05:12:43PM +0100, mirq-linux@rere.qmqm.pl wrote:
> On Sun, Nov 11, 2018 at 03:26:29PM +0000, Tariq Toukan wrote:
> > On 09/11/2018 6:45 AM, David Miller wrote:
> > > From: Micha=B3 Miros=B3aw <mirq-linux@rere.qmqm.pl>
> > > Date: Fri, 09 Nov 2018 00:17:58 +0100
> > >> This series removes from networking core and driver code an assumpti=
on
> > >> about how VLAN tag presence is stored in an skb. This will allow to =
free
> > >> up overloading of VLAN.CFI bit to incidate tag's presence.
> > >=20
> > > This looks good, series applied.
> > >=20
> > > Thanks.
> > Hi Michal,
> >=20
> > We started seeing the compilation errors below, they look related to=20
> > this series.
>=20
> Do you have the previous series applied that introduced __vlan_hwaccel_cl=
ear_tag()?
> It was applied to net-next before I sent this series.
>=20
> I did a allmodconfig build of net-next and saw no failures (apart from
> OVS that is fixed already).

The prerequisite commit in net-next is:

7025abb2e447b ("Merge branch 'vlan-prepare-for-removal-of-VLAN_TAG_PRESENT'=
")

Best Regards,
Micha=B3 Miros=B3aw
