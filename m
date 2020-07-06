Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 6 Jul 2020 12:13:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c0d3.blue; s=2018;
 t=1594030382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VO8lnjMo4pgk3nOOEXxhD7RoBNV9iIu75hV27TGyKhE=;
 b=TpRgwzLw9MoHEFRFLHo0xRSh2ZNhMEXuK52xxtnXcAQ4GIGdOC9My1Bs7jJEoc0QkjYzQW
 zjOlpSH2yDozco9TGuEHth44eouV07u0TXdW01w4mDpjcvHNecinNLvSuwnQOxOcUM+6Hz
 wQOqDi7eDQkwoT0/010fYlhlXNlzaHzlbQNVUmNREp1co02Dj90cnDy4Be43lw1tXLLLxv
 o8RMfIHlsljVJC5AqA18Xmpn/+PPtA5aDSSO9wvOQ+lZgPYsfXDwradxGORkd31Wz4nz5K
 hux7qNWF2cZmQtMMDltvAD2xMIP+tyCnoLyagnmoS2rsd1giyQxyf1RVTlMDHw==
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20200706101300.GE2648@otheros>
References: <20200705182234.10257-1-linus.luessing@c0d3.blue>
 <093beb97-87e8-e112-78ad-b3e4fe230cdb@cumulusnetworks.com>
 <20200705190851.GC2648@otheros>
 <4728ef5e-0036-7de6-8b6f-f29885d76473@cumulusnetworks.com>
 <20200705194915.GD2648@otheros>
 <15375380-b7ad-985c-6ad3-c86ece996cd0@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <15375380-b7ad-985c-6ad3-c86ece996cd0@cumulusnetworks.com>
Subject: Re: [Bridge] [PATCH net] bridge: mcast: Fix MLD2 Report IPv6
 payload length check
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: Martin Weinelt <martin@linuxlounge.net>, netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "David S . Miller" <davem@davemloft.net>

On Sun, Jul 05, 2020 at 11:18:36PM +0300, Nikolay Aleksandrov wrote:
> > > By the way, I can't verify at the moment, but I think we can drop that whole
> > > hunk altogether since skb_header_pointer() is used and it will simply return
> > > an error if there isn't enough data for nsrcs.
> > > 
> > 
> > Hm, while unlikely, the IPv6 packet / header payload length might be
> > shorter than the frame / skb size.
> > 
> > And even though it wouldn't crash reading over the IPv6 packet
> > length, especially as skb_header_pointer() is used, I think we should
> > still avoid reading over the size indicated by the IPv6 header payload
> > length field, to stay protocol compliant.
> > 
> > Does that make sense?
> > 
> 
> Sure, I just thought the ipv6_mc_may_pull() call after that includes those 2 bytes as well, so
> we're covered. That is, it seems to be doing the same check with the full grec size included.
> 

Ah, okay, that's what you mean! You're right, technically the
ipv6_mc_may_pull() later would cover it, too. And it should work,
even if nsrcs were outside of the IPv6 packet and had a bogus
value. (I think.)

My brain linearly parsing the parser code would probably get a bit
confused initially, as it'd look like a bit like a bug. But the
current check for nsrcs might look confusing, too (q.e.d.).

So as you prefer, I'd be okay with both leaving that check for
consistency or removing it for brevity.
