Message-ID: <40558.84.123.233.184.1174602247.squirrel@www.arcoscom.com>
In-Reply-To: <55003.195.55.244.106.1174552139.squirrel@www.arcoscom.com>
References: <48254.84.123.233.184.1174345071.squirrel@www.arcoscom.com>
	<55003.195.55.244.106.1174552139.squirrel@www.arcoscom.com>
Date: Thu, 22 Mar 2007 23:24:07 +0100 (CET)
From: "ArcosCom Linux User" <linux@arcoscom.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20070322232407_57705"
Subject: Re: [Bridge] Multilink + bridge + nat problem [with attached txt
	files]
Reply-To: linux@arcoscom.com
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: lartc@mailman.ds9a.nl, netfilter@lists.netfilter.org, bridge@osdl.org, netfilter-devel@lists.netfilter.org

------=_20070322232407_57705
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I attach 2 txt files:
   rt_status: ip route info + iptables mangle info.
   iptables_nat.txt: iptables -t nat -vnL

The questions and the issues are in the original e-mail (above).

Thanks

El Jue, 22 de Marzo de 2007, 9:28, ArcosCom Linux User escribi=F3:
> Any help please?
>
> Thanks.
>
> El Lun, 19 de Marzo de 2007, 23:57, ArcosCom Linux User escribi=F3:
>> Hi, I have a suspicious problem with multiple uplinks configuration.
>> First of all my configuration:
>>    1) kernel 2.6.20.3
>>    2) iptables 1.3.7
>>    3) last iproute (for masked marks)
>>
>> All wan interfaces are bridged (stp disabled) in only one interface
>> (wan0), all lan interfaces are bridged (stp enabled) in only one
>> interface
>> (zlan0).
>>
>> The wan0 bridge is to allow UPnP works.
>>
>> To allow related incoming traffic from one fisical interface I mark
>> connections, and the same to allow outgoing related.
>>
>> The routing rules are the same than lartc documentation plus a rule by
>> interface to allow the routing using marks (masked).
>>
>> The comands I use are:
>>
>> =3D=3DBEGIN=3D=3D
>> /sbin/ip rule del prio 50 table main
>> /sbin/ip rule del prio 100 fwmark 0x8000/0xf000 table 150
>> /sbin/ip rule del prio 150 from 217.125.139.204/26 table 150
>> /sbin/ip rule del prio 101 fwmark 0x4000/0xf000 table 151
>> /sbin/ip rule del prio 151 from 80.32.61.58/24 table 151
>> /sbin/ip rule del prio 200 table 200
>> /sbin/ip route flush table 150
>> /sbin/ip route flush table 151
>> /sbin/ip route flush table 200
>> /sbin/iptables -t mangle -D PREROUTING -j MARCAR_IFACE
>> /sbin/iptables -t mangle -F MARCAR_IFACE
>> /sbin/iptables -t mangle -X MARCAR_IFACE
>> /sbin/iptables -t mangle -F MARCAR_IFACE_TRAFICO
>> /sbin/iptables -t mangle -X MARCAR_IFACE_TRAFICO
>> /sbin/iptables -t mangle -D POSTROUTING -j MARCAR_IFACE_OUT
>> /sbin/iptables -t mangle -F MARCAR_IFACE_OUT
>> /sbin/iptables -t mangle -X MARCAR_IFACE_OUT
>> /sbin/iptables -t mangle -N MARCAR_IFACE
>> /sbin/iptables -t mangle -N MARCAR_IFACE_TRAFICO
>> /sbin/iptables -t mangle -A MARCAR_IFACE -j CONNMARK --restore-mark
>> /sbin/iptables -t mangle -A MARCAR_IFACE -m mark ! --mark 0x0000/0xf000
>> -j
>> RETURN
>> /sbin/iptables -t mangle -A MARCAR_IFACE -m mark --mark 0x0000/0xf000 -j
>> MARCAR_IFACE_TRAFICO
>> /sbin/iptables -t mangle -N MARCAR_IFACE_OUT
>> /sbin/iptables -t mangle -A MARCAR_IFACE_OUT -j CONNMARK --restore-mark
>> /sbin/iptables -t mangle -A MARCAR_IFACE_OUT -m mark ! --mark
>> 0x0000/0xf000 -j RETURN
>> /sbin/iptables -t mangle -A MARCAR_IFACE -m mark --mark 0x0000/0xf000 -i
>> wan0 -m physdev --physdev-in eth1 -m state --state NEW -j MARK --or-mark
>> 0x8000
>> /sbin/iptables -t mangle -A MARCAR_IFACE_OUT -m mark --mark
>> 0x0000/0xf000
>> -o wan0 -m conntrack --ctreplsrc 217.125.139.204 -j MARK --or-mark
>> 0x8000
>> /sbin/iptables -t mangle -A MARCAR_IFACE_OUT -m mark --mark
>> 0x0000/0xf000
>> -o wan0 -m conntrack --ctrepldst 217.125.139.204 -j MARK --or-mark
>> 0x8000
>> /sbin/iptables -t mangle -A MARCAR_IFACE_OUT -m mark --mark
>> 0x0000/0xf000
>> -o wan0 -s 217.125.139.204 -j MARK --or-mark 0x8000
>> /sbin/iptables -t mangle -A MARCAR_IFACE_OUT -m mark --mark
>> 0x0000/0xf000
>> -o wan0 -m conntrack --ctorigsrc 217.125.139.204 -j MARK --or-mark
>> 0x8000
>> /sbin/iptables -t mangle -A MARCAR_IFACE_OUT -m mark --mark
>> 0x0000/0xf000
>> -o wan0 -m conntrack --ctorigdst 217.125.139.204 -j MARK --or-mark
>> 0x8000
>> /sbin/iptables -t mangle -A MARCAR_IFACE -m mark --mark 0x0000/0xf000 -i
>> wan0 -m physdev --physdev-in eth3 -m state --state NEW -j MARK --or-mark
>> 0x4000
>> /sbin/iptables -t mangle -A MARCAR_IFACE_OUT -m mark --mark
>> 0x0000/0xf000
>> -o wan0 -m conntrack --ctreplsrc 80.32.61.58 -j MARK --or-mark 0x4000
>> /sbin/iptables -t mangle -A MARCAR_IFACE_OUT -m mark --mark
>> 0x0000/0xf000
>> -o wan0 -m conntrack --ctrepldst 80.32.61.58 -j MARK --or-mark 0x4000
>> /sbin/iptables -t mangle -A MARCAR_IFACE_OUT -m mark --mark
>> 0x0000/0xf000
>> -o wan0 -s 80.32.61.58 -j MARK --or-mark 0x4000
>> /sbin/iptables -t mangle -A MARCAR_IFACE_OUT -m mark --mark
>> 0x0000/0xf000
>> -o wan0 -m conntrack --ctorigsrc 80.32.61.58 -j MARK --or-mark 0x4000
>> /sbin/iptables -t mangle -A MARCAR_IFACE_OUT -m mark --mark
>> 0x0000/0xf000
>> -o wan0 -m conntrack --ctorigdst 80.32.61.58 -j MARK --or-mark 0x4000
>> /sbin/iptables -t mangle -A MARCAR_IFACE -j CONNMARK --save-mark
>> /sbin/iptables -t mangle -A MARCAR_IFACE -j RETURN
>> /sbin/iptables -t mangle -I PREROUTING -j MARCAR_IFACE
>> /sbin/iptables -t mangle -A MARCAR_IFACE_OUT -j CONNMARK --save-mark
>> /sbin/iptables -t mangle -A MARCAR_IFACE_OUT -j RETURN
>> /sbin/iptables -t mangle -I POSTROUTING -j MARCAR_IFACE_OUT
>> /sbin/ip rule add prio 50 table main
>> /sbin/ip rule add prio 100 fwmark 0x8000/0xf000 table 150
>> /sbin/ip rule add prio 150 from 217.125.139.204/26 table 150
>> /sbin/ip route add default via 217.125.139.193 dev wan0 src
>> 217.125.139.204 proto static table 150
>> /sbin/ip route append prohibit default table 150 metric 1 proto static
>> /sbin/ip rule add prio 101 fwmark 0x4000/0xf000 table 151
>> /sbin/ip rule add prio 151 from 80.32.61.58/24 table 151
>> /sbin/ip route add default via 80.32.61.1 dev wan0 src 80.32.61.58 proto
>> static table 151
>> /sbin/ip route append prohibit default table 151 metric 1 proto static
>> /sbin/ip rule add prio 200 table 200
>> /sbin/ip route add default table 200 proto static nexthop via
>> 217.125.139.193 dev wan0 weight 1 nexthop via 80.32.61.1 dev wan0 weight
>> 1
>> /sbin/ip route flush cache
>> =3D=3DEND=3D=3D
>>
>> I have this "output" for all chains and routes:
>> =3D=3DBEGIN=3D=3D
>> =3D=3D=3D REGLAS IPTABLES PARA EL ENRUTADO =3D=3D=3D
>> Chain PREROUTING (policy ACCEPT 8664K packets, 5097M bytes)
>> num   pkts bytes target     prot opt in     out     source
>> destination
>> 1    3348K 1832M MARCAR_IFACE  0    --  *      *       0.0.0.0/0
>>  0.0.0.0/0
>> Chain MARCAR_IFACE (1 references)
>> num   pkts bytes target     prot opt in     out     source
>> destination
>> 1    3348K 1832M CONNMARK   0    --  *      *       0.0.0.0/0
>> 0.0.0.0/0           CONNMARK restore
>> 2    2841K 1653M RETURN     0    --  *      *       0.0.0.0/0
>> 0.0.0.0/0           MARK match !0x0/0xf000
>> 3     507K  179M MARCAR_IFACE_TRAFICO  0    --  *      *       0.0.0.0/0
>>          0.0.0.0/0           MARK match 0x0/0xf000
>> 4    40690 2721K MARK       0    --  wan0   *       0.0.0.0/0
>> 0.0.0.0/0           MARK match 0x0/0xf000 PHYSDEV match --physdev-in
>> eth1
>> state NEW MARK or 0x8000
>> 5    48680 3062K MARK       0    --  wan0   *       0.0.0.0/0
>> 0.0.0.0/0           MARK match 0x0/0xf000 PHYSDEV match --physdev-in
>> eth3
>> state NEW MARK or 0x4000
>> 6     507K  179M CONNMARK   0    --  *      *       0.0.0.0/0
>> 0.0.0.0/0           CONNMARK save
>> 7     507K  179M RETURN     0    --  *      *       0.0.0.0/0
>> 0.0.0.0/0
>> Chain MARCAR_IFACE_TRAFICO (1 references)
>> num   pkts bytes target     prot opt in     out     source
>> destination
>> Chain POSTROUTING (policy ACCEPT 16M packets, 8665M bytes)
>> num   pkts bytes target     prot opt in     out     source
>> destination
>> 1    6483K 3397M MARCAR_IFACE_OUT  0    --  *      *       0.0.0.0/0
>>      0.0.0.0/0
>> Chain MARCAR_IFACE_OUT (1 references)
>> num   pkts bytes target     prot opt in     out     source
>> destination
>> 1    6483K 3397M CONNMARK   0    --  *      *       0.0.0.0/0
>> 0.0.0.0/0           CONNMARK restore
>> 2    5781K 2966M RETURN     0    --  *      *       0.0.0.0/0
>> 0.0.0.0/0           MARK match !0x0/0xf000
>> 3        0     0 MARK       0    --  *      wan0    0.0.0.0/0
>> 0.0.0.0/0           MARK match 0x0/0xf000 ctreplsrc 217.125.139.204 MARK
>> or 0x8000
>> 4     104K 7470K MARK       0    --  *      wan0    0.0.0.0/0
>> 0.0.0.0/0           MARK match 0x0/0xf000 ctrepldst 217.125.139.204 MARK
>> or 0x8000
>> 5      135  7091 MARK       0    --  *      wan0    217.125.139.204
>> 0.0.0.0/0           MARK match 0x0/0xf000 MARK or 0x8000
>> 6        0     0 MARK       0    --  *      wan0    0.0.0.0/0
>> 0.0.0.0/0           MARK match 0x0/0xf000 ctorigsrc 217.125.139.204 MARK
>> or 0x8000
>> 7        0     0 MARK       0    --  *      wan0    0.0.0.0/0
>> 0.0.0.0/0           MARK match 0x0/0xf000 ctorigdst 217.125.139.204 MARK
>> or 0x8000
>> 8        0     0 MARK       0    --  *      wan0    0.0.0.0/0
>> 0.0.0.0/0           MARK match 0x0/0xf000 ctreplsrc 80.32.61.58 MARK or
>> 0x4000
>> 9     101K 7298K MARK       0    --  *      wan0    0.0.0.0/0
>> 0.0.0.0/0           MARK match 0x0/0xf000 ctrepldst 80.32.61.58 MARK or
>> 0x4000
>> 10     175  7578 MARK       0    --  *      wan0    80.32.61.58
>> 0.0.0.0/0           MARK match 0x0/0xf000 MARK or 0x4000
>> 11       0     0 MARK       0    --  *      wan0    0.0.0.0/0
>> 0.0.0.0/0           MARK match 0x0/0xf000 ctorigsrc 80.32.61.58 MARK or
>> 0x4000
>> 12       1    48 MARK       0    --  *      wan0    0.0.0.0/0
>> 0.0.0.0/0           MARK match 0x0/0xf000 ctorigdst 80.32.61.58 MARK or
>> 0x4000
>> 13    702K  431M CONNMARK   0    --  *      *       0.0.0.0/0
>> 0.0.0.0/0           CONNMARK save
>> 14    702K  431M RETURN     0    --  *      *       0.0.0.0/0
>> 0.0.0.0/0
>> =3D=3D=3D REGLAS DE ENRUTAMIENTO =3D=3D=3D
>> 0:      from all lookup local
>> 50:     from all lookup main
>> 100:    from all fwmark 0x8000/0xf000 lookup uno
>> 101:    from all fwmark 0x4000/0xf000 lookup dos
>> 150:    from 217.125.139.204/26 lookup uno
>> 151:    from 80.32.61.58/24 lookup dos
>> 200:    from all lookup defecto
>> 32766:  from all lookup main
>> 32767:  from all lookup default
>> =3D=3D=3D TABLAS DE RUTAS =3D=3D=3D
>> =3D=3D=3D MAIN =3D=3D=3D
>> 217.125.139.192/26 dev wan0  proto kernel  scope link  src
>> 217.125.139.204
>> 80.32.61.0/24 dev wan0  proto kernel  scope link  src 80.32.61.58
>> 192.168.3.0/24 dev zlan0  proto kernel  scope link  src 192.168.3.247
>> 192.168.2.0/24 dev zlan0  proto kernel  scope link  src 192.168.2.247
>> 192.168.1.0/24 dev zlan0  proto kernel  scope link  src 192.168.1.247
>> 10.1.1.0/24 dev zlan0  proto kernel  scope link  src 10.1.1.6
>> 169.254.0.0/16 dev zlan0  scope link
>> 239.0.0.0/8 dev zlan0  scope link
>> =3D=3D=3D wan0 TABLA 150 =3D=3D=3D
>> default via 217.125.139.193 dev wan0  proto static  src 217.125.139.204
>> prohibit default  proto static  metric 1
>> =3D=3D=3D wan0 TABLA 151 =3D=3D=3D
>> default via 80.32.61.1 dev wan0  proto static  src 80.32.61.58
>> prohibit default  proto static  metric 1
>> =3D=3D=3D TABLA 200 (defecto) =3D=3D=3D
>> default  proto static
>>         nexthop via 217.125.139.193  dev wan0 weight 1
>>         nexthop via 80.32.61.1  dev wan0 weight 1
>>
>> =3D=3DEND=3D=3D
>>
>> The -t nat POSTROUTING rules:
>> =3D=3DBEGIN=3D=3DChain POSTROUTING (policy ACCEPT 58524 packets, 42M byt=
es)
>>  pkts bytes target     prot opt in     out     source
>> destination
>>     0     0 SNAT       0    --  *      eth3    10.1.1.0/24
>> 0.0.0.0/0           to:80.32.61.58
>>     0     0 SNAT       0    --  *      eth1    10.1.1.0/24
>> 0.0.0.0/0           to:217.125.139.204
>>     0     0 SNAT       0    --  *      wan0    10.1.1.0/24
>> 0.0.0.0/0           PHYSDEV match --physdev-out eth3 to:80.32.61.58
>>     0     0 SNAT       0    --  *      wan0    10.1.1.0/24
>> 0.0.0.0/0           PHYSDEV match --physdev-out eth1
>> to:217.125.139.204
>>     0     0 SNAT       0    --  *      eth3    10.1.1.0/24
>> 0.0.0.0/0           to:80.32.61.58
>>     0     0 SNAT       0    --  *      eth1    10.1.1.0/24
>> 0.0.0.0/0           to:217.125.139.204
>>  578K   39M MASQUERADE  0    --  *      wan0    10.1.1.0/24
>> 0.0.0.0/0
>>     0     0 MASQUERADE  0    --  *      wan0:1  10.1.1.0/24
>> 0.0.0.0/0
>>     0     0 SNAT       0    --  *      wan0    10.1.1.0/24
>> 0.0.0.0/0           to:80.32.61.58
>>     0     0 SNAT       0    --  *      wan0    10.1.1.0/24
>> 0.0.0.0/0           to:217.125.139.204
>>
>> =3D=3DEND=3D=3D
>>
>> The problems I have are:
>>    1) If I make ssh conections from internet to the router (not to any
>> pc
>> into the lan zone), sometimes the ssh sesions disconnect.
>>    2) If I run tcpdump as these:
>> tcpdump -n -i eth3 not host 80.32.61.58
>> tcpdump -n -i eth1 not host 217.125.139.204
>>       I can see :
>>           a) IP frames not nated, where the source address is from lan
>> zone.
>>           b) Source IPs are not the correct.
>>       With tcpdump command I expect don't see anything, instead I can
>> see
>> frames as described below.
>>
>> Because the wan interface is only 1 (with 2 ip's), I only can use "-j
>> MASQUERADE" for the nating, I can't use -m physdev --physdev-out,
>> netfilter layer appears don't know what is the real outgoing interface
>> in
>> the bridge wan0 and "wan0:1" is not handled by netfilter layer.
>>
>> The questions:
>>    1) Does anyone know if this is a known issue (the tcpdump output and
>> physdev issue)?
>>    2) Does anyone know how to use SNAT in this case (I cant use -j
>> SNAT)?
>>    3) With 2.6.19.7 I were using "-m physdev --physdev-out" into the
>> chain
>> "MARCAR_IFACE_OUT", but with the 2.6.20.3 updated kernel, the -m
>> physdev appears to be broken and I then must use -m conntrack. Is this
>> a good solution?
>>
>> Please, I need any help, with this configuration I discovered these
>> problems but I don't know how to solve them:
>>    1) wan0 bridge don't appears to be working 100% of time (appears that
>> packets from one IP in the bridge are sent to the other interface).
>>    2) NAT appears to be a bit confused and don't nat all packets,
>> MASQUERADE don't want to be working all time.
>>    3) -m physdev --physdev-out don't know what is the read physical
>> interface where the packets a sent. (Whith 2.6.19.7 kernel, this
>> extension were working, or, at least, there were counters in the rules.
>>    4) Conections from internet to the router machine are lost randomly.
>>
>> I have no problem to use POSTROUTING chain in nat table to DROP o REJECT
>> incorrect packets, but ... really need I to do that?
>>
>> Thanks!! All help are apretiated!!
>>
>> Regards.
>>
>> P.D.: Sorry, my english is a bit poor.
>>
>
>
>
>

