Return-Path: <mjevans1983@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=z9kde7D2DSUtiFR/9oAyV3R+IfHKH+NS1oIYBo5Xen0=;
	b=dMFH5tQoSzIo/K66p99SDIh716jUKU7N0tGlTFfvGZAa1GKdpY5bY+K5gETsKBSmkE
	Cjr/zsG7llWuF5ODcW+/CuuYHIAdeJdTZ4HFLfokPqpz0g8KP1BzArccsm52FeNbchlm
	KR8a6s+e50sHjumQJ00rSLH0ZZO46q+qyH3VlTbnQZSH6uixwiccbLgfRggod06Vm1EH
	vrE70q9opdq1ZwyobN5Ie7RdoQDFEkv3/wpWMk219fypujTKhO/lGQDWsmTrhqFZXkgO
	cv9sunKmNFBdh09oOT38mdJF9u4GvTQogzavTMvuuOaFvr01BV83FCtwdT6WlTs+E6J2
	OPTQ==
MIME-Version: 1.0
From: Michael Evans <mjevans1983@gmail.com>
Date: Fri, 11 Jan 2019 19:59:49 -0800
Message-ID: <CABp5QGLyBwLJoEcKC=BNKfgUuuA46TQ58Luw-8M4PwcSE5Wumw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

I have since reverted to the working LTS kernel image offered by Arch
Linux (4.19.13), but am willing to re-test / gather data additional
data on a couple lower-use time periods during the week.


After updating to Linux 4.20.0 (along with a full system update
otherwise) my BRIDGED network connections to some LXC containers
ceased working.

Attempting to troubleshoot this issue also produced extremely odd
results, which I think offhand MIGHT have caused network packets to
fill up some kind of memory buffer instead of being relaid or dropped;
there are some additional details at the serverfault and LXC bugs that
I filed, as it was initially (and still is) unclear where the actual
issue is.

-

At this time I am unsure if it is related to netdev (bridge, veth),
cgroups, or some changed default that should now be configured in a
way that is different to previous defaults.

https://serverfault.com/questions/947848/linux-bridge-broken-after-upgrade-out-of-ideas-places-to-look-now-4-20-0-arc

https://github.com/lxc/lxc/issues/2769


Also now filed: https://bugzilla.kernel.org/show_bug.cgi?id=202235

* It is NOT related to IP forwarding. This is a BRIDGED connection,
not a routed one, and it works on older kernels without that enabled.

* physical network to bridge works (and will stay connected for a few
min after later troubleshooting steps, even if ARP caches / ping flake
out and stop responding)

* VETH (within LXC) can ping the the host IP on the bridge (but not
the gateway, the host can before this step) if manually assigned a
static address. Doing this seems to cause general instability and a
timed out SSH session. This lead me to reboot between each round of
testing to ensure I had a clean slate to start with.

I went over the major settings that I did check in the other two bug
reports, but I'm open to checking other values and/or performing
different kinds of tests occasionally over a given week. Responses
won't be immediate but I'll try to check on this frequently over the
next two weeks.
