Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=EV1btiOrrKzmIG9fdDDMxxleS6gYQNgwCyZMdgyubQk=;
	b=lHDpO4z8siDXFinMgirCEggPKU6lYRs9yMeIPhCnvvMfElOzQs6zRKgCa4S+Ppvr77
	x2/qimgDNJ6UnEQhnyT7R3VIQPYXLapLHnbbAlodvoUSZvFbsNLVm9YsX1MgUOYcqkrm
	CcKJfTkGkOO4FxDJ7cygka2Ob1Ea7Y5rIcufYiCOMmj64yL9oRDqPDHv5Q0lk6Wa8+Bh
	DCqJzLggnJB3wNptHF96+Jzj0WzKlbFF3tOkI5YqJrDCNkmyjseMy2H/1IfjRBeTNi8M
	erpRRSSyhbtDg0eg5HIctThcCE7987aPYNyIrAE7s2PT7PnCHuVHEcB94+oV1dJBmI+C
	LFfw==
Date: Mon, 9 Jan 2017 13:30:32 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20170109133032.221f8669@xeon-e3>
In-Reply-To: <20170109212345.GA5513@otheros>
References: <20170102193214.31723-1-linus.luessing@c0d3.blue>
	<1483706872.4089.8.camel@sipsolutions.net>
	<8836daaa-9638-4502-d079-fd428595f822@nbd.name>
	<1483710841.12677.1.camel@sipsolutions.net>
	<22fad045-57c6-7789-d19f-f47bd0faf441@fami-braun.de>
	<20170107145516.GE3134@otheros>
	<1483949336.17582.3.camel@sipsolutions.net>
	<6f5ec9f1-800a-2bc4-2f41-9d803343bb22@fami-braun.de>
	<20170109212345.GA5513@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH net-next] bridge: multicast to unicast
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Linus =?UTF-8?B?TMO8c3Npbmc=?= <linus.luessing@c0d3.blue>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, "M. Braun" <michael-dev@fami-braun.de>, Johannes Berg <johannes@sipsolutions.net>, "David S . Miller" <davem@davemloft.net>, Felix Fietkau <nbd@nbd.name>

On Mon, 9 Jan 2017 22:23:45 +0100
Linus L=C3=BCssing <linus.luessing@c0d3.blue> wrote:

> On Mon, Jan 09, 2017 at 12:44:19PM +0100, M. Braun wrote:
> > Am 09.01.2017 um 09:08 schrieb Johannes Berg: =20
> > > Does it make sense to implement the two in separate layers though?
> > >=20
> > > Clearly, this part needs to be implemented in the bridge layer due to
> > > the snooping knowledge, but the code is very similar to what mac80211
> > > has now. =20
> >=20
> > Does the bridge always know about all stations connected? =20
>=20
> The bridge does not always know about all stations, especially the
> silent ones like in your DVB-T example.
>=20
> However, concerning IP multicast, there is IGMP/MLD. So the bridge
> does know about all stations which are interested in a specific IP
> multicast stream.
>=20
> (As long as there is a querier on the link, which periodically
> queriers for IGMP/MLD reports from any listener. If there is no
> querier then the bridge multicast snooping, including the bridge
> multicast-to-unicast will fall back to flooding)
>=20
>=20
> So if your television example uses IP multicast properly, it is
> completely doable with the bridge multicast-to-unicast, thanks to
> IGMP/MLD.

I wonder if MAC80211 should be doing IGMP snooping and not bridge
in this environment.
