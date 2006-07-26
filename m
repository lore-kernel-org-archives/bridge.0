Message-ID: <44C7979B.7040906@seskion.de>
Date: Wed, 26 Jul 2006 18:26:03 +0200
From: Juergen Pfeiffer <j.pfeiffer@seskion.de>
MIME-Version: 1.0
References: <44C77FD2.2030208@seskion.de>
	<20060726083455.08989fc6@localhost.localdomain>
In-Reply-To: <20060726083455.08989fc6@localhost.localdomain>
Content-Type: multipart/alternative;
	boundary="------------040508000704080206010300"
Subject: Re: [Bridge] Is bridgeing possible with kernel 2.6.10
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

This is a multi-part message in MIME format...

--------------040508000704080206010300
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Stephen Hemminger schrieb:
>
> Did the bridge get set up right? Did the interfaces come up (look at 'brc=
tl showstp br0')
>  =20
$ ifconfig eth0 0.0.0.0 down
$ ifconfig eth1 0.0.0.0 down
$ brctl addbr br0
$ brctl stp br0 on
$ brctl addif br0 eth0
$ brctl addif br0 eth1
$ ifconfig eth0 0.0.0.0 up
$ ifconfig eth1 0.0.0.0 up
$ ifconfig br0 0.0.0.0 up

$ brctl showmacs br0
port no mac addr                is local?       ageing timer
  1     00:11:22:33:44:50       yes                0.00
  2     00:11:22:33:44:51       yes                0.00
  2     00:11:95:34:af:01       no                 2.91
  2     00:c0:02:39:53:52       no                 2.76
$ brctl showstp br0
br0
 bridge id              8000.001122334450
 designated root        8000.001122334450
 root port                 0                    path cost                  0
 max age                  20.00                 bridge max=20
age            20.00
 hello time                2.00                 bridge hello=20
time          2.00
 forward delay            15.00                 bridge forward=20
delay      15.00
 ageing time             300.00
 hello timer               1.45                 tcn=20
timer                  0.00
 topology change timer     0.00                 gc timer                =20
273.04
 flags


eth0 (1)
 port id                8001                    state                 =20
learning
 designated root        8000.001122334450       path cost                100
 designated bridge      8000.001122334450       message age=20
timer          0.00
 designated port        8001                    forward delay=20
timer        3.48
 designated cost           0                    hold=20
timer                 0.44
 flags

eth1 (2)
 port id                8002                    state                 =20
learning
 designated root        8000.001122334450       path cost                100
 designated bridge      8000.001122334450       message age=20
timer          0.00
 designated port        8002                    forward delay=20
timer        3.45
 designated cost           0                    hold=20
timer                 0.43
 flags



> The bridge is sensitive to the network devices reporting carrier properly,
> so a bad network driver or card will make it not work.
>
>  =20



--=20
------------------------------------------------------------------------
J=FCrgen Pfeiffer =09
=09
	* _mailto:j.pfeiffer@seskion.de_
SesKion Softwareentwicklung und System Konzeption GmbH =09
=09
	( : +49-711-9905814
Karlsruher Str. 11/1 =09
=09
	Fax: +49-711-9905827
D-70771 Leinfelden-Echterdingen =09
=09
	1 _http://www.seskion.de_

------------------------------------------------------------------------

--------------040508000704080206010300
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Stephen Hemminger schrieb:
<blockquote cite="mid20060726083455.08989fc6@localhost.localdomain"
 type="cite"><br>
  <pre wrap="">
Did the bridge get set up right? Did the interfaces come up (look at 'brctl showstp br0')
  </pre>
</blockquote>
$ ifconfig eth0 0.0.0.0 down<br>
$ ifconfig eth1 0.0.0.0 down<br>
$ brctl addbr br0<br>
$ brctl stp br0 on<br>
$ brctl addif br0 eth0<br>
$ brctl addif br0 eth1<br>
$ ifconfig eth0 0.0.0.0 up<br>
$ ifconfig eth1 0.0.0.0 up<br>
$ ifconfig br0 0.0.0.0 up<br>
<br>
$ brctl showmacs br0<br>
port no mac addr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; is local?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ageing timer<br>
&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp; 00:11:22:33:44:50&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; yes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.00<br>
&nbsp; 2&nbsp;&nbsp;&nbsp;&nbsp; 00:11:22:33:44:51&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; yes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.00<br>
&nbsp; 2&nbsp;&nbsp;&nbsp;&nbsp; 00:11:95:34:af:01&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; no&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.91<br>
&nbsp; 2&nbsp;&nbsp;&nbsp;&nbsp; 00:c0:02:39:53:52&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; no&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.76<br>
$ brctl showstp br0<br>
br0<br>
&nbsp;bridge id&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8000.001122334450<br>
&nbsp;designated root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8000.001122334450<br>
&nbsp;root port&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; path
cost&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
&nbsp;max age&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 20.00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bridge max
age&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 20.00<br>
&nbsp;hello time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bridge hello
time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.00<br>
&nbsp;forward delay&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 15.00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bridge forward
delay&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 15.00<br>
&nbsp;ageing time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 300.00<br>
&nbsp;hello timer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.45&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tcn
timer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.00<br>
&nbsp;topology change timer&nbsp;&nbsp;&nbsp;&nbsp; 0.00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gc
timer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 273.04<br>
&nbsp;flags<br>
<br>
<br>
eth0 (1)<br>
&nbsp;port id&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8001&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
learning<br>
&nbsp;designated root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8000.001122334450&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; path
cost&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 100<br>
&nbsp;designated bridge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8000.001122334450&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; message age
timer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.00<br>
&nbsp;designated port&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8001&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; forward delay
timer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.48<br>
&nbsp;designated cost&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hold
timer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.44<br>
&nbsp;flags<br>
<br>
eth1 (2)<br>
&nbsp;port id&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8002&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
learning<br>
&nbsp;designated root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8000.001122334450&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; path
cost&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 100<br>
&nbsp;designated bridge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8000.001122334450&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; message age
timer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.00<br>
&nbsp;designated port&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8002&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; forward delay
timer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.45<br>
&nbsp;designated cost&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hold
timer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.43<br>
&nbsp;flags<br>
<br>
<br>
<br>
<blockquote cite="mid20060726083455.08989fc6@localhost.localdomain"
 type="cite">
  <pre wrap="">The bridge is sensitive to the network devices reporting carrier properly,
so a bad network driver or card will make it not work.

  </pre>
</blockquote>
<br>
<br>
<br>
<div class="moz-signature">-- <br>
<hr>
<table>
  <tbody>
    <tr>
      <td> <font face="Tahoma" size="2">J&uuml;rgen Pfeiffer</font> </td>
      <td><br>
      </td>
      <td><br>
      </td>
      <td> <font color="#000000" face="Wingdings" size="2">*</font> <u><font
 color="#00208c" face="Tahoma" size="2"><a
 href="mailto:j.pfeiffer@seskion.de">mailto:j.pfeiffer@seskion.de</a></font></u>
      <font face="Tahoma" size="2"> </font> </td>
    </tr>
    <tr>
      <td> <font color="#00208c" face="Arial Black" size="2">SesKion</font>
      <font face="Tahoma" size="2">Softwareentwicklung und System
Konzeption GmbH</font> </td>
      <td><br>
      </td>
      <td><br>
      </td>
      <td> <font face="Wingdings" size="2">(</font> <font
 face="Tahoma" size="2">: +49-711-9905814 </font> </td>
    </tr>
    <tr>
      <td> <font face="Tahoma" size="2">Karlsruher Str. 11/1</font> </td>
      <td><br>
      </td>
      <td><br>
      </td>
      <td> <font face="Tahoma" size="2">Fax: +49-711-9905827</font> </td>
    </tr>
    <tr>
      <td> <font face="Tahoma" size="2">D-70771 Leinfelden-Echterdingen</font>
      </td>
      <td><br>
      </td>
      <td><br>
      </td>
      <td> <font color="#000000" face="Wingdings" size="2">1</font> <u><font
 color="#00208c" face="Tahoma" size="2"><a href="http://www.seskion.de">http://www.seskion.de</a></font></u>
      <font face="Tahoma" size="2"> </font> </td>
    </tr>
  </tbody>
</table>
<hr>
</div>
</body>
</html>

--------------040508000704080206010300--
