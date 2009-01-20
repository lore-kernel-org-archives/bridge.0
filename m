MIME-Version: 1.0
In-Reply-To: <497523A0.7040201@dd-wrt.com>
References: <5d777c0a0901191630t63f56ff6md9268b0265909d5e@mail.gmail.com>
	<497523A0.7040201@dd-wrt.com>
Date: Tue, 20 Jan 2009 02:41:52 +0000
Message-ID: <2e59e6970901191841w5e03e3e3i8d409a2d74274389@mail.gmail.com>
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
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
To: "Sebastian Gottschall (DD-WRT)" <s.gottschall@dd-wrt.com>
Cc: bridge@lists.linux-foundation.org

On Tue, Jan 20, 2009 at 1:06 AM, Sebastian Gottschall (DD-WRT)
<s.gottschall@dd-wrt.com> wrote:
> ?ukasz Mierzwa schrieb:
>> Hi,
>>
>> I'm running kvm virtual machines with bridged networking with
>> libvirtd, virtual guests are getting ip addresses from dhcp, listing
>> interface information on kvm host gives me only bridge ip, there is no
>> information about guests ip assigned by dhcpd to tap interfaces that
>> are added to the bridge, is there any way to get this information from
>> kvm host system where the bridge is created? I couldn't find any
>> usable information on this subject, right now I need to check dhcp
>> leases or login over vnc. Thanks for any help.
> the bridging code is not responsible for tracking ip informations. you
> really have to check your dhcp leases which is the clean way.
> another trick is sending a broadcast ping to your client network and
> looking at the arp table. but this is just a dirty way

Sounds like a good place to use dynamic DNS.  This can be
dhcp-integrated (dnsmasq does this well, Windows server dns daemon
does it as well) or using a client inside the virtual machine to
register its name with a web service (no-ip.com, dyndns.org, etc.)

>
> Sebastian
>>
>> Lucas
>> ------------------------------------------------------------------------
>>
>> _______________________________________________
>> Bridge mailing list
>> Bridge@lists.linux-foundation.org
>> https://lists.linux-foundation.org/mailman/listinfo/bridge
>
>
> --
> Mit freundlichen Gr=FCssen / Regards
>
> Sebastian Gottschall / CTO
>
> NewMedia-NET GmbH - DD-WRT
> Firmensitz:  Wormser Stra=DFe 5 - 7, 64625 Bensheim
> Registergericht: Amtsgericht Darmstadt, HRB 25473
> Gesch=E4ftsf=FChrer: Peter Steinh=E4user, Christian Scheele
> http://www.dd-wrt.com
> email: s.gottschall@dd-wrt.com
> Tel.: +496251-582650 / Fax: +496251-5826565
>
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>
