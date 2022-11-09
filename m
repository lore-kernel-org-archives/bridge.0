Return-Path: <stephen@networkplumber.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B4D1F6066D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D7F3560625
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KRa3zLSl7ee1yGVNAAzjY5vpjyV6wqckozbmKlHsMfQ=;
 b=S0En1H5UJdZt5oSh6Ts0Qh4obRmUNA/FNjgSqzMXSV926VMcwoorELQn8nu8gxzRor
 KPrKpDTTsV/bJjXke862cHchAB+yBAz4s+8xfxvO0szFRYal4AV91g648gBDCuxWN0XR
 cPQywR7t75xcTLRvC+DyJVFharWFfssxBZNcA0jei/xhiZlYxjYk6M+HC+AdXAvqHdnX
 DS9ibrxOruofjoNZxGvSPFj5FeDMem/MugJPfwW1TzdvAXs+67xVqPVtowImnl2F1KCJ
 /CgcpxakOxaqJe+TebrnH4es6lwY1Xbh7PKnf0n1ubQy07JVAS9i3Fn+LSbq0qTebmKr
 wyag==
Date: Wed, 9 Nov 2022 12:08:58 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20221109120858.52e5a0aa@hermes.local>
In-Reply-To: <pPm5jFjNYHBUzqlDouAIg2v7XTQZJnHIVSWXoYOaTijreJ22xAZOSAcwJXHJiTLN8jIAQCs-LeX7hp9hp-FaxW-HGjn69fc6-eG3Kv6lxc4=@protonmail.com>
References: <nWfVbvdboX65r0xMXv0iZCj8TH7c8vStvilCD3Ilx5Y42yoHh34rJHJBMy8y4HhqXWXM0n3tLhLD870c863UjI20HBSxM8qwJlLMxuPjg0g=@protonmail.com>
 <20221109085109.6b0f87d3@hermes.local>
 <pPm5jFjNYHBUzqlDouAIg2v7XTQZJnHIVSWXoYOaTijreJ22xAZOSAcwJXHJiTLN8jIAQCs-LeX7hp9hp-FaxW-HGjn69fc6-eG3Kv6lxc4=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] How to connect more than 200 interfaces to a bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ali Shirvani <alishirv@protonmail.com>
Cc: Ali Shirvani via Bridge <bridge@lists.linux-foundation.org>

On Wed, 09 Nov 2022 19:25:32 +0000
Ali Shirvani <alishirv@protonmail.com> wrote:

> Sent with Proton Mail secure email.
> 
> ------- Original Message -------
> On Wednesday, November 9th, 2022 at 8:21 PM, Stephen Hemminger <stephen@networkplumber.org> wrote:
> 
> 
> > On Wed, 09 Nov 2022 10:51:27 +0000
> > Ali Shirvani via Bridge bridge@lists.linux-foundation.org wrote:
> >   
> > > Hello everyone,
> > > 
> > > It seems we reach the Linux bridge limitation on the number of interfaces in a single bridge. Currently, we have 210 tap interface in a bridge, and we suffer from more than 50% packet loss when we ping the IP address of the virtual machine that uses one of the tap interfaces in the bridge.
> > > Do you know how we can connect more than 200 VMs virtual interfaces to a bridge?
> > > 
> > > Best regards,
> > > Ali
> > > 
> > > Sent with Proton Mail secure email.  
> > 
> > 
> > The upper limit on interfaces per bridge should be 1023.
> > That limitation comes from spanning tree.
> > 
> > You might bet able to improve performance by disabling flooding to those tap devices.
> > Normally, any broadcast/unknown/multicast must be copied and flooded to each interface.  
> 
> Thanks a lot for your guidance. I disabled the spanning tree on the bridge with `brctl stp br0 off` but the issue does not resolve. Would you please elaborate more about disabling flooding on tap devices, I don't know how I should disable flooding on tap devices.

Look at the documentation of the bridge command which describes per-port options:
https://man7.org/linux/man-pages/man8/bridge.8.html

You do want to leave flooding on for the downstream bridge port.

You can also add some security by limiting where/when STP comes from and disable
learning on the TAP devices so that if VM sends bogus packets, the bridge won't get DoS.
