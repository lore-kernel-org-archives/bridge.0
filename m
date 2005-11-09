Message-ID: <8DA338857B4F404282EE2088005079EA7701F0@eammlex037-nb.lmc.ericsson.se>
From: "Andre Beliveau (QB/EMC)" <andre.beliveau@ericsson.com>
Subject: RE: [Bridge] Bridging EAPOL
Date: Wed, 9 Nov 2005 13:32:36 -0600 
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5E563.EA581EB6"
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: 'Stephen Hemminger' <shemminger@osdl.org>
Cc: "'bridge@lists.osdl.org'" <bridge@lists.osdl.org>

This is a multi-part message in MIME format...

------_=_NextPart_001_01C5E563.EA581EB6
Content-Type: text/plain
Content-Disposition: inline

Hi, 
 I had gotten that far also.  What I was going to try now was enable
ebtables and see if I can force packet to go through with some clever
filter.

Do you think it would work?

/AB

> -----Original Message-----
> From: Stephen Hemminger [mailto:shemminger@osdl.org] 
> Sent: Wednesday, November 09, 2005 2:02 PM
> To: Andre Beliveau (QB/EMC)
> Cc: 'bridge@lists.osdl.org'
> Subject: Re: [Bridge] Bridging EAPOL
> 
> This is what is trapping your frames.
> 
> br_input.c:br_handle_frame
> 	if (p->br->stp_enabled &&
> 	    !memcmp(dest, bridge_ula, 5) &&
> 	    !(dest[5] & 0xF0)) {
> 
> I didn't write it (Lennert did), and wouldn't change it 
> without finding the relevant place in the standard.  I 
> looked, and the 802.1d standard is kind of obtuse about 
> multicast addresses. They often write these standards as 
> spec's with yet another spec on how to map the standard to 
> real LAN's...
> 
> 
> --
> Stephen Hemminger <shemminger@osdl.org>
> OSDL http://developer.osdl.org/~shemminger
> 

------_=_NextPart_001_01C5E563.EA581EB6
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version 5.5.2658.2">
<TITLE>RE: [Bridge] Bridging EAPOL</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2>Hi, </FONT>
<BR><FONT SIZE=3D2>&nbsp;I had gotten that far also.&nbsp; What I was going=
 to try now was enable ebtables and see if I can force packet to go through=
 with some clever filter.</FONT></P>

<P><FONT SIZE=3D2>Do you think it would work?</FONT>
</P>

<P><FONT SIZE=3D2>/AB</FONT>
</P>

<P><FONT SIZE=3D2>&gt; -----Original Message-----</FONT>
<BR><FONT SIZE=3D2>&gt; From: Stephen Hemminger [<A HREF=3D"mailto:shemming=
er@osdl.org">mailto:shemminger@osdl.org</A>] </FONT>
<BR><FONT SIZE=3D2>&gt; Sent: Wednesday, November 09, 2005 2:02 PM</FONT>
<BR><FONT SIZE=3D2>&gt; To: Andre Beliveau (QB/EMC)</FONT>
<BR><FONT SIZE=3D2>&gt; Cc: 'bridge@lists.osdl.org'</FONT>
<BR><FONT SIZE=3D2>&gt; Subject: Re: [Bridge] Bridging EAPOL</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; This is what is trapping your frames.</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; br_input.c:br_handle_frame</FONT>
<BR><FONT SIZE=3D2>&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (p-&gt;br-&gt;stp=
_enabled &amp;&amp;</FONT>
<BR><FONT SIZE=3D2>&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; !=
memcmp(dest, bridge_ula, 5) &amp;&amp;</FONT>
<BR><FONT SIZE=3D2>&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; !=
(dest[5] &amp; 0xF0)) {</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; I didn't write it (Lennert did), and wouldn't chang=
e it </FONT>
<BR><FONT SIZE=3D2>&gt; without finding the relevant place in the standard.=
&nbsp; I </FONT>
<BR><FONT SIZE=3D2>&gt; looked, and the 802.1d standard is kind of obtuse a=
bout </FONT>
<BR><FONT SIZE=3D2>&gt; multicast addresses. They often write these standar=
ds as </FONT>
<BR><FONT SIZE=3D2>&gt; spec's with yet another spec on how to map the stan=
dard to </FONT>
<BR><FONT SIZE=3D2>&gt; real LAN's...</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; --</FONT>
<BR><FONT SIZE=3D2>&gt; Stephen Hemminger &lt;shemminger@osdl.org&gt;</FONT>
<BR><FONT SIZE=3D2>&gt; OSDL <A HREF=3D"http://developer.osdl.org/~shemming=
er" TARGET=3D"_blank">http://developer.osdl.org/~shemminger</A></FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C5E563.EA581EB6--
