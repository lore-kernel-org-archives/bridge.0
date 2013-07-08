Return-Path: <lambert.laurent91@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=9VhsDGqP6EBqFPP9eEBQJZBykP+Csb7AeSC+1/7U1K8=;
	b=ORpPwFmt8dXVs4TMyTBEXdgtkEEZRAt+o6vVHosrDZz8ihbgylZ9DbX2k49udcXfV3
	3sY+ZW1OGr+hKjE2gtFyVqXUreq7DIfbsRKe2mQUYNEsKaiomdTNCiiU1/DeYAeUCIDx
	B3KPYxT4Bmrsm7u+YIge8cVufaCYKPX5GL1xPgFcXuAXCTlQEdirabq0z0dpTB7HjHg3
	V2zcGNVGcknwtzz4wbbZLBnTxmwG6RL4FoqZf6siSIliVmneEvZnbKnx7RN5OFl+Urtu
	ttDSP6TmK+gZ7RXrGwGdUdKv2EYZ3aUIJwiWryMzOduCmNTFdKiwr6/IfzDyXUjVC+QW
	cQ6g==
MIME-Version: 1.0
In-Reply-To: <20130707215634.1c63ed9e@catus>
References: <CAGZVhE1nOXBO_QiDX58xR3mu_sd6v2p3tiZPe+hKsJ3mS+UWEQ@mail.gmail.com>
	<20130707215634.1c63ed9e@catus>
Date: Mon, 8 Jul 2013 10:12:15 +0200
Message-ID: <CAGZVhE2+X_J7H+BDA82D4KfMWO+aKX8zgimNKvZcZ6JvRw18hQ@mail.gmail.com>
From: Lambert Laurent <lambert.laurent91@gmail.com>
Content-Type: multipart/alternative; boundary=f46d044402683d99b504e0fb9ad1
Subject: Re: [Bridge] Tap and Bridge problem
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Marek Kierdelewicz <marek@piasta.pl>
Cc: bridge@lists.linux-foundation.org

--f46d044402683d99b504e0fb9ad1
Content-Type: text/plain; charset=ISO-8859-1

Hi,

Thank you for your answer. From what i understand two tap interface can't
speak together though a bridge. so the idea is to have two veth pair
between each tap and the bridge. I should get the following topology:

Tap0 == <Veth10> == <Veth00> == bridge == <Veth01> == <Veth11> == Tap1

Now i'm not sure to understand how to connect the tap device to the Veth.
Can you give me a hint on that part ?

Thank you


2013/7/7 Marek Kierdelewicz <marek@piasta.pl>

> > Hi,
>
> Hi,
>
> >I'm currently trying to use bridge and tap for my work. In my setup I
> >use two programs communicating though tap interface. I connect the two
> >tap interface with a bridge.
> >...
> >Now comes the problem, currently only broadcast or multicast frames
> >goes through the bridge. Every unicast frame get drop (or stuck)
> >between the
> >Did anyone this behavior in the past time ?
>
> Yes. Try using veth pair interfaces:
> ip link add name veth1 type veth peer name veth2
> You'll get veth1 and veth2 pair that act as a "wormhole". Now add veth1
> to the bridge and use veth2 with your program in the way you used tap.
>
> If you need second pair just repeat procedure with different interface
> names.
>
> Best regards,
> Marek Kierdelewicz
>



-- 
Lambert Laurent

--f46d044402683d99b504e0fb9ad1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div style>Thank you for your answer. Fr=
om what i understand two tap interface can&#39;t speak together though a br=
idge. so the idea is to have two veth pair between each tap and the bridge.=
 I should get the following topology:</div>
<div style><br></div><div style>Tap0 =3D=3D &lt;Veth10&gt; =3D=3D &lt;Veth0=
0&gt; =3D=3D bridge =3D=3D &lt;Veth01&gt; =3D=3D &lt;Veth11&gt; =3D=3D Tap1=
</div><div style><br></div><div style>Now i&#39;m not sure to understand ho=
w to connect the tap device to the Veth. Can you give me a hint on that par=
t ?</div>
<div style><br></div><div style>Thank you</div></div><div class=3D"gmail_ex=
tra"><br><br><div class=3D"gmail_quote">2013/7/7 Marek Kierdelewicz <span d=
ir=3D"ltr">&lt;<a href=3D"mailto:marek@piasta.pl" target=3D"_blank">marek@p=
iasta.pl</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">&gt; Hi,<br>
<div class=3D"im"><br>
Hi,<br>
<br>
&gt;I&#39;m currently trying to use bridge and tap for my work. In my setup=
 I<br>
&gt;use two programs communicating though tap interface. I connect the two<=
br>
&gt;tap interface with a bridge.<br>
</div>&gt;...<br>
<div class=3D"im">&gt;Now comes the problem, currently only broadcast or mu=
lticast frames<br>
&gt;goes through the bridge. Every unicast frame get drop (or stuck)<br>
&gt;between the<br>
</div><div class=3D"im">&gt;Did anyone this behavior in the past time ?<br>
<br>
</div>Yes. Try using veth pair interfaces:<br>
ip link add name veth1 type veth peer name veth2<br>
You&#39;ll get veth1 and veth2 pair that act as a &quot;wormhole&quot;. Now=
 add veth1<br>
to the bridge and use veth2 with your program in the way you used tap.<br>
<br>
If you need second pair just repeat procedure with different interface<br>
names.<br>
<br>
Best regards,<br>
Marek Kierdelewicz<br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>Lambert Laur=
ent
</div>

--f46d044402683d99b504e0fb9ad1--
