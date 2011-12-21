Return-Path: <cTXr3nd3DSn5@dyweni.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=_33a12b712ea9d1dab0727307743f622f"
Date: Wed, 21 Dec 2011 10:01:52 -0600
From: Dyweni - Bridge <cTXr3nd3DSn5@dyweni.com>
Message-ID: <755194a48992c82fe519179f9423c989@pl1.haspere.com>
Subject: [Bridge] Invalid Argument when adding a bond to a bridge
Reply-To: cTXr3nd3DSn5@dyweni.com
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Bridge <bridge@lists.linux-foundation.org>, Bonding Devel <bonding-devel@lists.sourceforge.net>

--=_33a12b712ea9d1dab0727307743f622f
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8

  

Hi All, 

I'm getting an 'Invalid argument' error when trying to
add a bonded interface to a new bridge. Has anyone seen this before?


I'm running Linux 3.2-rc6 

Bonded interface was created like this:


echo "+public-bond" > /sys/class/net/bonding_masters
echo "+eth0" >
/sys/class/net/public-bond/bonding/slaves 

The bridged interface was
created like this: 

brctl addbr pubbridge
brctl addif pubbridge
public-bond 

--  

-- 
Thanks,
Dyweni
  
--=_33a12b712ea9d1dab0727307743f622f
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=UTF-8

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
<html><body>
<p>Hi All,</p>
<p>I'm getting an 'Invalid argument' error when trying to add a bonded inte=
rface to a new bridge. &nbsp;Has anyone seen this before?</p>
<p>&nbsp;</p>
<p>I'm running Linux 3.2-rc6</p>
<p>&nbsp;</p>
<p>Bonded interface was created like this:</p>
<p>echo "+public-bond" &gt; /sys/class/net/bonding_masters<br />echo "+eth0=
" &gt; /sys/class/net/public-bond/bonding/slaves</p>
<p>The bridged interface was created like this:</p>
<p>brctl addbr pubbridge<br />brctl addif pubbridge public-bond</p>
<p>&nbsp;</p>
<p><span style=3D"white-space: pre-wrap;">-- </span></p>
<div>
<pre>--=20
Thanks,
Dyweni</pre>
</div>
</body></html>

--=_33a12b712ea9d1dab0727307743f622f--

