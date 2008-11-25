Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Nov 2008 08:30:09 +0100
Message-ID: <7B7881568CF40E4388B615CD06F87B98057A19@clara.maurer-it.com>
In-Reply-To: <492B80F8.9060507@gmxpro.de>
References: <492B80F8.9060507@gmxpro.de>
From: "Dietmar Maurer" <dietmar@proxmox.com>
Subject: Re: [Bridge] Using 2 Bridges Simultaneously for "Load Balancing"
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: andre.iost@gmxpro.de, bridge@lists.linux-foundation.org

> Thanks a lot, that worked like a charm! Would you be so kind as to
> enlighten me ;)? I guess, the "bridge_stp off" disables the spanning
> tree protocol, or whatever this is called, right? What is the

Yes. I guess you don't need it with your configuration.

> "bridge_fd 0" for?

sets the bridge forward delay to 0 seconds. That way you do not
have delays when you boot your host.

see "man brctl"

- Dietmar