------=_20070322232407_57705
Content-Type: text/plain; name="iptables_nat.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="iptables_nat.txt"

Chain PREROUTING (policy ACCEPT 5516K packets, 372M bytes)
 pkts bytes target     prot opt in     out     source               destination         
7085K  522M PREROUTING_UPNPD  0    --  *      *       0.0.0.0/0            0.0.0.0/0           
    0     0 DNAT       udp  --  wan0   *       0.0.0.0/0            0.0.0.0/0           udp dpt:4667 to:10.1.1.10 
   53  3074 DNAT       udp  --  wan0   *       0.0.0.0/0            0.0.0.0/0           udp dpt:4664 to:10.1.1.10 
    9   436 DNAT       tcp  --  wan0   *       0.0.0.0/0            0.0.0.0/0           tcp dpt:4664 to:10.1.1.10 
   23  1356 DNAT       tcp  --  wan0   *       0.0.0.0/0            0.0.0.0/0           tcp dpt:24 to:10.1.1.15 
87915 4314K DNAT       tcp  --  *      *       0.0.0.0/0            0.0.0.0/0           tcp dpt:4666 to:10.1.1.14:4666 
 271K   17M DNAT       udp  --  *      *       0.0.0.0/0            0.0.0.0/0           udp dpt:4666 to:10.1.1.14:4666 
   47  2886 DNAT       udp  --  *      *       0.0.0.0/0            0.0.0.0/0           udp dpt:4669 to:10.1.1.14:4669 
 1403 68916 DNAT       tcp  --  *      *       0.0.0.0/0            0.0.0.0/0           tcp dpt:4668 to:10.1.1.4 
  417 26816 DNAT       udp  --  *      *       0.0.0.0/0            0.0.0.0/0           udp dpt:4668 to:10.1.1.4 
   10   480 DNAT       tcp  --  *      *       0.0.0.0/0            0.0.0.0/0           tcp dpts:16000:16001 to:10.1.1.15 
  311 23761 DNAT       udp  --  *      *       0.0.0.0/0            0.0.0.0/0           udp dpts:16000:16001 to:10.1.1.15 
  225 10800 DNAT       tcp  --  *      *       0.0.0.0/0            0.0.0.0/0           tcp dpts:16002:16003 to:10.1.1.9 
   54  3493 DNAT       udp  --  *      *       0.0.0.0/0            0.0.0.0/0           udp dpts:16002:16003 to:10.1.1.9 
    4   192 DNAT       tcp  --  *      *       0.0.0.0/0            0.0.0.0/0           tcp dpts:16004:16005 to:10.1.1.11 
   95 11251 DNAT       udp  --  *      *       0.0.0.0/0            0.0.0.0/0           udp dpts:16004:16005 to:10.1.1.11 
