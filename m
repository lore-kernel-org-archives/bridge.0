MIME-Version: 1.0
In-Reply-To: <OF4B3FF703.CC38E26C-ONC12575D4.0058F1ED-C12575D4.005AB7C4@transmode.se>
References: <1244842010-24945-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<m3ab4dovgi.fsf@ursa.amorsen.dk>
	<OFCE5E72FE.D082AB78-ONC12575D4.005256D7-C12575D4.0052B193@transmode.se>
	<2e59e6970906130857t2441d0bap34e15fd2af12fe72@mail.gmail.com>
	<OF4B3FF703.CC38E26C-ONC12575D4.0058F1ED-C12575D4.005AB7C4@transmode.se>
Date: Sat, 13 Jun 2009 21:18:27 -0500
Message-ID: <2e59e6970906131918n66c7e000pe65dc7662f5df51f@mail.gmail.com>
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Content-Type: multipart/alternative; boundary=001485f42412975b8d046c458ef8
Subject: Re: [Bridge] [PATCH] [bridge] Add split horizon
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: bridge@lists.linux-foundation.org, Benny Amorsen <benny+usenet@amorsen.dk>

--001485f42412975b8d046c458ef8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

>
>
> I would really like to know in what situation you would use
> the current behavior to forward back VLAN pkgs over the same interface
> it was received on?


With a gigabit VLAN capable switch, 20 ports in untagged mode on distinct
VLANs, 1 trunking port attached to a gigbit card in my Linux firewall, 1
trunking port to a second gigabit VLAN capable switch configured similarly
in another physical location, it allows me to filter traffic between all 40
attached networks as if my Linux box had 40 network interfaces.  It's a very
useful combination of VLANs and bridging.


>
> Also, I am trying to find where it states that a VLAN is considered its own
> physical port. Any pointers?
>

A linux bridge is like a switching hub, with a separate port for every
interface you add with brctl addif.  All local interfaces get treated the
same -- they each get their own port on the bridge -- whether a physical or
virtual or sub-interface.

--001485f42412975b8d046c458ef8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;"><br>
I would really like to know in what situation you would use<br>
the current behavior to forward back VLAN pkgs over the same interface<br>
it was received on?</blockquote><div><br></div><div>With a gigabit VLAN cap=
able switch, 20 ports in untagged mode on distinct VLANs, 1 trunking port a=
ttached to a gigbit card in my Linux firewall, 1 trunking port to a second =
gigabit VLAN capable switch configured similarly in another physical locati=
on, it allows me to filter traffic between all 40 attached networks as if m=
y Linux box had 40 network interfaces. =A0It&#39;s a very useful combinatio=
n of VLANs and bridging.</div>
<div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex;"><br>
<br>
Also, I am trying to find where it states that a VLAN is considered its own=
<br>
<div><div></div><div class=3D"h5">physical port. Any pointers?</div></div><=
/blockquote><div><br></div><div>A linux bridge is like a switching hub, wit=
h a separate port for every interface you add with brctl addif. =A0All loca=
l interfaces get treated the same -- they each get their own port on the br=
idge -- whether a physical or virtual or sub-interface.</div>
</div>

--001485f42412975b8d046c458ef8--
