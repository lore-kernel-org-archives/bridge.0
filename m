MIME-Version: 1.0
In-Reply-To: <20110215080334.1fbc5357@nehalam>
References: <OF0ED85024.3389DB4D-ON8525782D.0054FDD2-8525782D.00597D7B@us.ibm.com>
	<20110215080334.1fbc5357@nehalam>
From: Andrew Woods <drew.woods@gmail.com>
Date: Wed, 16 Feb 2011 14:33:12 +0200
Message-ID: <AANLkTikRLJJxbQdvDDYTLt-pYpgc2BW5HxCpPpLJad5t@mail.gmail.com>
Content-Type: multipart/alternative; boundary=0016364d23db2c9ba3049c657dea
Subject: Re: [Bridge] Problem configuring bridge as a hub between host
 server and running VM guest
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: bridge@lists.linux-foundation.org, Ravi Varun Nair <rvnair@us.ibm.com>

--0016364d23db2c9ba3049c657dea
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I'm wanting to do something similar (mirror certain frames on a physical
interface to a tap device). I've never use tc before, but it seems it only
works on the L3 packet level, does it also work with all L2 frames (eg STP),
or will I need to use something like ebtables?

Thanks,
Drew

On Tue, Feb 15, 2011 at 6:03 PM, Stephen Hemminger <
shemminger@linux-foundation.org> wrote:

> On Fri, 4 Feb 2011 11:17:29 -0500
> Ravi Varun Nair <rvnair@us.ibm.com> wrote:
>
> > What I am trying to do is have a copy of all the traffic coming in on the
> > physical interface be given to the VM. T
>
> A better way is to use tc mirred action to mirror packets to a dummy or
> other
> interface.
>
> --
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>

--0016364d23db2c9ba3049c657dea
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<div><br></div><div>I&#39;m wanting to do something similar (mirror cert=
ain frames on a physical interface to a tap device). I&#39;ve never use tc =
before, but it seems it only works on the L3 packet level, does it also wor=
k with all L2 frames (eg STP), or will I need to use something like ebtable=
s?</div>

<div><br></div><div>Thanks,</div><div>Drew<br><br><div class=3D"gmail_quote=
">On Tue, Feb 15, 2011 at 6:03 PM, Stephen Hemminger <span dir=3D"ltr">&lt;=
<a href=3D"mailto:shemminger@linux-foundation.org">shemminger@linux-foundat=
ion.org</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><div class=3D"im">On Fri, 4 Feb 2011 11:17:=
29 -0500<br>
Ravi Varun Nair &lt;<a href=3D"mailto:rvnair@us.ibm.com">rvnair@us.ibm.com<=
/a>&gt; wrote:<br>
<br>
&gt; What I am trying to do is have a copy of all the traffic coming in on =
the<br>
&gt; physical interface be given to the VM. T<br>
<br>
</div>A better way is to use tc mirred action to mirror packets to a dummy =
or other<br>
interface.<br>
<font color=3D"#888888"><br>
--<br>
_______________________________________________<br>
Bridge mailing list<br>
<a href=3D"mailto:Bridge@lists.linux-foundation.org">Bridge@lists.linux-fou=
ndation.org</a><br>
<a href=3D"https://lists.linux-foundation.org/mailman/listinfo/bridge" targ=
et=3D"_blank">https://lists.linux-foundation.org/mailman/listinfo/bridge</a=
><br>
</font></blockquote></div><br></div>

--0016364d23db2c9ba3049c657dea--
