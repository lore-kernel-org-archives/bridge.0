Message-ID: <4975583A.9010905@dd-wrt.com>
Date: Tue, 20 Jan 2009 05:51:06 +0100
From: "Sebastian Gottschall (DD-WRT) " <s.gottschall@dd-wrt.com>
MIME-Version: 1.0
References: <5d777c0a0901191630t63f56ff6md9268b0265909d5e@mail.gmail.com>	
	<497523A0.7040201@dd-wrt.com>
	<2e59e6970901191841w5e03e3e3i8d409a2d74274389@mail.gmail.com>
In-Reply-To: <2e59e6970901191841w5e03e3e3i8d409a2d74274389@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
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
To: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Cc: bridge@lists.linux-foundation.org

richardvoigt@gmail.com schrieb:
> On Tue, Jan 20, 2009 at 1:06 AM, Sebastian Gottschall (DD-WRT)
> <s.gottschall@dd-wrt.com> wrote:
>  =20
>> ?ukasz Mierzwa schrieb:
>>    =20
>>> Hi,
>>>
>>> I'm running kvm virtual machines with bridged networking with
>>> libvirtd, virtual guests are getting ip addresses from dhcp, listing
>>> interface information on kvm host gives me only bridge ip, there is no
>>> information about guests ip assigned by dhcpd to tap interfaces that
>>> are added to the bridge, is there any way to get this information from
>>> kvm host system where the bridge is created? I couldn't find any
>>> usable information on this subject, right now I need to check dhcp
>>> leases or login over vnc. Thanks for any help.
>>>      =20
>> the bridging code is not responsible for tracking ip informations. you
>> really have to check your dhcp leases which is the clean way.
>> another trick is sending a broadcast ping to your client network and
>> looking at the arp table. but this is just a dirty way
>>    =20
>
> Sounds like a good place to use dynamic DNS.  This can be
> dhcp-integrated (dnsmasq does this well, Windows server dns daemon
> does it as well) or using a client inside the virtual machine to
> register its name with a web service (no-ip.com, dyndns.org, etc.)
>  =20
or chillispot / nocatauth /wifidog  etc. hotspot redirection services.=20
that might work too, if the authentication page is designed in that way
>  =20
>> Sebastian
>>    =20
>>> Lucas
>>> ------------------------------------------------------------------------
>>>
>>> _______________________________________________
>>> Bridge mailing list
>>> Bridge@lists.linux-foundation.org
>>> https://lists.linux-foundation.org/mailman/listinfo/bridge
>>>      =20
>> --
>> Mit freundlichen Gr=FCssen / Regards
>>
>> Sebastian Gottschall / CTO
>>
>> NewMedia-NET GmbH - DD-WRT
>> Firmensitz:  Wormser Stra=DFe 5 - 7, 64625 Bensheim
>> Registergericht: Amtsgericht Darmstadt, HRB 25473
>> Gesch=E4ftsf=FChrer: Peter Steinh=E4user, Christian Scheele
>> http://www.dd-wrt.com
>> email: s.gottschall@dd-wrt.com
>> Tel.: +496251-582650 / Fax: +496251-5826565
>>
>>
>> _______________________________________________
>> Bridge mailing list
>> Bridge@lists.linux-foundation.org
>> https://lists.linux-foundation.org/mailman/listinfo/bridge
>>
>>    =20
>
>  =20


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


