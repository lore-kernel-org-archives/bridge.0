Message-ID: <BLU149-W32BF6AE3ABAD47C9F2A8A48B170@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_b6ba0860-2f3b-4216-bd0e-f41dfbcd32e3_"
From: Fahim Akhter <akhter.fahim@hotmail.com>
Date: Thu, 13 Nov 2008 11:12:25 +0500
In-Reply-To: <20081111091105.2de861bb@extreme>
References: <BAY119-W404011B5F297F6E9D47DAA8B180@phx.gbl>
	<fed120860811081044k52dbd99fs174d10cd2df33d34@mail.gmail.com>
	<BLU149-W2552C09A3C56CF923B077E8B1A0@phx.gbl>
	<fed120860811100228x3fbff600l4e672635d4c260e3@mail.gmail.com>
	<BLU149-W34C4000F51A9F3DBDA06EC8B1A0@phx.gbl>
	<20081110083501.55aa10fd@extreme>
	<BLU149-W3001C3DF281B41D8F506DB8B150@phx.gbl> 
	<20081111091105.2de861bb@extreme>
MIME-Version: 1.0
Subject: Re: [Bridge] Modifying All Packets passing through the bridge!
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: shemminger@vyatta.com
Cc: bridge@lists.linux-foundation.org

--_b6ba0860-2f3b-4216-bd0e-f41dfbcd32e3_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Thanks a lot for your kind and generous help. So the final point is I use n=
etfilters for it :)
=20
When I was doing the encryption through the bridge=2C I used to set the sta=
tus (crypto/plain) master/slave through bridge control. But since I won't h=
ave the back end now instead netfilters. Is there any way to keep the statu=
s updated ?
=20
thanks again!> Date: Tue=2C 11 Nov 2008 09:11:05 -0800> From: shemminger@vy=
atta.com> To: akhter.fahim@hotmail.com> CC: srinivas.aji@gmail.com=3B bridg=
e@lists.linux-foundation.org> Subject: Re: [Bridge] Modifying All Packets p=
assing through the bridge!> > On Tue=2C 11 Nov 2008 12:16:34 +0500> Fahim A=
khter <akhter.fahim@hotmail.com> wrote:> > > > > P.S according to the littl=
e knowledge I have netfilters decide the fate of the packet by looking at t=
he header not the data=2C but I need the data to decide what to do with the=
 packet.> > Netfilter modules can see the whole packet=20
_________________________________________________________________
Connect to the next generation of MSN Messenger=A0
http://imagine-msn.com/messenger/launch80/default.aspx?locale=3Den-us&sourc=
e=3Dwlmailtagline=

--_b6ba0860-2f3b-4216-bd0e-f41dfbcd32e3_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Verdana
}
</style>
</head>
<body class=3D'hmmessage'>
Thanks a lot for your kind and generous help. So the final point is I use n=
etfilters for it :)<BR>
&nbsp=3B<BR>
When I was doing the encryption through the bridge=2C I used to set the sta=
tus (crypto/plain) master/slave through bridge control. But since I won't h=
ave the back end now instead netfilters. Is there any way to keep the statu=
s updated ?<BR>
&nbsp=3B<BR>
thanks again!<BR><BR>&gt=3B Date: Tue=2C 11 Nov 2008 09:11:05 -0800<BR>&gt=
=3B From: shemminger@vyatta.com<BR>&gt=3B To: akhter.fahim@hotmail.com<BR>&=
gt=3B CC: srinivas.aji@gmail.com=3B bridge@lists.linux-foundation.org<BR>&g=
t=3B Subject: Re: [Bridge] Modifying All Packets passing through the bridge=
!<BR>&gt=3B <BR>&gt=3B On Tue=2C 11 Nov 2008 12:16:34 +0500<BR>&gt=3B Fahim=
 Akhter &lt=3Bakhter.fahim@hotmail.com&gt=3B wrote:<BR>&gt=3B <BR>&gt=3B &g=
t=3B <BR>&gt=3B &gt=3B P.S according to the little knowledge I have netfilt=
ers decide the fate of the packet by looking at the header not the data=2C =
but I need the data to decide what to do with the packet.<BR>&gt=3B <BR>&gt=
=3B Netfilter modules can see the whole packet <BR><BR><br /><hr />Connect =
to the next generation of MSN Messenger=A0  <a href=3D'http://imagine-msn.c=
om/messenger/launch80/default.aspx?locale=3Den-us&source=3Dwlmailtagline' t=
arget=3D'_new'>Get it now! </a></body>
</html>=

--_b6ba0860-2f3b-4216-bd0e-f41dfbcd32e3_--
