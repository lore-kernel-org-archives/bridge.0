In-Reply-To: <20070125104604.613432d4@freekitty>
References: <969A8B08-19EE-445B-AAFB-2A9D8D3D5CE7@mpsnet.net.mx>
	<20070125104604.613432d4@freekitty>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="Apple-Mail-10-318858950"
Message-Id: <7350AD3A-96AF-46D6-AEFF-9B855A993974@mpsnet.net.mx>
From: Omar Armas <oarmas@mpsnet.net.mx>
Date: Thu, 25 Jan 2007 13:08:23 -0600
Subject: Re: [Bridge] problem bridging
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: bridge@osdl.org

This is a multi-part message in MIME format...

--Apple-Mail-10-318858950
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed
Content-Disposition: inline

>
> iptables FORWARD rules apply to routing not bridging
>
> See:
> 	http://ebtables.sourceforge.net/br_fw_ia/br_fw_ia.html#section6


I recompiled with kernel 2.6.19, included ebtables modules and now it  
is working, I can filter with iptables and the FORWARD chain.
I just want to confirm, was that the correct way to do it? Would have  
it worked if I had patched 2.4 with ebtables?


Omar Armas
Oficina: +52 55 56044655
Movil: 04455 1867 8953
oarmas@mpsnet.net.mx




--Apple-Mail-10-318858950
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=US-ASCII
Content-Disposition: inline

<HTML><BODY DEFANGED_style=3D"word-wrap: break-word; -khtml-nbsp-mode: spac=
e; -khtml-line-break: after-white-space; "><DIV><BLOCKQUOTE type=3D"cite"><=
DIV DEFANGED_style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0p=
x; margin-left: 0px; min-height: 14px; "><BR></DIV><DIV DEFANGED_style=3D"m=
argin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">=
iptables FORWARD rules apply to routing not bridging</DIV><DIV DEFANGED_sty=
le=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: =
0px; min-height: 14px; "><BR></DIV><DIV DEFANGED_style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">See:</DIV><DIV D=
EFANGED_style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; ma=
rgin-left: 0px; "><SPAN class=3D"Apple-tab-span" DEFANGED_style=3D"white-sp=
ace:pre">	</SPAN><A href=3D"http://ebtables.sourceforge.net/br_fw_ia/br_fw_=
ia.html#section6">http://ebtables.sourceforge.net/br_fw_ia/br_fw_ia.html#se=
ction6</A></DIV></BLOCKQUOTE></DIV><DIV><BR class=3D"khtml-block-placeholde=
r"></DIV><DIV><BR class=3D"khtml-block-placeholder"></DIV><DIV>I recompiled=
 with kernel 2.6.19, included ebtables modules and now it is working, I can=
 filter with iptables and the FORWARD chain.</DIV><DIV>I just want to confi=
rm, was that the correct way to do it? Would have it worked if I had patche=
d 2.4 with ebtables?</DIV><DIV><BR class=3D"khtml-block-placeholder"></DIV>=
<BR><DIV> <SPAN class=3D"Apple-style-span" DEFANGED_style=3D"border-collaps=
e: separate; border-spacing: 0px 0px; color: rgb(0, 0, 0); font-family: Hel=
vetica; font-size: 12px; font-style: normal; font-variant: normal; font-wei=
ght: normal; letter-spacing: normal; line-height: normal; text-align: auto;=
 -khtml-text-decorations-in-effect: none; text-indent: 0px; -apple-text-siz=
e-adjust: auto; text-transform: none; orphans: 2; white-space: normal; wido=
ws: 2; word-spacing: 0px; "><SPAN class=3D"Apple-style-span" DEFANGED_style=
=3D"border-collapse: separate; border-spacing: 0px 0px; color: rgb(0, 0, 0)=
; font-family: Helvetica; font-size: 12px; font-style: normal; font-variant=
: normal; font-weight: normal; letter-spacing: normal; line-height: normal;=
 text-align: auto; -khtml-text-decorations-in-effect: none; text-indent: 0p=
x; -apple-text-size-adjust: auto; text-transform: none; orphans: 2; white-s=
pace: normal; widows: 2; word-spacing: 0px; "><DIV>Omar Armas</DIV><DIV>Ofi=
cina: +52 55 56044655</DIV><DIV>Movil: 04455 1867 8953</DIV><DIV><A href=3D=
"mailto:oarmas@mpsnet.net.mx">oarmas@mpsnet.net.mx</A></DIV><DIV><BR class=
=3D"khtml-block-placeholder"></DIV><BR class=3D"Apple-interchange-newline">=
</SPAN></SPAN> </DIV><BR></BODY></HTML>
--Apple-Mail-10-318858950--
