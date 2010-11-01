MIME-Version: 1.0
In-Reply-To: <4CCC45E9.7070801@mclink.it>
References: <4CC69E41.6050205@mclink.it>
	<AANLkTi=xHJyMbMqssrSaPabOp9mddGVv15SboU33h10G@mail.gmail.com>
	<4CCC45E9.7070801@mclink.it>
Date: Mon, 1 Nov 2010 08:49:20 -0400
Message-ID: <AANLkTi=PCkJEN_uG7PDfMM+F3wYz6o41BwT1iJX_1ckp@mail.gmail.com>
From: Ryan Whelan <ryan.whelan@tbamerica.com>
Content-Type: multipart/alternative; boundary=20cf30433ebea5ed7b0493fd3cb8
Subject: Re: [Bridge] Transparent wired/wirless bridge: is it possible?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Mauro Condarelli <mc5686@mclink.it>
Cc: bridge@lists.linux-foundation.org

--20cf30433ebea5ed7b0493fd3cb8
Content-Type: text/plain; charset=ISO-8859-1

hostapd puts the interface into the bridge when it starts up- but you have
to put it in the config. in your hostpad.conf add 'bridge=br0' (making sure
of course you have the correct 'interface= ' set.) search for 'bridge' on
this page: http://wireless.kernel.org/en/users/Documentation/hostapd

once setup, hostapd should put the interface in the bridge at start up and
remove it at shutdown so you take the interface out of the interfaces file.

HTH

On Sat, Oct 30, 2010 at 12:20 PM, Mauro Condarelli <mc5686@mclink.it> wrote:

>  On 26/10/2010 14.36, Ryan Whelan wrote:
>
> Have you looked at hostapd (http://hostap.epitest.fi/hostapd/)?
>
> Sorry,
> I was not clear enough.
>
> I have the wireless card up-and-running in ap-mode using hostapd.
> I *can* connect a laptop to the wireless Access Point.
> I also know how to setup a masquerading router on the linux machine to
> share the landline connection (e.g.: using firestarter).
> This would create a second net for wireless with double natting.
> I would like to avoid this and I'm looking for a "bridge" configuration so
> that all machines (wireless & wired) can share the same subnet (
> 192.68.1.0/24).
>
> I tried something like:
> =====================
> auto lo
> iface lo inet loopback
>
> auto wlan2
> iface wlan2 inet manual
>     up /usr/sbin/service hostapd start
>     up /sbin/ifconfig wlan2 up
>     down /sbin/ifconfig wlan2 down
>     down /usr/sbin/service hostapd stop
>
> auto eth2
> iface eth2 inet manual
>     up /sbin/ifconfig eth2 up
>     down /sbin/ifconfig eth2 down
>
> auto br0
> iface br0 inet dhcp
>     bridge_ports eth2 wlan2
>     bridge_maxwait 0
> =====================
> ... but it does not seem to work as hoped.
>
> Thanks in Advance for *ANY* hint ;)
>
> Regards
> Mauro
>
>
> On Tue, Oct 26, 2010 at 5:24 AM, Mauro Condarelli <mc5686@mclink.it>wrote:
>
>> Hi,
>> I read a lot on the Internet, but didn't find quite what I need.
>> I'm not even sure it's possible.
>>
>> I have a machine with ethernet access and wireless card (in master mode).
>> Both are running ok under ubuntu maverick.
>> I also have a separate firewall (wired) acting as DHCP server for my
>> whole home network.
>> I would like to bind the two interfaces together with no translation (no
>> NAT, SNAT, masquerading, ...) so that the machines connecting to the
>> wireless lan can get their address from the firewall and access the
>> Internet.
>>
>> Is this possible with bridging?
>> If so: can someone point me to the right documentation?
>>
>> TiA
>> Mauro
>> _______________________________________________
>> Bridge mailing list
>> Bridge@lists.linux-foundation.org
>> https://lists.linux-foundation.org/mailman/listinfo/bridge
>>
>
>
>
> _____________________________________
> This e-mail and any attachments from Toyota Boshoku America
> (TBA), TrimMasters Inc. (TMI), or other affiliated companies may
> contain confidential and privileged information.
>
> If you are not the intended recipient, please notify the sender
> immediately by return e-mail, delete this e-mail and destroy any
> copies.
>
> Any dissemination or use of this information by a person other
> than the intended recipient is unauthorized and may be illegal.
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>

--20cf30433ebea5ed7b0493fd3cb8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

