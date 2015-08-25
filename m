Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=content-type:mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=VcufPhny/GIlcR80T8xSqjPfJXECcZQO2N1Pfh2o/fU=;
	b=fTcHQXJ63xtJAROcHR8nlToEks+XSQYT+hGTFwgO3zg0Oxo+BBnQqQMmKMd7rGh+1d
	S+oy13W+J0/pGa0DmE/me35i0TdVFqqbRYiHLu9IWsR/16melg7M+DHnxHqytlCFziK3
	mqNDTHOn6VpKRJ6AWbIsB99oYCu35qUxi2kNE=
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
In-Reply-To: <20150825.164156.953467413772013603.davem@davemloft.net>
Date: Tue, 25 Aug 2015 16:47:00 -0700
Content-Transfer-Encoding: quoted-printable
Message-Id: <ECD45BE2-8150-48EB-8CAC-44698B43A1FC@cumulusnetworks.com>
References: <1440464127-27391-1-git-send-email-razor@blackwall.org>
	<20150825.164156.953467413772013603.davem@davemloft.net>
Subject: Re: [Bridge] [PATCH net-next] bridge: vlan: allow to suppress local
	mac install for all vlans
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: vyasevic@redhat.com, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, wkok@cumulusnetworks.com


> On Aug 25, 2015, at 4:41 PM, David Miller <davem@davemloft.net> wrote:
>=20
> From: Nikolay Aleksandrov <razor@blackwall.org>
> Date: Tue, 25 Aug 2015 03:55:27 +0300
>=20
> If it is actually 03:55:27 +0300 where you are, please send me your
> time travel device.
>=20
> And in the future please submit patches outside of your time
> travelling activities (ie. fix the date on your computer)
> thanks :-)
>=20

hahaha :-)
Sorry about that, I=E2=80=99m in the US but my VM is in another =
timezone. Anyway I=E2=80=99ll
submit a v2 shortly back in the future.


