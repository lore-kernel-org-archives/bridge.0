Return-Path: <roll10@greynode.net>
From: Benjamin Scarlet <roll10@greynode.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Message-Id: <37377BC5-1B6C-4E86-9ACA-51C9B9599E70@greynode.net>
Date: Mon, 15 Apr 2013 08:15:23 -0400
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: [Bridge] bridging and VLANs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

I'm trying to understand the current and future state of bridging VLANs. =
I see there's been patch activity on this list, so I'm hoping someone =
here will be kind enough to explain.

I currently bridge VLANs, using commands like=20

$ brctl addbr neta
$ brctl addif neta eth0.100
...

This works for me, mostly. Should it? Is this interface going to change?

Thanks,
Ben Scarlet

