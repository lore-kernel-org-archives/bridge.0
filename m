Date: Fri, 18 Feb 2005 10:32:04 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Re: Problems using kernel 2.6
Message-ID: <20050218103204.32c8ace7@dxpl.pdx.osdl.net>
In-Reply-To: <200502170821.AA177209998@fox-netcenter.de>
References: <200502170821.AA177209998@fox-netcenter.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: m.juette@fox-netcenter.de
Cc: bridge@osdl.org

On Thu, 17 Feb 2005 08:21:56 +0100
"Marc Juette" <m.juette@fox-netcenter.de> wrote:

>=20
> Hello, I=B4m writing to you, because i=B4ve had the same problem with SuS=
E 9.2 and bridging. I tested a few setting (bridging as module, bridging co=
mpiled within Kernel...), but nothing matched. So I decided to install 9.1 =
and test again. And wow, it worked with only a few command lines:
>=20
> required:
> -SuSE 9.1 minimal installation
> -become root
>=20
> commands:
> yast -i bridge-utils
> ifconfig eth0 0.0.0.0
> ifconfig eth1 0.0.0.0
> brctl addbr br0
> brctl addif br0 eth0
> brctl addif br0 eth1
> ifconfig br0 up
>=20
> So it seems to be a bug in 9.2, but i=B4ve no time to figure out yet.
> I hope this helps. I will test some new Kernel on these settings the next=
 days. If you=B4re intreseted about results, let me know, i will send you m=
y logs, or everything that will help you.

First, make sure that devices are not being automatically started by system=
 at startup or hot-plug.
Go in with Yast and make sure eth0 and eth1 are configured to start manuall=
y.
Then use a script to setup the bridge (as per above).

I haven't looked at what sort of initialization Suse does for bridges throu=
gh Yast,
because every distro is different.

When you say it doesn't work, what do you mean, system crashes? packets are=
n't bridged? devices aren't up?

What you should look at is the output of brctl status commands.
Best to wait till after the initial learning period and do:
 brctl show br0
 brctl showstp br0
 brctl showmacs br0



