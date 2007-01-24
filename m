Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C73FE8.3B70F380"
Date: Wed, 24 Jan 2007 10:46:48 -0800
Message-ID: <8764B2C538F2C44B845C4B608D4515D31A48C6@EXVBE012-5.exch012.intermedia.net>
References: <8764B2C538F2C44B845C4B608D4515D31A48C2@EXVBE012-5.exch012.intermedia.net>
	<45B7A3ED.4080607@schaus.ca>
From: "Jake Farrell" <jake@amperion.com>
Subject: Re: [Bridge] STP Loop not blocking
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Cameron Schaus <cam@schaus.ca>, bridge@lists.osdl.org

This is a multi-part message in MIME format...

------_=_NextPart_001_01C73FE8.3B70F380
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

The setup is as follows

ixp4xx #1:  br0 (eth0, eth1, ath0, ath1) STP enabled
                  |                 |
                  |                 |
                  |                 |
ixp4xx #2:  br0 (eth0, eth1, ath0, ath1) STP enabled

with 2.6.16 one of the interfaces goes to blocking and the other is left to=
 forward. In 2.6.18 the interfaces always stay forwarding.

Jake


>
> Recently ran into a problem with the 2.6.18 kernel on Xscale arch when=20
> a bridge, with multiple interfaces on it, is configured with a=20
> redundant loop. All interfaces are left on forwarding and nexer switch=20
> to block when the loop is introduced. This was tested against a 2.6.16=20
> kernel and the problem did not occur, interfaces forwared and blocked=20
> correctly. Any help would be appreciated.
>
Since you haven't give much detail on your setup (is stp enabled on both=20
bridges, for example), I'm not 100% clear what may be happening.  But it=20
does sound like something I ran into before.

See my post, and Stephen's reply:
http://lists.osdl.org/pipermail/bridge/2006-December/001573.html

Cam



------_=_NextPart_001_01C73FE8.3B70F380
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Diso-8859-=
1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version 6.5.7650.28">
<TITLE>RE: [Bridge] STP Loop not blocking</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>The setup is as follows<BR>
<BR>
ixp4xx #1:&nbsp; br0 (eth0, eth1, ath0, ath1) STP enabled<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<BR>
ixp4xx #2:&nbsp; br0 (eth0, eth1, ath0, ath1) STP enabled<BR>
<BR>
with 2.6.16 one of the interfaces goes to blocking and the other is left to=
 forward. In 2.6.18 the interfaces always stay forwarding.<BR>
<BR>
Jake<BR>
<BR>
<BR>
&gt;<BR>
&gt; Recently ran into a problem with the 2.6.18 kernel on Xscale arch when=
<BR>
&gt; a bridge, with multiple interfaces on it, is configured with a<BR>
&gt; redundant loop. All interfaces are left on forwarding and nexer switch=
<BR>
&gt; to block when the loop is introduced. This was tested against a 2.6.16=
<BR>
&gt; kernel and the problem did not occur, interfaces forwared and blocked<=
BR>
&gt; correctly. Any help would be appreciated.<BR>
&gt;<BR>
Since you haven't give much detail on your setup (is stp enabled on both<BR>
bridges, for example), I'm not 100% clear what may be happening.&nbsp; But =
it<BR>
does sound like something I ran into before.<BR>
<BR>
See my post, and Stephen's reply:<BR>
<A HREF=3D"http://lists.osdl.org/pipermail/bridge/2006-December/001573.html=
">http://lists.osdl.org/pipermail/bridge/2006-December/001573.html</A><BR>
<BR>
Cam<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C73FE8.3B70F380--
