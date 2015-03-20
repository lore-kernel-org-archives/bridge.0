Return-Path: <brett.worth@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:date:from:reply-to:user-agent:mime-version:to:subject
	:content-type:content-transfer-encoding;
	bh=K51IrljsAQgFT2i4RjPbmPwUKqylnLKPhj8X4+M5lKQ=;
	b=PL59ubgHqSFbyy+ybHrJJ1RFUNriZSEmlRz5fLANdKVQJyEx38k8hjpg10bxcT9FUL
	o9CRfbqcgxwx0ivrtMqX2BWyHah+dhBoIz9m2B+NTXCnAN3XH3InXnfTg4jkzGxfTytc
	B8/2t0jYP3IREvMLGSglott8khTLo29DQ5LlCb+I0C8FzIdyXyuQGxUHSvSy8pqzUdPF
	yqtnpL2qNas8f2K/WIZG/hsuiQaLkGVa/JyVfluYM45QL4Kr5SQ90/G6pCA8PnDTfKCw
	j3V+o/FkBOHnAiV4h3N/HRK5EQkYbTL3hVkdFbCrr5ykD8lal26bUE1tAJFdLdWOP7wx
	v8ew==
Message-ID: <550BABAA.10803@gmail.com>
Date: Fri, 20 Mar 2015 16:10:02 +1100
From: Brett Worth <brett.worth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [Bridge] bridge port number changing
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

Hi all.  This is my first post to this list and I hope you'll be able to =
help.

I have been using the Linux bridge module for a long time under kvm on ce=
ntos.  This has
not given me any problems until now.

I'm adding some host servers and am using HP BL660 blades.

The kvm nic script in /etc/kvm creates a tap device then assigns a MAC ad=
dress after
modifying the first byte to FE.  This is so the port 1 host mac doesn't c=
hange.

On a working host server when running brctl showmacs br0 I see the tap ma=
c address and the
mac address assigned to the vm on the same port. The tap mac shows as loc=
al and the vm mac
is not.

The problem:

Intermittently (once a minute or so) the port number shown for the VM wil=
l switch to port
1.  During this time the VM cannot be contacted. The tap device mac remai=
ns at it's
original value.  If I wait it will switch back to the correct port number=
 i.e. the one
associated with the tap device at which point network connectivity is re-=
established.

I have looked for the VM mac address on the LAN but cannot see it so it s=
eems to be
something internal to the bridge.

Can anyone offer a suggestion as to what might be happening?

I'm running centos 6.6 and the bridge is 2.3.

Regards
Brett

--=20
  /) _ _ _/_/ / / /  _ _//
 /_)/</=3D / / (_(_/()/< ///