hostapd puts the interface into the bridge when it starts up- but you have =
to put it in the config. in your hostpad.conf add &#39;bridge=3Dbr0&#39; (m=
aking sure of course you have the correct &#39;interface=3D &#39; set.) sea=
rch for &#39;bridge&#39; on this page: <a href=3D"http://wireless.kernel.or=
g/en/users/Documentation/hostapd">http://wireless.kernel.org/en/users/Docum=
entation/hostapd</a><br>
<br>once setup, hostapd should put the interface in the bridge at start up =
and remove it at shutdown so you take the interface out of the interfaces f=
ile.<br><br>HTH<br><br><div class=3D"gmail_quote">On Sat, Oct 30, 2010 at 1=
2:20 PM, Mauro Condarelli <span dir=3D"ltr">&lt;<a href=3D"mailto:mc5686@mc=
link.it">mc5686@mclink.it</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">

 =20
   =20
   =20
 =20
  <div bgcolor=3D"#ffffff" text=3D"#000000"><div class=3D"im">
    On 26/10/2010 14.36, Ryan Whelan wrote:
    <blockquote type=3D"cite">Have you looked at hostapd (<a href=3D"http:/=
/hostap.epitest.fi/hostapd/" target=3D"_blank">http://hostap.epitest.fi/hos=
tapd/</a>)?
      <br>
    </blockquote></div>
    Sorry,<br>
    I was not clear enough.<br>
    <br>
    I have the wireless card up-and-running in ap-mode using hostapd.<br>
    I *can* connect a laptop to the wireless Access Point.<br>
    I also know how to setup a masquerading router on the linux machine
    to share the landline connection (e.g.: using firestarter).<br>
    This would create a second net for wireless with double natting.<br>
    I would like to avoid this and I&#39;m looking for a &quot;bridge&quot;
    configuration so that all machines (wireless &amp; wired) can share
    the same subnet (<a href=3D"http://192.68.1.0/24" target=3D"_blank">192=
.68.1.0/24</a>).<br>
    <br>
    I tried something like:<br>
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
    auto lo<br>
    iface lo inet loopback<br>
    <br>
    auto wlan2<br>
    iface wlan2 inet manual<br>
    =A0=A0=A0 up /usr/sbin/service hostapd start<br>
    =A0=A0=A0 up /sbin/ifconfig wlan2 up<br>
    =A0=A0=A0 down /sbin/ifconfig wlan2 down<br>
    =A0=A0=A0 down /usr/sbin/service hostapd stop<br>
    <br>
    auto eth2<br>
    iface eth2 inet manual<br>
    =A0=A0=A0 up /sbin/ifconfig eth2 up<br>
    =A0=A0=A0 down /sbin/ifconfig eth2 down<br>
    <br>
    auto br0<br>
    iface br0 inet dhcp<br>
    =A0=A0=A0 bridge_ports eth2 wlan2<br>
    =A0=A0=A0 bridge_maxwait 0<br>
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
    ... but it does not seem to work as hoped.<br>
    <br>
    Thanks in Advance for *ANY* hint ;)<br>
    <br>
    Regards<br><font color=3D"#888888">
    Mauro</font><div><div></div><div class=3D"h5"><br>
    <blockquote type=3D"cite">=A0<br>
      <div class=3D"gmail_quote">On Tue, Oct 26, 2010 at 5:24 AM, Mauro
        Condarelli <span dir=3D"ltr">&lt;<a href=3D"mailto:mc5686@mclink.it=
" target=3D"_blank">mc5686@mclink.it</a>&gt;</span>
        wrote:<br>
        <blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8e=
x; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">Hi,<br>
          I read a lot on the Internet, but didn&#39;t find quite what I
          need.<br>
          I&#39;m not even sure it&#39;s possible.<br>
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
          <a href=3D"mailto:Bridge@lists.linux-foundation.org" target=3D"_b=
lank">Bridge@lists.linux-foundation.org</a><br>
          <a href=3D"https://lists.linux-foundation.org/mailman/listinfo/br=
idge" target=3D"_blank">https://lists.linux-foundation.org/mailman/listinfo=
/bridge</a><br>
        </blockquote>
      </div>
      <br>
    </blockquote>
    <br>
  </div></div></div><div><div></div><div class=3D"h5">


<p>

<br>
_____________________________________<br>
This e-mail and any attachments from Toyota Boshoku America<br>
(TBA), TrimMasters Inc. (TMI), or other affiliated companies may <br>
contain confidential and privileged information. <br>
<br>
If you are not the intended recipient, please notify the sender  <br>
immediately by return e-mail, delete this e-mail and destroy any <br>
copies. <br>
<br>
Any dissemination or use of this information by a person other <br>
than the intended recipient is unauthorized and may be illegal.<br>
</p></div></div><br>_______________________________________________<br>
Bridge mailing list<br>
<a href=3D"mailto:Bridge@lists.linux-foundation.org">Bridge@lists.linux-fou=
ndation.org</a><br>
<a href=3D"https://lists.linux-foundation.org/mailman/listinfo/bridge" targ=
et=3D"_blank">https://lists.linux-foundation.org/mailman/listinfo/bridge</a=
><br></blockquote></div><br>

--20cf30433ebea5ed7b0493fd3cb8--
