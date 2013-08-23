Return-Path: <tarbal@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:date:message-id:subject
	:from:to:cc:content-type;
	bh=kvdMpduT78jt6ZoQL17Zzh8QHOIV4So0qis5f7PwXvE=;
	b=HR/paFAzUR65W3DZ++B+axnd1vpDDPDYG9G7s5bkRGJIWDhPqB9NNpbe5v05XwG04C
	4KydC25mxOAdgtVWJ6CAGZF4BNEXLNu46dERWWP/5i5bK6pucTExSIcjrTTJqa8GPsq7
	iKXaJl+At4FL3XSXkD1yMnGOENmEv7QaLV3+L3Lu7gILR7YsD1UqntyY9UKrHqmV/goB
	FH20WntKppFQ/UrsRiqd+KTR+jX/fwk3Cnx29M0OPEwTCnKLi4cx17NnvfguflQPdoOe
	kmVIlsJP/O5YANutOSm58sMMXbyCAR492u8BrXcJ/T3xp3cDB/GG+43py2Zp+rYMQsNc
	BzfA==
MIME-Version: 1.0
Sender: tarbal@gmail.com
In-Reply-To: <20130823062234.c34a6da6.skraw@ithnet.com>
References: <20130822224453.ca93782f.skraw@ithnet.com>
	<20130822234941.4affc863@catus>
	<20130822151941.301cd36a@nehalam.linuxnetplumber.net>
	<20130823062234.c34a6da6.skraw@ithnet.com>
Date: Thu, 22 Aug 2013 21:58:58 -0700
Message-ID: <CAL3LdT62oN3hdrDy2DL_Mk9+vUAsRzxaSjY5O87HbHgsjG+V6Q@mail.gmail.com>
From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Bridge] Can linux kernel bridge forward 802.1q tagged vlan
	packets?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephan von Krawczynski <skraw@ithnet.com>, Carolyn Wyborny <carolyn.wyborny@intel.com>, mitch.a.williams@intel.com
Cc: Stephen Hemminger <stephen@networkplumber.org>, Marek Kierdelewicz <marek@piasta.pl>, bridge@lists.linux-foundation.org, netdev <netdev@vger.kernel.org>

Adding Carolyn Wyborny (igb maintainer) and Mitch Williams (igbvf maintainer)...

On Thu, Aug 22, 2013 at 9:22 PM, Stephan von Krawczynski
<skraw@ithnet.com> wrote:
> On Thu, 22 Aug 2013 15:19:41 -0700
> Stephen Hemminger <stephen@networkplumber.org> wrote:
>
>> On Thu, 22 Aug 2013 23:49:41 +0200
>> Marek Kierdelewicz <marek@piasta.pl> wrote:
>>
>> > Hi,
>> >
>> > >My general idea is to bridge tagged vlan packets from a physical
>> > >interface (intel) to a virtual interface (virtio in qemu) and not
>> > >losing the tags, so the qemu guest can use vconfig and friends to get
>> > >some vlan interfaces. Is this possible and are there any additional
>> > >steps necessary besides the usual bridge configuration?
>> >
>> > I'm using this setup with KVM virtualization (Qemu's successor). It
>> > didn't work with default nic type for guest (realtek I think) as 802.1q
>> > tags were not preserved properly in one of the directions. I don't
>> > remember specifics. Anyway using e1000 driver instead of default fixed
>> > it. Works like a charm.
>>
>> KVM e1000 Vnic doesn't do VLAN offloading at least in my experience.
>> Virtio works fine.
>
> Ok guys, here is one of the major questions in this issue:
>
> How did you manage to convince the _host_ interface driver (in my setup "igb"
> from intel) to get the vlan tagged packets from the LAN port. igb has a vlan
> filter function built in and reads _no_ tagged packets at all if the driver
> does not tell it to. And in case of "up-ing" the interface for attachment to a
> bridge it does not configure this vlan filter.
> How is this expected to work?
>
> --
> Regards,
> Stephan
>
> --
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Cheers,
Jeff
