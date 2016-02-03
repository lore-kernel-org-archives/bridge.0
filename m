Return-Path: <djlogan2.dl@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=content-type:mime-version:subject:from:in-reply-to:date:cc
	:message-id:references:to;
	bh=ubBHG+qgfmMJYtez7KWbkUOis/GQl9hMLWGBT+pMnss=;
	b=IUmtpeIEMbAca76P95LVWDLQUabewLBRoL/EFByeaZCXNchfHXSKo60vLOARXpGjmv
	vhZGjh1tXMVTrEUW6fg7ca/Csc+vuLR7GlTk5kYz7Dq2g+HzOMeKz7B58Q02HRfHYIsw
	iCZcMH9vUKo/zH6F+dkg2wNYclm9olgS4XczOeLWJL6a/lkJI5Sgn23kEn1PHUUdrdhG
	TBrf/anwtUdITM3SkCJmdfjlz9exPj2uRTGXKXM1dIUJfhhdMFDIWSbKT+QJ82Dn9fge
	n8jRedBlCPmXc/yarHj3K2EHpvmCvT3nccRbn7QGnKNi6ZPfwg/CFPcaBuDNonHIkiLq
	ljag==
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_F48B6BCA-56CC-4325-9E40-F8671E2A56ED"
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
From: David Logan <djlogan2.dl@gmail.com>
In-Reply-To: <20160203115135.5654c1f5@samsung9>
Date: Tue, 2 Feb 2016 21:47:13 -0700
Message-Id: <11D8E565-5289-4471-B2A6-D6E26EF006AE@gmail.com>
References: <CAP9G-NKzk7QwFtD=YjqyFpt7sS+J=JYzCTPLjNAGoCTv_cxEMQ@mail.gmail.com>
	<20160203115135.5654c1f5@samsung9>
Subject: Re: [Bridge] Help with Ubuntu + bridge + tap + qemu + Windows
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: bridge@lists.linux-foundation.org, gilberto dos santos alves <gsavix@gmail.com>


--Apple-Mail=_F48B6BCA-56CC-4325-9E40-F8671E2A56ED
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi guys
Thanks you all very much for you willingness to help. I had been =
struggling with this problem for weeks! It seems as though it really =
wasn=E2=80=99t a bridge problem as Srinivas pointed out. I was careful =
to reinstall the virtio drivers from the appropriate web site, and all =
of my VMs have been up all day long.

My main problem (aside from my overall lack of network knowledge) was =
simply not realizing that the bridge transmit queue meant transmitting =
from the tap interface to the virtio driver. I thought it was simply =
reflecting the numbers of the guest (meaning I thought the transmit =
count meant the number of packets transmitted from the virtio driver, =
and subsequently transmitted from the tap interface to the bridge.)

My humble apologies for making the network experts spend time on a very =
simple issue, but thank you all so much for your help. I was all but =
disabled due to this problem.

David Logan
http://www.linkedin.com/in/davidjlogan
303-818-8222


> On Feb 2, 2016, at 5:51 PM, Stephen Hemminger =
<stephen@networkplumber.org> wrote:
>=20
> Read Wikipedia on Spanning Tree to see how it detects bridging loops.
> Look at dmesg to see when bridge STP disables a port when it detects =
loop


--Apple-Mail=_F48B6BCA-56CC-4325-9E40-F8671E2A56ED
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D"">Hi guys<div class=3D"">Thanks you all very much for you =
willingness to help. I had been struggling with this problem for weeks! =
It seems as though it really wasn=E2=80=99t a bridge problem as Srinivas =
pointed out. I was careful to reinstall the virtio drivers from the =
appropriate web site, and all of my VMs have been up all day =
long.</div><div class=3D""><br class=3D""></div><div class=3D"">My main =
problem (aside from my overall lack of network knowledge) was simply not =
realizing that the bridge transmit queue meant transmitting from the tap =
interface to the virtio driver. I thought it was simply reflecting the =
numbers of the guest (meaning I thought the transmit count meant the =
number of packets transmitted from the virtio driver, and subsequently =
transmitted from the tap interface to the bridge.)</div><div =
class=3D""><br class=3D""></div><div class=3D"">My humble apologies for =
making the network experts spend time on a very simple issue, but thank =
you all so much for your help. I was all but disabled due to this =
problem.</div><div class=3D""><br class=3D""><div class=3D"">
<span class=3D"Apple-style-span" style=3D"border-collapse: separate; =
color: rgb(0, 0, 0); font-family: Helvetica; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: normal; orphans: 2; text-align: -webkit-auto; text-indent: =
0px; text-transform: none; white-space: normal; widows: 2; word-spacing: =
0px; -webkit-border-horizontal-spacing: 0px; =
-webkit-border-vertical-spacing: 0px; =
-webkit-text-decorations-in-effect: none; -webkit-text-size-adjust: =
auto; -webkit-text-stroke-width: 0px;  ">David Logan<br class=3D""><a =
href=3D"http://www.linkedin.com/in/davidjlogan" =
class=3D"">http://www.linkedin.com/in/davidjlogan</a><br =
class=3D"">303-818-8222<br class=3D""><br class=3D""></span>

</div>
<br class=3D""><div><blockquote type=3D"cite" class=3D""><div =
class=3D"">On Feb 2, 2016, at 5:51 PM, Stephen Hemminger &lt;<a =
href=3D"mailto:stephen@networkplumber.org" =
class=3D"">stephen@networkplumber.org</a>&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div class=3D""><div class=3D"">Read =
Wikipedia on Spanning Tree to see how it detects bridging loops.<br =
class=3D"">Look at dmesg to see when bridge STP disables a port when it =
detects loop<br class=3D""></div></div></blockquote></div><br =
class=3D""></div></body></html>=

--Apple-Mail=_F48B6BCA-56CC-4325-9E40-F8671E2A56ED--
