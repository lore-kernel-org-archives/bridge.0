DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=beta;
	h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
	bh=Y0fAXbTel9MceF0LfUrfCmZTwA9f3K6MhV7uSEwXZcs=;
	b=mUihaJwvmMT3XAjHdk+iEO6eEH2GXDcdwQRaISqbj3XRLd60OtmJrnEzadq6kCzbR1KWnwK2/QspqUrSrmx0Yqd/85JqKoXRkBgcykPsuBK4wCFZWoZ3f/08P4b6vu11YO6QZjZPHMn6IdThjvNxGP0AAORzWjl416hocNw9eVM=
Message-ID: <bdfc5d6e0710290915x79c6bd43ie687090910b068e3@mail.gmail.com>
Date: Mon, 29 Oct 2007 12:15:22 -0400
From: "Andy Gospodarek" <andy@greyhouse.net>
Sender: adgospod@gmail.com
Subject: Re: [Bridge] Re: Small packets
In-Reply-To: <472600E6.7060203@candelatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <96CF49BD8B56384395D698BA99007FA32D06@exchange.pacwire.local>
	<m3k5p6hxye.fsf@ursa.amorsen.dk>
	<bdfc5d6e0710290806o81321bbhcaaa7d936a50bb0c@mail.gmail.com>
	<472600E6.7060203@candelatech.com>
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ben Greear <greearb@candelatech.com>
Cc: bridge@osdl.org, Benny Amorsen <benny+usenet@amorsen.dk>

On 10/29/07, Ben Greear <greearb@candelatech.com> wrote:
> Andy Gospodarek wrote:
> > On 10/29/07, Benny Amorsen <benny+usenet@amorsen.dk> wrote:
> >>>>>>> "LS" == Leigh Sharpe <lsharpe@pacificwireless.com.au> writes:
> >> LS> Standard e1000 hardware. The packets being bridged contain a VLAN
> >> LS> tag, which is included in the 60 bytes.
> >>
> >> The e1000 has VLAN acceleration. The VLAN tag is sent in a separate
> >> register. If you do packet capture on the sender, the packet will
> >> likely look 60 bytes long, even if it is 64 bytes on the wire.
> >>
> >> The same thing happens on receive. Packet dumping with VLAN's is a bit
> >> of a mess in Linux. If you're lucky you can find a card without VLAN
> >> acceleration to do the packet dump.
> >>
> >>
> >> /Benny
> >>
> >
> > Are these the lengths on the wire or when captured on the host?   The
> > smallest VLAN tagged frame should be 68 bytes IIRC.  A tagged frame
> > that is 64 bytes seems too small.
>
> That is not correct per the 802.1Q VLAN RFC, though
> I don't have the reference handy at the moment.
>
> 64 bytes is fine, vlan tagged or otherwise.
>
>
> Thanks,
> Ben
>
>

Ah, you are correct, Ben.  Thanks for pointing that out.  Section
C.4.4.1 of the IEEE 802.1Q spec does state that 64-byte tagged frames
are OK, but that is only if you are able to drop padding from a
64-byte untagged one.  Transmitting a 60-byte frame on the wire is
incorrect.
