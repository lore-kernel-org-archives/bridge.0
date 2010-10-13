From: Mark Liggett <mliggett@btisystems.com>
Date: Wed, 13 Oct 2010 11:27:18 -0400
Message-ID: <C8DB8E66.6920%mliggett@btisystems.com>
Content-Language: en
Content-Type: multipart/alternative;
	boundary="_000_C8DB8E666920mliggettbtisystemscom_"
MIME-Version: 1.0
Subject: [Bridge] F13 bridge issues
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>

--_000_C8DB8E666920mliggettbtisystemscom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

I'm using Ethernet bridging on an up-to-date F13 system.  I've created a br=
idge adapter br0 and added eth2 and eth3 to it.  Everything works as expect=
ed for a short time before the 2 Ethernet cards used in the bridge start re=
porting millions of errors.  I confirmed this is the case on 2 separate sys=
tems (although both systems use Intel NICs).  To try to resolve this I've:

- Compiled and installed the latest Intel igb driver 2.3.4
- Installed the latest Fedora kernel 2.6.34.7-56
- Uninstalled the standard bridge-utils 1.2-9, before compiling and install=
ing version 1.4

I've pastebin'd the system config here:  http://pastebin.ca/1960777

You can see the errors listed on eth2 and eth3.  I've tried both setting th=
e bridge up using /etc/sysconfig/network-scripts as well as manually (using=
 brctl and ifconfig).

My bridge/Ethernet interface configs are listed here: http://pastebin.ca/19=
60790

Any suggestions would be greatly appreciated.

Thanks,

Mark

--_000_C8DB8E666920mliggettbtisystemscom_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<HTML>
<HEAD>
<TITLE>F13 bridge issues</TITLE>
</HEAD>
<BODY>
<FONT FACE=3D"Tahoma, Verdana, Helvetica, Arial"><SPAN STYLE=3D'font-size:1=
1pt'>Hi everyone,<BR>
<BR>
I&#8217;m using Ethernet bridging on an up-to-date F13 system. &nbsp;I&#821=
7;ve created a bridge adapter br0 and added eth2 and eth3 to it. &nbsp;Ever=
ything works as expected for a short time before the 2 Ethernet cards used =
in the bridge start reporting millions of errors. &nbsp;I confirmed this is=
 the case on 2 separate systems (although both systems use Intel NICs). &nb=
sp;To try to resolve this I&#8217;ve:<BR>
<BR>
- Compiled and installed the latest Intel igb driver 2.3.4<BR>
- Installed the latest Fedora kernel 2.6.34.7-56<BR>
- Uninstalled the standard bridge-utils 1.2-9, before compiling and install=
ing version 1.4<BR>
<BR>
I&#8217;ve pastebin&#8217;d the system config here: &nbsp;<FONT COLOR=3D"#0=
000FF"><U><a href=3D"http://pastebin.ca/1960777">http://pastebin.ca/1960777=
</a><BR>
</U></FONT><BR>
You can see the errors listed on eth2 and eth3. &nbsp;I&#8217;ve tried both=
 setting the bridge up using /etc/sysconfig/network-scripts as well as manu=
ally (using brctl and ifconfig).<BR>
<BR>
My bridge/Ethernet interface configs are listed here: <FONT COLOR=3D"#0000F=
F"><U><a href=3D"http://pastebin.ca/1960790">http://pastebin.ca/1960790</a>=
<BR>
</U></FONT><BR>
Any suggestions would be greatly appreciated.<BR>
<BR>
Thanks,<BR>
<BR>
Mark</SPAN></FONT>
</BODY>
</HTML>


--_000_C8DB8E666920mliggettbtisystemscom_--
