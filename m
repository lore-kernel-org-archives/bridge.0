Return-Path: <teco@inf-net.nl>
From: Teco Boot <teco@inf-net.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Oct 2011 19:33:43 +0200
Message-Id: <58E37099-6A87-4E5F-872C-BEB27D821682@inf-net.nl>
Mime-Version: 1.0 (Apple Message framework v1084)
Subject: [Bridge] Bridge down when all ports are down
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

I have problems much like earlier postings:
 - Bridge interface always down since Linux >=3D 2.6.39
   =
http://lists.linuxfoundation.org/pipermail/bridge/2011-June/007711.html
 - possible bridge regression in "bridge: implement [add/del]_slave =
ops"?
   =
http://lists.linuxfoundation.org/pipermail/bridge/2011-June/007709.html

In my case, an app sends (multicast) traffic to br0 with eth1 and wlan0 =
ports. There are conditions with no wlan0 HW on subset of my gear and =
eth0 down because no connected workstation.

Problems:
1) Multicast between apps doesn't work when bridge is down. To send =
multicast _also_ on virtual interface needs update in app and is a bit =
of a hack, I think.
2) Troubleshoot the multicast packets with tcpdump on br0 doesn't work.

To send multicast _also_ on virtual interface needs update in app. It is =
also a bit of a hack, I think.

I tried to add interface lo or tap0 in the bridge. This didn't work.

Is there a trick to always bring up the bridge interface?
Add a config option? Such as brctl autostate <bridge> {on|off}
I don't mind having the default autostate set to on. But is was off =
before 2.6.39.

Thanks, Teco

