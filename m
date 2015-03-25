Return-Path: <brett.worth@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:date:from:reply-to:user-agent:mime-version:to:subject
	:references:in-reply-to:content-type;
	bh=w2O99wU9JbDyHS92MumBI3QNAIKcRL+bUW9mpwzjs54=;
	b=d4nmHKhExIG4f+3JAKx+DYjabqDi2O2ahhDPeYM7vEUeyLHnC4Lm6STNRomvsIxZ6J
	4o3c3EYhg4mGDRF53Fq1nquYsygfSBnlnTj0AzN1bmaSqEfk6g1ac5XG4ejuqoeMH+Sy
	RZzZKtywGl7Tz65BPZy2qyZKe4bAhUuVrlUERov38pCfZgNDZIqTVG0I5S/487tKWQLI
	XJCPDcFYsrhLJmQchf8reRXHZ7jFRx0GwuXaGIHySwzwjGdLlazrgt6Vw4fAfL49ybhI
	evoS5Qdb0z+4OtZuHOiDt5dyoOY4n/Va7/C6gCwV9oB6y2uu6bt6nnFKh98eSDzSGzgq
	dnag==
Message-ID: <551329FA.9040105@gmail.com>
Date: Thu, 26 Mar 2015 08:34:50 +1100
From: Brett Worth <brett.worth@gmail.com>
MIME-Version: 1.0
References: <550BABAA.10803@gmail.com>
In-Reply-To: <550BABAA.10803@gmail.com>
Content-Type: multipart/alternative;
	boundary="------------000107080609050009020203"
Subject: Re: [Bridge] bridge port number changing - FIXED
Reply-To: brett@worth.id.au
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

This is a multi-part message in MIME format.
--------------000107080609050009020203
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

On 20/03/15 16:10, Brett Worth wrote:
> Hi all.  This is my first post to this list and I hope you'll be able to help.
>
> I have been using the Linux bridge module for a long time under kvm on centos.  This has
> not given me any problems until now.
>
> I'm adding some host servers and am using HP BL660 blades.
>
> The kvm nic script in /etc/kvm creates a tap device then assigns a MAC address after
> modifying the first byte to FE.  This is so the port 1 host mac doesn't change.
>
> On a working host server when running brctl showmacs br0 I see the tap mac address and the
> mac address assigned to the vm on the same port. The tap mac shows as local and the vm mac
> is not.
>
> The problem:
>
> Intermittently (once a minute or so) the port number shown for the VM will switch to port
> 1.  During this time the VM cannot be contacted. The tap device mac remains at it's
> original value.  If I wait it will switch back to the correct port number i.e. the one
> associated with the tap device at which point network connectivity is re-established.
>
> I have looked for the VM mac address on the LAN but cannot see it so it seems to be
> something internal to the bridge.
>
> Can anyone offer a suggestion as to what might be happening?
>
> I'm running centos 6.6 and the bridge is 2.3.

I have finally found a solution to this problem which I thought might be of interest to 
the list.

The HP BL660 blades I am using have an Emulex NIC which used the be2net driver.  Between 
RHEL 6.5 and RHEL 6.6 the be2net modules was upgraded from 4.x to a 10.x version.

In the release notes 
(http://www-dl.emulex.com/support/lenovo/rt10.3.0/ga/Docs/linux/linux_relnotes_elx.pdf) I 
found this:

    "2. PING is not working when attempting to bridge the 1G or 10G ports to the virtual
    machines when SR-IOV is enabled for 10 G ports in the BIOS.
    This issue occurs due to limitations of the virtual Ethernet bridge. All transmitted
    broadcast packets are looped back by the controller. This affects the functionality of the
    Linux bridge, as it appears as if the same ARP broadcast packets are received on two
    different interfaces.
    Workaround
    a) Set the aging of the bridge to 0 using the following command:
    “brctl setageing <bridge> 0”

    "

Is it normal for the controller to loop back broadcast packets?

Is it going to make much of a difference to the the ageing set to zero?

Brett

-- 
   /) _ _ _/_/ / / /  _ _//
  /_)/</= / / (_(_/()/< ///


--------------000107080609050009020203
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">On 20/03/15 16:10, Brett Worth wrote:<br>
    </div>
    <blockquote cite="mid:550BABAA.10803@gmail.com" type="cite">
      <pre wrap="">Hi all.  This is my first post to this list and I hope you'll be able to help.

I have been using the Linux bridge module for a long time under kvm on centos.  This has
not given me any problems until now.

I'm adding some host servers and am using HP BL660 blades.

The kvm nic script in /etc/kvm creates a tap device then assigns a MAC address after
modifying the first byte to FE.  This is so the port 1 host mac doesn't change.

On a working host server when running brctl showmacs br0 I see the tap mac address and the
mac address assigned to the vm on the same port. The tap mac shows as local and the vm mac
is not.

The problem:

Intermittently (once a minute or so) the port number shown for the VM will switch to port
1.  During this time the VM cannot be contacted. The tap device mac remains at it's
original value.  If I wait it will switch back to the correct port number i.e. the one
associated with the tap device at which point network connectivity is re-established.

I have looked for the VM mac address on the LAN but cannot see it so it seems to be
something internal to the bridge.

Can anyone offer a suggestion as to what might be happening?

I'm running centos 6.6 and the bridge is 2.3.</pre>
    </blockquote>
    <br>
    I have finally found a solution to this problem which I thought
    might be of interest to the list.<br>
    <br>
    The HP BL660 blades I am using have an Emulex NIC which used the
    be2net driver.  Between RHEL 6.5 and RHEL 6.6 the be2net modules was
    upgraded from 4.x to a 10.x version.  <br>
    <br>
    In the release notes
    (<a class="moz-txt-link-freetext" href="http://www-dl.emulex.com/support/lenovo/rt10.3.0/ga/Docs/linux/linux_relnotes_elx.pdf">http://www-dl.emulex.com/support/lenovo/rt10.3.0/ga/Docs/linux/linux_relnotes_elx.pdf</a>)
    I found this:<br>
    <blockquote>"2. PING is not working when attempting to bridge the 1G
      or 10G ports to the virtual<br>
      machines when SR-IOV is enabled for 10 G ports in the BIOS.<br>
      This issue occurs due to limitations of the virtual Ethernet
      bridge. All transmitted<br>
      broadcast packets are looped back by the controller. This affects
      the functionality of the<br>
      Linux bridge, as it appears as if the same ARP broadcast packets
      are received on two<br>
      different interfaces.<br>
      Workaround<br>
      a) Set the aging of the bridge to 0 using the following command:<br>
      “brctl setageing &lt;bridge&gt; 0”<br>
      <br>
      "<br>
    </blockquote>
    Is it normal for the controller to loop back broadcast packets?<br>
    <br>
    Is it going to make much of a difference to the the ageing set to
    zero?<br>
    <br>
    Brett<br>
    <br>
    <pre class="moz-signature" cols="90">-- 
  /) _ _ _/_/ / / /  _ _//
 /_)/&lt;/= / / (_(_/()/&lt; ///
</pre>
  </body>
</html>

--------------000107080609050009020203--
