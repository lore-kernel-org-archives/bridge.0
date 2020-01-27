Return-Path: <andrew@lunn.ch>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=UvjYKQEomZljxw4yYS7NWvcMI7QwuePD0j2Ascrs53Y=; b=GIKMIgnLTgQ6+2t0UsJvhu9LRx
 hcRC1D95EQQ57+wINFyAWDsh9TjVnvFCYFKRqA7OgMyqB8DEh4htckxj9f6XHcCAmS8dHCFN6kRmF
 bQLaPtkJ0jLTiY+3jvakB3nTsoIK7QdxttYyzBKoYCiRShtCUwicd7gHRkCi5+smM0ek=;
Date: Mon, 27 Jan 2020 16:06:14 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20200127150614.GF13647@lunn.ch>
References: <20200124161828.12206-1-horatiu.vultur@microchip.com>
 <20200124161828.12206-7-horatiu.vultur@microchip.com>
 <20200125163504.GF18311@lunn.ch>
 <20200126132213.fmxl5mgol5qauwym@soft-dev3.microsemi.net>
 <20200126155911.GJ18311@lunn.ch>
 <20200127110418.f7443ecls6ih2fwt@lx-anielsen.microsemi.net>
 <c5733ddb-a837-b866-54bf-c631baf36c54@televic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c5733ddb-a837-b866-54bf-c631baf36c54@televic.com>
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
To: =?iso-8859-1?Q?J=FCrgen?= Lambrecht <j.lambrecht@televic.com>
Cc: ivecera@redhat.com, jiri@resnulli.us, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, davem@davemloft.net, UNGLinuxDriver@microchip.com, anirudh.venkataramanan@intel.com, "Allan W. Nielsen" <allan.nielsen@microchip.com>, jeffrey.t.kirsher@intel.com, olteanv@gmail.com, Horatiu Vultur <horatiu.vultur@microchip.com>

On Mon, Jan 27, 2020 at 03:26:38PM +0100, J=FCrgen Lambrecht wrote:
> On 1/27/20 12:04 PM, Allan W. Nielsen wrote:
>=20
>             > How do you handle the 'headless chicken' scenario? User spa=
ce
>             tells
>             > the port to start sending MRP_Test frames. It then dies. The
>             hardware
>=20
> Andrew, I am a bit confused here - maybe I missed an email-thread, I'm so=
rry
> then.
>=20
> In previous emails you and others talked about hardware support to send p=
ackets
> (inside the switch). But somebody also talked about data-plane and
> control-plane (about STP in-kernel being a bad idea), and that data-plane=
 is
> in-kernel, and control plane is a mrp-daemon (in user space).
> And in my mind, the "hardware" you mention is a frame-injector and can be=
 both
> real hardware and a driver in the kernel.
>=20
> Do I see it right?

Hi J=FCrgen

It i still unclear where the MRP_Test frames should be generated,
forward and consumed, either in kernel, or in user space.

The userspace RSTP daemon generates and consumes all the BPDUs in
userspace. But BPDUs are never forwarded. However MRP_Test frames are
forwarded by client nodes. Are the MRP_Test frames then part of the
data plane in a client?

What i think is clear is that the state machine is in user space.

For the rest, we are still exploring possibilities.

    Andrew
