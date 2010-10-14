From: Mark Liggett <mliggett@btisystems.com>
Date: Thu, 14 Oct 2010 12:00:39 -0400
Message-ID: <C8DCE7B7.69A7%mliggett@btisystems.com>
In-Reply-To: <20101013084639.5712c28c@nehalam>
Content-Language: en
Content-Type: multipart/alternative;
	boundary="_000_C8DCE7B769A7mliggettbtisystemscom_"
MIME-Version: 1.0
Subject: Re: [Bridge] F13 bridge issues
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>

--_000_C8DCE7B769A7mliggettbtisystemscom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

As you suspected, I believe the igb driver is at fault - I configured a bri=
dge on the same machine using onboard tg3 cards.

The bridge worked fine and the fault did not occur until I SCP'd a file to =
the server on the igb card.  After which the bridge continued to work fine.

Thanks for your help.

Mark


On 13/10/2010 16:46, "Stephen Hemminger" <shemminger@linux-foundation.org> =
wrote:

On Wed, 13 Oct 2010 11:27:18 -0400
Mark Liggett <mliggett@btisystems.com> wrote:

> Hi everyone,
>
> I'm using Ethernet bridging on an up-to-date F13 system.  I've created a =
bridge adapter br0 and added eth2 and eth3 to it.  Everything works as expe=
cted for a short time before the 2 Ethernet cards used in the bridge start =
reporting millions of errors.  I confirmed this is the case on 2 separate s=
ystems (although both systems use Intel NICs).  To try to resolve this I've=
:
>
> - Compiled and installed the latest Intel igb driver 2.3.4
> - Installed the latest Fedora kernel 2.6.34.7-56
> - Uninstalled the standard bridge-utils 1.2-9, before compiling and insta=
lling version 1.4
>
> I've pastebin'd the system config here:  http://pastebin.ca/1960777
>
> You can see the errors listed on eth2 and eth3.  I've tried both setting =
the bridge up using /etc/sysconfig/network-scripts as well as manually (usi=
ng brctl and ifconfig).
>
> My bridge/Ethernet interface configs are listed here: http://pastebin.ca/=
1960790
>
> Any suggestions would be greatly appreciated.
>
> Thanks,
>
> Mark

You might also be creating a packet loop?
Turn on spanning tree and find out.

--


--_000_C8DCE7B769A7mliggettbtisystemscom_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<HTML>
<HEAD>
<TITLE>Re: [Bridge] F13 bridge issues</TITLE>
</HEAD>
<BODY>
<FONT FACE=3D"Tahoma, Verdana, Helvetica, Arial"><SPAN STYLE=3D'font-size:1=
1pt'>Hi Stephen,<BR>
<BR>
As you suspected, I believe the igb driver is at fault &#8211; I configured=
 a bridge on the same machine using onboard tg3 cards. &nbsp;<BR>
<BR>
The bridge worked fine and the fault did not occur until I SCP&#8217;d a fi=
le to the server on the igb card. &nbsp;After which the bridge continued to=
 work fine.<BR>
<BR>
Thanks for your help.<BR>
<BR>
Mark<BR>
<BR>
<BR>
On 13/10/2010 16:46, &quot;Stephen Hemminger&quot; &lt;<a href=3D"shemminge=
r@linux-foundation.org">shemminger@linux-foundation.org</a>&gt; wrote:<BR>
<BR>
</SPAN></FONT><BLOCKQUOTE><FONT FACE=3D"Tahoma, Verdana, Helvetica, Arial">=
<SPAN STYLE=3D'font-size:11pt'>On Wed, 13 Oct 2010 11:27:18 -0400<BR>
Mark Liggett &lt;<a href=3D"mliggett@btisystems.com">mliggett@btisystems.co=
m</a>&gt; wrote:<BR>
<BR>
&gt; Hi everyone,<BR>
&gt;<BR>
&gt; I'm using Ethernet bridging on an up-to-date F13 system. &nbsp;I've cr=
eated a bridge adapter br0 and added eth2 and eth3 to it. &nbsp;Everything =
works as expected for a short time before the 2 Ethernet cards used in the =
bridge start reporting millions of errors. &nbsp;I confirmed this is the ca=
se on 2 separate systems (although both systems use Intel NICs). &nbsp;To t=
ry to resolve this I've:<BR>
&gt;<BR>
&gt; - Compiled and installed the latest Intel igb driver 2.3.4<BR>
&gt; - Installed the latest Fedora kernel 2.6.34.7-56<BR>
&gt; - Uninstalled the standard bridge-utils 1.2-9, before compiling and in=
stalling version 1.4<BR>
&gt;<BR>
&gt; I've pastebin'd the system config here: &nbsp;<a href=3D"http://pasteb=
in.ca/1960777">http://pastebin.ca/1960777</a><BR>
&gt;<BR>
&gt; You can see the errors listed on eth2 and eth3. &nbsp;I've tried both =
setting the bridge up using /etc/sysconfig/network-scripts as well as manua=
lly (using brctl and ifconfig).<BR>
&gt;<BR>
&gt; My bridge/Ethernet interface configs are listed here: <a href=3D"http:=
//pastebin.ca/1960790">http://pastebin.ca/1960790</a><BR>
&gt;<BR>
&gt; Any suggestions would be greatly appreciated.<BR>
&gt;<BR>
&gt; Thanks,<BR>
&gt;<BR>
&gt; Mark<BR>
<BR>
You might also be creating a packet loop?<BR>
Turn on spanning tree and find out.<BR>
<BR>
--<BR>
<BR>
</SPAN></FONT></BLOCKQUOTE>
</BODY>
</HTML>


--_000_C8DCE7B769A7mliggettbtisystemscom_--
