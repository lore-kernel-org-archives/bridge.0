Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=content-type:mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=aMn7CxHDZLXyg5LgXQjt4lplgXMEwGg9TvXcqd0nhO0=;
	b=dsAu1X3W9UtspUcxwKmfkfdpi9L4cNh0v2oXGAZ/HE3FvTe3ALuNsngk9B9cO2mjlz
	EWuUwAwKhOizxb9CKfBHyae2qxMJcmr5OJrrNSvVBfQf8aCVI/ynvCQ0/Y7ftBoVz250
	WVQajwlgFi4YHGL1WuMCo2lZH74QN2wB5TpsU=
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
In-Reply-To: <1438964658-2904-1-git-send-email-razor@blackwall.org>
Date: Fri, 7 Aug 2015 19:28:23 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <BD6CDFE9-7FCC-461E-A585-6F477AA99B14@cumulusnetworks.com>
References: <1438964658-2904-1-git-send-email-razor@blackwall.org>
Subject: Re: [Bridge] [PATCH net-next] bridge: netlink: add support for
	vlan_filtering attribute
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net


> On Aug 7, 2015, at 7:24 PM, Nikolay Aleksandrov <razor@blackwall.org> =
wrote:
>=20
> From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
>=20
> This patch adds the ability to toggle the vlan filtering support via
> netlink. Since we're already running with rtnl in .changelink() we =
don't
> need to take any additional locks.
>=20
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> ---
> I'll post the iproute2 patch if this one gets accepted.
>=20

Uh, I wanted to post a version that returns an error when vlan filtering =
isn=E2=80=99t supported
instead of always succeeding. So please drop this patch, I=E2=80=99ll =
post a v2 with that change
so the user will know if vlan filtering was actually enabled.



