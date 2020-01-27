Return-Path: <J.Lambrecht@TELEVIC.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=televic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfxmN6M+qSoBSMuH4LLbCunzFwNaYjkjHfOmTq+le0w=;
 b=lBEQUSZowgJ99l3oS1zGfxQJDgGnMF3fMMhVamOtdQ4U1CjB0ImzAepACtI9//kbl7JkkVTCiTRt4sukl2NOg6+3zEuNGGF9YULnHBNgb1jyo7uy7ZU0r4UqcpNUgZ5UaV0bJV7Up9A0aDJ4aNeSGq+uVBdjfD+zxwc1D5igfLQ=
References: <20200124161828.12206-1-horatiu.vultur@microchip.com>
 <20200124161828.12206-7-horatiu.vultur@microchip.com>
 <20200125163504.GF18311@lunn.ch>
 <20200126132213.fmxl5mgol5qauwym@soft-dev3.microsemi.net>
 <20200126155911.GJ18311@lunn.ch>
From: =?UTF-8?Q?J=c3=bcrgen_Lambrecht?= <j.lambrecht@televic.com>
Message-ID: <13ac391c-61f5-cb77-69a0-416b0390f50d@televic.com>
Date: Mon, 27 Jan 2020 12:29:14 +0100
In-Reply-To: <20200126155911.GJ18311@lunn.ch>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Bridge] [RFC net-next v3 06/10] net: bridge: mrp: switchdev:
 Extend switchdev API to offload MRP
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: ivecera@redhat.com, jiri@resnulli.us, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, davem@davemloft.net, UNGLinuxDriver@microchip.com, anirudh.venkataramanan@intel.com, jeffrey.t.kirsher@intel.com, olteanv@gmail.com, Horatiu Vultur <horatiu.vultur@microchip.com>

On 1/26/20 4:59 PM, Andrew Lunn wrote:
> Given the design of the protocol, if the hardware decides the OS etc
> is dead, it should stop sending MRP_TEST frames and unblock the ports.
> If then becomes a 'dumb switch', and for a short time there will be a
> broadcast storm. Hopefully one of the other nodes will then take over
> the role and block a port.

In my experience a closed loop should never happen. It can make software cr=
ash and give other problems.
An other node should first take over before unblocking the ring ports. (If =
this is possible - I only follow this discussion halfly)

What is your opinion?

(FYI:
I made that mistake once doing a proof-of-concept ring design: during testi=
ng, when a "broken" Ethernet cable was "fixed" I had for a short time a loo=
p, and then it happened often that that port of the (Marvell 88E6063) switc=
h was blocked.=A0 (To unblock, only solution was to bring that port down an=
d up again, and then all "lost" packets came out in a burst.)
That problem was caused by flow control (with pause frames), and disabling =
flow control fixed it, but flow-control is default on as far as I know.
)

Kind regards,

J=FCrgen

