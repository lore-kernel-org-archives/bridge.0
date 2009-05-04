MIME-Version: 1.0
In-Reply-To: <45a1b53e0905040747p48466d3aye289314499c01a2e@mail.gmail.com>
References: <45a1b53e0905040747p48466d3aye289314499c01a2e@mail.gmail.com>
Date: Mon, 4 May 2009 18:40:53 -0500
Message-ID: <2e59e6970905041640q55c60531j7355e9522dff773a@mail.gmail.com>
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Content-Type: multipart/alternative; boundary=001485f7d7fe75fdf304691eb179
Subject: Re: [Bridge] /dev/tap on uClinux and bridging
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Wade Maxfield <wmaxfield@gmail.com>
Cc: Bridge@lists.linux-foundation.org

--001485f7d7fe75fdf304691eb179
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

You should probably just use libpcap to receive all packets from each
interface, and SOCK_RAW to send.  This should be a more efficient of getting
packets to usermode than using bridging.

On Mon, May 4, 2009 at 9:47 AM, Wade Maxfield <wmaxfield@gmail.com> wrote:

>
>   I'm trying to use bridging and TUN/TAP on uClinux on Nios processor, on
> an Altera fpga.
>
>   I downloaded the source for tunctl and it compiled and runs just fine.
>
>   It says it created tap0, tap1, tap2, etc., but they don't show up in the
> /dev directory.
>
>    I'm assuming because there is no demon to create these entries.
>
>    I looked at Ubuntu, and saw the /dev/tapx entries are major, minor
> 36,16.
>
>   However, the /dev/net/tun in the uClinux is 200,10.
>
>    My question is this: If I create /dev/tap0 in the /dev directory, which
> Major,Minor number should I give it?
>
>    I'm a little fuzzy on this.  I'm assuming if the Major/Minor numbers are
> wrong, the brctl program won't be able to use the tap0 interface.
>
>    I want to do this, ultimately:
>
>   [ethernet]----[kernel bridge]---[tap]---(user program)------data
> link------(user program)---[tap]---[kernel bridge]--[ethernet]
>
>   The data link is non standard and proprietary.  The goal is to bridge the
> two ethernets.
>
>   Can someone give me some heads up?  Any pointers would be appreciated!!!
>
> thanks,
> Wade
>
>
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>

--001485f7d7fe75fdf304691eb179
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

You should probably just use libpcap to receive all packets from each inter=
face, and SOCK_RAW to send.=A0 This should be a more efficient of getting p=
ackets to usermode than using bridging.<br><br><div class=3D"gmail_quote">O=
n Mon, May 4, 2009 at 9:47 AM, Wade Maxfield <span dir=3D"ltr">&lt;<a href=
=3D"mailto:wmaxfield@gmail.com">wmaxfield@gmail.com</a>&gt;</span> wrote:<b=
r>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>=A0 I&#39;m t=
rying to use bridging and TUN/TAP on uClinux on Nios processor, on an Alter=
a fpga.<br>
<br>=A0 I downloaded the source for tunctl and it compiled and runs just fi=
ne.=A0 <br><br>=A0 It says it created tap0, tap1, tap2, etc., but they don&=
#39;t show up in the /dev directory.<br>
<br>=A0=A0 I&#39;m assuming because there is no demon to create these entri=
es.<br><br>=A0=A0 I looked at Ubuntu, and saw the /dev/tapx entries are maj=
or, minor 36,16.=A0 <br><br>=A0 However, the /dev/net/tun in the uClinux is=
 200,10.<br>

<br>=A0=A0 My question is this: If I create /dev/tap0 in the /dev directory=
, which Major,Minor number should I give it?<br><br>=A0=A0 I&#39;m a little=
 fuzzy on this.=A0 I&#39;m assuming if the Major/Minor numbers are wrong, t=
he brctl program won&#39;t be able to use the tap0 interface.<br>

<br>=A0=A0 I want to do this, ultimately:<br><br>=A0 [ethernet]----[kernel =
bridge]---[tap]---(user program)------data link------(user program)---[tap]=
---[kernel bridge]--[ethernet]<br><br>=A0 The data link is non standard and=
 proprietary.=A0 The goal is to bridge the two ethernets.<br>

<br>=A0 Can someone give me some heads up?=A0 Any pointers would be appreci=
ated!!!<br><br>thanks,<br><font color=3D"#888888">Wade<br><br>=A0 <br>
</font><br>_______________________________________________<br>
Bridge mailing list<br>
<a href=3D"mailto:Bridge@lists.linux-foundation.org">Bridge@lists.linux-fou=
ndation.org</a><br>
<a href=3D"https://lists.linux-foundation.org/mailman/listinfo/bridge" targ=
et=3D"_blank">https://lists.linux-foundation.org/mailman/listinfo/bridge</a=
><br></blockquote></div><br>

--001485f7d7fe75fdf304691eb179--
