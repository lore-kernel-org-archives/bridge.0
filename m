MIME-Version: 1.0
In-Reply-To: <4D491494.3060905@free.fr>
References: <AANLkTiksJVC7BOM=frcJ1mRzCuUXaqws7F4sH40Xq2iJ@mail.gmail.com>
	<4D491494.3060905@free.fr>
Date: Wed, 2 Feb 2011 17:34:28 +0530
Message-ID: <AANLkTimSkgo=qwWmQC845eSHE+XNxE1auwVPMc-ait=s@mail.gmail.com>
From: Sinbad <sinbad.sinbad@gmail.com>
Content-Type: multipart/alternative; boundary=90e6ba6e867a76186c049b4b73c6
Subject: Re: [Bridge] vlan interface egress port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?ISO-8859-1?Q?Nicolas_de_Peslo=FCan?= <nicolas.2p.debian@free.fr>
Cc: bridge@osdl.org

--90e6ba6e867a76186c049b4b73c6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

hi,

suppose my config is as below.

 # brctl addbr mybridge
 # brctl addif mybridge eth0
 # brctl addif mybridge eth1
 # ifconfig mybridge up
 # ifconfig mybridge 192.168.100.5 netmask 255.255.255.0

now if the an l3 packet has to egress from mybridge
which port will be chosen ?

thanks


On Wed, Feb 2, 2011 at 1:53 PM, Nicolas de Peslo=FCan <
nicolas.2p.debian@free.fr> wrote:

> Le 02/02/2011 09:02, Sinbad a =E9crit :
>
>  hi,
>>
>> suppose a vlan has 3 member ports and vlan is configured as an l3
>> interface
>> and if data is suppose to go out using that vlan interface, which
>> physical port
>> will be chosen among the 3 member ports ?
>>
>
> Can you describe your configuration a little bit more (possibly using the
> commands used to setup that configuration)?
>
>        Nicolas.
>

--90e6ba6e867a76186c049b4b73c6
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

hi,<br><br>suppose my config is as below.<br><br>=A0# brctl addbr mybridge<=
br>=A0# brctl addif mybridge eth0<br>=A0# brctl addif mybridge eth1 <br>=A0=
# ifconfig mybridge up<br>=A0# ifconfig mybridge 192.168.100.5 netmask 255.=
255.255.0<br>
<br>now if the an l3 packet has to egress from mybridge<br>which port will =
be chosen ?<br><br>thanks<br><br><br><div class=3D"gmail_quote">On Wed, Feb=
 2, 2011 at 1:53 PM, Nicolas de Peslo=FCan <span dir=3D"ltr">&lt;<a href=3D=
"mailto:nicolas.2p.debian@free.fr">nicolas.2p.debian@free.fr</a>&gt;</span>=
 wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">Le 02/02/2011 09:=
02, Sinbad a =E9crit :<div><div></div><div class=3D"h5"><br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
hi,<br>
<br>
suppose a vlan has 3 member ports and vlan is configured as an l3 interface=
<br>
and if data is suppose to go out using that vlan interface, which<br>
physical port<br>
will be chosen among the 3 member ports ?<br>
</blockquote>
<br></div></div>
Can you describe your configuration a little bit more (possibly using the c=
ommands used to setup that configuration)?<br><font color=3D"#888888">
<br>
 =A0 =A0 =A0 =A0Nicolas.<br>
</font></blockquote></div><br>

--90e6ba6e867a76186c049b4b73c6--
