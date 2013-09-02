Return-Path: <sujataverma3@yahoo.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024;
	t=1378101476; bh=nnmlPGAvlllpqkkfy4hR5+BFx9WI0PhEpdYGAMdz8uQ=;
	h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:References:Message-ID:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type;
	b=ovKAkzDSEPOpkj3Zgy2ZMnnMj4z9Py9KmobqMjoZ6Pb2sNQncY11FAsB8vjVYaJ3OWfBa3ClUfINODVxbb8lsTpZ+KW4dhdNNUp91ozpwCIWzKONf0Z7dEtVoTirBjLnOgUZwvTOpLhXHGnYUMEuSKnOn3d8ppGP4N/GybD/zwY=
References: <15785B7E063D464C86DD482FCAE4EBA5018D1AD3DA16@XCH11.scidom.de>	<15785B7E063D464C86DD482FCAE4EBA5018D1B8B7C29@XCH11.scidom.de>	<1377921042.19249.YahooMailNeo@web160202.mail.bf1.yahoo.com>
	<15785B7E063D464C86DD482FCAE4EBA5018D1B8B7C2B@XCH11.scidom.de>
Message-ID: <1378101476.60377.YahooMailNeo@web160205.mail.bf1.yahoo.com>
Date: Sun, 1 Sep 2013 22:57:56 -0700 (PDT)
From: Sujata Verma <sujataverma3@yahoo.com>
In-Reply-To: <15785B7E063D464C86DD482FCAE4EBA5018D1B8B7C2B@XCH11.scidom.de>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="-1263770829-1198791415-1378101476=:60377"
Subject: Re: [Bridge] br0: received packet on eth0 with own address as
	source	address
Reply-To: Sujata Verma <sujataverma3@yahoo.com>
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>, "Bridge ML (bridge@lists.linux-foundation.org)" <bridge@lists.linux-foundation.org>

---1263770829-1198791415-1378101476=:60377
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Bernd,=0A=0ACan you give more information about how these two hosts are con=
nected with the network? Are they stand alone PC ? Not much idea about KVM =
guests, but hope they both have different mac addresses configured.=0A=0ASo=
me info i could find =0A=0Ahttp://pic.dhe.ibm.com/infocenter/lnxinfo/v3r0m0=
/index.jsp?topic=3D%2Fliaat%2Fliaatkvmsecbridge.htm=0A=0AIf there is a loop=
 you will observe loss in the connectivity because there are too many packe=
ts, and it can even bring your network down. This loop can be because of ac=
tually someone connecting the cable unknowingly to create loop or could be =
because of mac address misconfiguration.=0A=0ARegards,=0ASujata=0A=0A=0A=0A=
=0A________________________________=0A From: "Lentes, Bernd" <bernd.lentes@=
helmholtz-muenchen.de>=0ATo: "Bridge ML (bridge@lists.linux-foundation.org)=
" <bridge@lists.linux-foundation.org> =0ASent: Saturday, August 31, 2013 4:=
37 PM=0ASubject: Re: [Bridge] br0: received packet on eth0 with own address=
 as source=09address=0A =0A=0ASujata wrote:=0A=0A> Bernd,=0A=0A> We see thi=
s messages ,when there is a loop in the network. Basically, it means that t=
he bridge is receiving same packets which it is sending.=0A=0A> Regards,=0A=
> Sujata=0A=0AHi Sujata,=0A=0Ahow can this happen ? I had intermittent loss=
es of connectivity. The error appears on two hosts, each have running some =
KVM guests.=0A=0A=0ABernd=0A[]=0A=0A=0AHelmholtz Zentrum M=FCnchen=0ADeutsc=
hes Forschungszentrum f=FCr Gesundheit und Umwelt (GmbH)=0AIngolst=E4dter L=
andstr. 1=0A85764 Neuherberg=0Awww.helmholtz-muenchen.de=0AAufsichtsratsvor=
sitzende: MinDir=B4in B=E4rbel Brumme-Bothe=0AGesch=E4ftsf=FChrer: Prof. Dr=
. G=FCnther Wess Dr. Nikolaus Blum Dr. Alfons Enhsen=0ARegistergericht: Amt=
sgericht M=FCnchen HRB 6466=0AUSt-IdNr: DE 129521671
---1263770829-1198791415-1378101476=:60377
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:Co=
urier New, courier, monaco, monospace, sans-serif;font-size:12pt"> Bernd,<b=
r><br>Can you give more information about how these two hosts are connected=
 with the network? Are they stand alone PC ? Not much idea about KVM guests=
, but hope they both have different mac addresses configured.<br><br>Some i=
nfo i could find <br><br>http://pic.dhe.ibm.com/infocenter/lnxinfo/v3r0m0/i=
ndex.jsp?topic=3D%2Fliaat%2Fliaatkvmsecbridge.htm<br><br>If there is a loop=
 you will observe loss in the connectivity because there are too many packe=
ts, and it can even bring your network down. This loop can be because of ac=
tually someone connecting the cable unknowingly to create loop or could be =
because of mac address misconfiguration.<br><br>Regards,<br>Sujata<br><div>=
<span><br></span></div><div><br></div>  <div style=3D"font-family: Courier =
New, courier, monaco, monospace, sans-serif; font-size: 12pt;"> <div
 style=3D"font-family: times new roman, new york, times, serif; font-size: =
12pt;"> <div dir=3D"ltr"> <hr size=3D"1">  <font face=3D"Arial" size=3D"2">=
 <b><span style=3D"font-weight:bold;">From:</span></b> "Lentes, Bernd" &lt;=
bernd.lentes@helmholtz-muenchen.de&gt;<br> <b><span style=3D"font-weight: b=
old;">To:</span></b> "Bridge ML (bridge@lists.linux-foundation.org)" &lt;br=
idge@lists.linux-foundation.org&gt; <br> <b><span style=3D"font-weight: bol=
d;">Sent:</span></b> Saturday, August 31, 2013 4:37 PM<br> <b><span style=
=3D"font-weight: bold;">Subject:</span></b> Re: [Bridge] br0: received pack=
et on eth0 with own address as source=09address<br> </font> </div> <div cla=
ss=3D"y_msg_container"><br>Sujata wrote:<br><br>&gt; Bernd,<br><br>&gt; We =
see this messages ,when there is a loop in the network. Basically, it means=
 that the bridge is receiving same packets which it is sending.<br><br>&gt;=
 Regards,<br>&gt; Sujata<br><br>Hi Sujata,<br><br>how can this happen ? I h=
ad intermittent
 losses of connectivity. The error appears on two hosts, each have running =
some KVM guests.<br><br><br>Bernd<br>[]<br><br><br>Helmholtz Zentrum M=FCnc=
hen<br>Deutsches Forschungszentrum f=FCr Gesundheit und Umwelt (GmbH)<br>In=
golst=E4dter Landstr. 1<br>85764 Neuherberg<br>www.helmholtz-muenchen.de<br=
>Aufsichtsratsvorsitzende: MinDir=B4in B=E4rbel Brumme-Bothe<br>Gesch=E4fts=
f=FChrer: Prof. Dr. G=FCnther Wess Dr. Nikolaus Blum Dr. Alfons Enhsen<br>R=
egistergericht: Amtsgericht M=FCnchen HRB 6466<br>USt-IdNr: DE 129521671<br=
><br><br></div> </div> </div>  </div></body></html>
---1263770829-1198791415-1378101476=:60377--
