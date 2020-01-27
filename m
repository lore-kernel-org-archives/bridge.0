Return-Path: <J.Lambrecht@TELEVIC.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=televic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0EE/7+dImiSiCP4FL8KM/6JoQcFdrF5hHRQPvb39S4U=;
 b=O158Jg7gXWEOv+yTz5oChTmEHPLLY3GmdYfUhUEiNj8iRJwSEFt5LVs+Q3QY+0qeRuYcDFbJBYHzxDuzSMzBrp57f1dtahlJkVQGgEnaRe5EWnahGTSl6LiItXuhvdPTju95b7A2ivR5+0+FMvlnpTXA2v7//40dXckO1JccEOk=
References: <20200124161828.12206-1-horatiu.vultur@microchip.com>
 <20200124161828.12206-5-horatiu.vultur@microchip.com>
 <20200125153403.GB18311@lunn.ch>
From: =?UTF-8?Q?J=c3=bcrgen_Lambrecht?= <j.lambrecht@televic.com>
Message-ID: <29368970-c46d-b509-a01b-874d81ed7fb5@televic.com>
Date: Mon, 27 Jan 2020 16:39:41 +0100
In-Reply-To: <20200125153403.GB18311@lunn.ch>
Content-Type: multipart/alternative;
 boundary="------------74244812AB79335BE4D5B00E"
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Bridge] [RFC net-next v3 04/10] net: bridge: mrp: Add generic
 netlink interface to configure MRP
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>, Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: ivecera@redhat.com, jiri@resnulli.us, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, anirudh.venkataramanan@intel.com, jeffrey.t.kirsher@intel.com, olteanv@gmail.com, davem@davemloft.net

--------------74244812AB79335BE4D5B00E
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 1/25/20 4:34 PM, Andrew Lunn wrote:
> Allan mentioned you might get around to implementing 802.1CB?

I read about MRP, being IEC 62439-2, and then I read further about IEC 6243=
9-3.4 Parallel Redundancy Protocol (PRP).

So is this 802.1CB-2017 - IEEE Standard then the same as PRP? (I mean, out =
of curiosity, why not stay in the same standard, then you pay only once ;-)


Kind regards,

J=FCrgen


--------------74244812AB79335BE4D5B00E
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

<html><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
  </head>
  <body>
    <div class=3D"moz-cite-prefix">On 1/25/20 4:34 PM, Andrew Lunn wrote:<b=
r>
    </div>
    <blockquote type=3D"cite" cite=3D"mid:20200125153403.GB18311@lunn.ch">
      <pre class=3D"moz-quote-pre" wrap=3D"">Allan mentioned you might get =
around to implementing 802.1CB?</pre>
    </blockquote>
    <p>I read about MRP, being IEC 62439-2, and then I read further
      about IEC 62439-3.4 Parallel Redundancy Protocol (PRP).</p>
    <p>So is this <span class=3D"sub-heading">802.1CB-2017 - IEEE
        Standard then the same as PRP? (I mean, out of curiosity, why
        not stay in the same standard, then you pay only once ;-)<br>
      </span></p>
    <p><span class=3D"sub-heading"><br>
      </span></p>
    <p><span class=3D"sub-heading">Kind regards,</span></p>
    <p><span class=3D"sub-heading">J=FCrgen<br>
      </span></p>
  </body>
</html>

--------------74244812AB79335BE4D5B00E--
