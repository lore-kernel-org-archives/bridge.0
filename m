Message-ID: <20050420081951.4128.qmail@webmail6.rediffmail.com>
MIME-Version: 1.0
From: "ashish  anand" <ashish_ibm@rediffmail.com>
Content-type: multipart/alternative;
	boundary="Next_1113985191---0-202.54.124.151-4125"
Subject: [Bridge] path-cost of a port to root if priority and link speed are
	same ?
Reply-To: ashish  anand <ashish_ibm@rediffmail.com>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
Date: Wed, 20 Apr 2005 08:18:30 -0000
To: bridge@lists.osdl.org

This is a multi-part message in MIME format...

--Next_1113985191---0-202.54.124.151-4125
Content-type: text/plain;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

 =A0
if I just connect two similar port say both 10 gb of one switch to another =
symmetric bridge with stp enabled on both bridge  , stpstate of all four po=
rts always remain forwarding.
( may be because all four of them are either root or desginated port in abo=
ve setup)

port priority for all four ports are default value 0x1.

should I except that one port atleast will get into blocking state , if i c=
onnect two non-similar ports together say a 10gb port on one switch to FE p=
ort on another switch as now path-cost to root will differ. ( as path-cost =
depending on link speed )=20

Best Regards,
Ashish Anand

--Next_1113985191---0-202.54.124.151-4125
Content-type: text/html;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<P>
&nbsp; <BR>
if I just connect two similar port say both 10 gb of one switch to another =
symmetric bridge with stp enabled on both bridge&nbsp; , stpstate of all fo=
ur ports always remain forwarding.<BR>
( may be because all four of them are either root or desginated port in abo=
ve setup)<BR>
<BR>
port priority for all four ports are default value 0x1.<BR>
<BR>
should I except that one port atleast will get into blocking state , if i c=
onnect two non-similar ports together say a 10gb port on one switch to FE p=
ort on another switch as now path-cost to root will differ. ( as path-cost =
depending on link speed ) <BR>
<BR>
Best Regards,<BR>
Ashish Anand<BR>

</P>
<br><br>
<A target=3D"_blank" HREF=3D"http://clients.rediff.com/signature/track_sig.=
asp"><IMG DEFANGED_SRC=3D"http://ads.rediff.com/RealMedia/ads/adstream_nx.c=
gi/www.rediffmail.com/inbox.htm@Bottom" BORDER=3D0 VSPACE=3D0 HSPACE=3D0></=
a>

--Next_1113985191---0-202.54.124.151-4125--
