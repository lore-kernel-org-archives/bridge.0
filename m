MIME-Version: 1.0
In-Reply-To: <45a1b53e0905040747p48466d3aye289314499c01a2e@mail.gmail.com>
References: <45a1b53e0905040747p48466d3aye289314499c01a2e@mail.gmail.com>
Date: Tue, 5 May 2009 20:11:48 +0000
Message-ID: <fed120860905051311x7b5d239bma1fd1820c27d1e3a@mail.gmail.com>
From: "Srinivas M.A." <srinivas.aji@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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

Network interfaces don't show up in /dev in Linux anyway. When tap0,
tap1, etc are created, they will show up in "ifconfig -a" and you can
add them to bridges at that point. /dev/net/tun should be the only
thing you need in /dev.

I think /dev/tapX is an older interface.

If your user program is trying to use the /dev/tapX devices, you could
modify it to use /dev/net/tun and connect to the right device using
the ioctl as described in Documentation/tuntap.txt in the Linux
source.

On Mon, May 4, 2009 at 2:47 PM, Wade Maxfield <wmaxfield@gmail.com> wrote:
>
> =A0 I'm trying to use bridging and TUN/TAP on uClinux on Nios processor, =
on an
> Altera fpga.
>
> =A0 I downloaded the source for tunctl and it compiled and runs just fine=
.
>
> =A0 It says it created tap0, tap1, tap2, etc., but they don't show up in =
the
> /dev directory.
>
> =A0=A0 I'm assuming because there is no demon to create these entries.
>
> =A0=A0 I looked at Ubuntu, and saw the /dev/tapx entries are major, minor
> 36,16.
>
> =A0 However, the /dev/net/tun in the uClinux is 200,10.
>
> =A0=A0 My question is this: If I create /dev/tap0 in the /dev directory, =
which
> Major,Minor number should I give it?
>
> =A0=A0 I'm a little fuzzy on this.=A0 I'm assuming if the Major/Minor num=
bers are
> wrong, the brctl program won't be able to use the tap0 interface.
>
> =A0=A0 I want to do this, ultimately:
>
> =A0 [ethernet]----[kernel bridge]---[tap]---(user program)------data
> link------(user program)---[tap]---[kernel bridge]--[ethernet]
>
> =A0 The data link is non standard and proprietary.=A0 The goal is to brid=
ge the
> two ethernets.
>
> =A0 Can someone give me some heads up?=A0 Any pointers would be appreciat=
ed!!!
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
