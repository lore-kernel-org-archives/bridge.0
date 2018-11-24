Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=date:in-reply-to:references:mime-version:content-transfer-encoding
	:subject:to:cc:from:message-id;
	bh=msj3yTNqnjwdCBJLsIyewubxo9mjdIRkIpyGcJW1kRg=;
	b=Dk6OcwX5LjsWHMOtvOuLLsNE9V293gwjkPZ4dMPSVIJwQUydU00CSyOE30FGH0S00c
	7xEEa2NaSYPa3JyN2yksNZTGEDZ7YoKLJaeybufeGu7kLOqM66jbZXwb6VXFjz8UuaR8
	mHfh41DWRDtHCMz0SE7T0bOpa27sajeKUFwK0=
Date: Sat, 24 Nov 2018 18:20:20 +0200
In-Reply-To: <20181124161647.GB24681@lunn.ch>
References: <20181124023422.13908-1-nikolay@cumulusnetworks.com>
	<20181124023422.13908-4-nikolay@cumulusnetworks.com>
	<20181124161647.GB24681@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: nikolay@cumulusnetworks.com
Message-ID: <551ED2FE-AA42-474F-9465-E98BB2E5B8E3@cumulusnetworks.com>
Subject: Re: [Bridge] [PATCH net-next v2 3/3] net: bridge: export supported
	boolopts
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

On 24 November 2018 18:16:47 EET, Andrew Lunn <andrew@lunn=2Ech> wrote:
>On Sat, Nov 24, 2018 at 04:34:22AM +0200, Nikolay Aleksandrov wrote:
>> Now that we have at least one bool option, we can export all of the
>> supported bool options via optmask when dumping them=2E
>>=20
>Hi Nik
>
>That answers my question then=2E=2E=2E
>
>I'm assuming this means there is no easy way to generate a bitmask of
>0? So you waited until there was at least one bit=2E
>
>(1 << 2) - 1 =3D 3
>(1 << 1) - 1 =3D 1
>(1 << 0) - 1 =3D 0
>
>So does=20
>
>GENMASK((BR_BOOLOPT_MAX - 1), 0);
>
>really not do the right thing when BR_BOOLOPT_MAX =3D 1?
>

GENMASK(0, 0) =3D 1
the minus is done before the shift=2E=20
Think of it of setting all bits from 0 to MAX - 1 inclusive=2E=20

>       Andrew


--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
