Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Jan 2009 20:51:14 +0100
Message-ID: <7B7881568CF40E4388B615CD06F87B9809885B@clara.maurer-it.com>
In-Reply-To: <20090112093636.18525a7a@extreme>
References: <531916880.118131231776345415.JavaMail.root@ken>
	<20090112093636.18525a7a@extreme>
From: "Dietmar Maurer" <dietmar@proxmox.com>
Subject: Re: [Bridge] Prevent MAC address from changing
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@vyatta.com>, Simon Detheridge <simon@widgit.com>
Cc: bridge@lists.linux-foundation.org

> latest kernels have a way to set mac address. After setting mac
address
> of bridge device, then address won't change.

AFAIK the bridge code always uses the lowest MAC address, so setting the
MAC address
does not help. As soon as you add a port with a lower MAC the address=20
changes. Or did that behavior change recently?

- Dietmar

