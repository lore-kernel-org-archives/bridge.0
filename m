Return-Path: <sagar.shedge92@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=lROP/o+MfdtrFJtAHJflPlyS5FcDDopl1vS5tlurQtE=;
	b=F9pZBjj0T3c+RVtTANxqFQ8T+HOcXY5LJh+yOTRRYwjkACSOhyNS8m+B4oTF64SoJ4
	tH+wpVR3eu4T9v4IbGfDhbcL5r4Faf4dfcZGdIsMZrczk0Ha5ihLaHIiSsGorOn4M1AU
	nT3NSpbDyWBjFaw4xFnj7fcYYk78UsZ7FWTbzlqICwFIwBmsibZZw3ZhQ4uZ9VlG8pvJ
	DEZwjNxCW5MgQP6HmDxvDXCXBpnpQhRma8cZ30mwBk3kDRLLBQoi3YC6SfGadGXvGjrT
	CeX1TojW84Cs6kEavI8Q07thhsFsqfKPdQfuLt7zQCvJS2f8C2pybun0/rWIZguSqQKV
	JZGg==
MIME-Version: 1.0
In-Reply-To: <20141125084332.7a261b17@urahara>
References: <CAPhYifHUARhGXbgUhB-Sd0y_sZj30CThAxToQJxp+FRtS1DM6Q@mail.gmail.com>
	<20141125084332.7a261b17@urahara>
Date: Wed, 26 Nov 2014 10:55:42 +0530
Message-ID: <CAPhYifGNpvFS_2wmZpXa0ShYGWmXnU_V=u1DFZnM5OTDg_yrEQ@mail.gmail.com>
From: Sagar Shedge <sagar.shedge92@gmail.com>
Content-Type: multipart/alternative; boundary=047d7b62488e4d25620508bc427e
Subject: Re: [Bridge] Put virbr0 in promiscuous mode
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: bridge@lists.linux-foundation.org

--047d7b62488e4d25620508bc427e
Content-Type: text/plain; charset=UTF-8

Hi Stephen,

Extremely sorry for typo.
I have made changes and are as follows  :-

I have two virtual machines VM1 and VM2 on KVM (ubuntu 14.04 LTS
3.13.0-24-generic). Then I have added eth0 of my VM to 'default' network
(NAT network).

Use case :-
I want to monitor all traffic on virbr0('default' network).

Steps followed :-
1. Add VM1 eth0 to virbr0
2. Add VM2 eth1 to virbr0
3. brctl setageing *virbr0 *0 ..(To put bridge in promiscuous)

Now I am running tcpdump on eth1 of VM2 and trying to ping google.com(outside
world)

In VM2 (tcpdump -i eth1), I can see only ingress(incoming) traffic of VM1.
I am not able see outgoing traffic of VM1.

If I create another bridge(*bridge connected to eth0 directly , not NAT*)
and trying same scenario with 2 VM then VM2 can see both ingress and
outgress traffic.

So want to know what is the issue?
Is linux bridge/libvirt doing something different with this virtbr0
bridge(NAT bridge)?

Regards,
Sagar

On Tue, Nov 25, 2014 at 10:13 PM, Stephen Hemminger <
stephen@networkplumber.org> wrote:

> On Mon, 24 Nov 2014 18:59:49 +0530
> Sagar Shedge <sagar.shedge92@gmail.com> wrote:
>
> > Steps followed :-
> > 1. Add VM1 eth0 to virbr0
> > 2. Add VM2 eth1 to virbr0
> > 3. brctl setageing ovsbr0 0 ..(To put bridge in promiscuous)
>
> ovsbr0 is Open Vswitch not linux bridge
>



-- 
Sagar Dilip Shedge,
Pune.

With Regards.

--047d7b62488e4d25620508bc427e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Stephen,<div><br></div><div>Extremely sorry for typo.</=
div><div>I have made changes and are as follows =C2=A0:-</div><div><br></di=
v><div><div style=3D"font-family:arial,sans-serif;font-size:13px"><div>I ha=
ve two virtual machines VM1 and VM2 on KVM (ubuntu 14.04 LTS 3.13.0-24-gene=
ric<span style=3D"color:rgb(80,0,80)">)</span>. Then I have added eth0 of m=
y VM to &#39;default&#39; network (NAT network).</div><div><br></div><div>U=
se case :-</div><div>I want to monitor all traffic on virbr0(&#39;default&#=
39; network).</div><div><br></div><div>Steps followed :-</div><div>1. Add V=
M1 eth0 to virbr0</div><div>2. Add VM2 eth1 to virbr0</div><div>3. brctl se=
tageing <b><font color=3D"#ff0000">virbr0</font> </b>0 ..(To put bridge in =
promiscuous)</div><div><br></div><div>Now I am running tcpdump on eth1 of V=
M2 and trying to ping=C2=A0<a href=3D"http://google.com/" target=3D"_blank"=
>google.com</a>(outside world)</div><div><br></div><div>In VM2 (tcpdump -i =
eth1), I can see only ingress(incoming) traffic of VM1. I am not able see o=
utgoing traffic of VM1.</div><div><br></div><div>If I create another bridge=
(<b><font color=3D"#ff0000">bridge connected to eth0 directly ,=C2=A0not NA=
T</font></b>) and trying same scenario with 2 VM then VM2 can see both ingr=
ess and outgress traffic.</div><div><br></div><div>So want to know what is =
the issue?</div><div>Is linux bridge/libvirt doing something different with=
 this virtbr0 bridge(NAT bridge)?</div></div></div><div style=3D"font-famil=
y:arial,sans-serif;font-size:13px"><br></div><div>Regards,</div><div>Sagar<=
/div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Tue=
, Nov 25, 2014 at 10:13 PM, Stephen Hemminger <span dir=3D"ltr">&lt;<a href=
=3D"mailto:stephen@networkplumber.org" target=3D"_blank">stephen@networkplu=
mber.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span cl=
ass=3D"">On Mon, 24 Nov 2014 18:59:49 +0530<br>
Sagar Shedge &lt;<a href=3D"mailto:sagar.shedge92@gmail.com">sagar.shedge92=
@gmail.com</a>&gt; wrote:<br>
<br>
&gt; Steps followed :-<br>
&gt; 1. Add VM1 eth0 to virbr0<br>
&gt; 2. Add VM2 eth1 to virbr0<br>
&gt; 3. brctl setageing ovsbr0 0 ..(To put bridge in promiscuous)<br>
<br>
</span>ovsbr0 is Open Vswitch not linux bridge<br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature">Sagar Dilip Shedge,<br>Pune.<br><div>=C2=A0</div>
<div>With Regards.</div><div>=C2=A0</div></div>
</div>

--047d7b62488e4d25620508bc427e--
