Return-Path: <ajaykanala321@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:content-type; bh=WqhISCB9DuFzqQVW7zT3dU0T4bUaLnQv4twkLhm64UE=;
	b=j51NBxglko76KXv6YOgitnNcXnK2oanJlJFT7hlGcyIPnAINyfOFxs9QaCleYLXYf6
	36J9CAY8Khxb18XTuxQYtj6IOwwEl9+/dwAZCcws3SFqqEKGXevqm8zorj2XGxTZGz8K
	xZdVxVupUErDUkIKr+5iAk0c6dy4e7Yi/ickuTaiobPujFDhaHvsHfncqAl3MXNExQEh
	PuslGHlDqKpWzh5S6tX66/BrluyXrhjOgPKsUgZJ7pCVdndhVg0gVxc+jQLV1ISQ5ZJu
	QCVZf2JrftFhGSXEi73Y7oC/xAgMg5PsJHiZIIIn0VDjcQRu0L3GtMk4mWF9AJV4TYaA
	SO1g==
MIME-Version: 1.0
In-Reply-To: <CAFxy--YE-jVQ2CH9gUgUsyTpAvJHYfHEApAMUR0JNynMM2DLKw@mail.gmail.com>
References: <CAFxy--YE-jVQ2CH9gUgUsyTpAvJHYfHEApAMUR0JNynMM2DLKw@mail.gmail.com>
Date: Fri, 14 Mar 2014 17:23:58 +0530
Message-ID: <CAFxy--a+9_dxFfLe5P-rjLUNjKX6StrWy9n43Z+2LagRptAhmw@mail.gmail.com>
From: ajay kanala <ajaykanala321@gmail.com>
Content-Type: multipart/alternative; boundary=089e011769d19b09c004f48fb90e
Subject: Re: [Bridge] linux 3.10.12 bridge gso with ethtool
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--089e011769d19b09c004f48fb90e
Content-Type: text/plain; charset=ISO-8859-1

Hi,
Any pointers would be appreciated !!

regards
ajay


On Wed, Mar 12, 2014 at 10:25 PM, ajay kanala <ajaykanala321@gmail.com>wrote:

> Hi,
> I am not sure if this is the right forum, please guide me to the right one
> if not.
>
> I am using a mips linux based router where i used linux kernel 2.6.32 for
> some time. In such scenario, i could turn off gso of a linux bridge using
> ethtool without any problems ( i had eth0 under br0 ).
>
> Recently i switched to kernel 3.10.12 and setting on gso flag using
> ethtool on the bridge interface br0 does not work and always throws up
> error "Could not change any device features".
>
> I am clueless what to do here as my device drivers are same across kernel
> upgrades. I only changed ethtool version to 3.10. Any pointers would be
> appreciated.
>
> Thanks for your time ..
>
> regards
> ajay
>
>

--089e011769d19b09c004f48fb90e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hi,<br></div>Any pointers would be apprecia=
ted !!<br><br></div>regards<br></div>ajay<br></div><div class=3D"gmail_extr=
a"><br><br><div class=3D"gmail_quote">On Wed, Mar 12, 2014 at 10:25 PM, aja=
y kanala <span dir=3D"ltr">&lt;<a href=3D"mailto:ajaykanala321@gmail.com" t=
arget=3D"_blank">ajaykanala321@gmail.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div><div><div><div>Hi,<br>=
I am not sure if this is the right forum, please guide me to the right one =
if not.<br>
<br></div>I am using a mips linux based router where i used linux kernel 2.=
6.32 for some time. In such scenario, i could turn off gso of a linux bridg=
e using ethtool without any problems ( i had eth0 under br0 ).<br>
<br></div>Recently i switched to kernel 3.10.12 and setting on gso flag usi=
ng ethtool on the bridge interface br0 does not work and always throws up e=
rror &quot;Could not change any device features&quot;.<br><br></div><div>

I am clueless what to do here as my device drivers are same across kernel u=
pgrades. I only changed ethtool version to 3.10. Any pointers would be appr=
eciated.<br><br></div>Thanks for your time ..<br><br></div><div>regards<spa=
n class=3D"HOEnZb"><font color=3D"#888888"><br>

</font></span></div><span class=3D"HOEnZb"><font color=3D"#888888"><div>aja=
y<br></div><br></font></span></div>
</blockquote></div><br></div>

--089e011769d19b09c004f48fb90e--
