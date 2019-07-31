Return-Path: <jeclark2006@aim.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aim.com; s=a2048;
	t=1564600544; bh=Xf6EC8BZEYPRUd/RHRAnCys6BP1a6r+eNkdmdNo0RJw=;
	h=From:Subject:Date:To:From:Subject;
	b=oKsvsxV93lL7BynaeGraHqjISzbVenF1qk7sbOAF5KK1oRUmI2xFbF13ijuECIxjbgldw8j/xMW3t1TPqIkJT/QidrR2QgWof+uKiTNwQm2/QrsIjuiuIfBLQDSJJYOd5nwvFRNO/w/MSVBEdMp4zDsDzl+J2sJtMZRqLKgRPrnB1phRwd0UWA3i8BrgfwYCdn4MSMEat1HqfQUs26Z1puOmhU0Ak2zk65+DxBY+6bVaUlJRZ/qtqPG7xAuep5/YbimE8p44vAISfIA0WiMxMwycvt7u38LpYz6+a6/LPIOby9Cb5QMAywhGNfn8HaIgSBtXQPQfEhPbWrOrL+mHyg==
From: John Clark <jeclark2006@aim.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Message-Id: <A23F6E83-0634-4BFA-AE82-DA947D3544CF@aim.com>
Date: Wed, 31 Jul 2019 11:55:37 -0700
Subject: [Bridge] Split path for packets, and bridge configuration problem.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org


I=E2=80=99m trying to configure a Linux system to bridge an ethernet =
link for packet ingress from a local network and combine that with a =
radio link for the reply packet egress.

I vaguely recall something like this use to be used for Satellite links, =
where the incoming packets from the outside world were via the Sat link, =
but outgoing packets were via a terrestrial link, phone modem or DSL, =
depending.

What I have working is the packet entering the bridge on the ethernet =
link, then I see the MAC address of the node from the in the =E2=80=98brid=
ge show=E2=80=99 output, but even if I assign the MAC address to the =
=E2=80=98radio=E2=80=99 tap interface, I see both the =E2=80=98ethernet=E2=
=80=99 port as =E2=80=98master=E2=80=99, and the tap device as =
=E2=80=98self=E2=80=99, but no packets are sent to the tap device.

In the past I=E2=80=99ve just written user apps that basically implement =
tunnels and using collection of such apps and taps, gotten packets to =
where I need them to be.

I was trying to use more standard tools, and not write more custom code.

Thanks for any assistance.
John Clark.

