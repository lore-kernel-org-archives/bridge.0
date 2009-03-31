Date: Tue, 31 Mar 2009 13:50:38 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20090331135038.6f5fc421@nehalam>
In-Reply-To: <20090330180331.4d2307d7@nehalam>
References: <950276.72949.qm@web8805.mail.in.yahoo.com>
	<20090330180331.4d2307d7@nehalam>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] BRCTL is displaying only 32 bridge interfaces even
 /proc/net/dev is showing more then that
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: bridge@lists.linux-foundation.org, rahul bhardwaj <rahul_bhardwaj36in@yahoo.co.in>

On Mon, 30 Mar 2009 18:03:31 -0700
Stephen Hemminger <shemminger@vyatta.com> wrote:

> On Fri, 20 Mar 2009 15:15:50 +0530 (IST)
> rahul bhardwaj <rahul_bhardwaj36in@yahoo.co.in> wrote:
>=20
> > Hi All,
> > I am using Linux 2.6.15 kernel. I want to create 4094 bridge interface =
but I am able to see only 32 bridge interfaces with the help of "brctl show=
". I am able see other interfaces into /proc/net/dev but brctl is not showi=
ng more then 32. It is also not allowing any operations (add/del) over thos=
e interfaces. Is it correct behaviour or I have do some changes in some set=
tings.=C2=A0
> > Could anybody please help me in this?=C2=A0
> >=20
> 2.6.15 is old, so I could well be wrong, but as I remember:
> The old interface (via ioctl) only had room for 32 bridges, so probably t=
hat
> was it. When interface changed to sysfs that was addressed.
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>=20

Did you try updating the bridge utils. The older versions had MAX_BRIDGES
defined as 32, and the code was written such that it read the whole configu=
ration
multiple times.

Current code has MAX_BRIDGES=3D1024, but that is only used on older kernels
that don't support sysfs.  With sysfs the interface just walks the contents
of /sys/class/net and that can handle as many interfaces as you have memory=
 for.

No kernel change should be needed.
