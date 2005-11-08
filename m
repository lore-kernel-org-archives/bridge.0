Message-ID: <30be90270511080550i42c62b21webe50c58f16959f1@mail.gmail.com>
Date: Tue, 8 Nov 2005 08:50:28 -0500
From: Hai Wang <u2.ireland@gmail.com>
Subject: Re: [Bridge] Bridge question
In-Reply-To: <30be90270511041319o2f97b74co83e64b2ca2937968@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_13651_13986635.1131457828575"
References: <DE026503646E7F40AF97BAB98334333BF0C972@uss-republic.finepoint.com>
	<30be90270511040955t7362da37m640573ff06c24243@mail.gmail.com>
	<30be90270511041016i25b04841o18e3fdf6a855d0f7@mail.gmail.com>
	<30be90270511041046n7b4ef6dalb3a235da6fba37a@mail.gmail.com>
	<20051104105720.02a93a7e@dxpl.pdx.osdl.net>
	<30be90270511041108l3c9414afp8526a70130e0f1dd@mail.gmail.com>
	<20051104113910.322bb270@dxpl.pdx.osdl.net>
	<30be90270511041214w2be63458s854bd8e51f850d05@mail.gmail.com>
	<20051104123442.0d12d7ed@dxpl.pdx.osdl.net>
	<30be90270511041319o2f97b74co83e64b2ca2937968@mail.gmail.com>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>, bridge@lists.osdl.org

This is a multi-part message in MIME format...

------=_Part_13651_13986635.1131457828575
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello Stephen,
  I have two questions for you, please help me.
  1. Are you aware that kernel panic issue when brtcl managed to remove
interfaces on the bridge on RH9 (2.4.X)? it is random, it seems to me that
it is racing issue? any fix?
  2. I went through ChangeLog of kernel, I found
 --------------------------------------------------------------------------=
-----------------------

*Summary of changes from v2.6.6 to v2.6.7*

shemminger@osdl.org

      [BRIDGE]: Allow multiple interfaces with same address (necessary
for VLAN's).

-----------------------------------------------------

it seems to me that ethernet bridge allows interfaces with same MACs
address only on kernel 2.6.7 or later, right? If I want to backport
the feature to kernel 2.4.x, what I should take care?



Many thanks

------=_Part_13651_13986635.1131457828575
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Hello Stephen,</div>
<div>&nbsp;</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I have two questions =
for you, please help me.</div>
<div>&nbsp;</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1. Are you aware that kerne=
l panic issue when brtcl managed to&nbsp;remove interfaces on the bridge on=
 RH9 (2.4.X)? it is random, it seems to me that it is racing issue? any fix=
?</div>
<div>&nbsp;</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2. I went through ChangeLog of ke=
rnel, I found</div>
<div>&nbsp;</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ---------------------------------=
----------------------------------------------------------------<pre><b DEF=
ANGED_style=3D"mso-bidi-font-weight: normal"><span DEFANGED_style=3D"FONT-S=
IZE: 14pt">Summary of changes from v2.6.6 to v2.6.7
</span></b></pre><pre><font size=3D"2"><a href=3D"mailto:shemminger@osdl.or=
g">shemminger@osdl.org</a></font><font size=3D"2">   </font></pre><pre><fon=
t size=3D"2"><span DEFANGED_style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;</span>[BRIDGE]: Allow multiple interfaces with same addres=
s (necessary for VLAN's).
</font></pre><pre><font size=3D"2">----------------------------------------=
-------------</font></pre><pre><font size=3D"2">it seems to me that etherne=
t bridge allows interfaces with same MACs address only on kernel 2.6.7 or l=
ater, right? If I want to backport the feature to kernel=20
2.4.x, what I should take care?</font></pre><pre><font size=3D"2"></font>&n=
bsp;</pre><pre><font size=3D"2">Many thanks</font></pre><pre><font size=3D"=
2"></font>&nbsp;</pre><pre><font size=3D"2"></font>&nbsp;</pre></div>
<div>&nbsp;</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </div>

------=_Part_13651_13986635.1131457828575--
