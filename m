Return-Path: <xmCM8KtKk25K@dyweni.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=_818a6c9e031bcae1429d22436b2506df"
Date: Thu, 22 Dec 2011 08:08:49 -0600
From: Dyweni - NetDev <xmCM8KtKk25K@dyweni.com>
Message-ID: <03b9acd1fc6e9223f1a78dbfac9b7945@pl1.haspere.com>
Subject: [Bridge] Invalid Argument when adding a bond to a bridge
Reply-To: xmCM8KtKk25K@dyweni.com
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: NetDev <netdev@vger.kernel.org>, Bridge <bridge@lists.linux-foundation.org>, Bonding Devel <bonding-devel@lists.sourceforge.net>

--=_818a6c9e031bcae1429d22436b2506df
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8

  

Hi All, 

I need some help figuring this one out... Whenever I try
to add a bond to a bridge, I get back an invalid argument error. I've
confirmed this on 3.2-rc6, 3.1.5, 3.0.13, and 2.6.39.4 (haven't checked
earlier kernels). 

Here's my setup: 32bit KVM virtual machine with no
network cards (... -net none ... ). 

I created the bond with: echo "+x"
> /sys/class/net/bonding_masters 

I created the bridge with: brctl
addbr b 

I try to add the bond to the bridge with: brctl addif b x 

--


Thanks,
Dyweni
  
--=_818a6c9e031bcae1429d22436b2506df
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=UTF-8

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
<html><body>
<p>Hi All,</p>
<p>I need some help figuring this one out... Whenever I try to add a bond t=
o a bridge, I get back an invalid argument error. &nbsp;I've confirmed this=
 on 3.2-rc6, 3.1.5, 3.0.13, and 2.6.39.4 (haven't checked earlier kernels)=
=2E</p>
<p>&nbsp;</p>
<p>Here's my setup: &nbsp;32bit KVM virtual machine with no network cards (=
=2E.. -net none ... ).</p>
<p>I created the bond with: &nbsp;&nbsp;echo "+x" &gt; /sys/class/net/bondi=
ng_masters</p>
<p>I created the bridge with: &nbsp;&nbsp;brctl addbr b</p>
<p>I try to add the bond to the bridge with: &nbsp;brctl addif b x</p>
<p>&nbsp;</p>
<p>--&nbsp;</p>
<div>
<pre>Thanks,
Dyweni</pre>
</div>
</body></html>

--=_818a6c9e031bcae1429d22436b2506df--