59458 2953K DNAT       tcp  --  *      *       10.1.1.0/24          0.0.0.0/0           tcp dpt:80 to:10.1.1.6:3128 
  214 11400 DNAT       tcp  --  *      *       10.1.1.0/24          0.0.0.0/0           tcp dpt:21 to:10.1.1.6:2121 
    0     0 DNAT       tcp  --  wan0   *       0.0.0.0/0            0.0.0.0/0           tcp dpt:17005 to:10.1.1.90 
    0     0 DNAT       udp  --  wan0   *       0.0.0.0/0            0.0.0.0/0           udp dpt:17005 to:10.1.1.90 
 8866  451K DNAT       tcp  --  wan0   *       0.0.0.0/0            0.0.0.0/0           tcp dpt:17025 to:10.1.1.89 
22168 2901K DNAT       udp  --  wan0   *       0.0.0.0/0            0.0.0.0/0           udp dpt:17025 to:10.1.1.89 

Chain POSTROUTING (policy ACCEPT 1920K packets, 602M bytes)
 pkts bytes target     prot opt in     out     source               destination         
    0     0 SNAT       0    --  *      eth3    10.1.1.0/24          0.0.0.0/0           to:80.32.61.58 
    0     0 SNAT       0    --  *      eth1    10.1.1.0/24          0.0.0.0/0           to:217.125.139.204 
    0     0 SNAT       0    --  *      wan0    10.1.1.0/24          0.0.0.0/0           PHYSDEV match --physdev-out eth3 to:80.32.61.58 
    0     0 SNAT       0    --  *      wan0    10.1.1.0/24          0.0.0.0/0           PHYSDEV match --physdev-out eth1 to:217.125.139.204 
    0     0 SNAT       0    --  *      eth3    10.1.1.0/24          0.0.0.0/0           to:80.32.61.58 
    0     0 SNAT       0    --  *      eth1    10.1.1.0/24          0.0.0.0/0           to:217.125.139.204 
