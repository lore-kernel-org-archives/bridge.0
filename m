Return-Path: <sagar.shedge92@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=OpzJVSQNBvSDLe63zQY3taJ3ok1C6hduVMSd08IooW0=;
	b=gYk9qWp/8hPueJ3ViYcXyH/kL43a/n0sHI1D4Tbz5bQI9F/EqujPBl5bJmK6qrMq5H
	swabCdK2ehmX+rzUX65dd7j9UMK85EgGBafCTgURlIwNJCRBEPSAzz3IB5IZKsiMjvwW
	Kjl/+uR2wLWBIeDr5arfYZn96npqWVpZP3u9LDbKFXJPOLlcuF7i94IcyzwxHSyL4MmC
	sPvNwW+GJLZXdHjYLjQJ5IJI5VdnW0WUnV2yaa94S8WiDaD15gEws2fvNLl77DBm2GUu
	Pt1+Kd9VtPU1hx97ffulmX1WKMqcWXFGLgGBdNuqNzbhtYV+HJ6oVjsujy+bmHlYJJlM
	+8zg==
MIME-Version: 1.0
Date: Mon, 24 Nov 2014 18:59:49 +0530
Message-ID: <CAPhYifHUARhGXbgUhB-Sd0y_sZj30CThAxToQJxp+FRtS1DM6Q@mail.gmail.com>
From: Sagar Shedge <sagar.shedge92@gmail.com>
Content-Type: multipart/alternative; boundary=bcaec548a13dec529005089ac980
Subject: [Bridge] Put virbr0 in promiscuous mode
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--bcaec548a13dec529005089ac980
Content-Type: text/plain; charset=UTF-8

Hi ,


I have two virtual machines VM1 and VM2 on KVM (ubuntu 14.04 LTS
3.13.0-24-generic). Then I have added eth0 of my VM to 'default' network
(NAT network).

Use case :-
I want to monitor all traffic on virbr0('default' network).

Steps followed :-
1. Add VM1 eth0 to virbr0
2. Add VM2 eth1 to virbr0
3. brctl setageing ovsbr0 0 ..(To put bridge in promiscuous)

Now I am running tcpdump on eth1 of VM2 and trying to ping google.com(outside
world)

In VM2 (tcpdump -i eth1), I can see only ingress(incoming) traffic of VM1.
I am not able see outgoing traffic of VM1.

If I create another bridge and trying same scenario with 2 VM then VM2 can
see both ingress and outgress traffic.

So want to know what is the issue?
Is linux bridge/libvirt doing something different with this virtbr0
bridge(NAT bridge)?


-- 
Regards,
Sagar Dilip Shedge,
Pune.

--bcaec548a13dec529005089ac980
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><br></div><span style=3D"font-family:arial,sans-serif=
;font-size:13px">Hi ,</span><div style=3D"font-family:arial,sans-serif;font=
-size:13px"><br></div><div style=3D"font-family:arial,sans-serif;font-size:=
13px"><br></div><div style=3D"font-family:arial,sans-serif;font-size:13px">=
I have two virtual machines VM1 and VM2 on KVM (ubuntu 14.04 LTS 3.13.0-24-=
generic<span style=3D"color:rgb(80,0,80)">)</span>. Then I have added eth0 =
of my VM to &#39;default&#39; network (NAT network).</div><div style=3D"fon=
t-family:arial,sans-serif;font-size:13px"><br></div><div style=3D"font-fami=
ly:arial,sans-serif;font-size:13px">Use case :-</div><div style=3D"font-fam=
ily:arial,sans-serif;font-size:13px">I want to monitor all traffic on virbr=
0(&#39;default&#39; network).</div><div style=3D"font-family:arial,sans-ser=
if;font-size:13px"><br></div><div style=3D"font-family:arial,sans-serif;fon=
t-size:13px">Steps followed :-</div><div style=3D"font-family:arial,sans-se=
rif;font-size:13px">1. Add VM1 eth0 to virbr0</div><div style=3D"font-famil=
y:arial,sans-serif;font-size:13px">2. Add VM2 eth1 to virbr0</div><div styl=
e=3D"font-family:arial,sans-serif;font-size:13px">3. brctl setageing ovsbr0=
 0 ..(To put bridge in promiscuous)</div><div style=3D"font-family:arial,sa=
ns-serif;font-size:13px"><br></div><div style=3D"font-family:arial,sans-ser=
if;font-size:13px">Now I am running tcpdump on eth1 of VM2 and trying to pi=
ng=C2=A0<a href=3D"http://google.com/" target=3D"_blank">google.com</a>(out=
side world)</div><div style=3D"font-family:arial,sans-serif;font-size:13px"=
><br></div><div style=3D"font-family:arial,sans-serif;font-size:13px">In VM=
2 (tcpdump -i eth1), I can see only ingress(incoming) traffic of VM1. I am =
not able see outgoing traffic of VM1.</div><div style=3D"font-family:arial,=
sans-serif;font-size:13px"><br></div><div style=3D"font-family:arial,sans-s=
erif;font-size:13px">If I create another bridge and trying same scenario wi=
th 2 VM then VM2 can see both ingress and outgress traffic.</div><div style=
=3D"font-family:arial,sans-serif;font-size:13px"><br></div><div style=3D"fo=
nt-family:arial,sans-serif;font-size:13px">So want to know what is the issu=
e?</div><div style=3D"font-family:arial,sans-serif;font-size:13px">Is linux=
 bridge/libvirt doing something different with this virtbr0 bridge(NAT brid=
ge)?</div><div><br></div><div><br></div>--=C2=A0<div>Regards,</div><div><di=
v class=3D"gmail_signature">Sagar Dilip Shedge,<br>Pune.<br><div>=C2=A0<br>=
</div></div>
</div></div>

--bcaec548a13dec529005089ac980--
