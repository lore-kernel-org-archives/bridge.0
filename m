Message-ID: <49FF4220.2080909@gmail.com>
Date: Mon, 04 May 2009 21:29:36 +0200
From: Jochen Hebbrecht <jochenhebbrecht@gmail.com>
MIME-Version: 1.0
References: <20090428124009.GA26387@kallisti.us>	
	<20090429162651.GA9455@kallisti.us> <49F882F9.4010100@gmail.com>	
	<20090429165329.GA9893@kallisti.us> <49F8C4C3.9020504@gmail.com>	
	<2e59e6970904292118u71ff441ft19448f753c1b6dd9@mail.gmail.com>	
	<db99f77d0904292330n4c460ccbv45e60f06bfa49c4@mail.gmail.com>	
	<49FA1E28.5020604@free.fr> <49FC4764.3030707@gmail.com>	
	<49FDD890.1090302@free.fr>
	<2e59e6970905032059u44da74e1x6b96b6c3d0144294@mail.gmail.com>
In-Reply-To: <2e59e6970905032059u44da74e1x6b96b6c3d0144294@mail.gmail.com>
Content-Type: multipart/alternative;
	boundary="------------020804010200060009020201"
Subject: Re: [Bridge] Ubuntu: network bridging between wireless and wired
 connection fails
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Cc: bridge@lists.linux-foundation.org

This is a multi-part message in MIME format.
--------------020804010200060009020201
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable



richardvoigt@gmail.com schreef:
>
>
> On Sun, May 3, 2009 at 12:46 PM, Nicolas de Peslo=FCan=20
> <nicolas.2p.debian@free.fr <mailto:nicolas.2p.debian@free.fr>> wrote:
>
>
>
>     Ok, now we understand what you are trying to do. In particular, I
>     assume
>     the DHCP server is on the subnet of location B (or behind a router
>     connected on this subnet), so the expected DHCP offer will come
>     from the
>     wire interface (eth0) and definitely not from the wireless interface
>     (eth1).
>
>
>
> Looking at "router" in the provided diagram, plus the placement of A=20
> and B, I am led to believe that location A is the primary network=20
> providing DHCP and outbound access.  Furthermore, Jochen was getting a=20
> DHCP assignment over his wireless interface before he tried to enable=20
> bridging.
>
> Your suggestion of configuration as a router could work.  But NAT=20
> would not if A is the primary location, because the printer would no=20
> longer have a address visible to location A.
Indeed, location A is my primary network which provides DHCP.
And yes, you are correct with your last sentence. The printer should be=20
visible for location A too :-)


--------------020804010200060009020201
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<br>
<br>
<a class="moz-txt-link-abbreviated" href="mailto:richardvoigt@gmail.com">richardvoigt@gmail.com</a> schreef:
<blockquote
 cite="mid:2e59e6970905032059u44da74e1x6b96b6c3d0144294@mail.gmail.com"
 type="cite"><br>
  <br>
  <div class="gmail_quote">On Sun, May 3, 2009 at 12:46 PM, Nicolas de
Peslo&uuml;an <span dir="ltr">&lt;<a moz-do-not-send="true"
 href="mailto:nicolas.2p.debian@free.fr">nicolas.2p.debian@free.fr</a>&gt;</span>
wrote:<br>
  <blockquote class="gmail_quote"
 style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
    <br>
Ok, now we understand what you are trying to do. In particular, I assume<br>
the DHCP server is on the subnet of location B (or behind a router<br>
connected on this subnet), so the expected DHCP offer will come from the<br>
wire interface (eth0) and definitely not from the wireless interface<br>
(eth1).</blockquote>
  <div><br>
  </div>
  <div><br>
  </div>
  <div>Looking at "router" in the provided diagram, plus the placement
of A and B, I am led to believe that location A is the primary network
providing DHCP and outbound access. &nbsp;Furthermore, Jochen was getting a
DHCP assignment over his wireless interface before he tried to enable
bridging.</div>
  <div><br>
  </div>
  <div>Your suggestion of configuration as a router could work. &nbsp;But
NAT would not if A is the primary location, because the printer would
no longer have a address visible to location A.</div>
  </div>
</blockquote>
Indeed, location A is my primary network which provides DHCP.<br>
And yes, you are correct with your last sentence. The printer should be
visible for location A too :-)<br>
<br>
</body>
</html>

--------------020804010200060009020201--
