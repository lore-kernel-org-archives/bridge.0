Return-Path: <cphealy@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=wA8FYsvazQz2oOOvznbomqxxGCnmruGrvIn0Jati3mM=;
	b=TuHKmJc/LK54ApOVYn5setA4aA7R9gOtyDgQjVXJY/NC7udAGeHQ1PQARuqHR06XaO
	8mWVjT/G4Ak7PeDOTXx/UPCVemDTEJz79QXespPEpI+dNr3b8eIQCbe4ekXbpxJf29FE
	Oyz4iuhmM0kZJkyJ0gQg3qR8aATDyi/wu9LmP+UejfAs5QoIGmkLzPLe86LvSQ5+i28h
	ClP5SHA8JsU/lWTRneWwCWHzKulU6XaX4w6AoralqunP04lIXCPa+2kDNjqwf3Tc1JUC
	FmIKwugRMs6wt6yRP0xlC/zFceiJinnitNwd18ABvHTnoohE8tNQB8+WKrNjEbHCK+RO
	mgFw==
MIME-Version: 1.0
In-Reply-To: <73d09703.4736.1456324c4ba.Coremail.kernelluck@163.com>
References: <73d09703.4736.1456324c4ba.Coremail.kernelluck@163.com>
Date: Mon, 14 Apr 2014 19:18:27 -0700
Message-ID: <CAFXsbZrWsxfPJ4vAfdXyA0_0mQEs_S_U0TsTMC=thBGGKAkVnA@mail.gmail.com>
From: Chris Healy <cphealy@gmail.com>
Content-Type: multipart/alternative; boundary=089e0115ec145df71b04f70b6a68
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

--089e0115ec145df71b04f70b6a68
Content-Type: text/plain; charset=UTF-8

1) The initial state of a port if it is running STP is disabled.  Once
there is link, it will transition to blocking.  After that point, depending
on the state of the rest of the network, it will either stay blocking or
attempt to transition to forwarding.

2) If a port state is in learning, that means that the bridge has
determined that it is OK for the port to go to forwarding, but it has not
been in the learning state for a long enough period of time. (learning is a
transitionary time period in the STP when a port will learn mac addresses
but will not forward traffic.)  Provided there is no topology change that
would result in the logic taking the port back to disabled, the local port
state should go from learning to forwarding after 1x the forward delay.
(This assumes the link does not go down, in which case the port state will
go to disabled.)

Hope that helps,

Chris


On Mon, Apr 14, 2014 at 7:08 PM, longguang.yue <kernelluck@163.com> wrote:

> hi,all
> 1.
> if the initial state of port is learning?
>
> 2.
> in what case, state trandfers from learing to forwarding, what is the
> condition?
>
>
> thanks
>
>
>

--089e0115ec145df71b04f70b6a68
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>1) The initial state of a port if it is run=
ning STP is disabled.=C2=A0 Once there is link, it will transition to block=
ing.=C2=A0 After that point, depending on the state of the rest of the netw=
ork, it will either stay blocking or attempt to transition to forwarding.<b=
r>
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
v class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Mon, Apr 14, =
2014 at 7:08 PM, longguang.yue <span dir=3D"ltr">&lt;<a href=3D"mailto:kern=
elluck@163.com" target=3D"_blank">kernelluck@163.com</a>&gt;</span> wrote:<=
br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div style=3D"line-height:1.7;font-size:14px=
;font-family:arial"><div>hi,all</div><div>1.</div><div>if the initial state=
 of port is learning?</div>
<div>=C2=A0</div><div>2.</div><div>in what case, state trandfers from leari=
ng to forwarding, what is the condition?</div><div>=C2=A0</div><div>=C2=A0<=
/div><div>thanks</div></div><br><br><span title=3D"neteasefooter"><span></s=
pan></span></blockquote>
</div><br></div>

--089e0115ec145df71b04f70b6a68--