4147K  290M MASQUERADE  0    --  *      wan0    10.1.1.0/24          0.0.0.0/0           
    0     0 MASQUERADE  0    --  *      wan0:1  10.1.1.0/24          0.0.0.0/0           
    0     0 SNAT       0    --  *      wan0    10.1.1.0/24          0.0.0.0/0           to:80.32.61.58 
    0     0 SNAT       0    --  *      wan0    10.1.1.0/24          0.0.0.0/0           to:217.125.139.204 

Chain OUTPUT (policy ACCEPT 393K packets, 453M bytes)
 pkts bytes target     prot opt in     out     source               destination         

Chain PREROUTING_UPNPD (1 references)
 pkts bytes target     prot opt in     out     source               destination         
    1    48 DNAT       tcp  --  wan0   *       0.0.0.0/0            0.0.0.0/0           tcp dpt:1301 to:10.1.1.85:1301 
    0     0 DNAT       tcp  --  wan0   *       0.0.0.0/0            0.0.0.0/0           tcp dpt:1292 to:10.1.1.85:1292 
    1    48 DNAT       tcp  --  wan0   *       0.0.0.0/0            0.0.0.0/0           tcp dpt:1143 to:5.141.179.219:1142 
    1    48 DNAT       tcp  --  wan0   *       0.0.0.0/0            0.0.0.0/0           tcp dpt:1142 to:10.1.1.85:1142 
    0     0 DNAT       tcp  --  wan0   *       0.0.0.0/0            0.0.0.0/0           tcp dpt:1117 to:5.141.179.219:1116 
    1    48 DNAT       tcp  --  wan0   *       0.0.0.0/0            0.0.0.0/0           tcp dpt:1116 to:10.1.1.85:1116 
    1    48 DNAT       tcp  --  wan0   *       0.0.0.0/0            0.0.0.0/0           tcp dpt:1681 to:10.1.1.85:1681 
    0     0 DNAT       tcp  --  wan0   *       0.0.0.0/0            0.0.0.0/0           tcp dpt:1678 to:10.1.1.85:1678 
    0     0 DNAT       tcp  --  wan0   *       0.0.0.0/0            0.0.0.0/0           tcp dpt:3461 to:10.1.1.85:3461 
    2   110 DNAT       udp  --  wan0   *       0.0.0.0/0            0.0.0.0/0           udp dpt:25085 to:10.1.1.85:25085 
    2    96 DNAT       tcp  --  wan0   *       0.0.0.0/0            0.0.0.0/0           tcp dpt:1550 to:10.1.1.85:1550 
    1    48 DNAT       tcp  --  wan0   *       0.0.0.0/0            0.0.0.0/0           tcp dpt:1554 to:10.1.1.85:1554 
    1    48 DNAT       tcp  --  wan0   *       0.0.0.0/0            0.0.0.0/0           tcp dpt:1347 to:10.1.1.85:1347 
    1    48 DNAT       tcp  --  wan0   *       0.0.0.0/0            0.0.0.0/0           tcp dpt:1152 to:10.1.1.85:1152 
    8   384 DNAT       tcp  --  wan0   *       0.0.0.0/0            0.0.0.0/0           tcp dpt:9049 to:10.1.1.85:9049 
