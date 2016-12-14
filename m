Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=EZQj5adHbjKeZ6SixO0sCKgqJV0XgisizSM2M2KefFw=;
	b=HE2jgYZ9qIrn/ixnMmXqv8MRn6gCxvtaYDg0A04FV+2eSXpjuZ4/F1EaXXVni75c6w
	9llGIzVvA/FY2Xt62ihGm6TJ+nsPR6WTapZFjKIglfN3anU6RAiQXmM8bLh74G/0KrzZ
	BoXdxVgyFbfBKxrqEw66D2485qrdmaYNLtcK48I5Bri5xiA06QLCA+CoOymgsLHX/uiu
	NfelmWjEggS6Sx18tdnymAfWrJ+RrK4qYPt1dueGS7yDlf1S7xzmsjncScMPirNeIOiU
	2XAxRqcZxU/JTaWKx+pXdvqU9EXaf95xLtQueV2sUMr1zUHAoPDt8Mm++F4F8fDzE8ZQ
	Bq5w==
Date: Tue, 13 Dec 2016 17:21:18 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20161213172118.2f55c503@xeon-e3>
In-Reply-To: <cfa1f2efae2217b50cbefccbf9ba7f0d24a23c63.1480755768.git.mirq-linux@rere.qmqm.pl>
References: <cfa1f2efae2217b50cbefccbf9ba7f0d24a23c63.1480755768.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH net-next] net: remove abuse of VLAN DEI/CFI bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: "open list:OPENVSWITCH" <dev@openvswitch.org>, netdev@vger.kernel.org, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>

On Sat,  3 Dec 2016 10:22:28 +0100 (CET)
Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl> wrote:

> This All-in-one patch removes abuse of VLAN CFI bit, so it can be passed
> intact through linux networking stack.
>=20
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <michal.miroslaw@atendesoftware.=
pl>
> ---
>=20
> Dear NetDevs
>=20
> I guess this needs to be split to the prep..convert[]..finish sequence,
> but if you like it as is, then it's ready.
>=20
> The biggest question is if the modified interface and vlan_present
> is the way to go. This can be changed to use vlan_proto !=3D 0 instead
> of an extra flag bit.
>=20
> As I can't test most of the driver changes, please look at them carefully.
> OVS and bridge eyes are especially welcome.
>=20
> Best Regards,
> Micha=C5=82=C2=A0Miros=C5=82aw

Is the motivation to support 802.1ad Drop Eligability Indicator (DEI)?

If so then you need to be more verbose in the commit log, and lots more
work is needed. You need to rename fields and validate every place a
driver is using DEI bit to make sure it really does the right thing
on that hardware. It is not just a mechanical change.
