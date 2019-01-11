Return-Path: <mjevans1983@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=CAmCs75VRiQn8qgxsxx6ZRZVXZ0oMk1gTlOcy8ipYqI=;
	b=B5ncXoNqg3rkv2iPRKpVzrsxbE2hhTVhMbnKp5GwlrpagiYP6p/Wk3zdafIe5kRo0b
	hLlAoWczYBaysN4UTt2AT4KF2WWqib9E9lVo3UKOFrxgQBqZis3UY5h5Lq6s6AeaWtC2
	yBV0k5weHXrGZ+iU+iyN1aa1vA6R74BSn+1CGJr7GmwZrMOl9WToqd3eURS8H7qB9UMd
	AnkGrt+XnLOPYHWq4ruwPktX9NZh6gL3o4OWSjVPzHJ053T2FLaNGJHGNYfu4QUItzNK
	nSAbKAuM459aHDdkb48L7BDFrvKIvoBDd+ARkL1P41kAhRCgBsuclVSaaBJWvEhdXq64
	6ksw==
MIME-Version: 1.0
From: Michael Evans <mjevans1983@gmail.com>
Date: Fri, 11 Jan 2019 15:04:51 -0800
Message-ID: <CABp5QGJ79E-o5K9zoWKOCP0-pYzkMxoy2wHc_76p=QOL2tFUUw@mail.gmail.com>
Content-Type: multipart/alternative; boundary="000000000000972ef0057f36b963"
Subject: [Bridge] regression in 4.20.0: physical to VETH (LXC) network
 bridge (unsure if cgroups is related)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: 

--000000000000972ef0057f36b963
Content-Type: text/plain; charset="UTF-8"

I have since reverted to the working LTS kernel image offered by Arch Linux
(4.19.13), but am willing to re-test / gather data additional data on a
couple lower-use time periods during the week.

After updating to Linux 4.20.0 (along with a full system update otherwise)
my BRIDGED network connections to some LXC containers ceased working.

Attempting to troubleshoot this issue also produced extremely odd results,
which I think offhand MIGHT have caused network packets to fill up some
kind of memory buffer instead of being relaid or dropped; there are some
additional details at the serverfault and LXC bugs that I filed, as it was
initially (and still is) unclear where the actual issue is.

-

At this time I am unsure if it is related to netdev (bridge, veth),
cgroups, or some changed default that should now be configured in a way
that is different to previous defaults.

https://serverfault.com/questions/947848/linux-bridge-broken-after-upgrade-out-of-ideas-places-to-look-now-4-20-0-arc


https://github.com/lxc/lxc/issues/2769

Also now filed: https://bugzilla.kernel.org/show_bug.cgi?id=202235

* It is NOT related to IP forwarding.  This is a BRIDGED connection, not a
routed one, and it works on older kernels without that enabled.

* physical network to bridge works (and will stay connected for a few min
after later troubleshooting steps, even if ARP caches / ping flake out and
stop responding)

* VETH (within LXC) can ping the the host IP on the bridge (but not the
gateway, the host can before this step) if manually assigned a static
address.  Doing this seems to cause general instability and a timed out SSH
session.  This lead me to reboot between each round of testing to ensure I
had a clean slate to start with.

I went over the major settings that I did check in the other two bug
reports, but I'm open to checking other values and/or performing different
kinds of tests occasionally over a given week.  Responses won't be
immediate but I'll try to check on this frequently over the next two weeks.

--000000000000972ef0057f36b963
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I have since reverted to the working LTS kernel image=
 offered by Arch Linux (4.19.13), but am willing to re-test / gather data a=
dditional data on a couple lower-use time periods during the week.=C2=A0=C2=
=A0<br></div><div>=C2=A0=C2=A0</div><div>After updating to Linux 4.20.0 (al=
ong with a full system update otherwise) my BRIDGED network connections to =
some LXC containers ceased working.=C2=A0=C2=A0</div><div>=C2=A0=C2=A0</div=
><div>Attempting to troubleshoot this issue also produced extremely odd res=
ults, which I think offhand MIGHT have caused network packets to fill up so=
me kind of memory buffer instead of being relaid or dropped; there are some=
 additional details at the serverfault and LXC bugs that I filed, as it was=
 initially (and still is) unclear where the actual issue is.=C2=A0=C2=A0</d=
iv><div>=C2=A0=C2=A0</div><div>-=C2=A0=C2=A0</div><div>=C2=A0=C2=A0</div><d=
iv>At this time I am unsure if it is related to netdev (bridge, veth), cgro=
ups, or some changed default that should now be configured in a way that is=
 different to previous defaults.=C2=A0=C2=A0</div><div>=C2=A0=C2=A0</div><d=
iv><a href=3D"https://serverfault.com/questions/947848/linux-bridge-broken-=
after-upgrade-out-of-ideas-places-to-look-now-4-20-0-arc">https://serverfau=
lt.com/questions/947848/linux-bridge-broken-after-upgrade-out-of-ideas-plac=
es-to-look-now-4-20-0-arc</a>=C2=A0=C2=A0</div><div>=C2=A0=C2=A0</div><div>=
<a href=3D"https://github.com/lxc/lxc/issues/2769">https://github.com/lxc/l=
xc/issues/2769</a>=C2=A0=C2=A0</div><div><br></div><div>Also now filed:=C2=
=A0<a href=3D"https://bugzilla.kernel.org/show_bug.cgi?id=3D202235">https:/=
/bugzilla.kernel.org/show_bug.cgi?id=3D202235</a></div><div>=C2=A0=C2=A0</d=
iv><div>* It is NOT related to IP forwarding.=C2=A0 This is a BRIDGED conne=
ction, not a routed one, and it works on older kernels without that enabled=
.=C2=A0=C2=A0</div><div>=C2=A0=C2=A0</div><div>* physical network to bridge=
 works (and will stay connected for a few min after later troubleshooting s=
teps, even if ARP caches / ping flake out and stop responding)=C2=A0=C2=A0<=
/div><div>=C2=A0=C2=A0</div><div>* VETH (within LXC) can ping the the host =
IP on the bridge (but not the gateway, the host can before this step) if ma=
nually assigned a static address.=C2=A0 Doing this seems to cause general i=
nstability and a timed out SSH session.=C2=A0 This lead me to reboot betwee=
n each round of testing to ensure I had a clean slate to start with.=C2=A0=
=C2=A0</div><div>=C2=A0=C2=A0</div><div>I went over the major settings that=
 I did check in the other two bug reports, but I&#39;m open to checking oth=
er values and/or performing different kinds of tests occasionally over a gi=
ven week.=C2=A0 Responses won&#39;t be immediate but I&#39;ll try to check =
on this frequently over the next two weeks.</div></div>

--000000000000972ef0057f36b963--
