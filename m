Message-ID: <497523A0.7040201@dd-wrt.com>
Date: Tue, 20 Jan 2009 02:06:40 +0100
From: "Sebastian Gottschall (DD-WRT) " <s.gottschall@dd-wrt.com>
MIME-Version: 1.0
References: <5d777c0a0901191630t63f56ff6md9268b0265909d5e@mail.gmail.com>
In-Reply-To: <5d777c0a0901191630t63f56ff6md9268b0265909d5e@mail.gmail.com>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] how to get a list of ip adresses
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?windows-1252?Q?=3Fukasz_Mierzwa?= <prymitive@gmail.com>
Cc: bridge@lists.linux-foundation.org

?ukasz Mierzwa schrieb:
> Hi,
>
> I'm running kvm virtual machines with bridged networking with=20
> libvirtd, virtual guests are getting ip addresses from dhcp, listing=20
> interface information on kvm host gives me only bridge ip, there is no=20
> information about guests ip assigned by dhcpd to tap interfaces that=20
> are added to the bridge, is there any way to get this information from=20
> kvm host system where the bridge is created? I couldn't find any=20
> usable information on this subject, right now I need to check dhcp=20
> leases or login over vnc. Thanks for any help.
the bridging code is not responsible for tracking ip informations. you=20
really have to check your dhcp leases which is the clean way.
another trick is sending a broadcast ping to your client network and=20
looking at the arp table. but this is just a dirty way

Sebastian
>
> Lucas
> ------------------------------------------------------------------------
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge


--=20
Mit freundlichen Gr=FCssen / Regards

Sebastian Gottschall / CTO=20

NewMedia-NET GmbH - DD-WRT=20
Firmensitz:  Wormser Stra=DFe 5 - 7, 64625 Bensheim
Registergericht: Amtsgericht Darmstadt, HRB 25473
Gesch=E4ftsf=FChrer: Peter Steinh=E4user, Christian Scheele
http://www.dd-wrt.com
email: s.gottschall@dd-wrt.com
Tel.: +496251-582650 / Fax: +496251-5826565=20


