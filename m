Return-Path: <djlogan2.dl@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=content-type:mime-version:subject:from:in-reply-to:date:cc
	:message-id:references:to;
	bh=opYLKnltDjFR8VNFw0ooLvcEQCpbTSTK2VeqkMlcbT4=;
	b=Dnbn95vnA3DD05BK02dAi6ugfpgDygHr89Iyp2j1/FAZltQ3vU9jSzThog/g9AwTaE
	CBgTy1/X4Dx9Sr2pt0bXiBvdAhw+zIayr16vbbrJ8erfAJ1J5VTKAIidCUdzRZTMyJQu
	LjbFsgaskqF8NzMmgL7kKgINY+Q9ltxbxsRaiXcsyGKSzOd/qj1QGgY0wXRHozCoV6n7
	m2bQGVJLdnW6LdDcBIs4d5pM1oBoyUAIfO+yuuX1S234P+r6Q+7yy9x73/3Zo6WL3i2W
	FcDaESYJCaizNJuN7033Nb8NNd+LW1IlJpn2ajaDQwpW1qVa6/GvawtLHFkSvcjg5sfK
	mZnQ==
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_D9AE5EED-5AFC-4334-9906-91BCBB0D82BB"
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
From: David Logan <djlogan2.dl@gmail.com>
In-Reply-To: <20160202142708.512d1cc8@samsung9>
Date: Mon, 1 Feb 2016 21:48:51 -0700
Message-Id: <A4B5DFE9-A190-4CE3-A5FA-F3488A1F14A3@gmail.com>
References: <5FA3B72D-03E5-43BD-B635-6A46070C6898@gmail.com>
	<6B2C2A75-2FC1-4938-B8FD-19D9325583A4@gmail.com>
	<20160202142708.512d1cc8@samsung9>
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
Cc: bridge@lists.linux-foundation.org


--Apple-Mail=_D9AE5EED-5AFC-4334-9906-91BCBB0D82BB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

That was a bit above my head. Can you elaborate or point me towards a =
web site that explains the terminology? Sorry, I=E2=80=99m reasonable at =
networking, I know what levels are, I have an idea of what the various =
fields and stuff are, but I am no means an expert :)

Also: While I have STP enabled at the moment as the recommendation of =
one web site, most of the time STP has been disabled in the bridge. I =
can turn it off and/or reboot and replicate the problem in minutes. Does =
that alter your suggestion?

David Logan


> On Feb 1, 2016, at 8:27 PM, Stephen Hemminger =
<stephen@networkplumber.org> wrote:
>=20
> On Mon, 1 Feb 2016 13:04:48 -0700
> David Logan <djlogan2.dl@gmail.com> wrote:
>=20
>> oops. Wrong machine. The uname -a really is
>>=20
>> Linux server2 3.16.0-59-generic #79~14.04.1-Ubuntu SMP Mon Jan 18 =
15:41:27 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux
>>=20
>> David Logan
>>=20
>>=20
>=20
> I suspect you have a loop and STP is detecting that the STP packets =
being sent
> out one of the ports on the bridge are showing back up on another port =
on the bridge.
>=20
> The way bridging works you need to make each port on the bridge is a =
separate L2 domain;
> otherwise you create a loop.


--Apple-Mail=_D9AE5EED-5AFC-4334-9906-91BCBB0D82BB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D"">That was a bit above my head. Can you elaborate or point me =
towards a web site that explains the terminology? Sorry, I=E2=80=99m =
reasonable at networking, I know what levels are, I have an idea of what =
the various fields and stuff are, but I am no means an expert :)<div =
class=3D""><br class=3D""></div><div class=3D"">Also: While I have STP =
enabled at the moment as the recommendation of one web site, most of the =
time STP has been disabled in the bridge. I can turn it off and/or =
reboot and replicate the problem in minutes. Does that alter your =
suggestion?</div><div class=3D""><br class=3D""><div class=3D"">
<span class=3D"Apple-style-span" style=3D"border-collapse: separate; =
color: rgb(0, 0, 0); font-family: Helvetica; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: normal; orphans: 2; text-align: -webkit-auto; text-indent: =
0px; text-transform: none; white-space: normal; widows: 2; word-spacing: =
0px; -webkit-border-horizontal-spacing: 0px; =
-webkit-border-vertical-spacing: 0px; =
-webkit-text-decorations-in-effect: none; -webkit-text-size-adjust: =
auto; -webkit-text-stroke-width: 0px;  ">David Logan<br class=3D""><br =
class=3D""></span>

</div>
<br class=3D""><div><blockquote type=3D"cite" class=3D""><div =
class=3D"">On Feb 1, 2016, at 8:27 PM, Stephen Hemminger &lt;<a =
href=3D"mailto:stephen@networkplumber.org" =
class=3D"">stephen@networkplumber.org</a>&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div class=3D""><div class=3D"">On =
Mon, 1 Feb 2016 13:04:48 -0700<br class=3D"">David Logan &lt;<a =
href=3D"mailto:djlogan2.dl@gmail.com" =
class=3D"">djlogan2.dl@gmail.com</a>&gt; wrote:<br class=3D""><br =
class=3D""><blockquote type=3D"cite" class=3D"">oops. Wrong machine. The =
uname -a really is<br class=3D""><br class=3D"">Linux server2 =
3.16.0-59-generic #79~14.04.1-Ubuntu SMP Mon Jan 18 15:41:27 UTC 2016 =
x86_64 x86_64 x86_64 GNU/Linux<br class=3D""><br class=3D"">David =
Logan<br class=3D""><br class=3D""><br class=3D""></blockquote><br =
class=3D"">I suspect you have a loop and STP is detecting that the STP =
packets being sent<br class=3D"">out one of the ports on the bridge are =
showing back up on another port on the bridge.<br class=3D""><br =
class=3D"">The way bridging works you need to make each port on the =
bridge is a separate L2 domain;<br class=3D"">otherwise you create a =
loop.<br class=3D""></div></div></blockquote></div><br =
class=3D""></div></body></html>=

--Apple-Mail=_D9AE5EED-5AFC-4334-9906-91BCBB0D82BB--
