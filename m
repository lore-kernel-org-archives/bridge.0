Message-ID: <4A00A700.7020507@gmail.com>
Date: Tue, 05 May 2009 22:52:16 +0200
From: Jochen Hebbrecht <jochenhebbrecht@gmail.com>
MIME-Version: 1.0
References: <20090428124009.GA26387@kallisti.us>		<db99f77d0904292330n4c460ccbv45e60f06bfa49c4@mail.gmail.com>		<49FA1E28.5020604@free.fr>
	<49FC4764.3030707@gmail.com>		<49FDD890.1090302@free.fr>
	<49FF41C4.4090404@gmail.com>		<49FF4AF8.1050801@free.fr>
	<49FF58EC.2090902@gmail.com>		<49FFDABF.4030500@free.fr>
	<4A007103.4010501@gmail.com>	<2e59e6970905051108q7448a0ai7f6e5cb16faf1e00@mail.gmail.com>
	<4A00915F.7000602@gmail.com> <4A009943.5000505@navigue.com>
In-Reply-To: <4A009943.5000505@navigue.com>
Content-Type: multipart/alternative;
	boundary="------------050104040904090407020102"
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
To: Jonathan Thibault <jonathan@navigue.com>
Cc: bridge@lists.linux-foundation.org

This is a multi-part message in MIME format.
--------------050104040904090407020102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jonathan Thibault schreef:
> I believe that to allow bridging on a 'client', you need to enable WDS on the interface (and likely on the AP as well).  Check to see if WDS is supported by your driver.  Basically (but I could be wrong), it is an 'ethernet over wifi' encapsulation since the wifi does not allow for mac spoofing on a client endpoint which would be required for normal bridging.
>
>
>   

Thnx Jonathan. I found this information:
________________________________

Doing full bridging of wireless (802.11) requires supporting WDS 
<http://www.linuxfoundation.org/en/index.php?title=Net:WDS&action=edit&redlink=1>. 
The current implementation doesn't do it.

It is possible to do limited wireless to Ethernet functionality with 
some wireless drivers. This requires the device to be able to support a 
different sender address and source address. That is what WDS provides.

There are ways to make it work, but it is not always straightforward and 
you probably won't get it right without a pretty solid understanding of 
802.11, it's modes, and the frame header format.

________________________________

... so, the current implementation doesn't do it? So I can conclude 
Linux isn't ready for bridging a wired and wireless network?
I didn't install any drivers for my wireless card, so I assume it uses 
the default driver of Ubuntu.

--------------050104040904090407020102
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Jonathan Thibault schreef:
<blockquote cite="mid:4A009943.5000505@navigue.com" type="cite">
  <pre wrap="">I believe that to allow bridging on a 'client', you need to enable WDS on the interface (and likely on the AP as well).  Check to see if WDS is supported by your driver.  Basically (but I could be wrong), it is an 'ethernet over wifi' encapsulation since the wifi does not allow for mac spoofing on a client endpoint which would be required for normal bridging.


  </pre>
</blockquote>
<br>
Thnx Jonathan. I found this information:<br>
________________________________<br>
<p>Doing full bridging of wireless (802.11) requires supporting <a
 href="http://www.linuxfoundation.org/en/index.php?title=Net:WDS&amp;action=edit&amp;redlink=1"
 class="new" title="Net:WDS (not yet written)"> WDS </a>. The current
implementation doesn't do it.
</p>
<p>It is possible to do limited wireless to Ethernet functionality
with some wireless drivers. This requires the device to be able to
support a different sender address and source address. That is what WDS
provides.
</p>
<p>There are ways to make it work, but it is not always
straightforward and you probably won't get it right without a pretty
solid understanding of 802.11, it's modes, and the frame header format.
</p>
________________________________<br>
<br>
... so, the current implementation doesn't do it? So I can conclude
Linux isn't ready for bridging a wired and wireless network?<br>
I didn't install any drivers for my wireless card, so I assume it uses
the default driver of Ubuntu. <br>
</body>
</html>

--------------050104040904090407020102--
