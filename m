MIME-Version: 1.0
In-Reply-To: <e6e2252e0905061032pc4bf5cfjb9eb32379d8e6323@mail.gmail.com>
References: <e6e2252e0905061032pc4bf5cfjb9eb32379d8e6323@mail.gmail.com>
Date: Thu, 7 May 2009 11:37:29 -0500
Message-ID: <45a1b53e0905070937q13f7b361tbf258f4a11158f39@mail.gmail.com>
From: Wade Maxfield <wmaxfield@gmail.com>
Content-Type: multipart/alternative; boundary=0016e6470ab0bd08c604695520bd
Subject: Re: [Bridge] PPP and Ethernet Half-bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrew Watts <systemstalker@gmail.com>
Cc: bridge@lists.linux-foundation.org

--0016e6470ab0bd08c604695520bd
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

  check out Openvpn.  It uses bridging and the tap interface to bridge into
user space, which can then go through ppp.  You may have to compile some
stuff for your box.

wade


On Wed, May 6, 2009 at 12:32 PM, Andrew Watts <systemstalker@gmail.com>wrote:

> Hi,
>
> I have a cellular modem that configures a ppp interface for IP
> communication.  I would like to bridge the ppp and Ethernet interface
> together.  brctl does not allow for bridging between ppp and ethernet
> interface.  I expect this mainly due to the fact that I am trying to
> bridge 2 different layer 2 protocols, PPP and Ethernet.  I have seen
> mention that many ADSL routers support "half bridge mode" or "ZIPB"
> (Zero IP Bridge), this is also called IP-Passthrough.  Basically I
> need a device that works like a modem such that the Public IP address
> that the modem receives from the ISP is passed trough and assigned to
> a node (router or SINGLE host).  One of the devices I want to connect
> doesn't play well with NAT nor does it have the ability to support
> PPPoE/USB Modems.  I am also trying to make a secondary modem as a
> failover connection that uses a 3G modem.  A company by the name of
> cradlepoint sells a device that does this called the CBA250.  I have a
> Linksys NSLU2 that would be PERFECT for this, I just don't know how to
> do it.  If possible I would also like to be able to firewall a little
> too.
>
> http://www.evdoinfo.com/content/view/2601/64/
>
> I want to do this to, just with Linux.  What code should I look at to
> do this or is there a way to configure the system to do what I want.
> In a perfect world ppp and ethernet would bridge and play nice but its
> not.  Any advice would be greatly appreciated.  I am more than willing
> to write code to get this to work but I'm pretty new to this and have
> no idea where to even start.
>
> Thanks
>
> Andrew
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>

--0016e6470ab0bd08c604695520bd
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

=A0 check out Openvpn.=A0 It uses bridging and the tap interface to bridge =
into user space, which can then go through ppp.=A0 You may have to compile =
some stuff for your box.<br><br>wade<br><br><br><div class=3D"gmail_quote">=
On Wed, May 6, 2009 at 12:32 PM, Andrew Watts <span dir=3D"ltr">&lt;<a href=
=3D"mailto:systemstalker@gmail.com">systemstalker@gmail.com</a>&gt;</span> =
wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi,<br>
<br>
I have a cellular modem that configures a ppp interface for IP<br>
communication. =A0I would like to bridge the ppp and Ethernet interface<br>
together. =A0brctl does not allow for bridging between ppp and ethernet<br>
interface. =A0I expect this mainly due to the fact that I am trying to<br>
bridge 2 different layer 2 protocols, PPP and Ethernet. =A0I have seen<br>
mention that many ADSL routers support &quot;half bridge mode&quot; or &quo=
t;ZIPB&quot;<br>
(Zero IP Bridge), this is also called IP-Passthrough. =A0Basically I<br>
need a device that works like a modem such that the Public IP address<br>
that the modem receives from the ISP is passed trough and assigned to<br>
a node (router or SINGLE host). =A0One of the devices I want to connect<br>
doesn&#39;t play well with NAT nor does it have the ability to support<br>
PPPoE/USB Modems. =A0I am also trying to make a secondary modem as a<br>
failover connection that uses a 3G modem. =A0A company by the name of<br>
cradlepoint sells a device that does this called the CBA250. =A0I have a<br=
>
Linksys NSLU2 that would be PERFECT for this, I just don&#39;t know how to<=
br>
do it. =A0If possible I would also like to be able to firewall a little<br>
too.<br>
<br>
<a href=3D"http://www.evdoinfo.com/content/view/2601/64/" target=3D"_blank"=
>http://www.evdoinfo.com/content/view/2601/64/</a><br>
<br>
I want to do this to, just with Linux. =A0What code should I look at to<br>
do this or is there a way to configure the system to do what I want.<br>
In a perfect world ppp and ethernet would bridge and play nice but its<br>
not. =A0Any advice would be greatly appreciated. =A0I am more than willing<=
br>
to write code to get this to work but I&#39;m pretty new to this and have<b=
r>
no idea where to even start.<br>
<br>
Thanks<br>
<br>
Andrew<br>
_______________________________________________<br>
Bridge mailing list<br>
<a href=3D"mailto:Bridge@lists.linux-foundation.org">Bridge@lists.linux-fou=
ndation.org</a><br>
<a href=3D"https://lists.linux-foundation.org/mailman/listinfo/bridge" targ=
et=3D"_blank">https://lists.linux-foundation.org/mailman/listinfo/bridge</a=
><br>
</blockquote></div><br><br>

--0016e6470ab0bd08c604695520bd--
