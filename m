MIME-Version: 1.0
In-Reply-To: <4A3824E8.5010905@vodafone.it>
References: <4A3824E8.5010905@vodafone.it>
Date: Wed, 17 Jun 2009 23:26:40 -0500
Message-ID: <2e59e6970906172126x51a7b0c1k8320079bf2d8854b@mail.gmail.com>
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Content-Type: multipart/alternative; boundary=001485f630967cb59d046c97d023
Subject: Re: [Bridge] bridge problem
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Paolo NOTARI <paolo_notari@vodafone.it>
Cc: bridge@osdl.org

--001485f630967cb59d046c97d023
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Tue, Jun 16, 2009 at 6:04 PM, Paolo NOTARI <paolo_notari@vodafone.it>wrote:

> Hello,
>
> I have these two card that I'm trying to use in a bridge :
>
> nVidia Corporation MCP67 Ethernet (rev a2)
> Davicom Semiconductor, Inc. 21x4x DEC-Tulip compatible 10/100 Ethernet (rev
> 31)
>
> Bridge works if nvidia is the LAN side and Davicom on WAN side, but no way
> to get bridge working if nvidia is on LAN and Davicom on WAN -


I have no clue what you're talking about.  The bridge logic treats all ports
exactly the same, except when it comes to spanning tree choosing one to shut
down when it detects a link.  Beyond that, your "working" and "not working"
don't seem to be different.

Are you sure you are using bridging, and not routing or NAT?


>
>
> Driver for Davicom is dmfe; with driver Tulip interface isn't even added to
> bridge
>
> Paolo
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>

--001485f630967cb59d046c97d023
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Tue, Jun 16, 2009 at 6:04 PM, Paolo N=
OTARI <span dir=3D"ltr">&lt;<a href=3D"mailto:paolo_notari@vodafone.it">pao=
lo_notari@vodafone.it</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x;">
Hello,<br>
<br>
I have these two card that I&#39;m trying to use in a bridge :<br>
<br>
nVidia Corporation MCP67 Ethernet (rev a2)<br>
Davicom Semiconductor, Inc. 21x4x DEC-Tulip compatible 10/100 Ethernet (rev=
 31)<br>
<br>
Bridge works if nvidia is the LAN side and Davicom on WAN side, but no way =
to get bridge working if nvidia is on LAN and Davicom on WAN -</blockquote>=
<div><br></div><div>I have no clue what you&#39;re talking about. =A0The br=
idge logic treats all ports exactly the same, except when it comes to spann=
ing tree choosing one to shut down when it detects a link. =A0Beyond that, =
your &quot;working&quot; and &quot;not working&quot; don&#39;t seem to be d=
ifferent.</div>
<div><br></div><div>Are you sure you are using bridging, and not routing or=
 NAT?</div><div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;"><br>
<br>
Driver for Davicom is dmfe; with driver Tulip interface isn&#39;t even adde=
d to bridge<br><font color=3D"#888888">
<br>
Paolo<br>
</font><br>_______________________________________________<br>
Bridge mailing list<br>
<a href=3D"mailto:Bridge@lists.linux-foundation.org">Bridge@lists.linux-fou=
ndation.org</a><br>
<a href=3D"https://lists.linux-foundation.org/mailman/listinfo/bridge" targ=
et=3D"_blank">https://lists.linux-foundation.org/mailman/listinfo/bridge</a=
><br></blockquote></div><br>

--001485f630967cb59d046c97d023--
