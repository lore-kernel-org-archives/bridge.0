Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:in-reply-to:references:mime-version:content-transfer-encoding
	:autocrypt:subject:to:cc:from:message-id;
	bh=CMQeKqjX7Wfae6jiiaxHdKGNOSspHywZwZM/mNjlhik=;
	b=BFCknMUoBzexOZXR2P9k7t2NOeaCxSVIrktRgG9a63mSnZJwjWeTBhbX42g/Bi1CMm
	Q8neXMy8F0icAMJPC877n58ZVG4iWwBEiQbqAzUWkoL+aU+T5VwKjhbXj/YoK+8KxRjZ
	pmykrAigW8grlCXaFbUT328YG8TLDye9NLMxWgunwDK+PhkZ0fXt8SH1A+oOCG1tqwOz
	neKYLNzgwxmDpawzYtX2ixXNq2tnRoETysAR3WjOXbRxyNB3G8PddmsKYODuTzSOKsg6
	eTd8F44U5n6C/LOKOHTcG/ypYbwpQX9TQmB4q5qFeviNG6pD6itqPpu0bET2TlbsV0zY
	ji0g==
Date: Sun, 16 Dec 2018 19:36:43 -0800
In-Reply-To: <20181216082517.GA31098@splinter>
References: <20181212230943.757-1-f.fainelli@gmail.com>
	<20181216082517.GA31098@splinter>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <B0966704-A9DC-4EE0-A190-E6C36AE832F5@gmail.com>
Subject: Re: [Bridge] [PATCH net-next] Documentation: networking: Clarify
	switchdev devices behavior
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@mellanox.com>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>, "nikolay@cumulusnetworks.com" <nikolay@cumulusnetworks.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>, Jiri Pirko <jiri@mellanox.com>, "davem@davemloft.net" <davem@davemloft.net>



On December 16, 2018 12:25:19 AM PST, Ido Schimmel <idosch@mellanox=2Ecom>=
 wrote:
>On Wed, Dec 12, 2018 at 03:09:43PM -0800, Florian Fainelli wrote:

>
>mlxsw doesn't support it=2E These bridges are mainly used with VLAN
>devices where the packets ingress the bridge untagged=2E When configured
>over physical ports, we only allow untagged packets into such a bridge=2E

There is another complication with at least some of the DSA switches, turn=
ing off VLAN filtering is a global operation, so we must deny it if we have=
 another bridge device that spans the same switch device which is also requ=
esting VLAN filtering to be on=2E Not necessarily a problem in a larger swi=
tch fabric comprised of multiple switches (the D in DSA) since they could c=
onceptually have multiple switches each with different VLAN filtering rules=
 but that complicates the matter significantly=2E

The more I think about supporting toggling VLAN filtering at runtime the l=
ess it seems to have a good return on investment:

- the bridge layer does not remove VLAN entries created while the bridge w=
as VLAN aware, thus complicating the on to off state, since we need to make=
 the switch port a member of all VLANs, untagged, some older switches don't=
 have a "join all VLAN" shorthand for that so that means programming up to =
4K VLAN entries=2E=2E=2Eslow=2E

- no reasonable use case comes to mind which would not involved knowing wh=
ether a bridge should be VLAN aware ahead of time=2E

I am therefore convinced that adopting the mlxsw behavior wrt=2E VLAN filt=
ering toggling is a good approach=2E Thanks!
--=20
Florian
