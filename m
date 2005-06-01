Message-ID: <34d8b2fe05060106074da8df04@mail.gmail.com>
Date: Wed, 1 Jun 2005 15:07:41 +0200
From: Louis Croisez <louis.croisez@gmail.com>
Subject: Re: [Bridge] Bridge not working on arm embedded platform
In-Reply-To: <1117609420.3384.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_863_16749177.1117631261792"
References: <34d8b2fe05053002387a1942bf@mail.gmail.com>
	<20050531094024.75098a16@dxpl.pdx.osdl.net>
	<34d8b2fe050531121736623672@mail.gmail.com>
	<1117609420.3384.1.camel@localhost.localdomain>
Reply-To: Louis Croisez <louis.croisez@gmail.com>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Bart De Schuymer <bdschuym@pandora.be>
Cc: bridge@lists.osdl.org

This is a multi-part message in MIME format...

------=_Part_863_16749177.1117631261792
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Bart, Hi kind bridge listers,

Just my 2 cents: make sure arptables doesn't drop the ARP packets...
>=20

How can I be sure that arptables is not interferring?
is it by putting 0 inside /proc/sys/net/bridge/bridge-nf-call-arptables ?

The symptom is : the arp broadcast (not the unicast arp response) is blocke=
d=20
just after ebt:Nat:PostRouting.
Note: ebt:Nat:PostRouting is the trace printed by the following ebtable=20
entry:
> ebtables -t nat -A POSTROUTING -j ACCEPT --log --log-prefix=3D"=20
ebt:Nat:PostRouting "

------=_Part_863_16749177.1117631261792
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Bart, Hi kind bridge listers,<br>
<br>
<blockquote DEFANGED_style=3D"border-left: 1px solid rgb(204, 204, 204); ma=
rgin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;" class=3D"gmail_quote">Just my =
2 cents: make sure arptables doesn't drop the ARP packets...<br>
</blockquote>
<br>
How can I be sure that arptables is not interferring?<br>
is it by putting 0 inside /proc/sys/net/bridge/bridge-nf-call-arptables ?<b=
r><br>The symptom is : the arp broadcast (not the unicast arp response) is =
blocked just after ebt:Nat:PostRouting.<br>
Note: ebt:Nat:PostRouting is the trace printed by the following ebtable ent=
ry:<br>
&gt; ebtables -t nat -A POSTROUTING -j ACCEPT --log --log-prefix=3D&quot; e=
bt:Nat:PostRouting &quot;<br>

------=_Part_863_16749177.1117631261792--