28779 3476K DNAT       udp  --  wan0   *       0.0.0.0/0            0.0.0.0/0           udp dpt:17021 to:10.1.1.85:17021 
10878  528K DNAT       tcp  --  wan0   *       0.0.0.0/0            0.0.0.0/0           tcp dpt:17021 to:10.1.1.85:17021 
    1    52 DNAT       tcp  --  wan0   *       0.0.0.0/0            0.0.0.0/0           tcp dpt:1126 to:10.1.1.85:1126 
    1    48 DNAT       tcp  --  wan0   *       0.0.0.0/0            0.0.0.0/0           tcp dpt:1086 to:10.1.1.85:1086 
    4   254 DNAT       udp  --  wan0   *       0.0.0.0/0            0.0.0.0/0           udp dpt:25091 to:10.1.1.91:25091 
------=_20070322232407_57705
Content-Type: text/plain; name="rt_status.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="rt_status.txt"

=== REGLAS IPTABLES PARA EL ENRUTADO ===
Chain PREROUTING (policy ACCEPT 91M packets, 60G bytes)
num   pkts bytes target     prot opt in     out     source               destination         
1      66M   42G MARCAR_IFACE  0    --  *      *       0.0.0.0/0            0.0.0.0/0           
2    1409K  162M            0    --  *      *       0.0.0.0/0            0.0.0.0/0           ipp2p v0.8.2 --edk 
3        0     0            0    --  *      *       0.0.0.0/0            0.0.0.0/0           ipp2p v0.8.2 --dc 
4        0     0            0    --  *      *       0.0.0.0/0            0.0.0.0/0           ipp2p v0.8.2 --kazaa 
5        0     0            0    --  *      *       0.0.0.0/0            0.0.0.0/0           ipp2p v0.8.2 --gnu 
6    3963K  740M            0    --  *      *       0.0.0.0/0            0.0.0.0/0           ipp2p v0.8.2 --bit 
7        0     0            0    --  *      *       0.0.0.0/0            0.0.0.0/0           ipp2p v0.8.2 --apple 
8        1  1420            0    --  *      *       0.0.0.0/0            0.0.0.0/0           ipp2p v0.8.2 --winmx 
9      157 91803            0    --  *      *       0.0.0.0/0            0.0.0.0/0           ipp2p v0.8.2 --soul 
10     581 27811            0    --  *      *       0.0.0.0/0            0.0.0.0/0           ipp2p v0.8.2 --ares 
11       0     0            0    --  *      *       0.0.0.0/0            0.0.0.0/0           ipp2p v0.8.2 --mute 
12       0     0            0    --  *      *       0.0.0.0/0            0.0.0.0/0           ipp2p v0.8.2 --waste 
13       0     0            0    --  *      *       0.0.0.0/0            0.0.0.0/0           ipp2p v0.8.2 --xdcc 
14   5373K  902M            0    --  *      *       0.0.0.0/0            0.0.0.0/0           ipp2p v0.8.2 --ipp2p 
15    171K   35M            tcp  --  *      *       0.0.0.0/0            0.0.0.0/0           tcp dpt:1863 
16    164K   40M            tcp  --  *      *       0.0.0.0/0            0.0.0.0/0           tcp spt:1863 
Chain MARCAR_IFACE (1 references)
num   pkts bytes target     prot opt in     out     source               destination         
1      66M   42G CONNMARK   0    --  *      *       0.0.0.0/0            0.0.0.0/0           CONNMARK restore 
2      53M   35G RETURN     0    --  *      *       0.0.0.0/0            0.0.0.0/0           MARK match !0x0/0xf000 
3      13M 7945M MARCAR_IFACE_TRAFICO  0    --  *      *       0.0.0.0/0            0.0.0.0/0           MARK match 0x0/0xf000 
4    1153K  105M MARK       0    --  wan0   *       0.0.0.0/0            0.0.0.0/0           MARK match 0x0/0xf000 PHYSDEV match --physdev-in eth1 state NEW MARK or 0x8000 
5     888K   61M MARK       0    --  wan0   *       0.0.0.0/0            0.0.0.0/0           MARK match 0x0/0xf000 PHYSDEV match --physdev-in eth3 state NEW MARK or 0x4000 
6      13M 7945M CONNMARK   0    --  *      *       0.0.0.0/0            0.0.0.0/0           CONNMARK save  
7      13M 7945M RETURN     0    --  *      *       0.0.0.0/0            0.0.0.0/0           
Chain MARCAR_IFACE_TRAFICO (1 references)
num   pkts bytes target     prot opt in     out     source               destination         
Chain POSTROUTING (policy ACCEPT 174M packets, 105G bytes)
num   pkts bytes target     prot opt in     out     source               destination         
1     126M   76G MARCAR_IFACE_OUT  0    --  *      *       0.0.0.0/0            0.0.0.0/0           
2        0     0            tcp  --  *      wan0    0.0.0.0/0            0.0.0.0/0           tcp dpt:1863 STRING match "takeshi_guanwi_ryu@hotmail.com" ALGO name bm TO 65535
Chain MARCAR_IFACE_OUT (1 references)
num   pkts bytes target     prot opt in     out     source               destination         
1     126M   76G CONNMARK   0    --  *      *       0.0.0.0/0            0.0.0.0/0           CONNMARK restore 
2     111M   63G RETURN     0    --  *      *       0.0.0.0/0            0.0.0.0/0           MARK match !0x0/0xf000 
3        0     0 MARK       0    --  *      wan0    0.0.0.0/0            0.0.0.0/0           MARK match 0x0/0xf000 ctreplsrc 217.125.139.204 MARK or 0x8000 
4    1487K  104M MARK       0    --  *      wan0    0.0.0.0/0            0.0.0.0/0           MARK match 0x0/0xf000 ctrepldst 217.125.139.204 MARK or 0x8000 
5     3096  144K MARK       0    --  *      wan0    217.125.139.204      0.0.0.0/0           MARK match 0x0/0xf000 MARK or 0x8000 
6        0     0 MARK       0    --  *      wan0    0.0.0.0/0            0.0.0.0/0           MARK match 0x0/0xf000 ctorigsrc 217.125.139.204 MARK or 0x8000 
7        0     0 MARK       0    --  *      wan0    0.0.0.0/0            0.0.0.0/0           MARK match 0x0/0xf000 ctorigdst 217.125.139.204 MARK or 0x8000 
8        2   104 MARK       0    --  *      wan0    0.0.0.0/0            0.0.0.0/0           MARK match 0x0/0xf000 ctreplsrc 80.32.61.58 MARK or 0x4000 
9    1463K  103M MARK       0    --  *      wan0    0.0.0.0/0            0.0.0.0/0           MARK match 0x0/0xf000 ctrepldst 80.32.61.58 MARK or 0x4000 
10    3346  142K MARK       0    --  *      wan0    80.32.61.58          0.0.0.0/0           MARK match 0x0/0xf000 MARK or 0x4000 
11       0     0 MARK       0    --  *      wan0    0.0.0.0/0            0.0.0.0/0           MARK match 0x0/0xf000 ctorigsrc 80.32.61.58 MARK or 0x4000 
12       0     0 MARK       0    --  *      wan0    0.0.0.0/0            0.0.0.0/0           MARK match 0x0/0xf000 ctorigdst 80.32.61.58 MARK or 0x4000 
13     15M   13G CONNMARK   0    --  *      *       0.0.0.0/0            0.0.0.0/0           CONNMARK save  
14     15M   13G RETURN     0    --  *      *       0.0.0.0/0            0.0.0.0/0           
=== REGLAS DE ENRUTAMIENTO ===
0:	from all lookup local 
50:	from all lookup main 
100:	from all fwmark 0x8000/0xf000 lookup uno 
101:	from all fwmark 0x4000/0xf000 lookup dos 
150:	from 217.125.139.204/26 lookup uno 
151:	from 80.32.61.58/24 lookup dos 
200:	from all lookup defecto 
32766:	from all lookup main 
32767:	from all lookup default 
=== TABLAS DE RUTAS ===
=== MAIN ===
217.125.139.192/26 dev wan0  proto kernel  scope link  src 217.125.139.204 
80.32.61.0/24 dev wan0  proto kernel  scope link  src 80.32.61.58 
192.168.3.0/24 dev zlan0  proto kernel  scope link  src 192.168.3.247 
192.168.2.0/24 dev zlan0  proto kernel  scope link  src 192.168.2.247 
192.168.1.0/24 dev zlan0  proto kernel  scope link  src 192.168.1.247 
10.1.1.0/24 dev zlan0  proto kernel  scope link  src 10.1.1.6 
169.254.0.0/16 dev zlan0  scope link 
239.0.0.0/8 dev zlan0  scope link 
=== wan0 TABLA 150 ===
default via 217.125.139.193 dev wan0  proto static  src 217.125.139.204 
prohibit default  proto static  metric 1 
=== wan0 TABLA 151 ===
default via 80.32.61.1 dev wan0  proto static  src 80.32.61.58 
prohibit default  proto static  metric 1 
=== TABLA 200 (defecto) ===
default  proto static 
	nexthop via 217.125.139.193  dev wan0 weight 1
	nexthop via 80.32.61.1  dev wan0 weight 1
------=_20070322232407_57705--


