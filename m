Return-Path: <wangyunjian@huawei.com>
From: wangyunjian <wangyunjian@huawei.com>
Date: Thu, 17 Jan 2019 01:40:51 +0000
Message-ID: <34EFBCA9F01B0748BEB6B629CE643AE60C9DDABB@DGGEMM533-MBX.china.huawei.com>
References: <1547643861-15340-1-git-send-email-wangyunjian@huawei.com>
	<20190116093312.5274776e@shemminger-XPS-13-9360>
In-Reply-To: <20190116093312.5274776e@shemminger-XPS-13-9360>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net v3] net: bridge: Fix ethernet header
 pointer before check skb forwardable
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Nkolay Aleksandrov <nikolay@cumulusnetworks.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Roopa Prabhu <roopa@cumulusnetworks.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, xudingke <xudingke@huawei.com>

> -----Original Message-----
> From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> Sent: Thursday, January 17, 2019 1:33 AM
> To: wangyunjian <wangyunjian@huawei.com>
> Cc: netdev@vger.kernel.org; xudingke <xudingke@huawei.com>;
> bridge@lists.linux-foundation.org; Nkolay Aleksandrov
> <nikolay@cumulusnetworks.com>; Roopa Prabhu
> <roopa@cumulusnetworks.com>
> Subject: Re: [PATCH net v3] net: bridge: Fix ethernet header pointer befo=
re
> check skb forwardable
>=20
> On Wed, 16 Jan 2019 21:04:21 +0800
> wangyunjian <wangyunjian@huawei.com> wrote:
>=20
> >  		if (unlikely(netpoll_tx_running(to->br->dev))) {
> > +			skb_push(skb, ETH_HLEN);
> >  			if (!is_skb_forwardable(skb->dev, skb)) {
> >  				kfree_skb(skb);
> >  			} else {
> > -				skb_push(skb, ETH_HLEN);
> >  				br_netpoll_send_skb(to, skb);
> >  			}
> >  			return;
>=20
> The patch looks correct.
>=20
> On minor style issue is that after moving skb_push out of the if statemen=
t,
> both branches of the statement now contain a single line and therefore th=
e
> brackets are no longer necessary.  Suprised that checkpatch did not compl=
ain
> about this.

OK, I'll fix it and send the v4 later.

Thanks
	Yunjian

