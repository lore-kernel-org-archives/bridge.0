Return-Path: <cphealy@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=CIE8P0OnL9vI0wiofLYPKu0DuanbpFGGCIY05jbJNBA=;
	b=oacwRPSaZkinJnHJZLU0zwPXXZQDlngShQq6xc27lpT1jBTveyXw0/iWHBuiyXTrNm
	GB3meGlpCrNrH4WbI6YbzjEdy9yJI3r5fzvWLcHP/lT6mhk4Sgd+tcvm+SikhEAGWEcB
	Gg/L03FfZIsO0IH3efUEHWEsS8CR3PwQhfemcFFdFXOBTUrMkub9qLk6e4j5K2dwAhmX
	m/GdwCEtsrt3dO+vdsgVs1yP9/E+idnQnJqt+sF20pJi6qKsTYT19mtRp0VimzgJDHSJ
	dYpO1iSnMoViUF+sw2QTULcYc/WqX1obRx5tdTkx9cuxXkZ+dVbyBL8eoqT6otvgbk0f
	di1Q==
MIME-Version: 1.0
In-Reply-To: <CAFXsbZrWsxfPJ4vAfdXyA0_0mQEs_S_U0TsTMC=thBGGKAkVnA@mail.gmail.com>
References: <73d09703.4736.1456324c4ba.Coremail.kernelluck@163.com>
	<CAFXsbZrWsxfPJ4vAfdXyA0_0mQEs_S_U0TsTMC=thBGGKAkVnA@mail.gmail.com>
Date: Tue, 15 Apr 2014 06:55:19 -0700
Message-ID: <CAFXsbZoxMspCMoo2HAmfQ=eN7PcSkF6sCyzmEAmk0J6eOQbpRw@mail.gmail.com>
From: Chris Healy <cphealy@gmail.com>
Content-Type: multipart/alternative; boundary=089e0149c50688a77204f7152645
Subject: Re: [Bridge] how bridge do the state transfer from learing to
	forwarding
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "longguang.yue" <kernelluck@163.com>
Cc: bridge <bridge@lists.linux-foundation.org>

--089e0149c50688a77204f7152645
Content-Type: text/plain; charset=UTF-8

Minor correction to my previous statement:

INCORRECT
Provided there is no topology change that would result in the logic taking
the port back to DISABLED

CORRECT
Provided there is no topology change that would result in the logic taking
the port back to BLOCKING


On Mon, Apr 14, 2014 at 7:18 PM, Chris Healy <cphealy@gmail.com> wrote:

> 1) The initial state of a port if it is running STP is disabled.  Once
> there is link, it will transition to blocking.  After that point, depending
> on the state of the rest of the network, it will either stay blocking or
> attempt to transition to forwarding.
>
> 2) If a port state is in learning, that means that the bridge has
> determined that it is OK for the port to go to forwarding, but it has not
> been in the learning state for a long enough period of time. (learning is a
> transitionary time period in the STP when a port will learn mac addresses
> but will not forward traffic.)  Provided there is no topology change that
> would result in the logic taking the port back to disabled, the local port
> state should go from learning to forwarding after 1x the forward delay.
> (This assumes the link does not go down, in which case the port state will
> go to disabled.)
>
> Hope that helps,
>
> Chris
>
>
> On Mon, Apr 14, 2014 at 7:08 PM, longguang.yue <kernelluck@163.com> wrote:
>
>> hi,all
>> 1.
>> if the initial state of port is learning?
>>
>> 2.
>> in what case, state trandfers from learing to forwarding, what is the
>> condition?
>>
>>
>> thanks
>>
>>
>>
>

--089e0149c50688a77204f7152645
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Minor correction to my previous statement:<br><b=
r></div><div>INCORRECT<br></div>Provided there is no topology change that w=
ould result in the logic taking the port back to DISABLED<br><br></div>CORR=
ECT<br>
Provided there is no topology change that would result in the logic taking =
the port back to BLOCKING<br></div><div class=3D"gmail_extra"><br><br><div =
class=3D"gmail_quote">On Mon, Apr 14, 2014 at 7:18 PM, Chris Healy <span di=
r=3D"ltr">&lt;<a href=3D"mailto:cphealy@gmail.com" target=3D"_blank">cpheal=
y@gmail.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div><div><div>1) The initi=
al state of a port if it is running STP is disabled.=C2=A0 Once there is li=
nk, it will transition to blocking.=C2=A0 After that point, depending on th=
e state of the rest of the network, it will either stay blocking or attempt=
 to transition to forwarding.<br>

</div><div><br>2) If a port state is in learning, that means that the bridg=
e has determined that it is OK for the port to go to forwarding, but it has=
 not been in the learning state for a long enough period of time. (learning=
 is a transitionary time period in the STP when a port will learn mac addre=
sses but will not forward traffic.)=C2=A0 Provided there is no topology cha=
nge that would result in the logic taking the port back to disabled, the lo=
cal port state should go from learning to forwarding after 1x the forward d=
elay.=C2=A0 (This assumes the link does not go down, in which case the port=
 state will go to disabled.)=C2=A0 <br>

<br></div><div>Hope that helps,<br><br>Chris<br></div></div></div></div><di=
v class=3D"HOEnZb"><div class=3D"h5"><div class=3D"gmail_extra"><br><br><di=
v class=3D"gmail_quote">On Mon, Apr 14, 2014 at 7:08 PM, longguang.yue <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:kernelluck@163.com" target=3D"_blank">k=
ernelluck@163.com</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div style=3D"line-height:1.7;font-size:14px=
;font-family:arial"><div>hi,all</div><div>1.</div><div>if the initial state=
 of port is learning?</div>

<div>=C2=A0</div><div>2.</div><div>in what case, state trandfers from leari=
ng to forwarding, what is the condition?</div><div>=C2=A0</div><div>=C2=A0<=
/div><div>thanks</div></div><br><br><span title=3D"neteasefooter"><span></s=
pan></span></blockquote>

</div><br></div>
</div></div></blockquote></div><br></div>

--089e0149c50688a77204f7152645--
