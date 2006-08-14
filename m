Message-ID: <44E09C40.8060306@seskion.de>
Date: Mon, 14 Aug 2006 17:52:32 +0200
From: Juergen Pfeiffer <j.pfeiffer@seskion.de>
MIME-Version: 1.0
References: <44C77FD2.2030208@seskion.de>
In-Reply-To: <44C77FD2.2030208@seskion.de>
Content-Type: multipart/alternative;
	boundary="------------020407080907040908060304"
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
Cc: uclinux-dev@uclinux.org

This is a multi-part message in MIME format...

--------------020407080907040908060304
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Juergen Pfeiffer schrieb:
> Hi
>
> I didn't get bridgeing to work with Linux kernel 2.6.10 (coldfire 5485)=20
> yet. When i try to configure bridgeing
> with "brctl", everything seems to be ok, but i if i try to ping through=20
> my bridge, i see ARP-Request arriving on the other side, but the
> ARP-Responses do not go back through the bridge.
>  =20

Now i found the error in the coldfire specific ethernet driver:=20
"drivers/net/fec/fec.c"
The driver did not set Promiscuouse Mode correct in Hardware Registers:

function fec_set_multicast_list() with error:
*void fec_set_multicast_list(struct net_device *dev)
{
    // Pointer to the address list
    struct dev_mc_list *dmi;

    unsigned int crc, data;
    int i, j, k;

    // Receive the base address
    unsigned long base_addr =3D (unsigned long) dev->base_addr;

    if (dev->flags & IFF_PROMISC || dev->flags & IFF_ALLMULTI)
    {
        // Allow all incoming frames
        FEC_GALR(base_addr) =3D 0xFFFFFFFF;
        FEC_GAUR(base_addr) =3D 0xFFFFFFFF;
        return;
    }
...
*


function fec_set_multicast_list() correct:
*void fec_set_multicast_list(struct net_device *dev)
{
    // Pointer to the address list
    struct dev_mc_list *dmi;

    unsigned int crc, data;
    int i, j, k;

    // Receive the base address
    unsigned long base_addr =3D (unsigned long) dev->base_addr;

    if (dev->flags & IFF_PROMISC)
    {
        // Allow all incoming frames
        if ((FEC_RCR(base_addr) & FEC_RCR_PROM)=3D=3D0) {
            FEC_ECR(base_addr) &=3D ~FEC_ECR_ETHEREN;
            FEC_RCR(base_addr) |=3D FEC_RCR_PROM;
            FEC_ECR(base_addr) |=3D FEC_ECR_ETHEREN;
        }
        return;
    }
    if ((FEC_RCR(base_addr) & FEC_RCR_PROM)!=3D0) {
        FEC_ECR(base_addr) &=3D ~FEC_ECR_ETHEREN;
        FEC_RCR(base_addr) &=3D ~FEC_RCR_PROM;
        FEC_ECR(base_addr) |=3D FEC_ECR_ETHEREN;
    }
    if (dev->flags & IFF_ALLMULTI)
    {
        // Allow all incoming frames
        FEC_GALR(base_addr) =3D 0xFFFFFFFF;
        FEC_GAUR(base_addr) =3D 0xFFFFFFFF;
        return;
    }
...
*

after this the bridge worked fine!


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

--------------020407080907040908060304
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Juergen Pfeiffer schrieb:
<blockquote cite="mid44C77FD2.2030208@seskion.de" type="cite">
  <pre wrap="">Hi

I didn't get bridgeing to work with Linux kernel 2.6.10 (coldfire 5485) 
yet. When i try to configure bridgeing
with "brctl", everything seems to be ok, but i if i try to ping through 
my bridge, i see ARP-Request arriving on the other side, but the
ARP-Responses do not go back through the bridge.
  </pre>
</blockquote>
<br>
Now i found the error in the coldfire specific ethernet driver:
"drivers/net/fec/fec.c"<br>
The driver did not set Promiscuouse Mode correct in Hardware Registers:<br>
<br>
function fec_set_multicast_list() with error:<br>
<font color="#000099"><b><tt>void fec_set_multicast_list(struct
net_device *dev)<br>
{<br>
&nbsp;&nbsp;&nbsp; // Pointer to the address list<br>
&nbsp;&nbsp;&nbsp; struct dev_mc_list *dmi;<br>
<br>
&nbsp;&nbsp;&nbsp; unsigned int crc, data;<br>
&nbsp;&nbsp;&nbsp; int i, j, k;<br>
<br>
&nbsp;&nbsp;&nbsp; // Receive the base address<br>
&nbsp;&nbsp;&nbsp; unsigned long base_addr = (unsigned long) dev-&gt;base_addr;<br>
<br>
&nbsp;&nbsp;&nbsp; if (dev-&gt;flags &amp; IFF_PROMISC || dev-&gt;flags &amp;
IFF_ALLMULTI)<br>
&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; // Allow all incoming frames<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; FEC_GALR(base_addr) = 0xFFFFFFFF;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; FEC_GAUR(base_addr) = 0xFFFFFFFF;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return;<br>
&nbsp;&nbsp;&nbsp; }<br>
...<br>
</tt></b></font><br>
<br>
<br>
function fec_set_multicast_list() correct:<br>
<font color="#000099"><b><tt>void fec_set_multicast_list(struct
net_device *dev)<br>
{<br>
&nbsp;&nbsp;&nbsp; // Pointer to the address list<br>
&nbsp;&nbsp;&nbsp; struct dev_mc_list *dmi;<br>
<br>
&nbsp;&nbsp;&nbsp; unsigned int crc, data;<br>
&nbsp;&nbsp;&nbsp; int i, j, k;<br>
<br>
&nbsp;&nbsp;&nbsp; // Receive the base address<br>
&nbsp;&nbsp;&nbsp; unsigned long base_addr = (unsigned long) dev-&gt;base_addr;<br>
<br>
&nbsp;&nbsp;&nbsp; if (dev-&gt;flags &amp; IFF_PROMISC)<br>
&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; // Allow all incoming frames<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if ((FEC_RCR(base_addr) &amp; FEC_RCR_PROM)==0) {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; FEC_ECR(base_addr) &amp;= ~FEC_ECR_ETHEREN;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; FEC_RCR(base_addr) |= FEC_RCR_PROM;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; FEC_ECR(base_addr) |= FEC_ECR_ETHEREN;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return;<br>
&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; if ((FEC_RCR(base_addr) &amp; FEC_RCR_PROM)!=0) {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; FEC_ECR(base_addr) &amp;= ~FEC_ECR_ETHEREN;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; FEC_RCR(base_addr) &amp;= ~FEC_RCR_PROM;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; FEC_ECR(base_addr) |= FEC_ECR_ETHEREN;<br>
&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; if (dev-&gt;flags &amp; IFF_ALLMULTI)<br>
&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; // Allow all incoming frames<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; FEC_GALR(base_addr) = 0xFFFFFFFF;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; FEC_GAUR(base_addr) = 0xFFFFFFFF;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return;<br>
&nbsp;&nbsp;&nbsp; }<br>
...<br>
</tt></b></font><br>
<br>
after this the bridge worked fine!<br>
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

--------------020407080907040908060304--
