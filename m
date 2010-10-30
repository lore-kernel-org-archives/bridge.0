Message-ID: <4CCC45E9.7070801@mclink.it>
Date: Sat, 30 Oct 2010 18:20:57 +0200
From: Mauro Condarelli <mc5686@mclink.it>
MIME-Version: 1.0
References: <4CC69E41.6050205@mclink.it>
	<AANLkTi=xHJyMbMqssrSaPabOp9mddGVv15SboU33h10G@mail.gmail.com>
In-Reply-To: <AANLkTi=xHJyMbMqssrSaPabOp9mddGVv15SboU33h10G@mail.gmail.com>
Content-Type: multipart/alternative;
	boundary="------------030203050405030902060608"
Subject: Re: [Bridge] Transparent wired/wirless bridge: is it possible?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ryan Whelan <rcwhelan@gmail.com>
Cc: bridge@lists.linux-foundation.org

This is a multi-part message in MIME format.
--------------030203050405030902060608
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 26/10/2010 14.36, Ryan Whelan wrote:
> Have you looked at hostapd (http://hostap.epitest.fi/hostapd/)?
Sorry,
I was not clear enough.

I have the wireless card up-and-running in ap-mode using hostapd.
I *can* connect a laptop to the wireless Access Point.
I also know how to setup a masquerading router on the linux machine to 
share the landline connection (e.g.: using firestarter).
This would create a second net for wireless with double natting.
I would like to avoid this and I'm looking for a "bridge" configuration 
so that all machines (wireless & wired) can share the same subnet 
(192.68.1.0/24).

I tried something like:
=====================
auto lo
iface lo inet loopback

auto wlan2
iface wlan2 inet manual
     up /usr/sbin/service hostapd start
     up /sbin/ifconfig wlan2 up
     down /sbin/ifconfig wlan2 down
     down /usr/sbin/service hostapd stop

auto eth2
iface eth2 inet manual
     up /sbin/ifconfig eth2 up
     down /sbin/ifconfig eth2 down

auto br0
iface br0 inet dhcp
     bridge_ports eth2 wlan2
     bridge_maxwait 0
=====================
... but it does not seem to work as hoped.

Thanks in Advance for *ANY* hint ;)

Regards
Mauro
>
> On Tue, Oct 26, 2010 at 5:24 AM, Mauro Condarelli <mc5686@mclink.it 
> <mailto:mc5686@mclink.it>> wrote:
>
>     Hi,
>     I read a lot on the Internet, but didn't find quite what I need.
>     I'm not even sure it's possible.
>
>     I have a machine with ethernet access and wireless card (in master
>     mode).
>     Both are running ok under ubuntu maverick.
>     I also have a separate firewall (wired) acting as DHCP server for my
>     whole home network.
>     I would like to bind the two interfaces together with no
>     translation (no
>     NAT, SNAT, masquerading, ...) so that the machines connecting to the
>     wireless lan can get their address from the firewall and access the
>     Internet.
>
>     Is this possible with bridging?
>     If so: can someone point me to the right documentation?
>
>     TiA
>     Mauro
>     _______________________________________________
>     Bridge mailing list
>     Bridge@lists.linux-foundation.org
>     <mailto:Bridge@lists.linux-foundation.org>
>     https://lists.linux-foundation.org/mailman/listinfo/bridge
>
>


--------------030203050405030902060608
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
    <title></title>
  </head>
  <body bgcolor="#ffffff" text="#000000">
    On 26/10/2010 14.36, Ryan Whelan wrote:
    <blockquote
      cite="mid:AANLkTi=xHJyMbMqssrSaPabOp9mddGVv15SboU33h10G@mail.gmail.com"
      type="cite">Have you looked at hostapd (<a moz-do-not-send="true"
        href="http://hostap.epitest.fi/hostapd/">http://hostap.epitest.fi/hostapd/</a>)?
      <br>
    </blockquote>
    Sorry,<br>
    I was not clear enough.<br>
    <br>
    I have the wireless card up-and-running in ap-mode using hostapd.<br>
    I *can* connect a laptop to the wireless Access Point.<br>
    I also know how to setup a masquerading router on the linux machine
    to share the landline connection (e.g.: using firestarter).<br>
    This would create a second net for wireless with double natting.<br>
    I would like to avoid this and I'm looking for a "bridge"
    configuration so that all machines (wireless &amp; wired) can share
    the same subnet (192.68.1.0/24).<br>
    <br>
    I tried something like:<br>
    =====================<br>
    auto lo<br>
    iface lo inet loopback<br>
    <br>
    auto wlan2<br>
    iface wlan2 inet manual<br>
    &nbsp;&nbsp;&nbsp; up /usr/sbin/service hostapd start<br>
    &nbsp;&nbsp;&nbsp; up /sbin/ifconfig wlan2 up<br>
    &nbsp;&nbsp;&nbsp; down /sbin/ifconfig wlan2 down<br>
    &nbsp;&nbsp;&nbsp; down /usr/sbin/service hostapd stop<br>
    <br>
    auto eth2<br>
    iface eth2 inet manual<br>
    &nbsp;&nbsp;&nbsp; up /sbin/ifconfig eth2 up<br>
    &nbsp;&nbsp;&nbsp; down /sbin/ifconfig eth2 down<br>
    <br>
    auto br0<br>
    iface br0 inet dhcp<br>
    &nbsp;&nbsp;&nbsp; bridge_ports eth2 wlan2<br>
    &nbsp;&nbsp;&nbsp; bridge_maxwait 0<br>
    =====================<br>
    ... but it does not seem to work as hoped.<br>
    <br>
    Thanks in Advance for *ANY* hint ;)<br>
    <br>
    Regards<br>
    Mauro<br>
    <blockquote
      cite="mid:AANLkTi=xHJyMbMqssrSaPabOp9mddGVv15SboU33h10G@mail.gmail.com"
      type="cite">&nbsp;<br>
      <div class="gmail_quote">On Tue, Oct 26, 2010 at 5:24 AM, Mauro
        Condarelli <span dir="ltr">&lt;<a moz-do-not-send="true"
            href="mailto:mc5686@mclink.it">mc5686@mclink.it</a>&gt;</span>
        wrote:<br>
        <blockquote class="gmail_quote" style="margin: 0pt 0pt 0pt
          0.8ex; border-left: 1px solid rgb(204, 204, 204);
          padding-left: 1ex;">Hi,<br>
          I read a lot on the Internet, but didn't find quite what I
          need.<br>
          I'm not even sure it's possible.<br>
          <br>
          I have a machine with ethernet access and wireless card (in
          master mode).<br>
          Both are running ok under ubuntu maverick.<br>
          I also have a separate firewall (wired) acting as DHCP server
          for my<br>
          whole home network.<br>
          I would like to bind the two interfaces together with no
          translation (no<br>
          NAT, SNAT, masquerading, ...) so that the machines connecting
          to the<br>
          wireless lan can get their address from the firewall and
          access the<br>
          Internet.<br>
          <br>
          Is this possible with bridging?<br>
          If so: can someone point me to the right documentation?<br>
          <br>
          TiA<br>
          Mauro<br>
          _______________________________________________<br>
          Bridge mailing list<br>
          <a moz-do-not-send="true"
            href="mailto:Bridge@lists.linux-foundation.org">Bridge@lists.linux-foundation.org</a><br>
          <a moz-do-not-send="true"
            href="https://lists.linux-foundation.org/mailman/listinfo/bridge"
            target="_blank">https://lists.linux-foundation.org/mailman/listinfo/bridge</a><br>
        </blockquote>
      </div>
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------030203050405030902060608--
