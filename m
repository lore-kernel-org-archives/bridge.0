Return-Path: <J.Lambrecht@TELEVIC.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=televic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0DMqGlTKm8HHRe49C+g1orF4N2RnDiTm6X2wJTIsjI=;
 b=NmTtoeGOjdeqt32BRNT6LQbo05Hr/7wDh8H2bwjDTQOLnNRbYow0SCAIvKmj3Dkw46umZAbL9aPZliUdYe02aY19LkWhczmMih33e622PEE0crCWHXJISSsN4lVBSVUjoLFWaEbLwBGgZ9SdijgCgCgMqgUaQOC02oFL3hLI3Zk=
From: =?UTF-8?Q?J=c3=bcrgen_Lambrecht?= <j.lambrecht@televic.com>
References: <20200124161828.12206-1-horatiu.vultur@microchip.com>
 <20200124161828.12206-10-horatiu.vultur@microchip.com>
 <20200125161615.GD18311@lunn.ch>
 <20200126130111.o75gskwe2fmfd4g5@soft-dev3.microsemi.net>
 <20200126171251.GK18311@lunn.ch>
 <20200127105746.i2txggfnql4povje@lx-anielsen.microsemi.net>
 <20200127134053.GG12816@lunn.ch>
Message-ID: <eac22f69-94ae-2a36-f974-9aa840ac9bfc@televic.com>
Date: Tue, 28 Jan 2020 10:56:23 +0100
In-Reply-To: <20200127134053.GG12816@lunn.ch>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Bridge] [RFC net-next v3 09/10] net: bridge: mrp: Integrate
 MRP into the bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>, "Allan W. Nielsen" <allan.nielsen@microchip.com>
Cc: ivecera@redhat.com, jiri@resnulli.us, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, davem@davemloft.net, UNGLinuxDriver@microchip.com, anirudh.venkataramanan@intel.com, jeffrey.t.kirsher@intel.com, olteanv@gmail.com, Horatiu Vultur <horatiu.vultur@microchip.com>

On 1/27/20 2:40 PM, Andrew Lunn wrote:
>> Again, I do not know how other HW is designed, but all the SOC's we are
>> working with, does allow us to add a TCAM rule which can redirect these
>> frames to the CPU even on a blocked port.
> It is not in scope for what you are doing, but i wonder how we
> describe this in a generic Linux way? And then how we push it down to
> the hardware?
>
> For the Marvell Switches, it might be possible to do this without the
> TCAM. You can add forwarding DB entries marked as Management. It is
> unclear if this overrides the blocked state, but it would be a bit odd
> if it did not.
A MGMT frame does override the blocked state according the the datasheet.
And any MAC address can be loaded, not only 01:80:C2:00:00:0x (802.1D) and =
01:80:C2:00:00:2x (GARP). Then the ATU is used instead of something special=
ized.
(referring to Andrew's email of 20200126 6:12 PM)
(I only checked again 88E6250/88E6220/88E6071/88E6070/88E6020 Functional Sp=
ecification)


Kind regards,

J=FCrgen


