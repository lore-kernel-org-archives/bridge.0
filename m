Return-Path: <djlogan2.dl@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=content-type:mime-version:subject:from:in-reply-to:date:cc
	:message-id:references:to;
	bh=ATReXZi9taEqsfnWdRw14dgsoME+WLGodCo4pL9P4p4=;
	b=PNEHs4FWwVGqvq1/ujM7UNjY0AzqXnj45X9O6lRt0+5VJeAfN5bB6iuhyPbagJK5mS
	1cJ8xx1uzC/9WgIdAXHfV03PAJ9Eo0APVOx7Yf7XA3f7uv9aVYQ2Q2+3prlnozkgt2+H
	yclaBCo262DC9VgwayBpNv49LJG4a4jmhkcTm+i0jf/omS/C+AqiXM0yMNVT084h224t
	TL7G7WkKTpLd5FJXBUK62zMGxpuV0CIpkeJ4Bjv50aN4vH88PSrGBTV7yCe2RfrEERy4
	yoSL8Q9dJUxFMp4Rdbq2UzT02wV+1KQDw67Frs3cmhKcepCMws0sQWldQupEAClrhoKy
	iSFg==
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_E9CA288A-3786-4609-AD90-914FB5E1FD7C"
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
From: David Logan <djlogan2.dl@gmail.com>
In-Reply-To: <CANbryT-OrFoLy5APcXbrEEQSTAHQqfTH303HwV7d-jWM9mApyw@mail.gmail.com>
Date: Mon, 1 Feb 2016 22:47:37 -0700
Message-Id: <541B3DA2-45E9-4E55-9BA0-DF554FCB2FE6@gmail.com>
References: <5FA3B72D-03E5-43BD-B635-6A46070C6898@gmail.com>
	<CANbryT-OrFoLy5APcXbrEEQSTAHQqfTH303HwV7d-jWM9mApyw@mail.gmail.com>
Subject: Re: [Bridge] Help with Ubuntu + bridge + tap + qemu + Windows
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Srinivas M.A." <srinivas.aji@gmail.com>
Cc: bridge@lists.linux-foundation.org


--Apple-Mail=_E9CA288A-3786-4609-AD90-914FB5E1FD7C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

No, not  yet, because I had no idea exactly who was responsible for =
what. I am using the virtio drivers and qemu. Let me look into that and =
see if I can find somebody to ask about it. That=E2=80=99s way more =
information that I had. I thought the =E2=80=9Ctx packets=E2=80=9D were =
packets being transmitted from the vm to the bridge, not the other way =
around.

David Logan
http://www.linkedin.com/in/davidjlogan
303-818-8222


> On Feb 1, 2016, at 10:34 PM, Srinivas M.A. <srinivas.aji@gmail.com> =
wrote:
>=20
> On Tue, Feb 2, 2016 at 1:21 AM, David Logan <djlogan2.dl@gmail.com> =
wrote:
>>=20
>> tap2      Link encap:Ethernet  HWaddr 8a:21:a8:cb:f5:98
>>          inet6 addr: fe80::8821:a8ff:fecb:f598/64 Scope:Link
>>          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>>          RX packets:51870 errors:0 dropped:0 overruns:0 frame:0
>>          TX packets:741595 errors:0 dropped:5702 overruns:0 carrier:0
>>          collisions:0 txqueuelen:500
>>          RX bytes:3220139 (3.2 MB)  TX bytes:1113177111 (1.1 GB)
>=20
> You are seeing TX packets dropped at the tap interface. So these are
> packets that are being sent from the bridge to the VM on the tap
> device, but getting dropped, probably because the tap device's queue
> is full. This would mean that the packets are not getting read by the
> VM fast enough, or may be not read at all after some point, since you
> see only the dropped increase after a while. So the issue is likely to
> be related to the virtualization software, rather than the bridge.
> Have you tried asking about this on forums related to the
> virtualization system you are using?


--Apple-Mail=_E9CA288A-3786-4609-AD90-914FB5E1FD7C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D"">No, not &nbsp;yet, because I had no idea exactly who was =
responsible for what. I am using the virtio drivers and qemu. Let me =
look into that and see if I can find somebody to ask about it. That=E2=80=99=
s way more information that I had. I thought the =E2=80=9Ctx packets=E2=80=
=9D were packets being transmitted from the vm to the bridge, not the =
other way around.<div class=3D""><br class=3D""><div class=3D"">
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
class=3D"">On Feb 1, 2016, at 10:34 PM, Srinivas M.A. &lt;<a =
href=3D"mailto:srinivas.aji@gmail.com" =
class=3D"">srinivas.aji@gmail.com</a>&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div class=3D""><div class=3D"">On =
Tue, Feb 2, 2016 at 1:21 AM, David Logan &lt;<a =
href=3D"mailto:djlogan2.dl@gmail.com" =
class=3D"">djlogan2.dl@gmail.com</a>&gt; wrote:<br class=3D""><blockquote =
type=3D"cite" class=3D""><br class=3D"">tap2 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Link encap:Ethernet &nbsp;HWaddr =
8a:21:a8:cb:f5:98<br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;inet6 addr: =
fe80::8821:a8ff:fecb:f598/64 Scope:Link<br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;UP BROADCAST =
RUNNING MULTICAST &nbsp;MTU:1500 &nbsp;Metric:1<br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;RX packets:51870 =
errors:0 dropped:0 overruns:0 frame:0<br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;TX packets:741595 =
errors:0 dropped:5702 overruns:0 carrier:0<br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;collisions:0 =
txqueuelen:500<br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;RX bytes:3220139 =
(3.2 MB) &nbsp;TX bytes:1113177111 (1.1 GB)<br class=3D""></blockquote><br=
 class=3D"">You are seeing TX packets dropped at the tap interface. So =
these are<br class=3D"">packets that are being sent from the bridge to =
the VM on the tap<br class=3D"">device, but getting dropped, probably =
because the tap device's queue<br class=3D"">is full. This would mean =
that the packets are not getting read by the<br class=3D"">VM fast =
enough, or may be not read at all after some point, since you<br =
class=3D"">see only the dropped increase after a while. So the issue is =
likely to<br class=3D"">be related to the virtualization software, =
rather than the bridge.<br class=3D"">Have you tried asking about this =
on forums related to the<br class=3D"">virtualization system you are =
using?<br class=3D""></div></div></blockquote></div><br =
class=3D""></div></body></html>=

--Apple-Mail=_E9CA288A-3786-4609-AD90-914FB5E1FD7C--
