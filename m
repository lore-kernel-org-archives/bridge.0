Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding;
	bh=WDsgZBIVcfNfxoTSmCwCZvEdd6xPwqM2hVr4T7kVBaE=;
	b=k6CdRNWaHYCDPldin/lVBs6R/fj6KzfdVThWUxY0kQcOGq9Nkd0vyZ6cLC5imslox9
	HIKxyF6leM+Eyr4+gtnQ6bgAs1rZfcxwSBtRmtBBdxQOWygnWRG3csfigJ5cCv4Gw89n
	RNcZm78bLac5XnlrYn/f7zxMh5vEDmllr10E0TnthZ6v2QkZhVC0HSnY8XMkiYZ9V19Y
	VqZZAmY1EkXrZDFune7q5EYJlwUdsLfmT9iS1UIIJdPPMjOV21k8Gr3xppdNTHSqMFpM
	yq6rOvkGcEUhlolkhBILb3LxTbLEycMC4q/cMBF8xtxX/m32tXI76d8ppbEyZwZVkGL8
	4CYA==
Date: Fri, 22 Jan 2016 13:10:46 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20160122131046.6f141681@xeon-e3>
In-Reply-To: <56A2993B.4070307@gmail.com>
References: <56A2993B.4070307@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] hw csum failure introduced in linux-4.2
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6?= Rojas <noltari@gmail.com>
Cc: bridge@lists.linux-foundation.org, davem@davemloft.net

On Fri, 22 Jan 2016 22:03:55 +0100
=C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com> wrote:

>  From linux-4.2 there's a "hw csum failure" for bridges using hardware=20
> checksums when IPv6 multicast traffic is received.
>=20
> Here are some reports:
> https://lkml.org/lkml/2015/12/1/699
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1266601
> https://discourse.osmc.tv/t/hw-csum-failure/9990
> https://github.com/raspberrypi/linux/issues/1259
>=20
> I think it may have been introduced in commit=20
> 9afd85c9e4552b276e2f4cfefd622bdeeffbbf26 (net: Export IGMP/MLD message=20
> validation code) but I haven't done any tests to confirm it.
> Any help on this issue would be really appreciated.
>=20
> Regards,
> =C3=81lvaro.

What hardware? You missed the kernel bugzilla? If it was reported
there I would have forwarded it to netdev@vger.kernel.org.

Can you reproduce it with 4.4?
