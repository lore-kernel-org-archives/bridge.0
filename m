MIME-Version: 1.0
In-Reply-To: <000001cad5e4$fcc81030$f6583090$@com>
References: <q2x1803dfd21004061402h67b2a920m4b9b1ac2dc66bb2f@mail.gmail.com>
	<l2sc5b98f841004061617s1bb85838k7c1cc7a887646b53@mail.gmail.com>
	<000001cad5e4$fcc81030$f6583090$@com>
Date: Tue, 6 Apr 2010 19:08:35 -0600
Message-ID: <g2wc5b98f841004061808gc8817c6fj62d89fe4f6810396@mail.gmail.com>
From: Robert LeBlanc <robert@leblancnet.us>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Bridging vSwitches in VMwares ESXi
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ryan King <ryank@globaldial.com>
Cc: bridge@lists.linux-foundation.org

On Tue, Apr 6, 2010 at 5:57 PM, Ryan King <ryank@globaldial.com> wrote:

> I've also had the exact same issues. =A0However, if I move one of the vNI=
Cs to
> a vSwitch using a different physical nic, then the issue seems to go away=
.

In my experience, as long as you only have on pNIC per vSwitch, it
works just fine. As soon as you add a second pNIC to the vSwitch, it
creates a loop and confuses the linux bridge (you can watch the MAC
bounce between ports if you do a standard ping from one machine and a
broadcast ping from another machine). We were using Broadcom NICs.


Robert LeBlanc
Life Sciences & Undergraduate Education Computer Support
Brigham Young University
