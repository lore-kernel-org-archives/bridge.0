Return-Path: <J.Lambrecht@TELEVIC.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=televic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Lr7m+pDy+NDdqliBnCTKuAIFylrGhfL9hY7M8wqsrQ=;
 b=LEViIjRq6SRfXKijDLKdO66+ca9uIOIManua3YPfRSD9kwMamNFrEaFs8hS07LvUYqMZgTsHS+sxfxkrJgmRcydghAPsmvZDvq2cPelQICZaQHUsUYztvSrCrm0ZTY8gX6Vm1F69w1V4+rNd+4+44Mz1CA/zSlwFhb5ZFcvkLRE=
References: <20200124161828.12206-1-horatiu.vultur@microchip.com>
 <20200124161828.12206-10-horatiu.vultur@microchip.com>
 <20200125161615.GD18311@lunn.ch>
 <20200126130111.o75gskwe2fmfd4g5@soft-dev3.microsemi.net>
 <20200126171251.GK18311@lunn.ch>
 <20200127105746.i2txggfnql4povje@lx-anielsen.microsemi.net>
 <20200127134053.GG12816@lunn.ch>
From: =?UTF-8?Q?J=c3=bcrgen_Lambrecht?= <j.lambrecht@televic.com>
Message-ID: <14339d64-a863-c335-8d3c-0431598a10ba@televic.com>
Date: Mon, 27 Jan 2020 16:33:26 +0100
In-Reply-To: <20200127134053.GG12816@lunn.ch>
Content-Type: multipart/alternative;
 boundary="------------AD2A57F78718981CC9D655DB"
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

--------------AD2A57F78718981CC9D655DB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

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



--------------AD2A57F78718981CC9D655DB
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

<html><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
  </head>
  <body>
    <div class=3D"moz-cite-prefix">On 1/27/20 2:40 PM, Andrew Lunn wrote:<b=
r>
    </div>
    <blockquote type=3D"cite" cite=3D"mid:20200127134053.GG12816@lunn.ch">
      <blockquote type=3D"cite" style=3D"color: #000000;">
        <pre class=3D"moz-quote-pre" wrap=3D"">Again, I do not know how oth=
er HW is designed, but all the SOC's we are
working with, does allow us to add a TCAM rule which can redirect these
frames to the CPU even on a blocked port.
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">It is not in scope for what yo=
u are doing, but i wonder how we
describe this in a generic Linux way? And then how we push it down to
the hardware?

For the Marvell Switches, it might be possible to do this without the
TCAM. You can add forwarding DB entries marked as Management. It is
unclear if this overrides the blocked state, but it would be a bit odd
if it did not.</pre>
    </blockquote>
    A MGMT frame does override the blocked state according the the
    datasheet.<br>
    <blockquote type=3D"cite" cite=3D"mid:20200127134053.GG12816@lunn.ch">
      <pre class=3D"moz-quote-pre" wrap=3D"">
</pre>
    </blockquote>
    And any MAC address can be loaded, not only 01:80:C2:00:00:0x
    (802.1D) and 01:80:C2:00:00:2x (GARP). Then the ATU is used instead
    of something specialized.<br>
    (referring to Andrew's email of 20200126 6:12 PM)<br>
    (I only checked again 88E6250/88E6220/88E6071/88E6070/88E6020
    Functional Specification)
    <p><br>
    </p>
    <p>Kind regards,</p>
    <p>J=FCrgen<br>
    </p>
    <p><br>
    </p>
  </body>
</html>

--------------AD2A57F78718981CC9D655DB--
