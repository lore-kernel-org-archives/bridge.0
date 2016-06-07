Return-Path: <upuvvad1@binghamton.edu>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=binghamton-edu.20150623.gappssmtp.com; s=20150623;
	h=mime-version:from:date:message-id:subject:to;
	bh=22jiJl8yUzRH0ci/vpuqUHVWrki6mNle+DRUYrAlycc=;
	b=cN9K5aWp+Rowil+B1nXi8lKWqXRmgXX0kYcKKCj5aXU+4s2avqlwKpVKRHG5a/1KO9
	BLqWBQ94Iv20KL+3mgLZDX2HWwLvVYkSJ1/JVLQeQbyggZi1OacxYLtYlrRnaPJ+WmU5
	cCBKnpmnoOGe7eAzOKguGadpDoPKommiEj5tBA6Wg2YsqhmIBKvInNUxPwTUW07FoCKb
	ryjz+p3ETDvCeF11YFcZfqC924LwkSDOeGN6ACgZdIfMydxVTZ3xeddefAJbDKqRzGcT
	nOy2waYHNf+62+dQcNYHRiimApmwtPz5twAljjL6Uqq9yK96FZSA4PcLpVePsdUj1Oh0
	c8tQ==
MIME-Version: 1.0
From: Udaya Puvvadi <upuvvad1@binghamton.edu>
Date: Tue, 7 Jun 2016 12:20:42 -0400
Message-ID: <CAKWq4gNPD5m_=-WPDZWzS0GOgkyHYtY3yh0wsJJy9+gohiwhtg@mail.gmail.com>
Content-Type: multipart/alternative; boundary=001a1137b0ea5d3c6d0534b2942c
Subject: [Bridge] NFS connection drops as interface added to bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--001a1137b0ea5d3c6d0534b2942c
Content-Type: text/plain; charset=UTF-8

Hi,

I am running PXE boot with Debian Stretch image, with eth2 interface
bound to kernel for doing NFS mounts.

I am trying to add this interface to the bridge, for network
communication across virtual interfaces, however the NFS drops
connections as soon as I add the interface.

Can you please help me on how to do the NFS mount's over a bridge connection ?

-- 
Thanks,
Udaya Puvvadi

--001a1137b0ea5d3c6d0534b2942c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><pre style=3D"color:rgb(0,0,0)">Hi,</pre><pre style=3D"col=
or:rgb(0,0,0)">I am running PXE boot with Debian Stretch image, with eth2 i=
nterface bound to kernel for doing NFS mounts.</pre><pre style=3D"color:rgb=
(0,0,0)">I am trying to add this interface to the bridge, for network commu=
nication across virtual interfaces, however the NFS drops connections as so=
on as I add the interface.</pre><pre style=3D"color:rgb(0,0,0)">Can you ple=
ase help me on how to do the NFS mount&#39;s over a bridge connection ?<br =
class=3D""></pre>-- <br><div class=3D"gmail_signature" data-smartmail=3D"gm=
ail_signature"><div dir=3D"ltr">Thanks,<div>Udaya Puvvadi</div></div></div>
</div>

--001a1137b0ea5d3c6d0534b2942c--
