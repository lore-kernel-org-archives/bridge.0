Message-ID: <84b37b3605042721351957ae1@mail.gmail.com>
Date: Wed, 27 Apr 2005 23:35:33 -0500
From: Adam M <gnuman1@gmail.com>
In-Reply-To: <84b37b3605042312424df0fae5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
References: <84b37b3605042312424df0fae5@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Subject: [Bridge] 2.6.11/10 (and probably others),
	usbnet + bridge => massive memory corruption
Reply-To: Adam M <gnuman1@gmail.com>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

Hi all,

Well, I've been trying to set up Debian on an OpenZaurus bootstrap..
well, there were some complications after I enabled bridging between
usbnet and via_rhine ethernet,

My set up includes,

1. Network interface setup using usbnet
2. Bridge eth0+usb0=>main (bridge name)
3. bootstrap Debian on an NFS volume.

There are no lost pockets or any type of kernel oops. I can produce a
segfault in the brctl utility by trying to turn off STP when there are
interfaces attached, but that's about it.

Almost immediately after I set up the bridge, I've started to
experience application dumping core. Things like firefox stopped
working, but thunderbird was ok. Or xterm segfaulting... During this
time the network (bridge) seemed ok.

After a short while, everything seems to just crap out either by
kernel rebooting or stalling (no kernel oops).

So far I'm been generating a lot of traffic over usbnet (no bridge) and
things seem to work OK... After I enable bridging, well, scary things happen.

- Adam

PS. I'm not on this list, so please CC me in all replies. Thanks!

